## 개요

- 참석자: 김상윤, 김정근, 김지엽, 김태정, 김형준, 임창수, 정홍관, 홍은비
- 진도: ARM Programmer's Guide, Chapter 6. The A64 instruction set
- 내용정리: [정홍관님 노션](https://www.notion.so/2020-09-26-f4d73337cd7a4d47a4615d22da2c4dbd)

## 진행 사항

- ARM Cortex-A Series Programmer's Guide 시작

## 질문 리스트

- 빅,리틀 구조/ 왜 A53, A57밖에 없는지?
  - 최신화 반영 안된듯
  - A53은 리틀, A57은 빅으로 주로 사용됨
- Rich OS, 풍부한 OS?
  - [What is a Trusted Execution Environment (TEE)?](https://www.trustonic.com/technical-articles/what-is-a-trusted-execution-environment-tee/)
- [Trustzone for Cortex-A](https://www.arm.com/why-arm/technologies/trustzone-for-cortex-a/tee-and-smc)
- Host OS도 하이퍼 바이저가 필요한가?
  - [🎯 KVM-ARM](https://selfish-developer.com/entry/KVM-ARM)

## 추후 조사 리스트

- Trusted OS가 호스트 OS를 뜻하는건지? 

  - [How is arm trusted OS is different from normal OS?](https://stackoverflow.com/questions/50093672/how-is-arm-trusted-os-is-different-from-normal-os)
  - [🎯 Introduction to Trusted Execution Environment: ARM's TrustZone](https://blog.quarkslab.com/introduction-to-trusted-execution-environment-arms-trustzone.html)

## 결정사항

- 다음주에 head.S 코드 들어갑니다.
- on/off 모임 시작 
  - 기준 : 2단계 이하, off 신청 3명 이상
  - 월요일 모집, 화요일 예약
  - GitHub에 [단체명 계정](https://github.com/iamroot17th6)
  - kernel 5.9 RC 준비
  - 천천히 라인 바이 라인으로 천천히 분석할 예정