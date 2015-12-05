RubyWebアプリケーション開発
===================

# 目的 #
パーフェクトRubyのPart5 Webアプリケーション開発を教材にRubyの勉強をする

# 前提 #
| ソフトウェア   | バージョン   | 備考        |
|:---------------|:-------------|:------------|
| ruby           |2.2.1-p85    |             |
| vagrant        |1.7.4    |             |
| docker         |1.9.1    |             |

# 構成 #
## 環境セットアップ

### Vagarnt

    $ vagrant up
    $ vagrant ssh
    $ cd /vagrant
    
### Docker
    
    $ docker build --no-cache=true --rm -t hiroshima-arc/ruby-webapp .
    $ docker run -it -v $(pwd):/app -p 9292:9292 --name app hiroshima-arc/ruby-webapp
    $ rackup -o 0.0.0.0
    
## Webアプリケーション開発

### Webインターフェースの追加

### 再びtodoコマンド

### Todoアプリケーション2.0.0の完成

# 参照 #

+ [パーフェクトRuby](http://www.amazon.co.jp/%E3%83%91%E3%83%BC%E3%83%95%E3%82%A7%E3%82%AF%E3%83%88Ruby-PERFECT-SERIES-6-Ruby%E3%82%B5%E3%83%9D%E3%83%BC%E3%82%BF%E3%83%BC%E3%82%BA/dp/4774158798)
