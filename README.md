# dotfiles
Repo for various dotfiles.


# and stuff I'll forget and thank myself for adding here later.

```
# Change to pihole/pihole:latest for Stock Default
# Change to boostchicken/pihole:latest for DoH
# Change to cbcrowe/pihole-unbound:latest for Unbound

IMAGE=cbcrowe/pihole-unbound:latest

podman pull $IMAGE

podman stop pihole

podman rm pihole

podman run -d --network dns --restart always \
  --name pihole \
  -e TZ="America/New York" \
  -v "/data/etc-pihole/:/etc/pihole/" \
  -v "/data/pihole/etc-dnsmasq.d/:/etc/dnsmasq.d/" \
  --dns=127.0.0.1 \
  --hostname pi.hole \
  -e VIRTUAL_HOST="pi.hole" \
  -e PROXY_LOCATION="pi.hole" \
  -e PIHOLE_DNS_1="127.0.0.1#5335" \
  -e ServerIP="192.168.1.2" \
  -e CUSTOM_CACHE_SIZE=0 \
  -e FTLCONF_REPLY_ADDR4="192.168.1.2" \
  -e FTLCONF_REPLY_ADDR6="" \
  -e IPv6="False" \
  $IMAGE
  ```
