FROM openjdk
MAINTAINER Serhii Klymoshenko "Serhii_Klymoshenko@epam.com.com"
#WORKDIR /home/app
COPY  target/*.jar ./

EXPOSE 8080
EXPOSE 80
CMD ["java", "-jar", "spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar"]

