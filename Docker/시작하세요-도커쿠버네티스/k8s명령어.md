### minikube

```sh
# 포트포워딩
minikube service <서비스명>
```

### 공통

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



