#ws+tls+web
#切换root用户执行下面命令
apt update && apt upgrade -y
apt install vim curl git -y
git clone https://github.com/iii93/v2ray.git
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
read -p "请输入你的id（a7f43ece-5d93-46a5-94e8-5a20d19cf3dc）：" uuid 
sed -i "s/\"id\": \"[^\"]*\"/\"id\": \"${uuid}\"/g" /usr/local/etc/v2ray/config.json
read -p "请输入你的路径：" path
sed -i 's/ray/'"${path}"'/g' /usr/local/etc/v2ray/config.json 
mv /v2ray/Caddyfile /etc/caddy/ 
read -p "请输入你的域名：" domain
sed -i "s/https:\/\/abc\.com/${domain}/g" /etc/caddy/Caddyfile 
sed -i 's/ray/'"${path}"'/g' /etc/caddy/Caddyfile 
mv /v2ray/index.html /usr/share/caddy
systemctl start v2ray
systemctl start caddy
# 开启bbr（添加参数到/etc/sysctl.conf文件）
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
echo "net.ipv4.tcp_window_scaling=1" >> /etc/sysctl.conf
sysctl -p
