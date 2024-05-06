# Docker 명령어 모음집

##  1. 도커 기본

### 도커 정보

```sh
docker info
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

### 도커 이미지 목록

```sh
docker images
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
