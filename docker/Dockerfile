FROM debian:buster-slim
ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && apt-get install -y --no-install-recommends \
		apt-utils \
		ca-certificates \
		cron \
		curl \
		iproute2 \
		iputils-ping \
		net-tools \
		python3 \
		python3-dev \
        python3-lxml \
		sudo \
        && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash pi
RUN echo "pi ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/010_pi-nopasswd
USER pi
WORKDIR /home/pi

#curl failed with certificate error (only on arm), see https://blog.abgefaerbt.de/docker/2020/12/15/docker-buildx-clamav-curl-unable-to-get-local-issuer-certificate.html
RUN sudo c_rehash
RUN curl -s https://raw.githubusercontent.com/jonas-he/openWB/master/openwb-install.sh | sudo bash
RUN printf "* * * * * /var/www/html/openWB/regel.sh >> /var/log/openWB.log 2>&1\n\
* * * * * sleep 10 && /var/www/html/openWB/regel.sh >> /var/log/openWB.log 2>&1\n\
* * * * * sleep 20 && /var/www/html/openWB/regel.sh >> /var/log/openWB.log 2>&1\n\
* * * * * sleep 30 && /var/www/html/openWB/regel.sh >> /var/log/openWB.log 2>&1\n\
* * * * * sleep 40 && /var/www/html/openWB/regel.sh >> /var/log/openWB.log 2>&1\n\
* * * * * sleep 50 && /var/www/html/openWB/regel.sh >> /var/log/openWB.log 2>&1\n" | crontab -

COPY entrypoint.sh /home/pi/entrypoint.sh
RUN sudo chmod +x /home/pi/entrypoint.sh
ENTRYPOINT ["/home/pi/entrypoint.sh"]