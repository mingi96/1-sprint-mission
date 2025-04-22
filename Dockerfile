FROM gradle:8.5-jdk17-alpine AS builder

WORKDIR /app

COPY --chown=gradle:gradle . .

RUN ./gradlew build --no-daemon

FROM amazoncorretto:17

WORKDIR /app

ENV PROJECT_NAME=discodeit
ENV PROJECT_VERSION=1.2-M8

ENV JVM_OPTS=""

COPY --from=builder /app/build/libs/${PROJECT_NAME}-${PROJECT_VERSION}.jar app.jar

EXPOSE 80

ENTRYPOINT ["sh", "-c", "java $JVM_OPTS -jar app.jar"]
