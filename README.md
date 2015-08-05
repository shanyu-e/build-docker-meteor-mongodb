## 前言：
做过就不难了，所以就不想写，但也是花了3天时间完成，那就服务下大众吧。然后吐槽下meteor的mup部署方式，尼玛，把老子服务器弄挂了。所以对于我这种买不起很多服务器，又有多版本Python、mongodb需求的穷逼。果断上docker。

## 目的:

 * 在docker上集成meteor的最简版本
 * 保持可迭代快速部署
 * 暂时只是个示例
 
## Versions:

Regardless of the version number of the tool included in this package, your application will run
on whatever version of Meteor it is configured to run under. --大体模仿镜像源第二名的版本目标

## Example run:

`docker run --rm -p 3001:3000 -e REPO=https://github.com/shanyu-e/dockmeteor.git mymeteor/meteor`

This is my first docker with meteor.

## 基本使用教程

 * 装好docker，装好逼
 * 拉取这个仓库
 * cd到本地路径，用我的这个Dockerfile新建镜像`docker build -t mymeteor/meteor  .`
 * 启动容器`docker run --rm -p 3001:3000 -e REPO=https://github.com/shanyu-e/dockmeteor.git mymeteor/meteor`,REPO填你自己的git仓库
 * 可以打开浏览器测试了，尼玛，docker万岁！
 
## 尾声

 进新公司后，突然接触到好多salt什么的高精度化的部署方式，和自己一个人瞎闹腾还是区别很大，然后又不想学salt，果断邂逅docker，从此过上幸福生活。附赠几个自己写的好用命令：
 
 * 删除空白的镜像：`docker rmi -f $(docker images | awk '/none/ { print $3 }')`
 * 停止正在运行的容器`docker stop $(docker ps | awk '{print $1}'|awk 'NR==2')`
