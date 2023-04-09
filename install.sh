#切换root用户执行下面命令
apt update && apt upgrade -y
apt install vim
apt install curl
#安装v2ray
bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)
systemctl enable v2ray
#安装caddy
 apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
apt update
apt install caddy
#修改v2ray和caddy配置文件
rm /usr/local/etc/v2ray/config.json
rm /etc/caddy/Caddyfile
rm /usr/share/caddy/index.html
mv /v2ray/config.json /usr/local/etc/v2ray/
mv /v2ray/Caddyfile /etc/caddy/
mv /v2ray/index.html /usr/share/caddy
systemctl start v2ray
systemctl start caddy
# 开启bbr（添加参数到/etc/sysctl.conf文件）
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
echo "net.ipv4.tcp_window_scaling=1" >> /etc/sysctl.conf
sysctl -p
