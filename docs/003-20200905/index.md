## 개요

- 장소: 온라인(Zoom)
- 참석자: 김수연, 김정근, 김지엽, 김태정, 박준은, 이승원, 정홍관, 조현일, 홍은비
- 학습내용: <리눅스 커널 내부구조> 인터럽트, 리눅스 모듈프로그래밍, 디바이스 드라이버, 네트워크

## 참고한 링크

- 마이크로 커널 vs 모노리틱 커널
  - [리눅스 이야기: 리눅스 vs. 미닉스 1부](https://joone.net/2019/02/09/30-리눅스-이야기-리눅스-vs-미닉스-1부/)
  - [리눅스 이야기: 리눅스 vs. 미닉스 2부](https://joone.net/2019/05/26/31-리눅스-이야기-리눅스-vs-미닉스-2부/)
- [Linux Device Driver](https://tribal1012.tistory.com/154)
- [TCP/IP 네트워크 스택 이해하기](https://d2.naver.com/helloworld/47667)
- [ARM coretex-A Series Programmer's Guide for ARMv8-A](https://developer.arm.com/documentation/den0024/a/preface)
- [ARM - Learn the Architecture](https://developer.arm.com/architectures/learn-the-architecture)

## 참고한 커널 소스 코드

- [tbl 파일](https://elixir.bootlin.com/linux/v5.8.6/source/arch/x86/entry/syscalls/syscall_64.tbl)
- [alloc_register_chrdev()](https://elixir.bootlin.com/linux/v5.8.6/source/fs/char_dev.c#L268)
- [submit_bh(), ll_rw_block()](https://elixir.bootlin.com/linux/v5.8.6/source/fs/buffer.c#L3077)
- [struct gendisk](https://elixir.bootlin.com/linux/v5.8.6/source/include/linux/genhd.h#L170)
- [struct hd_struct](https://elixir.bootlin.com/linux/v5.8.6/source/include/linux/genhd.h#L54)
- [struct block_device](https://elixir.bootlin.com/linux/v5.8.6/source/include/linux/fs.h#L476)
- [bdev_inode](https://elixir.bootlin.com/linux/v5.8.6/source/fs/block_dev.c#L39)
- [block ramdisk device](https://elixir.bootlin.com/linux/v5.8.6/source/drivers/block/brd.c)

---

- [dev_alloc_skb()](https://elixir.bootlin.com/linux/v5.8.6/source/net/core/skbuff.c#L425)
- [skb_copy_expand()](https://elixir.bootlin.com/linux/v5.8.6/source/net/core/skbuff.c#L1737)
- [skb_clone()](https://elixir.bootlin.com/linux/v5.8.6/source/net/core/skbuff.c#L1429)

---

- [ksys_write()](https://elixir.bootlin.com/linux/v5.8.6/source/fs/read_write.c#L620)
- [inset_sendmsg()](https://elixir.bootlin.com/linux/v5.8.6/source/net/ipv4/af_inet.c#L807)
- [tcp_transmit_skb()](https://elixir.bootlin.com/linux/v5.8.6/source/net/ipv4/tcp_output.c#L1080)
- [ip_queue_xmit()](https://elixir.bootlin.com/linux/v5.8.6/source/net/ipv4/ip_output.c#L451)

---

- [ksys_read()](https://elixir.bootlin.com/linux/v5.8.6/source/fs/read_write.c#L596)
- [inet_recvmsg()](https://elixir.bootlin.com/linux/v5.8.6/source/net/ipv4/af_inet.c#L835)
- [sock_common_recvmsg()](https://elixir.bootlin.com/linux/v5.8.6/source/net/core/sock.c#L3260)
- [tcp_recvmsg()](https://elixir.bootlin.com/linux/v5.8.6/source/net/ipv4/tcp.c#L2015)
