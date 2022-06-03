FROM amazoncorretto:11
WORKDIR app
COPY ./target/egail-1.2.2-standalone.jar ./egail-1.2.2-standalone.jar
CMD ["java", "-jar", "egail-1.2.2-standalone.jar"]