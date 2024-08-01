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



