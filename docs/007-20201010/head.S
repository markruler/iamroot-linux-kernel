/* SPDX-License-Identifier: GPL-2.0-only */
/*
 * Low-level CPU initialisation
 * Based on arch/arm/kernel/head.S
 *
 * Copyright (C) 1994-2002 Russell King
 * Copyright (C) 2003-2012 ARM Ltd.
 * Authors:	Catalin Marinas <catalin.marinas@arm.com>
 *		Will Deacon <will.deacon@arm.com>
 */

#include <linux/linkage.h>
#include <linux/init.h>
#include <linux/irqchip/arm-gic-v3.h>
#include <linux/pgtable.h>

#include <asm/asm_pointer_auth.h>
#include <asm/assembler.h>
#include <asm/boot.h>
#include <asm/ptrace.h>
#include <asm/asm-offsets.h>
#include <asm/cache.h>
#include <asm/cputype.h>
#include <asm/elf.h>
#include <asm/image.h>
#include <asm/kernel-pgtable.h>
#include <asm/kvm_arm.h>
#include <asm/memory.h>
#include <asm/pgtable-hwdef.h>
#include <asm/page.h>
#include <asm/scs.h>
#include <asm/smp.h>
#include <asm/sysreg.h>
#include <asm/thread_info.h>
#include <asm/virt.h>

#include "efi-header.S" //## http://www.iamroot.org/ldocs/linux.html#sec-7-1

#define __PHYS_OFFSET	(KERNEL_START - TEXT_OFFSET) //

/* 
## 해당 코드 존재의 이유 - http://jake.dothome.co.kr/head-64/
## KERNEL_START >> arch/arm64/include/asm/memory.h
## TEXT_OFFSET >> arch/arm64/Makefile
## TEXT_OFFSET Randomization code removed - https://lwn.net/Articles/824072/
## 이유 1 - https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=751c263bb74fd36b5fc2589d36abc75042336444
## 이유 2 - https://www.spinics.net/lists/arm-kernel/msg798878.html

## 사라진 이유? KASLR로 인한 deprecated로 예상함
*/

#if (TEXT_OFFSET & 0xfff) != 0
#error TEXT_OFFSET must be at least 4KB aligned
#elif (PAGE_OFFSET & 0x1fffff) != 0
#error PAGE_OFFSET must be at least 2MB aligned
#elif TEXT_OFFSET > 0x1fffff
#error TEXT_OFFSET must be less than 2MB
#endif
/*
  ## 순차적인 deprecated 예정이라 생각함
  ## https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=9703d9d7f77ce129621f7d80a844822e2daa7008
*/

/*
 * Kernel startup entry point.
 * ---------------------------
 *
 * The requirements are:
 *   MMU = off, D-cache = off, I-cache = on or off,
 *   x0 = physical address to the FDT blob. 
  ## FDT (Flat Device Tree)
  ## FDT에 대한 설명 - https://tot0rokr.github.io/kernel/device%20tree/DTBv1/
  ## 모기향책 94 페이지에 디바이스 트리 
 *
 * This code is mostly position independent so you call this at
 * __pa(PAGE_OFFSET + TEXT_OFFSET).
 *
 * Note that the callee-saved registers are used for storing variables
 * that are useful before the MMU is enabled. The allocations are described
 * in the entry routines.
 */
	__HEAD
_head:
	/*
	 * DO NOT MODIFY. Image header expected by Linux boot-loaders.
	 */
// ## EFI 업데이트 log - https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=3c7f255039a2ad6ee1e3890505caf0d029b22e29
/*
## UEFI의 사용 이유, 그리고 (Dis)Advantages - https://www.lifewire.com/unified-extensible-firmware-interface-833069
## UEFI에 대한 설명 - https://www.lifewire.com/efi-file-2620983
## arm Developer 에서 UEFI- https://developer.arm.com/architectures/system-architectures/software-standards/uefi
## Intel UEFI 설명 - https://www.intel.com/content/www/us/en/architecture-and-technology/unified-extensible-firmware-interface/efi-homepage-general-technology.html
##
## CONFIG_EFI의 설정 과정
## 공식문서: https://www.kernel.org/doc/html/latest/arm/uefi.html
## 
## Kconfig, Makefile, defconfig 세 가지 파일을 통해 설정됨
## 
## 1) Makefile에서 $(CONFIG_XXX)가 사용됨
## 2) Kconfig에서 config XXX로 해당 매크로 설정 --> 자동으로 CONFIG_XXX가 생성됨
## 
## 예) config GPIO
## 	bool
## 	default y --> 디폴트로 사용하는 설정
## 
##   만들어진 CONFIG_XXX는 .config 파일에 명시된다 --> 최종적으로 autoconf.h 파일로 생성됨
## 
## 3) if/endif를 통해 Kconfig내의 config XXX 설정을 featuring하는 경우가 있음
##   해당 feature macro에 대한 정의는 defconfig에서 설정함
## 
## 예) if MSM_DEVICES
##       config GPIO
##       bool
##       default y
## 	endif
## 
## 	위 예시에서 MSM_DEVICES 매크로가 defconfig에서 정의됨 (MSM_DEVICES = true인 경우 해당 config 문 수행됨)

*/
/*
 * This add instruction has no meaningful effect except that
 * its opcode forms the magic "MZ" signature required by UEFI.
 */

// ## MZ란? - https://wiki.osdev.org/MZ
/*
  ## add	x13, x18, #0x16
  ## add 명령어는 명령어 binary encoding의 상위 16bit가 MZ signature = 0x5A4D = 16'b0101101001001101가 되도록 설정한 것임
  ## 명령어 형식 32bit = 하위 16bit + 상위 16bit에서 상위 16bit가 010110(0x16)10010(x18)01101(x13)임
  ## 명령어 encoding은 ARM architecture reference manual 참조
 */
#ifdef CONFIG_EFI
	add	x13, x18, #0x16
	b	primary_entry
#else
	b	primary_entry			// branch to kernel start, magic
	.long	0				      // reserved
#endif
	le64sym	_kernel_offset_le		// Image load offset from start of RAM, little-endian
	le64sym	_kernel_size_le			// Effective size of kernel image, little-endian
	le64sym	_kernel_flags_le		// Informative flags, little-endian
	.quad	0				  // reserved
	.quad	0				  // reserved
	.quad	0				  // reserved
	.ascii	ARM64_IMAGE_MAGIC		// Magic number ## arch/arm64/include/asm/image.h
#ifdef CONFIG_EFI
	.long	pe_header - _head		  // Offset to the PE header.

pe_header:
	__EFI_PE_HEADER // ## arch/arm64/kernel/efi-header.S
#else
	.long	0				  // reserved
#endif

	__INIT

	/*
	 * The following callee saved general purpose registers are used on the
	 * primary lowlevel boot path:
	 *
	 *  Register   Scope                      Purpose
	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
	 *  x23        primary_entry() .. start_kernel()        physical misalignment/KASLR offset
	 *  x28        __create_page_tables()                   callee preserved temp register
	 *  x19/x20    __primary_switch()                       callee preserved temp registers
	 *  x24        __primary_switch() .. relocate_kernel()  current RELR displacement
	 */

/*
  ## Assembler Annotations : https://www.kernel.org/doc/html/latest/asm-annotations.html
  ## SYM_* 매크로에 대한 정확한 설명 : https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=ffedeeb780dc554eff3d3b16e6a462a26a41d7ec 
  ## 어셈블리에서의 "함수"와 같은 느낌 -> 다른곳에서 b인스트럭션 실행 시, 해당 로직으로 이동
  ## SYM_CODE_START는 primary_entry를 global symbol로 만들고 align을 수행 (.globl : linker가 symbol을 찾을 수 있게 해줌)
  ## https://kldp.org/node/96304
  ## code alignment : (p104) https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-optimization-manual.pdf
  ## b, bl: https://developer.arm.com/documentation/dui0068/b/arm-instruction-reference/arm-branch-instructions/b-and-bl
*/
SYM_CODE_START(primary_entry)
	bl	preserve_boot_args //## b=branch, bl=branch with link
	bl	el2_setup			// Drop to EL1, w0=cpu_boot_mode
	adrp	x23, __PHYS_OFFSET
	and	x23, x23, MIN_KIMG_ALIGN - 1	// KASLR offset, defaults to 0
	bl	set_cpu_boot_mode_flag
	bl	__create_page_tables
	/*
	 * The following calls CPU setup code, see arch/arm64/mm/proc.S for
	 * details.
	 * On return, the CPU will be ready for the MMU to be turned on and
	 * the TCR will have been set.
	 */
	bl	__cpu_setup			// initialise processor
	b	__primary_switch
SYM_CODE_END(primary_entry)

/*
 * Preserve the arguments passed by the bootloader in x0 .. x3
 */
// ## bootloader? https://www.ionos.com/digitalguide/server/configuration/what-is-a-bootloader/
SYM_CODE_START_LOCAL(preserve_boot_args)
// ## https://ammonia3.tistory.com/9
// ## x0는 FDT의 주소 값을 담고 있다.
  mov	x21, x0				      // x21=FDT

  adr_l	x0, boot_args			// record the contents of
  stp	x21, x1, [x0]			  // x0 .. x3 at kernel entry
  // ## [] -> 포인터
  stp	x2, x3, [x0, #16]		// ## [x0+16]에 x2, x3 저장
	// ## Primary CPU general-purpose register settings(x0,x1,x2,x3에 저장된 값들 확인 가능) - https://www.kernel.org/doc/Documentation/arm64/booting.txt

  dmb	sy				          // needed before dc ivac with
	      			            // MMU off

  mov	x1, #0x20	      		// 4 x 8 bytes
  b	__inval_dcache_area		// tail call
SYM_CODE_END(preserve_boot_args)
