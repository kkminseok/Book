```sh
#오브젝트 종류 확인
kubectl api-resources

# 오브젝트 간단한 설명
kubectl explain pod

# 쿠버네티스에 생성
kubectl apply -f ~.yaml

# 특정 오브젝트의 목록 확인
kubectl get pods

# 생성된 리소스의 자세한 정보 출력
kubectl describe pods <오브젝트 이름>

# 포드 컨테이너 내부에 직접 들어가기
kubectl exec -it <오브젝트 이름> bash

# 포드 로그 확인
kubectl logs <오브젝트 이름>

# 오브젝트 삭제
kubectl delete -f ~.yaml

# 포드 라벨 확인
kubectl get pods --show-labels

# 포드 편집
kubectl edit pods <오브젝트 명>
```

### 레플리카셋

```sh
# 레플리카셋 확인
kubectl get rs

# 레플리카셋 삭제
kubectl delete rs <오브젝트 이름>
```

### 디플로이먼트

```sh
# 디플로이먼트 목록 출력
kubectl get deployment

# 디플로이먼트 삭제
kubectl delete deploy my-nginx-deployment

# 디플로이먼트에 생성된 이미지 변경
# record는 변경사항을 저장한다는 뜻 deprecated예정인데 이후에는 애노테이션 사용해야함.
kubectl set image deployment <디플로이먼트명> 이미지이름=바꿀이미지:태그 --record

# 디플로이먼트 리비전 확인
kubectl rollout histroy deployment <디플로이먼트명>

# 디플로이먼트 롤백
kubectl rollout undo deployment <디플로이먼트명> --to-revision=돌아갈항목idx

# 디플로이먼트 상세정보
kubectl describe deploy <디플로이먼트명>
```


### 서비스

```sh
# 서비스 목록 출력
kubectl get services

# 서비스 삭제
kubectl delete svc <서비스명>
kubectl delete -f ~.yaml

# NodePort Port 범위지정
--service-node-port-range=30000-35000
```

### 네임스페이스
```sh
# 네임스페이스 목록 가져오기
kubectl get namespaces
kubectl get ns

# 네임스페이스 생성
kubectl create namespace <namespace 이름>

# 모든 네임스페이스 리소스 확인
kubectl get pods --all-namespaces

# 네임스페이스 삭제
kubectl delete namespace <namespace 이름>
```

### 컨피그맵
```sh
# 컨피그맵 생성
kubectl create configmap <컨피그맵 이름> <각종 설정값들>
|--from-literal|: 문자열 저장
|--from-file|: 파일 저장
|--from-env-file|: 여러개의 키-값 형태의 내용으로 구성된 설정파일 한 번에 가져올 수 있음.

# 컨피그맵 출력
kubectl get cm
```

### 시크릿

```sh
# 시크릿 생성
kubectl create secret gerneric <시크릿 명> [o] key=value
[o] => |--from-literal|: 컨피그맵 속성과 동일
    => |--from-file|: 컨피그맵 속성과 동일
    => |--from-env-file|: 컨피그맵 속성과 
# generic은 시크릿의 종류

# 시크릿 목록 출력
kubectl get secrets

# 도커 레지스트리에 접근
kubectl create secret docker-registry <시크릿 이름> \
--docker-username=<도커 유저명> \
--docker-password=<도커 패스워드> \
--docker-server=<사설 레지스트리 주소, 필수값은 아님>

# TLS용 시크릿 생성
kubectl create secret tls <시크릿 이름> \
--cert <crt> --key <key>

# kustomization.yaml로부터 시크릿 생성
kubectl apply -k ./

# kustomization.yaml로부터 생성한 시크릿 삭제
kubectl delete -k ./
```

### 인그레스

```sh
# 인그레스 목록
kubectl get ingress
```