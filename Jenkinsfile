node {

    stage('Checkout') {
      echo "Checkout code in progress...."
      checkout scm
    }

     stage('Create image') {
	     def newApp
	     def registry = 'registry.hub.docker.com'
	     def registryCredential = 'swe645group'
	     def buildHome = 'swe645group/swe645angular_ui'
		   docker.withRegistry( 'https://' + registry, registryCredential ) {
			    def buildName = buildHome + ":$BUILD_NUMBER"
				newApp = docker.build buildName
				newApp.push()
				buildName = buildHome + ":latest"
				newApp = docker.build buildName
				newApp.push()
    	}
    }

    stage('Deploy') {
     withKubeConfig([credentialsId: 'rancher-login', serverUrl: 'https://ec2-3-89-40-188.compute-1.amazonaws.com/k8s/clusters/c-wdq5x']) {
     sh "sed -i 's/{buildNumber}/$BUILD_NUMBER/g' swe645-angular.yaml"
     sh '/usr/local/bin/kubectl apply -f swe645-angular.yaml'
    }
    }
}
