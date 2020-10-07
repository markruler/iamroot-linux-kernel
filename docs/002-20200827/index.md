## 개요

- 장소: 온라인(Zoom)
- 참석자: 김상윤, 김정근, 김지엽, 김태정, 박준은, 이경렬, 임창수, 정홍관, 홍은비
- 학습내용: <리눅스 커널 내부구조> 메모리 관리 (Buddy와 slab), 파일시스템, 인터럽트 (인터럽트 처리과정)
- 질문 토론
  - 버디 할당자 bitmap 의 역할 용도
  - 버디 할당자와 슬랩 할당자의 관계
  - 슬랩은 더이상 사용되지 않는가
  - ext2 inode에서 가리키는 파일 최대 크기가 48KB + 4MB + 4GB + 4TB 인 이유
  - inode 번호는 시스템에서 유일한 값을가지는가, 혹은 디스크 파티션 마다..
  - do_IRQ를 별도로 두는 이유

## 참고한 링크
- 메모리
  - [Slab Allocator](https://decdream.tistory.com/347)
  - [페이지 테이블 – ARM32: 문c 블로그](http://jake.dothome.co.kr/pt/)
- 파일 시스템
  - [Ext4 File System](http://esos.hanyang.ac.kr/tc/2015gradproject8/i/entry/3)
  - [Inodes](https://www.grymoire.com/Unix/Inodes.html)
  - [Does the inode change when renaming or moving a file?](https://unix.stackexchange.com/questions/192800/does-the-inode-change-when-renaming-or-moving-a-file)
  - [가상 파일 시스템(VFS)](https://5kyc1ad.tistory.com/275)
- 인터럽트
  - [인터럽트 코드 분석](https://neoteny.tistory.com/86)
  - [디바이스 드라이버를 위한 커널 서비스 - 인터럽트 처리](https://chardoc.tistory.com/3)

## 참고한 커널 소스 코드

- [struct file_operstions{}](https://elixir.bootlin.com/linux/latest/source/include/linux/fs.h#L1837)
- [struct inode_operations{}](https://elixir.bootlin.com/linux/latest/source/include/linux/fs.h#L1879)
- [ksys_read()](https://elixir.bootlin.com/linux/latest/source/fs/read_write.c#L596)
- [vfs_read(): file->f_op->read()](https://elixir.bootlin.com/linux/latest/source/fs/read_write.c#L461)
- [generic_file_read_iter()](https://elixir.bootlin.com/linux/latest/source/mm/filemap.c#L2276)
- [register_filesystem()](https://elixir.bootlin.com/linux/latest/source/fs/filesystems.c#L72)
- [struct file_system_type{}](https://elixir.bootlin.com/linux/latest/source/include/linux/fs.h#L2247)

## 기타 자료

- [kernel map](https://makelinux.github.io/kernel/map/)
