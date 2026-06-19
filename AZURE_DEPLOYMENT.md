# Azure App Service Deployment Guide

## Prerequisites

1. **Azure Account**: Free tier (F1 plan) - no credit card required for first 12 months
2. **GitHub Account**: With repository access
3. **Azure CLI**: Installed locally (optional, for manual testing)

## Setup Steps

### Step 1: Create Azure Service Principal for GitHub Actions

Run these commands in your terminal:

```bash
az login
az account set --subscription "79e355f4-6aab-4746-a3fa-6d7588b44fc1"

az ad sp create-for-rbac \
  --name "github-flix-deploy" \
  --role contributor \
  --scopes /subscriptions/79e355f4-6aab-4746-a3fa-6d7588b44fc1 \
  --json-auth
```

**Output will look like:**
```json
{
  "clientId": "...",
  "clientSecret": "...",
  "subscriptionId": "79e355f4-6aab-4746-a3fa-6d7588b44fc1",
  "tenantId": "..."
}
```

### Step 2: Add GitHub Secrets

1. Go to your GitHub repository
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Create these secrets:

| Secret Name | Value |
|------------|-------|
| `AZURE_CREDENTIALS` | Full JSON output from Step 1 |
| `DEPLOYMENT_ID` | Random string (e.g., `abc123xyz`) - part of App Service name |

**Example:**
```
AZURE_CREDENTIALS = {"clientId":"...","clientSecret":"...","subscriptionId":"79e355f4-6aab-4746-a3fa-6d7588b44fc1","tenantId":"..."}
DEPLOYMENT_ID = prod001
```

### Step 3: Update Bicep Parameters (Optional)

Edit `infra/deploy.bicep` to customize:
- `location`: westus (current default)
- `environment`: prod (current default)
- `resourceGroupName`: rg-flix-prod (current default)

### Step 4: Deploy

Push to `main` branch to trigger the workflow:

```bash
git add .
git commit -m "Deploy to Azure"
git push origin main
```

The GitHub Actions workflow will:
1. ✅ Build Node.js dependencies
2. ✅ Build Docker images
3. ✅ Push to GitHub Container Registry (GHCR)
4. ✅ Deploy Bicep infrastructure to Azure
5. ✅ Deploy containers to App Services

### Step 5: Verify Deployment

Check GitHub Actions logs:
- Go to **Actions** tab
- Click latest workflow run
- View job logs

Access your deployed apps:
- **Frontend**: `https://app-flix-frontend-prod-<DEPLOYMENT_ID>.azurewebsites.net`
- **Gateway**: `https://app-flix-gateway-prod-<DEPLOYMENT_ID>.azurewebsites.net`
- **Services**: Similar URLs for video, history, user services

## Troubleshooting

### Service Principal Auth Fails
- Verify `AZURE_CREDENTIALS` secret is valid JSON
- Check subscription ID matches

### App Service Deployment Fails
- Ensure Docker image is pushed to GHCR
- Check `DEPLOYMENT_ID` secret matches app name in Bicep

### Container Startup Issues
- View logs: `az webapp log tail --resource-group <rg-name> --name <app-name>`
- Verify ports match in Dockerfile (Express apps on port 8080-8081)

## Cost Estimation (Free Tier)

- **App Service Plan (F1)**: $0/month ✅ Free
- **Storage Account**: ~$0.50/month (minimal)
- **Total**: ~$0.50/month (or free first 12 months)

## Next Steps

1. Set up GitHub Secrets (Step 2)
2. Push to `main` branch
3. Monitor Actions workflow
4. Test deployed apps at their Azure URLs
