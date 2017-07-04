# Docker OpenVPN

A docker container to run a configurable openvpn server

## Installation

```bash
docker run -d --cap-add=NET_ADMIN --device /dev/net/tun -v openvpn_folder:/etc/openvpn -v certificate_folder:/cert -p 1194:1194/udp sealeo/openvpn
```

### Environments
CIPHER: [default: cipher AES-256-CBC]
- cipher AES-128-CBC
- cipher AES-192-CBC
- cipher AES-256-CBC
- cipher CAMELLIA-128-CBC
- cipher CAMELLIA-192-CBC
- cipher CAMELLIA-256-CBC
- cipher SEED-CBC

DH_KEY_SIZE: [default: 2048]
- 2048
- 3072
- 4096
- Custom

RSA_KEY_SIZE: [default: 2048]
- 2048
- 3072
- 4096
- Custom

DNS: [default: 1]
- 1 (resolv.conf)
- 2 (#FDN)
- 3 (#DNS.WATCH)
- 4 (#OpenDNS)
- 5 (#Google)

PROTOCOL: [default: udp]
- udp
- tcp

EXTERNAL_PORT: [default: 1194]
(value that will be set into client configuration files)

## Usage

```bash
docker run -d --cap-add=NET_ADMIN --device /dev/net/tun -v openvpn_folder:/etc/openvpn -v certificate_folder:/cert -p 1194:1194/udp sealeo/openvpn
```

## Docker Compose

```yaml
version: '3'
services:
  vpn:
    container_name: vpn
    image: sealeo/openvpn
    restart: always
    network_mode: bridge
    volumes:
    - ./openvpn:/etc/openvpn
    - ./cert:/cert
    environment:
    #- CIPHER=cipher AES-256-CBC
    #- DH_KEY_SIZE=2048
    #- RSA_KEY_SIZE=2048
    #- DNS=1
    #- PROTOCOL=udp
    #- EXTERNAL_PORT=1194
    ports:
    - 1194:1194/udp
    cap_add:
    - NET_ADMIN
    devices:
    - /dev/net/tun
```

### Creating a new user

```bash
docker exec -it docker_name addvpnuser
```

### Revoking a user

```bash
docker exec -it docker_name delvpnuser
```

## Credits

Credit to Nyr for his Road Warrior script : https://github.com/Nyr/openvpn-install

## License

Released under MIT license.
