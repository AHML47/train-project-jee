@echo off
mkdir WebContent\WEB-INF\lib 2>nul

echo Downloading servlet-api.jar...
curl -L "https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/4.0.1/javax.servlet-api-4.0.1.jar" -o WebContent\WEB-INF\lib\javax.servlet-api-4.0.1.jar

echo Downloading mysql-connector-java.jar...
curl -L "https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.27/mysql-connector-java-8.0.27.jar" -o WebContent\WEB-INF\lib\mysql-connector-java-8.0.27.jar

echo Done! 