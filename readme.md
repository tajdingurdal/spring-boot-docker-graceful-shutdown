- mvn clean install
- docker-compose -f .\docker\services.yaml build --no-cache
- docker-compose -f .\docker\services.yaml up

After starting the container, send an API request to test:

- docker kill --signal="SIGTERM" imageID


Here are two great articles:

https://medium.com/@gchudnov/trapping-signals-in-docker-containers-7a57fdda7d86#.qxvh1vb1e

https://medium.com/viascom/graceful-shutdowns-for-containerized-spring-boot-applications-d9c465ce4fd9
