#!/usr/bin/env bash

######################################################################
# @author      : Linus Fernandes (linusfernandes at gmail dot com)
# @file        : toggleworkflow
# @created     : Tuesday Oct 28, 2025 12:09:15 IST
#
# @description :
######################################################################

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
