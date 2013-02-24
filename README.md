csso-rails: Stylesheet Optimizer(CSSO) for Rails Asset pipeline
=======

Ruby adapter for <https://github.com/afelix/csso>

About
-----
CSSO does structure-optimization for css.
Css is usually reduced more than in half in uncompressed and around 15% in gzipped.

### A real-world example
A living rails application css - some written in less, some handwritten):

|        | Original     |  sass  | yui 2.4.7  | csso  | % of original
|:-------|:------------:|:------:|:-----:|:-----:|:------:
|Plain   | 129497       | 107006 | 60758 | 60874 | 47%
|GZipped | 14046        | 12047  | 10558 | 10472 | 74%

Very close to yui compressor, wining in gzipped (you're using nginx mod\_gzip_static, don't you?)

A more hard example - twitter bootstrap.css, already minified:

|        | Original     | lessc | yui 2.4.7  | csso  | % of original
|:-------|:------------:|:-----:|:-----:|:-----:|:------:
|Plain   | 81443        | 71520 | 68755 | 67679 | 83%
|GZipped | 12384        | 11633 | 11652 | 11477 | 92%

usage
------

### In Rails 3.1+
add `gem 'csso-rails'` to your gemfile, and that's it!

Upon including it becomes the default compressor even if sass is included too.
More explicit way - set in config: config.assets.css_compressor = :csso


### In plain ruby

```ruby
 require 'rubygems'
 gem 'csso-rails'
 require 'csso'
 puts Csso.optimize("a{ color: #FF0000; }") # produces "a{color:red}"
```

In _maniac mode_(`Csso.optimize(css, true)`, default for pipeline) css is processed several times until it stops getting lighter (there're cases when original csso does not do all optimizations for no reason).

### In command line:

    ruby_csso non_optimized.css > optimized.css


MIT-License
-------

> Original CSSO code - Copyright (C) 2011 by Sergey Kryzhanovsky
> ruby gem - Copyright(C) 2012 Vasily Fedoseyev

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
