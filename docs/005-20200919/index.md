## 개요

- 참석자: 김상윤, 김정근, 김지엽, 김태정, 김형준, 박준은, 임창수, 정홍관, 홍은비
- 오늘 내용 정리: [정홍관님 노션](https://www.notion.so/2020-09-19-0f80d4c80894471c8974aa02dff235de)

## 진행 사항

- <코드로 알아보는 ARM 리눅스 커널 (2판)> 1.4 캐시부터 1.8 전력관리까지
- 다음주 코로나 확산세에 따라 오프라인 진행 예정
- 다음주 부터 [프로그래머스 가이드](https://developer.arm.com/documentation/den0024/a/)

## 질문 리스트

- [폰노이만, 하버드 아키텍쳐](https://needjarvis.tistory.com/437)
- 태그는 실제 메모리 주소와 매핑되는 주소
- 캐시 쓰기 write-through 정책 
  - 쓰기 시 캐시와 외부 메모리를 함께 갱신
- 캐시 write-back 쓰기 정책
  - 쓰기 시 캐시 라인만 갱신하고 더티 비트 설정
  - 캐시와 외부 메모리를 함께 갱신, 이때 캐시 라인과 메모리의 내용이 일치하므로 더티 비트는 설정되지 않음
- [Cache - PoC, PoU, LoC, LoU](http://jake.dothome.co.kr/cache2/)
- [MVA, VA, PA](https://developer.arm.com/documentation/ddi0344/c/programmer-s-model/addresses-in-a-processor-system)
  - [차이점](https://stackoverflow.com/questions/57250796/difference-between-virtual-address-and-modified-virtual-address-in-arm-architect)
- [TLB](https://developer.arm.com/architectures/learn-the-architecture/memory-management/tlb-maintenance)
- [TTBR](https://developer.arm.com/documentation/den0024/a/the-memory-management-unit/separation-of-kernel-and-application-virtual-address-spaces)
- 테이블 디스크립터에서의 level 의미
  - 그림 1-20, 1-21 참조
- [다른 에이전트 간에 공유가 가능한이 여부를 결정? 에이전트란?](https://community.arm.com/developer/ip-products/processors/f/cortex-a-forum/3238/the-exact-definition-of-outer-and-inner-in-armv7)
- Exclusive Monitor에 대한 이해
  - [local exclusive monitor & global exclusive monitor](http://cloudrain21.com/local-exclusive-monitor-global-exclusive-monitor)
  - [Exclusive Monitor and LDXR/STXR Instruction](https://tot0rokr.github.io/arm64/synchronization/exclusive-monitor/)
- [AMBA AXI and ACE Protocol Specification](https://developer.arm.com/documentation/ihi0022/latest)
- [Cache – Coherent: MOESI](http://jake.dothome.co.kr/cache4/)
- [CCI-400](https://developer.arm.com/documentation/den0024/a/multi-core-processors/bus-protocol-and-the-cache-coherent-interconnect)

## 추후 조사 리스트

- 캐시에서 웨이 및 세트
- PoC, PoU
→ 메모리 바라보는 관점? 일관성 유지?, 정확한 개념 이해
- 블록 엔트리에 대한 정확한 이해
- cacheable, noncacheable을 나누는 정확한 기준
- 캐시의 일관성, 100% 신뢰 가능한가?

## 기타 의견

- 슬슬 온오프 모임으로 전환 시기 조율
