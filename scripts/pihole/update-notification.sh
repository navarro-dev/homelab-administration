#!/usr/bin/env sh

# Functions

#######################
# Takes 2 arguments: local_version and remote_version
#
# Checks if the 2 versions match as a string value
#   - If same, returns a 0 for TRUE
#   - If not the same, returns a 1 for FALSE
#
# If local and remote versions do not match, most likely there
# is a new version of pi-hole available
#
# Example usage:
# compareVersions "1.2.3" "1.0.2"
#######################
compareVersions() {
  local local_version="${1}"
  local remote_version="${2}"

    if [ "$local_version" = "$remote_version" ]; then
        true
    else
        false
    fi
}

# Variables
readonly PI_HOLE_VERSIONS_FILE="/etc/pihole/versions"
readonly DISCORD_SCRIPT="/opt/pihole-custom/discord-notifications.sh"
readonly CORE_BASE_URL="https://github.com/pi-hole/pi-hole/releases/"
readonly ADMINLTE_BASE_URL="https://github.com/pi-hole/AdminLTE/releases/"
readonly FTL_BASE_URL="https://github.com/pi-hole/FTL/releases/"

if [ -f ${PI_HOLE_VERSIONS_FILE} ]; then
    # shellcheck disable=SC1090
    . "$PI_HOLE_VERSIONS_FILE"
else
    echo "Could not find /etc/pihole/versions. Running update now."
    pihole updatechecker
    # shellcheck disable=SC1090
    . "$PI_HOLE_VERSIONS_FILE"
fi

# Source the discord-notifications file for sendPiHoleDiscordMessage()
# shellcheck disable=SC1091
. "$DISCORD_SCRIPT"

compareVersions "${CORE_VERSION:=N/A}" "${GITHUB_CORE_VERSION:=N/A}"
new_core_version=$?
compareVersions "${WEB_VERSION:=N/A}" "${GITHUB_WEB_VERSION:=N/A}"
new_web_version=$?
compareVersions "${FTL_VERSION:=N/A}" "${GITHUB_FTL_VERSION:=N/A}"
new_ftl_version=$?

if [ $new_core_version -eq 1 ]; then 
    sendPiHoleDiscordMessage "Core" "$CORE_BASE_URL" "${GITHUB_CORE_VERSION:=N/A}"
fi

if [ $new_web_version -eq 1 ]; then 
    sendPiHoleDiscordMessage "Web Admin" "$ADMINLTE_BASE_URL" "${GITHUB_WEB_VERSION:=N/A}"
fi

if [ $new_web_version -eq 1 ]; then 
    sendPiHoleDiscordMessage "FTL Engine" "$FTL_BASE_URL" "${GITHUB_FTL_VERSION:=N/A}"
fi