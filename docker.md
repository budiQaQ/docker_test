#### docker安装
```bash
# 1. 更新软件包
sudo apt-get update
sudo apt-get upgrade

# 2. 安装docker依赖
sudo apt-get install ca-certificates curl gnupg lsb-release

# 3. 添加密钥
curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -

# 4. 添加阿里云docker软件源
sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"

# 5. 安装docker
apt-get install docker-ce docker-ce-cli containerd.i

# 7. 检查是否安装成功
sudo docker run hello-world

# 8. 配置加速地址
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
    "registry-mirrors": [
        "https://do.nark.eu.org",
        "https://dc.j8.work",
        "https://docker.m.daocloud.io",
        "https://dockerproxy.com",
        "https://docker.mirrors.ustc.edu.cn",
        "https://docker.nju.edu.cn"
    ]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
systemctl status docker
```

#### 配置python环境
- 打一个Dockerfile
```Dockerfile
FROM python  # 拉取python镜像
RUN pip install numpy -i https://pypi.tuna.tsinghua.edu.cn/simple  # 在清华源安装numpy
RUN mkdir -p /workfolder  # 在docker镜像中建立工作路径
COPY ./main.py /workfolder/  # 将本地文件拷贝至docker内的工作路径下
CMD ["python", "/workfolder/main.py"]  # 在python镜像中执行文件
```

- 创建镜像文件
```bash
docker image build -t new_python:v01
```

- 执行容器
```bash
docker container run --rm -it new_python:v02
```