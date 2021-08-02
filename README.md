##### command to build docker image
docker build --no-cache --pull -t myjenkins . 

##### create network if not present
docker network create jenkins

##### command to run docker image
docker run \
  --name myjenkins \
  --rm \
  --detach \
  --network jenkins \
  --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client \
  --env DOCKER_TLS_VERIFY=1 \
  --env PLUGINS_FORCE_UPGRADE=true \
  --env TRY_UPGRADE_IF_NO_MARKER=true \
  --publish 8080:8080 \
  --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
myjenkins

to get list of all plugins in currrent installation of jenkins to plugins.txt

curl -sSL "http://admin:admin@localhost:8080/pluginManager/api/xml?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins" | perl -pe 's/.*?<shortName>([\w-]+).*?<version>([^<]+)()(<\/\w+>)+/\1 \2\n/g'|sed 's/ /:/' >> plugins.txt