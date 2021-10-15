cd `dirname "$0"`
docker stop sonarqube

#cd docker/sonarqube
docker-compose up -d
docker logs sonarqube -f
