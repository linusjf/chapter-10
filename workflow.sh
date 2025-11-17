#!/usr/bin/env bash

######################################################################
# @author      : Linus Fernandes (linusfernandes at gmail dot com)
# @file        : workflow
# @created     : Tuesday Oct 28, 2025 12:09:15 IST
#
# @description :
######################################################################
source ./gh.sh

function enable_workflow() {
  OWNER="$1"
  REPO="$2"
  WORKFLOW="$3"
  ACTION="enable"
  echo "Setting workflow ${WORKFLOW} to ${ACTION}..."
  gh api \
    --method PUT \
    -H "Accept: application/vnd.github+json" \
    "/repos/${OWNER}/${REPO}/actions/workflows/${WORKFLOW}/${ACTION}"
}

function disable_workflow() {
  OWNER="$1"
  REPO="$2"
  WORKFLOW="$3"
  ACTION="disable"
  echo "Setting workflow ${WORKFLOW} to ${ACTION}..."
  gh api \
    --method PUT \
    -H "Accept: application/vnd.github+json" \
    "/repos/${OWNER}/${REPO}/actions/workflows/${WORKFLOW}/${ACTION}"
}

function get_workflow_id() {
  wf="$1"
  declare -a vals
  get_owner_and_repo vals
  owner="${vals[0]}"
  repo="${vals[1]}"

  id=$(gh api "repos/${owner}/${repo}/actions/workflows" \
    | jq -r --arg wf "$wf" '.workflows[] | select(.path|endswith($wf)) | .id')
  echo "$id"
}

function list_workflows() {
  declare -a vals
  get_owner_and_repo vals
  owner="${vals[0]}"
  repo="${vals[1]}"

  echo "Available workflows for ${owner}/${repo}:"
  echo ""
  
  # Get workflows and format as table
  gh api "repos/${owner}/${repo}/actions/workflows" \
    | jq -r '.workflows[] | [.id, .name, .path, .state] | @tsv' \
    | column -t -s $'\t' -N "Workflow ID,Workflow Name,File Path,State"
}
