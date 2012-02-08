csso-rails: Stylesheet Optimizer(CSSO) for Rails Asset pipeline
=======

Ruby adapter for <https://github.com/afelix/csso>

about
-----
  CSSO does structure-optimization for css.
  (readme and tests/comparison - coming later)
  Css is usually reduced more that in half in uncompressed and around 15% in gzipped.

usage
------

From ruby:
  require 'csso'
  Csso.optimize("a{ color: #FF0000; }")
  # produces "a{color:red}"

In Rails 3.1+:  
  add this gem to your gemfile, and that's it!
  gem 'csso-rails', :git => ''
  Upon including it becomes the default compressor,
  More explicit way - set in config: config.assets.css_compressor = :csso

In command line:
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