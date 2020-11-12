agent {
	docker{
	        image 'maven:3-alpine' 
            args '-v /root/testDocker:/root/testDocker
	}
    stage 'build'
    docker.image('maven:3-alpine').inside {
        stage 'Git clone'
            git branch: 'master', credentialsId: '1dc60717-cfbc-41c8-bd75-93986cfb7bb5', url: 'https://github.com/remaieva/EPAM-GW.git'
        stage 'Maven build'
        	sh 'cd /root/testDocker'
            sh 'mvn clean package -f javahello/pom.xml'
    }
}
