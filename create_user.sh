#!/bin/bash

# 确保脚本以root用户运行
if [ "$(id -u)" -ne 0 ]; then
  echo "此脚本需要以root身份运行。"
  exit 1
fi

# 设置新用户名和密码（假设它们已知）
NEW_USER=$1
USER_PASSWORD=$2
USER_HOME="/home/$NEW_USER"

# 1. 添加新用户
useradd -m -s /bin/bash $NEW_USER
echo "$NEW_USER:$USER_PASSWORD" | chpasswd

# 2. 给新用户添加root权限
usermod -aG sudo $NEW_USER

# 3. 配置~/.bashrc
echo "alias python=python3" >> $USER_HOME/.bashrc
echo "# user-add: cuda" >> $USER_HOME/.bashrc
echo "export PATH=/usr/local/cuda-12.1/bin:\$PATH" >> $USER_HOME/.bashrc
echo "export LD_LIBRARY_PATH=/usr/local/cuda-12.1/lib64:\$LD_LIBRARY_PATH" >> $USER_HOME/.bashrc
echo "export CUDA_HOME=/usr/local/cuda" >> $USER_HOME/.bashrc
echo "" >> $USER_HOME/.bashrc
echo "# user-add: anaconda" >> $USER_HOME/.bashrc
echo "export PATH=/software/anaconda3/bin:\$PATH" >> $USER_HOME/.bashrc
echo "" >> $USER_HOME/.bashrc
echo "source /software/anaconda3/bin/activate" >> $USER_HOME/.bashrc
echo "" >> $USER_HOME/.bashrc
echo "# >>> conda initialize >>>" >> $USER_HOME/.bashrc
echo "# !! Contents within this block are managed by 'conda init' !!" >> $USER_HOME/.bashrc
echo "__conda_setup=\"\$(/software/anaconda3/bin/conda 'shell.bash' 'hook' 2> /dev/null)\"" >> $USER_HOME/.bashrc
echo "if [ \$? -eq 0 ]; then" >> $USER_HOME/.bashrc
echo "  eval \"\$__conda_setup\"" >> $USER_HOME/.bashrc
echo "else" >> $USER_HOME/.bashrc
echo "  if [ -f \"/software/anaconda3/etc/profile.d/conda.sh\" ]; then" >> $USER_HOME/.bashrc
echo "    . \"/software/anaconda3/etc/profile.d/conda.sh\"" >> $USER_HOME/.bashrc
echo "  else" >> $USER_HOME/.bashrc
echo "    export PATH=\"/software/anaconda3/bin:\$PATH\"" >> $USER_HOME/.bashrc
echo "  fi" >> $USER_HOME/.bashrc
echo "fi" >> $USER_HOME/.bashrc
echo "unset __conda_setup" >> $USER_HOME/.bashrc
echo "# <<< conda initialize <<<" >> $USER_HOME/.bashrc

# 4. 配置pip.conf
mkdir -p $USER_HOME/.config/pip
echo "[global]" > $USER_HOME/.config/pip/pip.conf
echo "trusted-host = mirrors.tools.huawei.com" >> $USER_HOME/.config/pip/pip.conf
echo "index-url = http://mirrors.tools.huawei.com/pypi/simple/" >> $USER_HOME/.config/pip/pip.conf

# 5. 配置condarc
echo "channels:" > $USER_HOME/.condarc
echo "  - defaults" >> $USER_HOME/.condarc
echo "proxy_servers:" >> $USER_HOME/.condarc
echo "  http: http://$NEW_USER:$USER_PASSWORD@proxyhk.huawei.com:8080" >> $USER_HOME/.condarc
echo "  https: http://$NEW_USER:$USER_PASSWORD@proxyhk.huawei.com:8080" >> $USER_HOME/.condarc
echo "ssl_verify: false" >> $USER_HOME/.condarc
echo "report_errors: false" >> $USER_HOME/.condarc

# 修改文件权限
chown -R $NEW_USER:$NEW_USER $USER_HOME/.bashrc
chown -R $NEW_USER:$NEW_USER $USER_HOME/.config
chown -R $NEW_USER:$NEW_USER $USER_HOME/.condarc

echo "新用户 $NEW_USER 已成功创建并配置完成。"