# How-To

Note: Playbooks are intended for Ubuntu 22.04

## Running Playbooks
`ansible-playbook <playbook>.yml -i <inventory_file> -K`

## Running Ad-Hoc Commands
`ansible <all|group> -i <inventory_file> -K -a "<shell command>"`
- example: `ansible all -i ansible-playbooks/hosts -a "hostname"`