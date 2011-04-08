Overview [![stillmaintained](http://stillmaintained.com/eval/csv-omg.png)](http://stillmaintained.com/eval/csv-omg)
========

CsvOmg (formerly known as [csvmapper](https://github.com/thinkcreate/csvmapper)) easily lets you map CSV to objects. Inspired by [happymapper](https://github.com/jnunemaker/happymapper).
Please check out the example below and included tests to see how it works.


Examples
-----

    module Shop
      class Product
        include CsvOmg

        col :name,           'product_name'
        col :uid,            'product_uid',    Integer
        col :description,    2
        col(:price_in_cents, 'product_price',  Float){|float| (float * 100).round }

      end
    end

    csv =<<-CSV.gsub(/^ +/,'')
      product_uid,product_name,product_description,product_price
      1200,Ham,like you never tasted before,19.99
    CSV

    p1 = Shop::Product.parse(csv).first
    p1.price_in_cents   # 1999

Requirements
------------

[FasterCSV](https://rubygems.org/gems/fastercsv)

Installation
------------

    $ gem install csv-omg

Author
------

Gert Goet (eval) :: gert@thinkcreate.nl :: @gertgoet

License
------

(The MIT license)

Copyright (c) 2011 Gert Goet, ThinkCreate

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
