RubyWebアプリケーション開発
===================

# 目的 #
パーフェクトRubyのPart5 Webアプリケーション開発を教材にRubyの勉強をする

# 前提 #
| ソフトウェア   | バージョン   | 備考        |
|:---------------|:-------------|:------------|
| ruby           |2.2.1-p85    |             |
| bootstrap      |3.3.6        |             |
| vagrant        |1.7.4    |             |
| docker         |1.11.0-rc3    |             |
| docker-compose |1.7.0rc1    |             |

# 構成 #
## 開発環境セットアップ

    $ vagrant up
    $ vagrant ssh
    $ cd /vagrant        
    $ docker build --no-cache=true --rm -t hiroshima-arc/ruby-webapp:dev -f Dockerfile-dev .
    $ docker run -it -v $(pwd):/app -p 9292:9292 --name app-dev hiroshima-arc/ruby-webapp:dev
    $ bundle
    $ rackup -o 0.0.0.0
    
## 本番環境セットアップ
    
    $ vagrant up
    $ vagrant ssh
    $ cd /vagrant        
    $ docker build --no-cache=true --rm -t hiroshima-arc/ruby-webapp .
    $ docker run -d -p 9292:9292 --name app-prd hiroshima-arc/ruby-webapp
            
## Webアプリケーション開発

### Webインターフェースの追加

### 再びtodoコマンド

### Todoアプリケーション2.0.0の完成

# 参照 #

+ [パーフェクトRuby](http://www.amazon.co.jp/%E3%83%91%E3%83%BC%E3%83%95%E3%82%A7%E3%82%AF%E3%83%88Ruby-PERFECT-SERIES-6-Ruby%E3%82%B5%E3%83%9D%E3%83%BC%E3%82%BF%E3%83%BC%E3%82%BA/dp/4774158798)
