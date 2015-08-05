# 这又是啥：

* 使用build方式打包为nodejs程序，并用自定义mongodb来跑meteor的docker文件（嗯，我就喜欢一句话呢说完的感觉）
* 新建镜像docker build -t shanyue/meteor .
* 启动容器docker run --rm -p 3000:3000 -e REPO=https://github.com/shanyu-e/dockmeteor.git -e MONGO_URL=mongodb://user:pw@oforever.net:27017/meteor shanyue/meteor
