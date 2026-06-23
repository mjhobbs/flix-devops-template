param location string = 'westus'
param environment string = 'dev'
param containerRegistryUrl string = 'ghcr.io'
param repositoryName string = 'mjhobbs/flix-devops-template'
param registryUsername string = ''
param registryPassword string = ''

// Container Instances for microservices (no VM quota required)

// Frontend Container Instance
resource frontendContainer 'Microsoft.ContainerInstance/containerGroups@2023-05-01' = {
  name: 'aci-flix-frontend-${environment}'
  location: location
  properties: {
    containers: [
      {
        name: 'frontend'
        properties: {
          image: '${containerRegistryUrl}/${repositoryName}/frontend:latest'
          resources: {
            requests: {
              cpu: 1
              memoryInGb: 1
            }
          }
          ports: [
            {
              port: 8081
              protocol: 'TCP'
            }
          ]
          environmentVariables: [
            {
              name: 'PORT'
              value: '8081'
            }
          ]
        }
      }
    ]
    osType: 'Linux'
    ipAddress: {
      type: 'Public'
      ports: [
        {
          port: 8081
          protocol: 'TCP'
        }
      ]
      dnsNameLabel: 'flix-frontend-${environment}-${uniqueString(resourceGroup().id)}'
    }
    imageRegistryCredentials: [
      {
        server: containerRegistryUrl
        username: registryUsername
        password: registryPassword
      }
    ]
    restartPolicy: 'Always'
  }
}

// Gateway Container Instance
resource gatewayContainer 'Microsoft.ContainerInstance/containerGroups@2023-05-01' = {
  name: 'aci-flix-gateway-${environment}'
  location: location
  properties: {
    containers: [
      {
        name: 'gateway'
        properties: {
          image: '${containerRegistryUrl}/${repositoryName}/gateway:latest'
          resources: {
            requests: {
              cpu: 1
              memoryInGb: 1
            }
          }
          ports: [
            {
              port: 8080
              protocol: 'TCP'
            }
          ]
          environmentVariables: [
            {
              name: 'PORT'
              value: '8080'
            }
          ]
        }
      }
    ]
    osType: 'Linux'
    ipAddress: {
      type: 'Public'
      ports: [
        {
          port: 8080
          protocol: 'TCP'
        }
      ]
      dnsNameLabel: 'flix-gateway-${environment}-${uniqueString(resourceGroup().id)}'
    }
    imageRegistryCredentials: [
      {
        server: containerRegistryUrl
        username: registryUsername
        password: registryPassword
      }
    ]
    restartPolicy: 'Always'
  }
}

// Video Service Container Instance
resource videoServiceContainer 'Microsoft.ContainerInstance/containerGroups@2023-05-01' = {
  name: 'aci-flix-video-${environment}'
  location: location
  properties: {
    containers: [
      {
        name: 'video-service'
        properties: {
          image: '${containerRegistryUrl}/${repositoryName}/video-service:latest'
          resources: {
            requests: {
              cpu: 1
              memoryInGb: 1
            }
          }
          ports: [
            {
              port: 3000
              protocol: 'TCP'
            }
          ]
          environmentVariables: [
            {
              name: 'PORT'
              value: '3000'
            }
          ]
        }
      }
    ]
    osType: 'Linux'
    ipAddress: {
      type: 'Public'
      ports: [
        {
          port: 3000
          protocol: 'TCP'
        }
      ]
      dnsNameLabel: 'flix-video-${environment}-${uniqueString(resourceGroup().id)}'
    }
    imageRegistryCredentials: [
      {
        server: containerRegistryUrl
        username: registryUsername
        password: registryPassword
      }
    ]
    restartPolicy: 'Always'
  }
}

// History Service Container Instance
resource historyServiceContainer 'Microsoft.ContainerInstance/containerGroups@2023-05-01' = {
  name: 'aci-flix-history-${environment}'
  location: location
  properties: {
    containers: [
      {
        name: 'history-service'
        properties: {
          image: '${containerRegistryUrl}/${repositoryName}/history-service:latest'
          resources: {
            requests: {
              cpu: 1
              memoryInGb: 1
            }
          }
          ports: [
            {
              port: 3001
              protocol: 'TCP'
            }
          ]
          environmentVariables: [
            {
              name: 'PORT'
              value: '3001'
            }
          ]
        }
      }
    ]
    osType: 'Linux'
    ipAddress: {
      type: 'Public'
      ports: [
        {
          port: 3001
          protocol: 'TCP'
        }
      ]
      dnsNameLabel: 'flix-history-${environment}-${uniqueString(resourceGroup().id)}'
    }
    imageRegistryCredentials: [
      {
        server: containerRegistryUrl
        username: registryUsername
        password: registryPassword
      }
    ]
    restartPolicy: 'Always'
  }
}

// User Service Container Instance
resource userServiceContainer 'Microsoft.ContainerInstance/containerGroups@2023-05-01' = {
  name: 'aci-flix-user-${environment}'
  location: location
  properties: {
    containers: [
      {
        name: 'user-service'
        properties: {
          image: '${containerRegistryUrl}/${repositoryName}/user-service:latest'
          resources: {
            requests: {
              cpu: 1
              memoryInGb: 1
            }
          }
          ports: [
            {
              port: 3002
              protocol: 'TCP'
            }
          ]
          environmentVariables: [
            {
              name: 'PORT'
              value: '3002'
            }
          ]
        }
      }
    ]
    osType: 'Linux'
    ipAddress: {
      type: 'Public'
      ports: [
        {
          port: 3002
          protocol: 'TCP'
        }
      ]
      dnsNameLabel: 'flix-user-${environment}-${uniqueString(resourceGroup().id)}'
    }
     imageRegistryCredentials: [
       {
         server: containerRegistryUrl
         username: registryUsername
         password: registryPassword
       }
     ]
    restartPolicy: 'Always'
  }
}

// Outputs
output frontendContainerUrl string = 'http://${frontendContainer.properties.ipAddress.fqdn}:8081'
output gatewayContainerUrl string = 'http://${gatewayContainer.properties.ipAddress.fqdn}:8080'
output videoServiceUrl string = 'http://${videoServiceContainer.properties.ipAddress.fqdn}:3000'
output historyServiceUrl string = 'http://${historyServiceContainer.properties.ipAddress.fqdn}:3001'
output userServiceUrl string = 'http://${userServiceContainer.properties.ipAddress.fqdn}:3002'
