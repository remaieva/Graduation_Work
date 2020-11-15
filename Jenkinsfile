node {
    stage 'build'
    docker.image('maven').inside {
        stage 'Git clone'
            git branch: 'master', credentialsId: '1dc60717-cfbc-41c8-bd75-93986cfb7bb5', url: 'https://github.com/remaieva/EPAM-GW.git'
        stage 'Maven build'
            sh 'mvn clean package -f javahello/pom.xml'
        stage 'Git push'
            sh 'git config --global  user.email "nata.remaieva@gmail.com"'
            sh 'git config --global  user.name "remaieva"'
            sh 'git add .'
            sh 'git commit -am "Updated version from mvn"'
            sh 'git push origin master'
    }
}
