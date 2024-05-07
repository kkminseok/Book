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
- WORKDIR: 명령어를 실행할 디렉터리 
    - `cd`와 같은 역할.
- EXPOSE: 노출시킬 포트를 설정
- CMD: 컨테이너가 시작될 때마다 실행할 명령어 
    - 한 번만 사용할 수 있음. 

```sh
# Dockerfile build
docker build -t [이미지이름]:[태그] [Dockerfile이 저장된 경로]
|-t|: 이미지 이름설정. 가급적 사용
|-f|: Dockerfile의 이름을 지정
|--no-cache|: 캐시 사용하지 않음
|--cache-from [이미지명]|: 빌드 캐시를 지정
```

