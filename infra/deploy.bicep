targetScope = 'subscription'

param location string = 'westus'
param environment string = 'dev'
param resourceGroupName string = 'rg-flix-${environment}'
param containerRegistryUrl string = 'ghcr.io'
param repositoryName string = 'mjhobbs/flix-devops-template'

// Create resource group
resource resourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: resourceGroupName
  location: location
}

// Deploy container instances to resource group
module containerInstances './main.bicep' = {
  scope: resourceGroup
  name: 'containerInstances'
  params: {
    location: location
    environment: environment
    containerRegistryUrl: containerRegistryUrl
    repositoryName: repositoryName
  }
}

// Outputs
output resourceGroupName string = resourceGroup.name
output frontendUrl string = containerInstances.outputs.frontendContainerUrl
output gatewayUrl string = containerInstances.outputs.gatewayContainerUrl
output videoServiceUrl string = containerInstances.outputs.videoServiceUrl
output historyServiceUrl string = containerInstances.outputs.historyServiceUrl
output userServiceUrl string = containerInstances.outputs.userServiceUrl
