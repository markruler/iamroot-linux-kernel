## 개요

- 장소: 온라인 줌
- 교재: 리눅스 커널 내부구조(백승재, 최종무 저)
- 진행: 4. 메모리 관리 (4.2 물리 메모리 관리 구조)
- 참석자: 김상윤, 김수연, 김정근, 김지엽, 김태정, 윤원섭, 이경렬, 이승원, 임창수, 정홍관, 조현일, 홍은비

## 질문, 토론

1. NPTL, NGTL 차이
2. uid,euid,suid,fsuid의 개념
3. p80 deadline 관련 값은 사용자가 직접 지정하는 것인가
4. vruntime 의 reset 유무
5. 실시간 스케줄링 일반적인 사용처
6. sighandler 는 user level? kernel level?
7. kernel 레벨의 sighandler가 존재하는가?
8. 최신 멀티코어 PC는 numa인지.. (p94 각주)

## 참고 링크

- [Elixir Cross Referencer](https://elixir.bootlin.com/linux/latest/source)
- [Deadline Scheduler: 문c 블로그](http://jake.dothome.co.kr/dl-scheduler/)
- [sched_fair: vruntime and min_vruntime will be overflow?](https://linux.kernel.narkive.com/BxtudLHp/sched-fair-vruntime-and-min-vruntime-will-be-overflow)
- [Where does signal handler executed?](https://stackoverflow.com/questions/27965761/where-does-signal-handler-executed)
- [커널에서 시그널은 어떻게 처리할까?](http://rousalome.egloos.com/9987169)
- [credentials - Linux man page](https://linux.die.net/man/7/credentials)