appName="MyApp"
redirectUri="http://localhost"

# Authenticate with Azure CLI
az login

# Create the Azure AD application
az ad app create --display-name "$appName" --reply-urls "$redirectUri"

# Get the client ID (Application ID)
clientId=$(az ad app show --display-name "$appName" --query "appId" --output tsv)

# Generate a client secret
clientSecret=$(az ad app credential reset --id "$clientId" --query "password" --output tsv)

# Print the client ID and client secret
echo "Client ID: $clientId"
echo "Client Secret: $clientSecret"

# Step 1: Obtain the access token
access_token=$(curl -s -X POST -H "Metadata: true" "http://169.254.169.254/metadata/identity/oauth2/token" -d "resource=https://management.azure.com&client_id=$clientId&client_secret=$clientSecret&grant_type=client_credentials" | jq -r .access_token)

# Step 2: Retrieve the metadata information
metadata=$(curl -s -H "Metadata: true" -H "Authorization: Bearer $access_token" "http://169.254.169.254/metadata/instance?api-version=2021-06-01")

# Format the metadata output as JSON
json_metadata=$(echo "$metadata" | jq '.')

# Print the formatted metadata
echo "$json_metadata"
