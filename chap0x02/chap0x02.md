# 实验二 From GUI to CLI

## 实验目标

- [x] vimtutuor操作录像

- [x] vimtutor完成后的自查清单

## 实验环境

- VirtualBox
- ubuntu-18.04.1-server-amd64

## vimtutuor操作录像

- [第一节学习视频](https://asciinema.org/a/Dw26fAo3tjMTahawPkHPleePY)

- [第二节学习视频](https://asciinema.org/a/CkcYg6HRYOiKanHD6yYS9BdHE)

- [第三节学习视频](https://asciinema.org/a/FMYGf7m8a9UlIs5pSDCRznuZg)

- [第四节学习视频](https://asciinema.org/a/Q0deTXzZ3zA0DnP3TG6V6EFA5)

- [第五节学习视频](https://asciinema.org/a/mdvo4Kf9zOx32TOBWYVWAaxVS)

- [第六节学习视频](https://asciinema.org/a/bfNyDp6rAuQfQ80sQ3esf6Dwq)

- [第七节学习视频](https://asciinema.org/a/ybfVY4tuvxd3DC9idIZOu8leQ)

## vimtutor完成后的自查清单

- 你了解vim有哪几种工作模式？

    - 正常模式 (Normal-mode) 

    - 插入模式 (Insert-mode)

    - 命令模式 (Command-mode)

    - 可视模式 (Visual-mode)

- Normal模式下，从当前行开始，一次向下移动光标10行的操作方法？如何快速移动到文件开始行和结束行？如何快速跳转到文件中的第N行？

    - 向下移动光标十行：`10j`

    - 开始：`gg`

    - 结束：`G`

    - 第N行：`NG`

- Normal模式下，如何删除单个字符、单个单词、从当前光标位置一直删除到行尾、单行、当前行开始向下数N行？

    - 单个字符：`x`

    - 单个单词：`dw`

    - 删除到行尾：`d$`

    - 删除单行：`dd`

    - 删除向下N行：`Ndd`

- 如何在vim中快速插入N个空行？如何在vim中快速输入80个-？

    - 快速插入N个空行：`No`

    - 输入80个-：`80i-ESC`

- 如何撤销最近一次编辑操作？如何重做最近一次被撤销的操作？

    - 撤销最近一次编辑操作：`u`

    - 重做最近一次被撤销的操作：`Ctrl+R`

- vim中如何实现剪切粘贴单个字符？单个单词？单行？如何实现相似的复制粘贴操作呢？

    - 剪切粘贴

        - 单词字符：`xp`

        - 单词单词：`dwp`

        - 单行：`ddp`

    - 相似的复制粘贴操作

        - 进入`visual`模式之后选择要复制的内容，然后退出回到`normal`模式进行粘贴

        - 操作
            - `v` 进入 `visual` 模式

            - 选择要复制的内容

                - `^` 选中当前行，光标位置到行首

                - `$` 选中当前行，光标位置到行尾

                - `w` 到下一个单词首

            - `y` 复制操作

            - `ESC` 退回到`normal`模式

            - `p` 粘贴

- 为了编辑一段文本你能想到哪几种操作方式（按键序列）？

    1. `vim filename`

    2. `i` 进入编辑

    3. 编辑完成，`ESC`回到`normal`模式

    4. `:wq`保存后退出

- 查看当前正在编辑的文件名的方法？查看当前光标所在行的行号的方法？

    - 查看当前正在编辑的文件名和光标所在行号：`Ctrl+G`

    - 或者以下方法也可以查看光标所在行号：`:set number`

- 在文件中进行关键词搜索你会哪些方法？如何设置忽略大小写的情况下进行匹配搜索？如何将匹配的搜索结果进行高亮显示？如何对匹配到的关键词进行批量替换？

    - 关键词搜索

        - `/keyword`

        - `?keyword`

    - 设置忽略大小写的情况下进行匹配搜索：`:set ic`

    - 将匹配的搜索结果进行高亮显示：`set hls is`

    - 对匹配到的关键词进行批量替换：`:%s/old/new/g`

- 在文件中最近编辑过的位置来回快速跳转的方法？

    - 最近编辑过的位置来回快速跳转

        - 向前：`Ctrl+I`

        - 向后：`Ctrl+O`

- 如何把光标定位到各种括号的匹配项？例如：找到(, [, or {对应匹配的),], or }

    1. 将光标移动到该括号

    2. 按下 `%` 进行匹配

- 在不退出vim的情况下执行一个外部程序的方法？

    - 不退出vim的情况下执行一个外部程序：`:!+外部程序命令`

- 如何使用vim的内置帮助系统来查询一个内置默认快捷键的使用方法？如何在两个不同的分屏窗口中移动光标？

    - 使用vim的内置帮助系统来查询一个内置默认快捷键的使用方法：`:help`
    
    - 在两个不同的分屏窗口中移动光标：`Ctrl+W`