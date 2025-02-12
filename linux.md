#### 远程服务器信息
IP: 115.120.230.114
password: 110527.Huawei

#### 用户相关操作
```bash
# 添加用户
sudo adduser budi

# 编辑系统权限文件
vim /etc/sudoers

# 在root ALL=(ALL) ALL下添加用户
budi    ALL=(ALL:ALL)ALL
```

#### 配置权限
```
bash create_user.sh w00910522 w00910522
```


#### 安装anaconda以及镜像配置
```
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
#设置搜索时显示通道地址
conda config --set show_channel_urls yes
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```