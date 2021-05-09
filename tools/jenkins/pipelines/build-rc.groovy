pipeline {
  options {
    timeout(time: 5)
  }

  environment {
    //SDKROOT = "${env.WORKSPACE}/android-sdk/cmdline-tools/"
    //SDKMGR = "${SDKROOT}bin/sdkmanager"
    FLUTTER_DIR = "/srv/jenkins/flutter/flutter"
    GRADLE_DIR = "/srv/jenkins/gradle/gradle-6.7"
  }

  stages {
    stage('Setup CI') {
      steps {
        sh """

          echo '${env.WORKSPACE}'
          echo 'Check WS cleaned up'
          if ! \$(cd android-sdk 2> /dev/null); then exit 1; fi

          echo 'Installing android-sdk'
          wget https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip
          mkdir ${env.WORKSPACE}/android-sdk
          unzip -d ${env.WORKSPACE}/android-sdk/ commandlinetools-linux-6858069_latest.zip
          ${env.SDKMGR} --sdk_root=${env.SDKROOT} --update
          yes | ${env.SDKMGR} --sdk_root=${env.SDKROOT}"platforms;android-25"
          yes | ${env.SDKMGR} --sdk_root=${env.SDKROOT} "build-tools;25.0.2"
          yes | ${env.SDKMGR} --sdk_root=${env.SDKROOT} "extras;google;m2repository"
          yes | ${env.SDKMGR} --sdk_root=${env.SDKROOT} "extras;android;m2repository"
          yes | \$(yes | ${env.SDKMGR} --sdk_root=${env.SDKROOT} --licenses)

          echo 'Setting env variables for gradle build'
          echo 'sdk.dir=${env.WORKSPACE}/android-sdk/cmdline-tools' > android/local.properties
          echo 'flutter.sdk=/srv/jenkins/flutter/flutter' >> local.properties  

          echo 'Adding flutter and gradle to path'
          export PATH="\$PATH:${env.FLUTTER_DIR}/bin:${env.GRADLE_DIR}/bin"

          echo 'Install flutter deps'
          flutter --version && dart --version
          flutter pub get && flutter pub outdated && flutter pub upgrade        
        """
      }
    }
    stage('Make gralde wrapper') {
      setps {
        sh """
          echo 'Adding flutter and gradle to path'
          export PATH="\$PATH:${env.FLUTTER_DIR}/bin:${env.GRADLE_DIR}/bin"

          echo 'Make gradle wrapper'
          gradle wrapper --gradle-version 6.7
        """
      }
    }
    stage('Build app') {
      setps {
        sh """
          echo 'Building android app'
          ./gradlew -b ${env.WORKSPACE}/android/app/build.gradle build
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