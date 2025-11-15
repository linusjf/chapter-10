#!/usr/bin/env bash

######################################################################
# @author      : Linus Fernandes (linusfernandes at gmail dot com)
# @file        : git
# @created     : Saturday Nov 15, 2025 12:36:03 IST
#
# @description :
######################################################################

function get_owner_and_repo() {
  # shellcheck disable=SC2178
  local -n _output=$1
  local remote_url=$(git remote get-url origin 2> /dev/null)
  # Works for both HTTPS and SSH URLs
  if [[ $remote_url =~ github\.com[:/](.+)/(.+)\.git ]]; then
    owner="${BASH_REMATCH[1]}"
    repo="${BASH_REMATCH[2]}"
    _output=("$owner" "$repo")
  else
    echo "❌ Could not parse owner/repo from remote URL." >&2
    exit 1
  fi
}
