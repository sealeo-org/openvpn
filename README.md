# Project Name

This is a  simple docker container that allow to run an openvpn server with strong cipher if you want it.

## Installation

    docker run -d --cap-add=NET_ADMIN --privileged -v openvpn_folder:/etc/openvpn -v certificate_folder:/cert -e CIPHER="cipher AES-256-CBC" -e DH_KEY_SIZE="2048" -e RSA_KEY_SIZE="2048" -e DNS=1 -p 1194:1194/udp sealeo/openvpn

CIPHER :
- cipher AES-128-CBC
- cipher AES-192-CBC
- cipher AES-256-CBC
- cipher CAMELLIA-128-CBC
- cipher CAMELLIA-192-CBC
- cipher CAMELLIA-256-CBC
- cipher SEED-CBC

DH_KEY_SIZE : 
- 2048
- 3072
- 4096
- Custom

RSA_KEY_SIZE : 
- 2048
- 3072
- 4096

DNS : 
 - 1 resolv.conf
 - 2 #FDN
 - 3 #DNS.WATCH
 - 4 #OpenDNS
 - 5 #Google

It will take some time to generate all the keys and certficate the first time.
    
TODO: Docker-Compose

## Usage

    docker run -d --cap-add=NET_ADMIN --device /dev/net/tun  --privileged -v openvpn_folder:/etc/openvpn -v certificate_folder:/cert -p 1194:1194/udp sealeo/openvpn

### Creating a new user :

    docker exec sealeo/openvpn bash
    addvpnuser
    #follow the instruction
    #The certificate will be available in the openvpn folder in the client subfolder
    #Edit the 3rd line with the right port if you changed it

### Revoking a user
    docker exec sealeo/openvpn bash
    delvpnuser

## History

v 1.0 First Commit

TODO: LDAP Support

## Credits

Credit to Nyr for his Road Warrior script : https://github.com/Nyr/openvpn-install

## License

Released under MIT license.
