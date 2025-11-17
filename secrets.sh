#!/usr/bin/env bash

######################################################################
# @author      : Linus Fernandes (linusfernandes at gmail dot com)
# @file        : setreposecrets
# @created     : Tuesday Oct 28, 2025 15:47:52 IST
#
# @description :
######################################################################

# Common variables
CONTAINER_REGISTRY="linusjfflixtube.azurecr.io"
REGISTRY_UN="linusjfflixtube"
RESOURCE_GROUP="flixtube"
ACR_NAME="linusjfflixtube"
AKS_NAME="flixtube"

function get_registry_password() {
  az acr credential show \
    --name "$ACR_NAME" \
    --resource-group "$RESOURCE_GROUP" \
    --query "passwords[0].value" \
    --output tsv
}

function get_kube_config() {
  # Backup current kube config
  mv ~/.kube/config ~/.kube/config.bak

  # Get AKS credentials
  az aks get-credentials --resource-group "$RESOURCE_GROUP" --name "$AKS_NAME"

  # Base64 encode kube config and remove newlines
  base64 < ~/.kube/config | tr -d '\n'
}

function resource_group_exists() {
  az group exists --name "$1"
}

function set_common_secrets() {
  local mode="$1"

  if [[ "$(resource_group_exists "$RESOURCE_GROUP")" == "true" ]]; then
    # Get secrets
    local registry_pw
    registry_pw=$(get_registry_password)
    local kube_config_base64
    kube_config_base64=$(get_kube_config)

    if [[ "$mode" == "local" ]]; then
      # Store to .secrets file
      true > .secrets
      {
        echo "CONTAINER_REGISTRY=$CONTAINER_REGISTRY"
        echo "REGISTRY_UN=$REGISTRY_UN"
        echo "REGISTRY_PW=$registry_pw"
        echo "KUBE_CONFIG=$kube_config_base64"
        echo "LOCAL_DEPLOY=true"
      } >> .secrets
    else
      # Set GitHub secrets
      gh secret set "CONTAINER_REGISTRY" --body "$CONTAINER_REGISTRY"
      gh secret set "REGISTRY_UN" --body "$REGISTRY_UN"
      gh secret set "REGISTRY_PW" --body "$registry_pw"
      gh secret set "KUBE_CONFIG" --body "$kube_config_base64"
      gh secret set "LOCAL_DEPLOY" --body "false"
    fi
  else
    echo "Resource group ${RESOURCE_GROUP} does not exist. Setting repo secrets is not executed."
    return 1
  fi
}

function set_repo_secrets() {
  set_common_secrets "github"
}

function store_secrets_locally() {
  set_common_secrets "local"
}
