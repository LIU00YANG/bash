#!/bin/bash

# 提升为 root 权限
echo "请确保以 root 用户运行此脚本！"

# 备份原始的 sshd_config 文件
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# 允许 root 用户登录
sed -i 's/#PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# 启用密码认证
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

# 设置 root 密码
echo "请输入新的 root 密码:"
passwd root

# 重启 SSH 服务
systemctl restart sshd.service

# 设置 SSH 服务开机自启
systemctl enable sshd.service

echo "SSH 配置已更新，并已重启服务。"
