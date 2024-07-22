docker run -d \
--name catalog-service \
--net catalog-network \
-p 9001:9001 \
-e SPRING_DATASOURCE_URL=jdbc:postgresql://polar-postgres:5432/polardb_catalog \
-e SPRING_PROFILES_ACTIVE=testdata \
catalog-service

# v2 gradlew
./gradlew bootBuildImage \
--imageName ghcr.io/kkminseok/catalog-service \
--publishImage \
-PregistryUrl=ghcr.io \ 
-PregistryUsername=kkminseok \
-PregistryToken=ghp
