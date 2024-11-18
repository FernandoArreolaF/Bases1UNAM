plugins {
    id("java")
}

group = "org.example"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral() // Asegura que las dependencias se descarguen desde Maven Central
}

dependencies {
    // Dependencia del controlador JDBC para PostgreSQL
    implementation("org.postgresql:postgresql:42.6.0")

    // Dependencias para pruebas con JUnit
    testImplementation(platform("org.junit:junit-bom:5.10.0"))
    testImplementation("org.junit.jupiter:junit-jupiter")
}

tasks.test {
    useJUnitPlatform() // Configura el uso de JUnit 5
}
