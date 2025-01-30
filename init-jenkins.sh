# Build Jenkins container image
docker build -t myjenkins-blueocean:latest .

# Create Jenkins Containr Networks
docker network create jenkins

# Run Jenkins with Blueocean UI
# Note: replace the DOCKER_HOST with the proxy containers IP address and internal port
docker run --name jenkins-blueocean --restart=on-failure --detach \
  --network jenkins \
  --env DOCKER_HOST="tcp://172.18.0.3:2375" \
  --env DOCKER_TLS_VERIFY="" \
  --env DOCKER_CERT_PATH="" \
  --volume jenkins-data:/var/jenkins_home \
  --publish 8080:8080 --publish 50000:50000 \
  myjenkins-blueocean:latest


# Get admin password
docker exec jenkins-blueocean cat /var/jenkins_home/secrets/initialAdminPassword

# Run intermediate Container os Jenkins Master Node (Docker container) can communicate
# with Docker Daemon safely on the custom Jenkins Containr Network we made
docker run -d --restart=always -p 127.0.0.1:2376:2375 --network jenkins -v /var/run/docker.sock:/var/run/docker.sock 
alpine/socat tcp-listen:2375,fork,reuseaddr unix-connect:/var/run/docker.sock