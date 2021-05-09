pipeline {
  options {
    timeout(time: 5)
  }

  environment {
    SDKROOT = "/data0/srv/jenkins/jobs/noisepollutionlocator_71_android_app_build/workspace /android-sdk/cmdline-tools/"
    SDKMGR = "${SDKROOT}bin/sdkmanager"
  }

  stages {
    stage('Setup CI') {
      steps {
        sh """
          echo 'Adding gradle and android-sdk to path"
          export PATH="$PATH:
          export PATH="$PATH:/srv/jenkins/flutter/flutter/bin" && \
flutter --version && dart --version && \
flutter pub get && flutter pub outdated && flutter pub upgrade && \

export PATH="$PATH:/srv/jenkins/flutter/flutter/bin:/srv/jenkins/gradle/gradle-6.7/bin" && \
gradle wrapper --gradle-version 6.7 && ./gradlew -b /data0/srv/jenkins/jobs/noisepollutionlocator_71_android_app_build/workspace/android/app/build.gradle build
          echo 'Installing android-sdk'
          wget https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip
          mkdir ${env.WORKSPACE}/android-sdk
          unzip -d ${env.WORKSPACE}/android-sdk/ commandlinetools-linux-6858069_latest.zip
          ${env.SDKMGR} --sdk_root=${env.SDKROOT} --update
          yes | ${env.SDKMGR} --sdk_root=${env.SDKROOT}"platforms;android-25"
          yes | ${env.SDKMGR} --sdk_root=${env.SDKROOT} "build-tools;25.0.2"
          yes | ${env.SDKMGR} --sdk_root=${env.SDKROOT} "extras;google;m2repository"
          yes | ${env.SDKMGR} --sdk_root=${env.SDKROOT} "extras;android;m2repository"
          yes | $(yes | ${env.SDKMGR} --sdk_root=${env.SDKROOT} --licenses)

          echo 'sdk.dir=${env.WORKSPACE}/android-sdk/cmdline-tools' > android/local.properties

          echo 'Installing flutter'
          mkdir flutter

          echo 'Installing gradle'
          mdkir gradle
        """
      }
    }
    stage('Make gradle wrapper') {
      setps {
        sh """
          echo 'Making gradle wrapper'
          cd android && touch local.properties && \
          echo 'sdk.dir=/data0/srv/jenkins/jobs/noisepollutionlocator_71_android_app_build/workspace/android-sdk/cmdline-tools' > local.properties && \
          echo 'flutter.sdk=/srv/jenkins/flutter/flutter' >> local.properties
        """
      }
    }
    stage('Build app') {
      setps {
        sh """
          echo 'Building android app'
          ./gradlew build
        """
      }
    }
  }

  post {
    always {
      cleanWs()
    }
  }
}