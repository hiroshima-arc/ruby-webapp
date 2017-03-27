RubyWebアプリケーション開発
===================

# 目的 #
パーフェクトRubyのPart5 Webアプリケーション開発を教材にRubyの勉強をする

# 前提 #
| ソフトウェア   | バージョン   | 備考        |
|:---------------|:-------------|:------------|
| ruby           |2.4.0    |             |
| bootstrap      |3.3.6    |             |
| vagrant        |1.8.7    |             |
| docker         |1.12.5   |             |
| docker-compose |1.8.0    |             |

# 構成 #
## 開発環境セットアップ

    $ vagrant up
    $ vagrant ssh
    $ cd /vagrant        
    $ bundle
    $ bundle exec rackup -o 0.0.0.0
    
http://0.0.0.0:9292/ で動作を確認する    
    
## 本番環境セットアップ
    
    $ vagrant up
    $ vagrant ssh
    $ cd /vagrant        
    $ docker build --no-cache=true --rm -t hiroshima-arc/ruby-webapp .
    $ docker run -d -p 9292:9292 --name app-prd hiroshima-arc/ruby-webapp
    
http://0.0.0.0:9292/ で動作を確認する        
            
## Webアプリケーション開発

### Webインターフェースの追加

### 再びtodoコマンド

### Todoアプリケーション2.0.0の完成

# 参照 #

+ [パーフェクトRuby](http://www.amazon.co.jp/%E3%83%91%E3%83%BC%E3%83%95%E3%82%A7%E3%82%AF%E3%83%88Ruby-PERFECT-SERIES-6-Ruby%E3%82%B5%E3%83%9D%E3%83%BC%E3%82%BF%E3%83%BC%E3%82%BA/dp/4774158798)
