# 又找了一个地方写东西

## 关于我
帝都某小厂的码农，一个普通的中年男子。

## 关于这里
按理说这里会写一些和博客相关的东西，但是迫于年纪大了，想来想去这个页面应该只需要记录一下博客的搭建就好了，这样甚至连 About Page 都可以省掉。

站点全部使用mkdocs弄的，以前没注意过这个Python的静态网页生成工具，只晓得Pelican。对Pelican感觉不是特别好，以前（现在也是）团队博客的网页就是用的Pelican，比较丑，theme没有一个能打的。

Mkdocs倒是很简单，几乎不需要什么配置，yml文件里面写一些需要展示的page，然后定义一些插件就好。
这种定义的方式我觉得还是比较喜欢的，至少比 Sphinx 那种上来一大套 conf.py 要好，东西少，看起来也更干净。

普通的markdown特性都可以自带解决，有些特殊的可能需要记录一下。

* mkdocs本身

本身有两个`mkdocs build/serve`命令，好用倒是挺好用的，尤其是`serve`还可以支持即时生效，自动reload。但是看了一下
貌似并不能指定需要`build/serve`的目录，必须要去有yml文件的目录下执行才可以。不过好在最终的静态文件输出目录还是可以支持指定的。
于是我就鸡贼地写了一个简单的Makefile，指定生成的最后静态文件在二级目录。

配置文件也比较简单，如果需要在侧边的目录显示，那么需要配置nav选项，填上对应的pzge名字，以及对应的 相对路径。

如果不需要，那么可以直接在docs里面写上路径就行了，访问的时候可以直接路径访问。

截至目前（2019/05/21）时刻的 yml 配置文件应该是一个比较满意的状态了，用了 Material for MkDocs，主题还行，中规中矩。完整版可以见页尾。

* 代码

代码其实使用原生的语法就可以了。

```python
import pandas as pd

df = pd.DataFrame({"a": [1,2,3,4], "b": ["aa", "bb", "cc", "dd"]})
```

* 公式

公式这里需要使用一个插件python-markdown-math，然后配置一下inline math的配置。
我是照着[这个方案](https://stackoverflow.com/questions/27882261/mkdocs-and-mathjax)解决的。

$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}$$

inline math: $I(w)=-log(w)$

* 表格

| First Header | Second Header | Third Header |
| ------------ | ------------- | ------------ |
| Content Cell | Content Cell  | Content Cell |
| Content Cell | Content Cell  | Content Cell |

* 乐谱

乐谱部分现在的处理方案是使用GitHub做图床，也就是目前这个项目的另一个static分支。用的也是一个比较不错的工具PicGo，不过需要注意的是GitHub raw会把svg这样的纯文本分享出去的直链也是搞成纯文本，header给丢掉了，所以需要在链接后面加上`xxx.svg?sanitize=true`。

![](https://raw.githubusercontent.com/ailurus1991/ailurus1991.github.io/static/blog_images/test_chorus-1.svg?sanitize=true)



----

```yml
site_name: 啊又一个博客
nav:
    - Home: index.md
    - About: about.md
    - Basics:
        - '信息论': 'basics/information_theory.md'

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
    - mdx_math:
        enable_dollar_delimiter: True
    - admonition
    - codehilite:
        guess_lang: true
    - toc:
        permalink: true
```

