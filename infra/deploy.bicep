targetScope = 'subscription'

param location string = 'westus'
param environment string = 'dev'
param resourceGroupName string = 'rg-flix-${environment}'

// Create resource group
resource resourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: resourceGroupName
  location: location
}

// Deploy app services to resource group
module appServices './main.bicep' = {
  scope: resourceGroup
  name: 'appServices'
  params: {
    location: location
    environment: environment
  }
}

output resourceGroupName string = resourceGroup.name
output frontendAppName string = appServices.outputs.frontendAppName
output gatewayAppName string = appServices.outputs.gatewayAppName
