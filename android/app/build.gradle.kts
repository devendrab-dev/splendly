plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services")     
    id("com.google.firebase.crashlytics")   
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.devendra.money_tracker"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.devendra.money_tracker"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")

            // ENABLE Crashlytics symbol upload
            firebaseCrashlytics {
                nativeSymbolUploadEnabled = true
                unstrippedNativeLibsDir =
                    file("build/intermediates/merged_native_libs/release/out/lib")
            }
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // This is REQUIRED for Crashlytics plugin 3.x
    implementation("com.google.firebase:firebase-crashlytics-ktx:18.6.1")
}