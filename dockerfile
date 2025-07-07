# Etapa de compilación con Maven ya instalado
FROM maven:3.8.6-eclipse-temurin-17 AS compile

WORKDIR /app

# Copia todo el proyecto al contenedor
COPY . .

# Compila el proyecto y genera el .jar, sin ejecutar tests para acelerar
RUN mvn clean package -DskipTests

# Etapa de producción con solo el JDK para ejecutar la app
FROM eclipse-temurin:17-jdk AS prod

WORKDIR /app

# Copia el .jar generado en la etapa de compilación
COPY --from=compile /app/target/*.jar app.jar

# Exponer puerto 8080
EXPOSE 8080

# Comando para ejecutar la app
CMD ["java", "-jar", "app.jar"]
