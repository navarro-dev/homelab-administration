# Ubuntu Server 22.04 Setup

Considerations when creating an Ubuntu Server 22.04 virtual machine on ESXi (free license).

### Prerequisites

- minimum 1 vCPU
- minimum 2GB RAM
- Boot Options > Firmware set to EFI

## Boot ISO with default, except the following

- Select _minimized_ Ubuntu version
- Install OpenSSH server
    + Retrieve public key from GitHub