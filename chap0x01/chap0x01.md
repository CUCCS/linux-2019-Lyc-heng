# 实验一

## 实验目标

- [x] Virtualbox安装完Ubuntu之后新添加的网卡如何实现系统开机自动启用和自动获取IP？

- [x] 如何使用sftp在虚拟机和宿主机之间传输文件？

- [x] 如何配置无人值守安装iso并在Virtualbox中完成自动化安装

## 实验环境

- VirtualBox

- ubuntu-18.04.1-server-amd64

## 实验过程

1. Virtualbox安装完Ubuntu之后新添加的网卡如何实现系统开机自动启用和自动获取IP？

    - 为虚拟机设置双网卡，第一块网卡为NAT，第二块网块为host-only

    - 设置完第二块网卡后，开机发现`ifconfig`的输出中只有第一块网卡的信息

    - 查看相关配置信息

            cat /etc/network/interfaces

        ![](/img/2-3.PNG)
    
    - 查看文件内容提示的路径上的文件

        ![](/img/2-4.PNG)

    - 复制该文件，并重命名和修改其中部分内容

        ![](/img/2-5.PNG)
    
    - 让新配置生效，再执行`ifconfig`可以看到第二块网卡，并且系统重新开机后自动启用和获得IP

            sudo netplan apply
        
        ![](/img/2-6.PNG)

2. 如何使用sftp在虚拟机和宿主机之间传输文件？

    - 使用GitBash进行sftp

            # 连接虚拟机进行sftp
            stfp 用户名@IP地址

            # 查看当前路径
            lpwd

            # 查看即将传输的路径
            pwd
    
    - 顺便将即将要进行配置的iso传输到虚拟机

            # put iso所在路径 想要存放文件的虚拟机路径
            put D:/ubuntu-18.04.1-server-amd64.iso /home/lycheng
        
        ![](/img/3-1.PNG)

        ![](/img/3-2.PNG)
        
3. 如何配置无人值守安装iso并在Virtualbox中完成自动化安装

    - 在当前用户目录下创建一个用于挂载iso镜像文件的目录

            mkdir loopdir
    
    - 挂载iso镜像文件到该目录

            mount -o loop ubuntu-16.04.1-server-amd64.iso loopdir

    - 创建一个工作目录用于克隆光盘内容

            mkdir cd

    - 同步光盘内容到目标工作目录

            rsync -av loopdir/ cd
    
    - 卸载iso镜像

            umount loopdir
        
    - 编辑Ubuntu安装引导界面增加一个新菜单项入口

            vim /cd/isolinux/txt.cfg

            # 添加以下内容到该文件后强制保存退出
            label autoinstall
            menu label ^Auto Install Ubuntu Server
            kernel /install/vmlinuz
            append  file=/cdrom/preseed/ubuntu-server-autoinstall.seed debian-installer/locale=en_US console-setup/layoutcode=us keyboard-configuration/layoutcode=us console-setup/ask_detect=false localechooser/translation/warn-light=true localechooser/translation/warn-severe=true initrd=/install/initrd.gz root=/dev/ram rw quiet
        
        ![](/img/1-1.PNG)
        
    - 将配置完成的ubuntu-server-autoinstall.seed的移到 ~/cd/preseed 目录中

    - 修改isolinux/isolinux.cfg，增加内容timeout 10

        ![](/img/1-2.PNG)
    
    - 重新生成md5sum.txt，由于权限不够，所以先对要操作的文件进行提权

            sudo chmod 777 md5sum.txt

            find . -type f -print0 | xargs -0 md5sum > md5sum.txt
    
    - 封闭改动后的目录到.iso,会提示没有mkisofs，需先安装`genisoimage`

            apt-get install genisoimage

            IMAGE=custom.iso
            BUILD=~/cd/

            mkisofs -r -V "Custom Ubuntu Install CD" \
                        -cache-inodes \
                        -J -l -b isolinux/isolinux.bin \
                        -c isolinux/boot.cat -no-emul-boot \
                        -boot-load-size 4 -boot-info-table \
                        -o $IMAGE $BUILD
    
    - 使用sftp将生成的镜像文件传输到宿主机上

            # get 目标文件目录 本地文件目录
            get /home/lycheng/cd/custom.iso D:/
    
    - 利用custom.iso进行无人值守安装，[安装过程](replay.mp4)由视频形式给出

                
4. ubuntu-server-autoinstall.seed与[官方示例](https://help.ubuntu.com/lts/installation-guide/example-preseed.txt)对比

- 左边为官方示例，右边为修改后.seed

- 选择支持的地点；跳过语言支持的选项

![](/img/4-1.PNG)

- 增加链接超时设置，并修改时间为5s；增加dhcp超时设置，并修改时间为5s；启用手工配置网络选项

![](/img/4-2.PNG)

- 设置IP地址；设置网管；设置域名服务器；设置弹窗确认为true

![](/img/4-3.PNG)

- 设置默认主机名；设置默认域名；启用强制主机名为`isc-vm-host`

![](/img/4-4.PNG)

- 设置用户名和密码

![](/img/4-5.PNG)

- 设置时区为上海；关闭时钟校准

![](/img/4-6.PNG)

- 自动选取最大空闲分区

![](/img/4-7.PNG)

- LVM分区，选择尽可能多的分区；更改分区策略为`multi`

![](/img/4-8.PNG)

- 不使用网络镜像

![](/img/4-9.PNG)

- 选择安装模式为server；安装openssh-server；设置在debootstrap后不进行自动更新；设置自动进行安全更新

![](/img/4-10.PNG)

## 参考资料

- [CUCCS/2015-linux-public-ghan3](https://github.com/CUCCS/2015-linux-public-ghan3/blob/master/%E7%AC%AC%E4%B8%80%E7%AB%A0%EF%BC%9ALinux%E5%9F%BA%E7%A1%80%EF%BC%88%E5%AE%9E%E9%AA%8C%EF%BC%89/hw1.md)

- [CUCCS/2018-NS-Public-TheMasterOfMagic](https://github.com/CUCCS/2018-NS-Public-TheMasterOfMagic/blob/ns-chap0x01/ns/chap0x01/%E5%9F%BA%E4%BA%8EVirtualBox%E7%9A%84%E7%BD%91%E7%BB%9C%E6%94%BB%E9%98%B2%E5%9F%BA%E7%A1%80%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA.md)

- [Linux sftp命令详解](https://www.cnblogs.com/ftl1012/p/sftp.html)