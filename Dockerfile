FROM debian:8

LABEL maintainer="Cyrius, Celforyon"
LABEL version="1.0"
LABEL description="Simple vpn server using openvpn."

RUN echo "deb http://swupdate.openvpn.net/apt jessie main" > /etc/apt/sources.list.d/swupdate-openvpn.list

RUN apt-get update && apt-get install -y wget
RUN wget -O - https://swupdate.openvpn.net/repos/repo-public.gpg | apt-key add -
RUN apt-get update && apt-get install -y \
	ca-certificates \
	iptables \
	openssl \
	openvpn \
	supervisor \
	&& rm -rf /var/lib/apt/lists/*
	
RUN echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf 
RUN wget -O ~/EasyRSA-3.0.1.tgz https://github.com/OpenVPN/easy-rsa/releases/download/3.0.1/EasyRSA-3.0.1.tgz && \
	tar xzf ~/EasyRSA-3.0.1.tgz -C ~/ && \
	mv ~/EasyRSA-3.0.1/ /etc/openvpn/ && \
	mv /etc/openvpn/EasyRSA-3.0.1/ /etc/openvpn/easy-rsa/ && \
	chown -R root:root /etc/openvpn/easy-rsa/ && \
	rm -rf ~/EasyRSA-3.0.1.tgz && \
	cd /etc/openvpn/easy-rsa/

RUN apt-get purge -y wget

VOLUME ["/etc/openvpn"]
VOLUME ["/cert"]

EXPOSE 1194/udp

ENV CIPHER="cipher AES-256-CBC"
ENV DH_KEY_SIZE=2048
ENV RSA_KEY_SIZE=2048
ENV DNS=1
ENV PROTOCOL=udp
ENV EXTERNAL_PORT=1194

ADD bin /usr/local/bin
ADD ./supervisord.conf /root
CMD ovpn_run
