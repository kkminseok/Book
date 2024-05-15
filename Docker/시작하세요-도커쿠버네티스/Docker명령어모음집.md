# Docker 명령어 모음집

##  1. 도커 기본

```sh
# 도커데몬 실행, 중지
service docker start || dockerd(포그라운드)
service docker stop
```

### 도커 정보

```sh
docker info

### 도커 명령어 위치
which docker
```

## 2. 도커 엔진

### 도커 엔진 버전

```sh
docker -v
```


```sh
# 컨테이너 정지 하면서 빠져나오기
exit

# 컨테이너 정지 하지 않고 빠져나오기
(command) Ctrl +P, Q
```

### 도커 이미지 

```sh
# docker 이미지 목록
docker images
|--filter| => 이미지 필터 검색

```

### 도커 컨테이너 관련

```sh
# 컨테이너 실행
docker run ~
|-p|: 컨테이너 포트 바인딩 - -p [호스트의 포트]:[컨테이너의 포트]
                            -p [컨테이너 포트] => 호스트포트 랜덤 바인딩

|-d|: Detached모드로 컨테이너 실행  - 백그라운드
|-e|: 환경변수 설정
|--link|: A컨테이너에서 B컨테이너로 접근할 수 있도록 지칭(Legacy)
|--storage-opt|: 컨테이너 저장공간의 크기 제한

# 컨테이너 생성
docker create ~
# 컨테이너 시작
docker start ~
# 컨테이너 중지
docker stop ~
# 컨테이너 명령어 전달
docker exec
# 컨테이너 명령어 직접 실행
docker attach

# 컨테이너 목록
docker ps
|-a|: 모든 컨테이너 목록 출력
|-q|: 컨테이너 ID만 출력
|--format|: 컨테이너 출력결과 커스텀
    ex) docker ps --format "table {{.ID}}\t{{.Status}}\t{{.Image}}"

# 컨테이너 이름 재작성
docker rename [원본이름] [수정된 이름]

# 컨테이너 삭제
docker rm [컨테이너 명]
|-f|: 강제 삭제

# 중지된 컨테이너 모두 삭제
docker container prune

# 모든 컨테이너 정지
docker stop $(docker ps -a -q)

# 모든 컨테이너 삭제
docker rm $(docker ps -a -q)

# 컨테이너 포트바인딩 확인
docker port [컨테이너 명]

# 컨테이너 볼륨 마운트
docker run ~ -v [호스트 디렉터리]:[컨테이너 디렉터리]

# 컨테이너끼리 볼륨 마운트
docker run ~ --volumes-from [컨테이너 명]

# 컨테이너 정보
docker container inspect [컨테이너명]

# 컨테이너 자원 할당 변경
docker update [변경할 자원 제한] [컨테이너명]

# 컨테이너 메모리 제한
docker run ~ --memory="1g"  - 단위 m, g
|--memory-swap="1g"|: swap 메모리 설정

# 컨테이너 cpu 제한
docker run ~ --cpu-shares 1024 (비중설정)

# 컨테이너 특정 cpu 사용하도록 제한
docker run ~ --cpuset-cpus=2 (3번째 사용하도록)
|--cpuset-cpus="0,3"| (1,4 번째 사용)
|--cpuset-cpus="0-2"| (1,2,3번째 사용)

# 컨테이너 I/O 제한
docker run ~ --device-write-bps [디바이스이름]:[값](1mb) ~ -> 초당 쓰기작업 1mb제한
```

### 도커 볼륨

```sh
# 도커 볼륨 생성
docker volume create [--name 볼륨명] 

# 도커 볼륨 연결
docker run ~ -v [볼륨의 이름]:[컨테이너 디렉터리 경로]

# 도커 볼륨 정보 확인
docker inspect --type volume [볼륨명]

# 사용하지 않은 도커볼륨 삭제
docker volume prune
```

### 도커 네트워크

```sh
# 도커 네트워크 목록
docker network ls

# 도커 브리지 생성
docker network create --driver bridge 브리지명

# 도커 호스트 네트워크 설정
docker run ~ --net host [또는] none ~

# 도커 컨테이너 네트워크 설정
docker run ~ --net container:[컨테이너명]

# 도커 브리지 네트워크 별칭 설정
docker run ~ --net [브리지네트워크명] --net-alias [별칭]

#도커 브리지 해제
docker network disconnect [브리지명] [컨테이너명]
docker network connect [브리지명] [컨테이너명]
```

### 도커 로깅

```sh
# 도커 컨테이너 로그 확인
docker logs [컨테이너명]
|--tail [N]|: 마지막 n번째줄까지 출력
|--since [timestamp]|: timestamp이후의 로그 출력
|-f|: 실시간 로그 출력

# 도커 로그 상세 설정
docker run ~ --log-opt max-size=10k 
docker run ~ --log-opt max-file=3
..
```

### 도커 이미지

```sh
# 도커 이미지 검색
docker search [이미지명]

# 도커 이미지 생성
docker commit [Option] 컨테이너명 [저장소:태그명]

# 도커 커밋 히스토리
docker history [이미지:태그명]

# 도커 이미지, 추출 및 불러오기
docker save -o [추출할 파일명] [이미지명]
docker load [추출된 파일명]

docker export -o [추출할 파일명] [이미지명]
docker import [추출된 파일명] [만들 이미지명:태그]

# 도커 이미지 이름 추가
docker tag [기존 이미지명] [새롭게 생성될 이미지명]
```

### 도커 데몬 디버그

```sh
dockerd -D
//서비스인 경우
jounralctl -u docker || /var/log/upstart/docker.log
//실시간 로그 스트림
docker events
docker system events
|--filter| : 출력 종류 지정
//실행중 컨테이너 자원 사용량 스트림 출력
docker stats
|--no-stream| : 스트림 아닌 한 번만 출력
//도커에서 사용하고 있는 이미지, 컨테이너, 로컬 볼륭 등을 삭제할때 확보할 수 있는 공간 출력
docker system df

```

### 도커 스웜

```sh
//스웜 클러스터 정보 확인
docker info | grep Swarm

//스웜 매니저 생성
docker swarm init --adverties-addr [pulbicIP]
//토큰 값 확인
docker swarm join-token manager
//토큰 값 갱신
docker swarm join-token --rotate manager

//워커 노드 추가
docker swarm join \ --token [매니저 토큰] [매니저ip:port]
//워커 노드 삭제 (해당 노드에서)
docker swarm leave
=> 매니저 노드는 --force를 붙여야함.
//워커 노드 삭제 (매니저 노드에서)
docker node rm [워커 노드명]
//워커 노드 매니저 노드로 변경(매니저 노드에서)
docker node promote [워커 노드명]
//매니저 노드 워커노드로 변경
docker node demote [매니저 노드명]

```