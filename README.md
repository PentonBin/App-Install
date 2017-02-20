# Ubuntu常用软件安装脚本

## 目录说明
- debs：存放需要安装的软件deb包；
- hosts：用于存放hosts文件（已修改google IP）
- logs：存放日志文件
- tars：存放需要安装的软件压缩包
- install.sh：部署脚本

将需要安装的软件，分别拷贝到对应的目录下，对于`tars`下的仅支持安装部分软件（如果不是强迫症可以全部解压到HOME路径下）

## 使用说明
1. 将在`HOME`目录下新建`JDK`、`Android`、`Hexo`、`Idea`、`Pycharm`、`Wechat`、`iNode`目录
2. 将安装以下软件(仅需要apt-get install的软件)：wiznote、docky、Ultra-flat-icons、codeblock、Indicator-sysmonitor VLC、 Unity Tweak Tool、GIMP、Shutter、Vim、SSH、Git、Wine Unzip
3. 将安装所有`debs`目录下的软件
4. 如果`tars`目录下包含：jdk、Android Studio、Idea、Pycharm、Wechat、iNode的压缩包，将自动安装到对应的目录，并配置好jdk路径

## 仅根据个人习惯进行安装