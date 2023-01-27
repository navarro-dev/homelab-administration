# How-To

## Running Playbooks
`ansible-playbook <playbook>.yml -i <inventory_file> -K`

## Running Ad-Hoc Commands
`ansible <all|group> -i <inventory_file> -K -a "<shell command>"`
- example: `ansible all -i ansible-playbooks/hosts -a "hostname"`