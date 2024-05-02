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
# 컨테이너 생성
docker create ~
# 컨테이너 시작
docker start ~
# 컨테이너 명령어 전달
docker exec
# 컨테이너 명령어 직접 실행
docker attach
```

