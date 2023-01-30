#!/usr/bin/env sh

# Required system packages: jq

# Discord Webhook
url="<enter channel webhook>" #https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks

# Functions

#######################
# Takes 3 arguments: local_version and remote_version
#
# Send Discord message to notify of new pi-hole component version
#
# Example usage:
# sendPiHoleDiscordMessage "Core" "https://site.com/" "1.0.2"
#######################
sendPiHoleDiscordMessage() {
        local pihole_admin_url="http://pihole.home/admin/"
        local pihole_icon_url="https://wp-cdn.pi-hole.net/wp-content/uploads/2020/05/vortex-wide.png"
        local color="39423"

        ## Format for curl
        json_payload=$( jq -n \
                  --arg msg "New Pi-hole ${1} version available!" \
                  --arg title "${1} ${3} Changelog" \
                  --arg clog_url "${2}${3}" \
                  --arg icon_url "$pihole_icon_url" \
                  --arg color "$color" \
                  '{content: $msg, embeds: [{ title: $title, url: $clog_url, author: { name: "HomeLab Automation" }, color: $color, thumbnail: { url: $icon_url } }]'} )

        curl -H "Content-Type: application/json" -H "Accept: application/json" -X POST --data "$json_payload" $url
}

