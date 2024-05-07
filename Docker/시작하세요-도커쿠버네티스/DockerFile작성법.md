```docker
FROM ubuntu:14.04
MAINTAINER minseok
LABEL "purpose"="practice"
RUN apt-get update
RUN apt-get install apache2 -y
ADD test.html /var/www/html
WORKDIR /var/www/html
RUN ["/bin/bash", "-c", "echo hello >> test2.html"]
EXPOSE 8090
CMD apachectl -DFOREGROUND
```

- FROM: 생성할 이미지의 베이스 이미지
    - 한 번 이상 입력 필요
- MAINTAINER: 이미지를 생성한 개발자 정보 
    - 1.13.0 도커 버전 이후 사용x 
    - `LABEL maintainer "minseok <aaaa727@khu.ac.kr>` 로 대체가능
- LABEL: 이미지에 메타데이터 추가. '키:값'형태
- RUN: 컨테이너 내부에서 명령을 실행 
    - RUN ["실행 가능한 파일", "명령줄 인자 1", "명령줄 인자 2", ...]
- ADD: 파일을 이미지에 추가 
    - Dockerfile이 위치한 디렉터리(컨텍스트)에서 가져옴.
    - ["추가할 파일 이름1", "추가할 파일 이름2"...., "컨테이너에 추가될 위치"]로 사용가능. 
- COPY: 파일을 이미지에 복사
- WORKDIR: 명령어를 실행할 디렉터리 
    - `cd`와 같은 역할.
- EXPOSE: 노출시킬 포트를 설정
- CMD: 컨테이너가 시작될 때마다 실행할 명령어 
    - 한 번만 사용할 수 있음. 
- ENV: 환경변수 지정 
    - `ENV test /home` => test라는 환경변수에 /home
    - `run` 명령어에서 겹친경우 기존값은 덮어 쓰여짐.
- VOLUME: 호스트와 공유할 컨테이너 내부 디렉터리 설정
- ARG: build명령어에서 추가 인자를 받아 Dockfile 내에서 사용될 변수 지정. 기본값 지정도 가능하다.
    - `ARG my_arg`, `ARG my_Arg_2=value2`
    - `docker build --build-arg **my_arg**=/home1 -t myarg:0.0 ./`
- USER: 컨테이너 내에서 사용될 사용자 계정의 이름이나 UID설정
    - 보안 측면에서 사용하는것을 권장
- ONBUILD: 빌드된 이미지를 기반으로 하는 다른 이미지가 Dockerfile로 생성될 때 실행할 명령어 추가
- STOPSIGNAL: 컨테이너가 정지될 때 사용될 시스템 콜의 종류 지정
    - 기본은 `SIGTERM`
- **HEALTHCHECK**: 이미지로부터 생성된 컨테이너에서 동작하는 애플리케이션 상태를 체크하도록 설정
    - `curl`로 체크하므로 `curl`설치가 선행되어야함.
    - 여러 애플리케이션이 포함되어 있거나 컨테이너 관리에 용이할듯
- SHELL: 사용하려는 셸을 따로 지정하고 싶을때 사용.
    > Python, Node사용할때 사용할 수는 있을 것 같은데..
- ENTRYPOINT: 수행할 명령을 지정


```sh
# Dockerfile build
docker build -t [이미지이름]:[태그] [Dockerfile이 저장된 경로]
|-t|: 이미지 이름설정. 가급적 사용
|-f|: Dockerfile의 이름을 지정
|--no-cache|: 캐시 사용하지 않음
|--cache-from [이미지명]|: 빌드 캐시를 지정
```

