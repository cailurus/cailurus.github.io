# A simple about page

站点全部使用mkdocs弄的，以前没注意过这个Python的静态网页生成工具，只晓得Pelican。对Pelican感觉不是特别好，
以前（现在也是）团队博客的网页就是用的Pelican，比较丑，theme没有一个能打的。

Mkdocs倒是很简单，几乎不需要什么配置，yml文件里面写一些需要展示的page，然后定义一些插件就好。
这种定义的方式我觉得还是比较喜欢的，至少比Sphinx那种上来一大套conf.py要好，就这么几个东西，
看起来也更干净。

普通的markdown特性都可以自带解决，有些特殊的可能需要记录一下。

* mkdocs本身

本身有两个`mkdocs build/serve`命令，好用倒是挺好用的，尤其是`serve`还可以支持即时生效，自动reload。但是看了一下
貌似并不能指定需要`build/serve`的目录，必须要去有yml文件的目录下执行才可以。不过好在最终的静态文件输出目录还是可以支持指定的。
于是我就鸡贼地写了一个简单的Makefile，指定生成的最后静态文件在二级目录。

配置文件也比较简单，如果需要在侧边的目录显示，那么需要配置nav选项，填上对应的pzge名字，以及对应的 相对路径。

如果不需要，那么可以直接在docs里面写上路径就行了，访问的时候可以直接路径访问。

```yml
site_name: a blog
docs:
    deeplearning/dldl/dl1.md
    deeplearning/dldl/dl2.md

nav:
    - Home: index.md
    - DataScience:
        - 'DS1': datascience/ds1.md
        - 'DS2': datascience/ds2.md
    - DeepLearning:
        - 'dl1': deeplearning/dldl/dl1.md
        - 'dl2': deeplearning/dldl/dl2.md
    - About: about.md

theme: readthedocs
extra_javascript: 
    - https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML
markdown_extensions:
    - mdx_math:
        enable_dollar_delimiter: True
```


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

