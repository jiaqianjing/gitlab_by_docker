#!/bin/bash
local_ip=`hostname -i` # this command only support linux
docker run -d \
  -p $local_ip:443:443 \
  -p $local_ip:2022:2022 \ # 这里 2022 是容器内 ngix 代理的 gitlab 端口，需要在 /etc/gitlab/gitlab.rb 中设置 external_url
  -p $local_ip:2222:22 \
  -v $PWD/gitlab/config:/etc/gitlab \
  -v $PWD/gitlab/logs:/var/log/gitlab \
  -v $PWD/gitlab/data:/var/opt/gitlab \
  --hostname gitlab.example.com \
  --shm-size 256m \
  --privileged=true \
  --restart always \
  --name gitlab \
  gitlab/gitlab-ce:latest
