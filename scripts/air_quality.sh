#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/helpers.sh"

get_air_quality() {
  curl -s --location -g --request GET http://api.airvisual.com/v2/nearest_city?key=c6b29550-4461-4555-b4a6-4eef4d241181 | jq '.data.current.pollution'| jq '.aqius'
}

main() {
  local update_interval=$((30 * $(get_tmux_option "@tmux-air_quality-interval" 60)))
  local current_time=$(date "+%s")
  local previous_update=$(get_tmux_option "@air_quality-previous-update-time")
  local delta=$((current_time - previous_update))

  if [ -z "$previous_update" ] || [ $delta -ge $update_interval ]; then
    local airq_value=$(get_air_quality)
    if [ "$?" -eq 0 ]; then
      $(set_tmux_option "@air_quality-previous-update-time" "$current_time")
      $(set_tmux_option "@air_quality-previous-value" "$airq_value")
    fi
  fi

  air_quality_value=$(get_tmux_option "@air_quality-previous-value")
  v=$(($air_quality_value+0))
  if (( $v < 120 )); then
    color="green"
  elif (( $v < 150 )); then
    color="blue"
  else
    color="red"
  fi

  echo -n "#[fg=$color]$air_quality_value#[default]"
}

main
