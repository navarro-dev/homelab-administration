#!/usr/bin/env sh

# Required system packages: jq

# Discord Webhook
url="https://discord.com/api/webhooks/1068580837202874398/56dWveDtyprIJdBMQqmO1BnbjzRb0lQ1KQMFq60pf3OUxB8f4vr4i9C_lCxcF1_7r5i9"

# Functions
sendPiHoleDiscordMessage() {
        pihole_admin_url="http://pihole.home/admin/"
        pihole_thumbnail_url="https://wp-cdn.pi-hole.net/wp-content/uploads/2020/05/vortex-wide.png"

        ## Format for curl
        json_payload=$( jq -n \
                  --arg msg "New Pi-hole ${1} version available!" \
                  --arg title "${1} ${3} Changelog" \
                  --arg des "To update go here" \
                  --arg cl_url "${2}" \
                  --arg tn_url "$pihole_thumbnail_url" \
                  '{content: $msg, embeds: [{ title: $title, url: $cl_url, thumbnail: { url: $tn_url }}]'} )

        curl -H "Content-Type: application/json" -H "Accept: application/json" -X POST --data "$json_payload" $url
}

