FROM eclipse-temurin:17-jdk

WORKDIR /app

RUN apt-get update && apt-get install -y dumb-init

COPY target/graceful-shutdown-0.0.1-SNAPSHOT.jar app.jar
COPY run_application2.sh /etc/run_application2.sh

RUN chmod +x /etc/run_application2.sh

EXPOSE 8080

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/etc/run_application2.sh"]