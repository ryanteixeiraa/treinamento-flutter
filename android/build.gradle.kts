// android/build.gradle.kts (Nível do Projeto)

plugins {
    // Definir as versões dos plugins aqui é a abordagem moderna.
    // O apply false significa que eles são adicionados ao classpath para serem usados pelos submódulos.
    id("com.android.application") version "8.7.0" apply false
//    id("com.android.library") version "8.7.0" apply false // Se você tiver módulos de biblioteca Android
    id("org.jetbrains.kotlin.android") version "1.9.22" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
        // Você pode precisar adicionar outros repositórios se seus plugins exigirem,
        // por exemplo, jitpack.io
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// Opcional: Se você realmente precisa do buildDirectory customizado.
// Caso contrário, remova estas linhas para usar o padrão.
// val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
// rootProject.layout.buildDirectory.value(newBuildDir)
// subprojects {
//     val newSubprojectBuildDir = newBuildDir.dir(project.name)
//     project.layout.buildDirectory.value(newSubprojectBuildDir)
// }