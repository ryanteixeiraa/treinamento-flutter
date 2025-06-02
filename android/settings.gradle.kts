// android/build.gradle.kts (NÍVEL DO PROJETO)
plugins {
    // O id("com.android.application") e id("org.jetbrains.kotlin.android")
    // JÁ ESTÃO SENDO DECLARADOS com versões no seu settings.gradle.kts.
    // Portanto, eles NÃO PRECISAM ser declarados novamente aqui se o settings.gradle.kts
    // é a fonte da verdade para as versões desses plugins no classpath.
    //
    // No entanto, a prática mais comum é declarar as versões dos plugins
    // que serão usados pelos submódulos AQUI no build.gradle.kts do projeto raiz,
    // e o settings.gradle.kts no bloco plugins lida apenas com plugins
    // que o próprio settings script precisa (como o flutter-plugin-loader).

    // Se o seu settings.gradle.kts já tem:
    //    id("com.android.application") version "8.7.0" apply false
    //    id("org.jetbrains.kotlin.android") version "1.8.22" apply false
    //
    // Então, idealmente, você não repetiria as versões no build.gradle.kts do projeto.
    // MAS, é mais comum definir as versões aqui e o settings.gradle.kts só
    // lida com os repositórios e o plugin loader do flutter.

    // ASSUMINDO A ABORDAGEM MAIS COMUM (definir versões aqui):
    id("com.android.application") version "8.7.0" apply false
    id("org.jetbrains.kotlin.android") version "1.8.22" apply false // <--- VERIFIQUE SE ESTA VERSÃO DO KOTLIN É COMPATÍVEL COM AGP 8.7.0.
    // AGP 8.x geralmente requer Kotlin 1.9.x. Tente 1.9.22 ou 1.9.23.

    // E, crucialmente para o seu erro:
    // id("com.android.library") version "8.7.0" apply false // <--- COMENTE OU REMOVA ESTA LINHA se você não tem módulos de biblioteca nativos que EXIGEM isso.
}