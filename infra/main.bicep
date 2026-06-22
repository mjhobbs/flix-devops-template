param location string = 'westus'
param environment string = 'dev'

// Resource Group name
var resourceGroupName = 'rg-flix-${environment}-${uniqueString(resourceGroup().id)}'

// Storage account for container registry (optional, for private images)
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'stflix${environment}${uniqueString(resourceGroup().id)}'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    accessTier: 'Hot'
  }
}

// App Service Plan (B1 Standard Linux tier)
resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: 'plan-flix-${environment}'
  location: location
  kind: 'linux'
  sku: {
    name: 'Standard_B1s'
    tier: 'Standard'
    capacity: 1
  }
  properties: {
    reserved: true
  }
}

// Frontend App Service
resource frontendAppService 'Microsoft.Web/sites@2023-01-01' = {
  name: 'app-flix-frontend-${environment}-${uniqueString(resourceGroup().id)}'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'NODE|20'
      alwaysOn: false
      appSettings: [
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
      ]
    }
    httpsOnly: true
  }
}

// Gateway App Service
resource gatewayAppService 'Microsoft.Web/sites@2023-01-01' = {
  name: 'app-flix-gateway-${environment}-${uniqueString(resourceGroup().id)}'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'NODE|20'
      alwaysOn: false
      appSettings: [
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
      ]
    }
    httpsOnly: true
  }
}

// Video Service App Service
resource videoServiceAppService 'Microsoft.Web/sites@2023-01-01' = {
  name: 'app-flix-video-${environment}-${uniqueString(resourceGroup().id)}'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'NODE|20'
      alwaysOn: false
      appSettings: [
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
      ]
    }
    httpsOnly: true
  }
}

// History Service App Service
resource historyServiceAppService 'Microsoft.Web/sites@2023-01-01' = {
  name: 'app-flix-history-${environment}-${uniqueString(resourceGroup().id)}'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'NODE|20'
      alwaysOn: false
      appSettings: [
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
      ]
    }
    httpsOnly: true
  }
}

// User Service App Service
resource userServiceAppService 'Microsoft.Web/sites@2023-01-01' = {
  name: 'app-flix-user-${environment}-${uniqueString(resourceGroup().id)}'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'NODE|20'
      alwaysOn: false
      appSettings: [
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
      ]
    }
    httpsOnly: true
  }
}

// Outputs
output frontendAppName string = frontendAppService.name
output gatewayAppName string = gatewayAppService.name
output videoServiceAppName string = videoServiceAppService.name
output historyServiceAppName string = historyServiceAppService.name
output userServiceAppName string = userServiceAppService.name
output appServicePlanId string = appServicePlan.id
output storageAccountId string = storageAccount.id
