### 책 정보

- 도메인 주도 개발 시작하기 저자
- 2025년 4월28일 발행 따끈따근한 책

### 1장 들어가며

- 초보 개발자가 흔히 저지르는 실수 예시를 이야기하며 성능, 외부 연동, 보안 등 반드시 알아야할 여러 주제의 기초적인 내용을 다룰 것임을 암시하고 있다.

### 2장 느려진 서비스, 어디부터 봐야 할까

- 처리량과 응답시간에 대한 개념 설명을 진행하고 있다. 성능저하가 발생시 체크해봐야할 부분이 크게 보자면 위 2개이기 때문이다.
- <span style="color:#eb6420;">응답시간 기준, 대체적으로 DB연동과 외부 API 연동에서 많은 시간을 잡아먹는다.</span>
    - 때문에 이부분을 중점적으로 확인한다한다. 그래서 외부 API 연동 시간을 줄이는 가상 쓰레드같은 개념들이 나온걸까? 생각하게 된다.
- 처리량 기준, TPS를 확인하여 성능 개선을 해나가야한다.
    - 동시에 처리할 수 있는 요청 수를 증가시키거나 한 개 요청을 처리하는 시간을 단축시켜 개선이 가능하다.
-   대부분 서비스가 커지면서 성능 이슈가 발생
    -   모니터링 도구를 이용
    -   주로 DB연동이나 외부 API 연동에서 발생
-   서버관점에서 처리량 및 응답 시간을 개선하여 해결해줄 수 있는 것
    -   수직 확장
        -   단기간 해결이 가능하지만 결국 또다시 성능 문제로 이어짐. 비용 문제도 발생
    -   수평 확장
        -   서버를 늘리고 로드밸런싱을 통한 분산처리
        -   주의점
            -   DB병목, 외부API병목인데 서버를 늘린다해서 해결이 안됨. 오히려 부하가 더 심하게 발생함.
    -   DB 커넥션 풀
        -   커넥션 풀 크기: 미리 생성해둘 커넥션 갯수 지정
            -   크기를 증대하면 처리량이 늘릴 수 있지만 DB에 부하가 증가할 수 있음.
        -   커넥션 대기 시간
            -   긴 시간 무응답으로 대기하는 것 보다 사용자가 에러를 인지할 수 있게 하는 것도 괜찮다.
                -   사용자가 취소하고 재시도할 수 있는 경우 오히려 부하가 증가
        -   최대 유휴 시간, 유효성 검사, 최대 유지시간
            -   최대 유휴 시간은 사용되지 않은 커넥션을 풀에 유지할 수 있는 최대 시간.
            -   유효성 검사는 커넥션이 정상적으로 사용할 수 있는 상태인지 여부를 확인하는 절차.
            -   최대 유지시간은 커넥션이 생성되지 강제로 닫을때까지의 시간. 즉 4시간으로 설정하면 4시간 뒤에는 커넥션이 유효해도 커넥션을 닫고 풀에서 제거
    -   서버 캐시
        -   많은 데이터를 저장하여 hit rate를 높힐 수 있지만 메모리 문제로 TTL을 설정하거나 삭제 전략을 선택하여 효율성을 올리자.
        -   자주 바뀌지 않고 데이터 규모도 작다면 로컬 캐시 고려하는것도 방법
        -   만약 트래픽이 급증하는 부분이 예상된다면 캐시에 미리 데이터를 적재해서 보여주는것도 방법
    -   GC, 메모리 사용
        -   적당한 힙크기를 설정해야 STW시간을 최적화할 수 있다.
        -   <span style="color:#eb6420;">API 조회 범위도 제한해야 한 번에 메모리에 올리는 양이 줄어든다.</span>
        -   <span style="color:#eb6420;">파일 다운로드 같은 것은 스트림형태로 구현하여 한 번에 많은 트래픽을 받아 메모리가 터지는 일을 줄이자.</span>
    -   응답 데이터 압축
        -   html,css, js, json과 같이 텍스트로 구성된 응답은 압축하면 데이터 전송량을 크게 줄일 수 있음.
    -   브라우저 캐시, CDN이용
        -   나는 서버 개발자라 그렇구나 하고 넘어갔다. css,js같이 무거운 파일들을 대상으로 처리하면 좋을듯하다.


### 3장 성능을 좌우하는 DB 설계와 쿼리

- 조회 기능과 트래픽 규모를 고려하여 인덱스 설계를 잘하자.
    - 때에 따라선 복합 인덱스도 사용하자.
    - 선택도가 높은 컬럼을 골라야한다. 하지만 모든 상황에 적용되는건 아니다.
    - **커버링 인덱스** 활용하자
    - 인덱스도 데이터이기에 필요한 만큼만 추가하자.
    - 서브쿼리로 집계를 해야하는 경우 별도 집계테이블을 떼서 계산한 값을 미리 저장하는 것도 좋은 방법이다.
        - 비정규화 괜찮나요? -> 요구사항에 따라 다르지만 집계 자체가 핵심 기능이 아니라면 몇 개 틀어져도 괜찮고, 이는 언제든 맞출 수 있다.
        - 동시성 문제 -> 트랜잭션 격리 수준에서 원자적으로 처리하는지 검증이 필요하다.
    - Id값을 기준으로 조회하면 성능이 더 빨라질 수 있다.
        - 모바일 환경(무한스크롤)에서는 적합할 듯으로보임. Web(페이지네이션)으로 하는것은 데이터가 비정확하지 않을까란 문제가 있다고 생각듦.
    - <span style="color:#eb6420;">**전체 갯수(count)를 사용하는건 성능저하의 원인이 존재하니 기획자나 서비스 담당자에게 이를 인지시키도록하자.**</span>
    - 오래된 데이터는 삭제
        - 요구사항에 따라 삭제해도 데이터는 삭제(히스토리성 같은 데이터)
- 알아두면 좋을 몇 가지 주의사항
    - 쿼리 타임아웃 설정
    - Master-slave구조 데이터베이스의 경우, 조회는 무조건 Slave, 변경은 Master에서 무조건 수행하는건 아니다. 순간적으로 데이터가 일치하지 않을 경우가 있기에(복제 지연)요구사항에 따라 Master DB에서 읽어야할 때도 있다.
    - 조인하는데, 두 컬럼의 타입이 다른경우 캐스팅을 먼저 진행하면 인덱스가 활성화될 수 있다.
    - **테이블 컬럼 변경은 정말 신중해야한다** 
        - 동작 과정이 새 테이블 생성 -> 기존 데이터 복사 -> 새 테이블로 대체 과정을 거치기 때문이다.

### 4장 외부 연동이 문제일 때 살펴봐야 할 것들

- 타임아웃
    - 타임아웃을 설정해야 병목현상을 줄일 수 있다. 빠른 응답시간을 제공할 수 있다.
    - 연결 타임아웃, 읽기 타임아웃도 활용할 수 있으면 하자.
- 재시도
    - 요구사항에 따라. 단순 조회, 연결 타임아웃, 멱등성을 지닌 기능인 경우
    - 재시도를 많이하면 이 또한 병복이나 같은 내용을 2번 이상 읽으려고 하는 등의 문제가 생길 수 있다.
- 요청 처리 제한
    - 한 번에 요청 보내는 갯수를 줄이고 나머지 요청에 대해서는503 에러 코드같은것을 반환해 클라이언트에 과부하 상황임을 알리는 방법도 고려해보자.
- 외부 연동과 DB 연동
    - 외부연동에서 타임아웃이 난 경우에는 트랙잰션 롤백을 하면 됨.
    - 외부연동에서 읽기 실패되었는데 외부 API에서 계산로직같은게 포함되어있다면 롤백을 해도 외부서버에서의 롤백은 안됨.
        - 성공여부를 응답에 포함시켜 이를기준으로 롤백 판단
        - 이 마저도 타임아웃이 난다면? ...
    - 외부연동은 성공했는데 DB에서 실패하면
        - 외부연동에 취소 API를 보내, 이전 상태로 되돌려야함.
- HTTP 커넥션 풀
    - HTTP 커넥션 풀 크기, 풀에서 커넥션 가져올때까지 대기시간, 커넥션 유지시간을 적절하게 설정할 필요가 있음.
        - 커넥션 풀을 늘리면 많은 요청을 받지만 부하가 들고, 커넥션 대기시간을 줄이면 빠른 응답을 받을 수 있지만 적정 수준이 필요하다.
- 이중화고려
    - 단, 재정/ 핵심 서비스인지 체크 필요


### 5장 비동기 연동, 언제 어떻게 써야 할까

- 비동기를 고려해야할때
    - 약간의 시차가 있어도 되는 경우(즉, 순서보장이 아니여도 되는 경우)
    - 일부 기능은 실패했을때 재시도가 가능한 경우
    - 연동 실패시 수동으로 처리가 가능한 기능이 있는 경우
    - 연동에 실패했을때 무시해도 되는 경우
- 비동기를 구현하기 위한 다양한 방법
    - 별도 쓰레드 실행
        - 별도 쓰레드 생성
        - 쓰레드 풀 이용
    - 메시징
        - 메시지 송수신자 서로 성능에 대한 영향을 잘 받지 않음. 메시징 시스템에서 알아서 처리량에 맞게 전달할 수 있음. 
        - 확장성 용이. consumer가 추가되는 경우 코드 수정없이 이벤트 연결만 하면됨.
        - 고려사항
            - 메시지 유실: 무시, 재시도, 실패로그 남겨 수동처리
            - 중복 메시지 수신: 메시지 고유id로 판단하여 중복처리
        -  **트랜잭션 아웃박스 패턴**
            - 메시지 데이터를 DB에 보관 후 메시징 보냄.(메시지 유실 방지)
            -  중계 시스템이 DB읽고 메시지 전송. 
            - 발송 완료 표시는 테이블에 저장하거나 파일에 마지막 메시지id를 기록하는 방식이 있는데, 이중화 시스템에서는 동시성 문제 때문에 마지막 메시지id를 기록하는 방식이 나을 수 있다.
    - 배치 전송
    - CDC(Change Data Capture)


### 6장 동시성, 데이터가 꼬이기 전에 잡아야 한다.

- 동시성 문제에 대한 설명
    - <span style="color:#eb6420;">Spring의 경우 싱글톤 객체에서 발생하는 동시성 문제</span>
- 프로세스 수준에서의 동시 접근 제어
    - `lock`을 이용한 접근 제어 + synchronized, ReentrantLock
    - 읽기 쓰기 잠금(패턴)을 이용한 동시 접근 제어 가능
    - 원자적 타입(Atomic)
        - lock보다는 CPU효율이 높음.
    - 동시성 지원 컬렉션
- DB와 동시성
    - 트랜잭션이 모든걸 해결해주지는 않는다.
        - 비관적, 낙관적 잠금을 통한 해결법
        - 비관적잠금: 데이터에 먼저 도달한 트랜잭션이 잠금 획득, 비관적인 이유는 정상 처리될 확률이 낮기 때문임. 때문에 프로세스 락 = 분산 잠금도 있음
        - 낙관적잠금: 데이터 비교해서 잠금. 비교적 성공률이 높아서 낙관적 잠금
    - 증분쿼리로 해결할 수 있는지도 확인 필요
- 주의사항
    - 잠금 반드시 해제
    - 잠금 대기시간 필요 여부 확인(병목현상 때문) - 데드락 회피
- 단일 스레드로 처리
    - 중간에 작업 큐를 둬서(단일 쓰레드로 동작하는) 로직을 처리하는 방법
    - 구조는 복잡해짐


### 7장 IO병목, 어떻게 해결하지

- 트래픽이 증가하면 IO 대기, 컨택스트 스위칭으로 인한 CPU낭비 및 요청마다 스레드할당해서 메모리 사용량이 높아진다.
- 가상 스레드, 고루틴 등을 사용
    - 경량 스레드로 이루어짐. 
    - Java24에서 제공하는 가상쓰레드 이야기
    - IO 중심작업에서 효율이 좋은편.
- 논블로킹IO 고려
    - 리액터 패턴(이벤트 루프) 사용 고려(프레임워크로 해결하여 고민 줄이기)
- **성능 문제 없는데 성능 높이겠다며 기술을 채택하지말자.**

### 8장 실무에서 꼭 필요한 보안 지식

-   인증과 인가
    -   사용자 식별자 저장하는데에는 크게 2가지 방법 존재
        -   토큰과 매핑되는 식별정보를 별도 저장소에 저장
            -   세션에 저장: 스프링의 서블릿 세션, 단점은 이중화에서는 동일한 세션 값을 가지지 않는다는 것
            -   외부 저장소에 저장: 토큰을 위한 저장소 용량이 필요하지만 엄청 규모가 크지 않은이상 감당이 가능
        -   토큰 자체에 식별 정보를 포함
            -   대표적인게 **jwt** 세션과 달리 수평확장이 쉬움. 데이터 주고받으렉 늘어나서 네트워크 트래픽이 증가, 서버에서 제거 불가, 즉 탈취 당했을때의 별도 정책이 필요할 수 있음, 쿠키를 통해 주고 받거나 헤더를 통해 주고 받음.
            -   **클라이언트 ip와 토큰, 유효시간을 주고받아서 보안을 증대할 수 있음.** IP가 다르면 탈취당한걸로 간주.
        -   토큰을 API에서 받아서 식별하지 말자.
-   데이터 암호화
    -   비밀번호 같은건 평문으로 디비에 저장하지 말아야함.
    -   단반향 암호화: 데이터를 암호화하면 복호화할 수 없음. salt방식을 통해 보안 강화가 가능. 단방향 암호화는 원본 데이터에 대해 항상 동일한 해시 값이 생성되기 때문. 이를 레인보우 테이블이라 하는데 이를 기준으로 계속 시도해서 비밀번호 탈취가 가능하기 때문. 때문에 salt방식을 통해 원본 데이터를 알기 힘들게 함.
        -   양방향 암호화: 데이터 암호화하면 복호화 가능
            -   대칭 키 방식: 암호화, 복호화를 같은 키를 가지고 함. 키의 보안이 매우 중요.
            -   비대칭 키 방식: 공개키, 개인키 있음. IV를 통하여 같은 원본 데이터라도 매 번 암호화된 값이 달라짐.
    -   hmac: 데이터 보낼때 비밀키를 이용하여 암호화하고 이를 같이 서버측에보냄
        -   이점: 서버측에서는 원본 데이터가 중간에 변조되지 않았는지 확인.
        -   단점: 비밀키 관리 어려움.
    -   방화벽: 인바운드, 아웃바운드 포트관리 할 수 있음 하자.
    -   로그인/로그아웃 내역, 설정 변경 내역 등 감사로그를 남기자.
    -   API나 동일한 Url을 너무 자주 호출하면 부정 사용으로 간주하여 조치를 취하는 것도 방법
    -   시큐어 코딩: 대표적으로 쿼리 문자열에 변수를 추가하여 사용하지말고, Prepared statement를 통해 SQL 인젝션 등을 막자.
    -   개발자 개인도 PC가 해킹당할 수 있으니, 이를 생각하여 개발하자.

### 9장 최소한 알고 있어야 할 서버 지식

-   파일권한 읽는법, OS에서의 사용자 계정, 프로세스 모니터링, 파일디스크립터 관리법, 서버와 OS간 시간 동기화, 크론 스케줄링, alias사용하기, 네트워크 정보 확인
-   **이 챕터는 대강 알고 있는 내용이므로 딱히 정리할 필요는 없어보임.**


### 10장 모르면 답답해지는 네트워크 기초

- 말그대로 네트워크 기초에 관한 챕터
- 노드, 네트워크, 라우터, IP주소, 도메인, NAT, VPN, TCP, UPD, QUIC에 대한 개념
    - *기초적인 내용이라 정리할건 없음*

### 11장 자주 쓰는 서버 구조와 설계 패턴

- 여러 아키텍트에 대한 내용
- MVC패턴(Model-View-Controller)
    - 비즈니스 로직을 처리하는 모델과 결과를 생성하는 뷰 분리
    - 애플리케이션의 흐름 제어나 사용자의 요청 처리는 컨트롤러에 집중
- 계층형 아키텍처
    - 하위 계층은 상위 계층에 대한 의존을 갖지 않음. 대표적으로 (표현 -> 응용 -> 도메인 -> 인프라)
 - DDD와 전술 패턴
     - 이 부분은 저자가 쓴 다른 책을 읽는게 더 깊게 학습할 수 있음.
 - 마이크로서비스 아키텍처
     - **모놀리식과 비교한 장단점이 있음. 여러가지 고려해서 적용하는것이 좋다.**
 - 이벤트 기반 아키텍처
     - 독립적 배포 이점
 - CQRS 패턴
     - 명령을 위한 모델과 조회를 위한 모델을 분리
     - 단일 모델로 조회와 생성 등을 수행할 때 불필요한 속성들을 너무 많이 지닌경우 이를 통해 해결 서로 영향을 줄 수 있기 때문
     - 단점으로는 작성해야할 코드가 늘어남. 구현 기술도 늘어날 수도 있음.

### 부록 A 처음 해보는 성능 테스트를 위한 기본 정리

- 성능 테스트 종류
    - 부하 테스트
    - 스트레스 테스트
    - 지속 부하 테스트
    - 스파이크 테스트
- 포화점: 성능이 저하되기 전의 최대 처리량
- 버클존: 포화점을 지나 성능이 꺾이기 시작하는 구간

- NoSQL 이해하기
- DB로 분산 잠금 구현하기


### 전체 서평

전반적으로 도움되는 얘기는 많았다. 내용 자체도 어렵지는 않고 딱 봤을때 '아~ 그럴 수 있겠다' 정도로 가볍게 넘어갈 수 있는 내용들이였다. 그렇다고 내용자체는 가벼운건 아니였다.

사실 DB, 외부연동, 비동기 관련해서는 접할 일도 많고 나같은 주니어 백엔드 개발자들은 고려할 것도 많았는데, 그런 부분을 잘 언급해준 것 같다. 
중간에 네트워크 기초 이부분은 조금 지루했지만, 내가 생각했을때 내가 다른 개발자들에 비하여 네트워크에 접할 일이 많았던거고 나와 다른 개발자들은 네트워크쪽에 대한 이해가 부족했을 수도 있다. 그리고 나도 책을 읽으면서 환기해서 좋았다.

결국엔 내가 ebook에서 대여해서 읽기 시작했지만 종이책으로 살만큼 소장할만한 가치가 있는 책이였고, 

5점 만점에 4점을 매기겠습니다.
