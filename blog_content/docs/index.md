# 又找了一个地方写东西

## 关于我
帝都某小厂的码农，一个普通的中年男子。

## 关于这里
按理说这里会写一些和博客相关的东西，但是迫于年纪大了，想来想去这个页面应该只需要记录一下博客的搭建就好了，这样甚至连 About Page 都可以省掉。

站点全部使用mkdocs弄的，以前没注意过这个Python的静态网页生成工具，只晓得Pelican。对Pelican感觉不是特别好，以前（现在也是）团队博客的网页就是用的Pelican，比较丑，theme没有一个能打的。

Mkdocs倒是很简单，几乎不需要什么配置，yml文件里面写一些需要展示的page，然后定义一些插件就好。
这种定义的方式我觉得还是比较喜欢的，至少比 Sphinx 那种上来一大套 conf.py 要好，东西少，看起来也更干净。

普通的markdown特性都可以自带解决，有些特殊的可能需要记录一下。

### mkdocs本身

本身有两个`mkdocs build/serve`命令，好用倒是挺好用的，尤其是`serve`还可以支持即时生效，自动reload。但是看了一下
貌似并不能指定需要`build/serve`的目录，必须要去有yml文件的目录下执行才可以。不过好在最终的静态文件输出目录还是可以支持指定的。
于是我就鸡贼地写了一个简单的Makefile，指定生成的最后静态文件在二级目录。

配置文件也比较简单，如果需要在侧边的目录显示，那么需要配置nav选项，填上对应的pzge名字，以及对应的 相对路径。

如果不需要，那么可以直接在docs里面写上路径就行了，访问的时候可以直接路径访问。

截至目前（2019/05/21）时刻的 yml 配置文件应该是一个比较满意的状态了，用了 Material for MkDocs，主题还行，中规中矩。完整版可以见页尾。

### 表格

| First Header | Second Header | Third Header |
| ------------ | ------------- | ------------ |
| Content Cell | Content Cell  | Content Cell |
| Content Cell | Content Cell  | Content Cell |

### 乐谱

乐谱部分现在的处理方案是使用GitHub做图床，也就是目前这个项目的另一个static分支。用的也是一个比较不错的工具PicGo，不过需要注意的是GitHub raw会把svg这样的纯文本分享出去的直链也是搞成纯文本，header给丢掉了，所以需要在链接后面加上`xxx.svg?sanitize=true`。

![](https://raw.githubusercontent.com/ailurus1991/ailurus1991.github.io/static/blog_images/test_chorus-1.svg?sanitize=true)

## 部分功能的插件测试

### 小标记
小标记用的是Admonition这个插件，是py markdown包里面自带的。

??? bug "我是一个bug嘿嘿嘿"
    啊被你发现了
    
除了bug，还有别的其他的，花样挺多。

!!! example
    aaa
    
!!! danger
    bbb

!!! success
    ccc
    
同一种logo还能有几个不同的qualifier

!!! tip
    ddd
    
!!! hint
    ddd
    
### 代码高亮
代码高亮用的是pygments，语法和markdown里面插入代码是一样的。
```python 
import pandas as pd

df = pd.DataFrame({"a": [1,2,3,4], "b": ["aa", "bb", "cc", "dd"]})
```

还可以搞group，以及指定行高亮。。。

``` bash tab="Bash"
#!/bin/bash

echo "Hello world!"
```

``` c tab="C" 
#include <stdio.h>

int main(void) {
  printf("Hello world!\n");
}
```

``` c++ tab="C++" hl_lines="3 4"
#include <iostream>

int main() {
  std::cout << "Hello world!" << std::endl;
  return 0;
}
```

### 小标题链接
其实是toc功能，直接在toc里面启用permalink就好了，不过我这里还把anchorlink也启用了（为了好看。

### 数学公式

如果是官方的那个主题，公式需要一个插件python-markdown-math，照着[这个方案](https://stackoverflow.com/questions/27882261/mkdocs-and-mathjax)就行。

不过我选择使用懒人解决方案：[PyMdown Extensions](https://facelessuser.github.io/pymdown-extensions/extensions/arithmatex/)！

直接启用arithmatex就行了，不过同样需要一个extra js（毕竟最后渲染大家用的都是MathJax。

$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}$$

inline math: $I(w)=-log(w)$

### Misc
其实这个大礼包里面花里胡哨的插件还真不少，而且启用都非常简单。


* [x] 吃早饭 :beers:
* [x] 吃午饭 :ice_cream:
* [x] 写代码 :desktop_computer:  ++command+c++ ++command+v++
* [x] 吃晚饭 :taco:
* [ ] 打游戏 :video_game:
* [ ] 看电影:roll_of_paper:
* [ ] 睡觉 :night_with_stars:


----

```yml
site_name: 啊又一个博客

nav:
    - Home: index.md
    - Basics:
        - '信息论': 'basics/information_theory.md'
        - 'TF-IDF': 'basics/tfidf.md'

theme:
    name: 'material'
    palette:
        primary: 'teal'
        accent: 'teal'
    font:
        text: 'Noto Serif SC'
        code: 'Ubuntu Mono'
    logo:
        icon: 'local_cafe'

extra:
    social:
        - type: 'twitter'
          link: 'https://twitter.com/ailurus1991'

extra_javascript: 
    - https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML

markdown_extensions:
    - pymdownx.arithmatex
    - pymdownx.betterem:
        smart_enable: all
    - pymdownx.caret
    - pymdownx.critic
    - pymdownx.details
    - pymdownx.emoji:
        emoji_generator: !!python/name:pymdownx.emoji.to_png
        emoji_index: !!python/name:pymdownx.emoji.emojione
    - pymdownx.inlinehilite
    - pymdownx.magiclink
    - pymdownx.mark
    - pymdownx.smartsymbols
    - pymdownx.superfences
    - pymdownx.tasklist:
        custom_checkbox: true
    - pymdownx.tilde
    - pymdownx.keys

    - admonition
    - codehilite:
        guess_lang: true
        linenums: true
    - toc:
        permalink: true
        anchorlink: true
```

