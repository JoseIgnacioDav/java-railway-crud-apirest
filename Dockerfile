FROM eclipse-temurin:21-jdk AS build

COPY . /app
WORKDIR /app

RUN chmod +x mvnw
RUN ./mvnw package -DskipTests
RUN mv -f target/*.jar app.jar

FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /app/app.jar .

RUN useradd runtime && chown -R runtime:runtime /app
USER runtime

# Declarar el argumento por defecto para evitar el aviso de variable no definida
ARG PORT=8080
ENV PORT=${PORT}

# Usar formato JSON recomendado
ENTRYPOINT ["java", "-jar", "app.jar"]