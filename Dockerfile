FROM eclipse-temurin:21-jdk AS build

COPY . /app
WORKDIR /app

RUN chmod +x mvnw
RUN ./mvnw package -DskipTests
RUN mv -f target/*.jar app.jar

FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /app/app.jar .

RUN useradd -u 1000 runtime && chown -R runtime:runtime /app
USER runtime

ENV PORT=${PORT}

ENTRYPOINT java -Dserver.port=${PORT} -jar app.jar