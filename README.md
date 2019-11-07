## 名称（Title）
万葉（Manyou）
  
## 開発環境（Development environment）  
* ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-darwin18]
* Rails 5.2.3
* psql (PostgreSQL) 11.5  
  
## テーブル構成（Database Table Info）  
  
|User|||
|:-:|:-:|:-:|
|PK|id||
||name|string|  
  
|Task|||
|:-:|:-:|:-:|
|PK|id||
|FK|user_id|integer|
||title<br>content<br>limit<br>priority<br>status|string<br>text<br>datetime<br>integer<br>integer|  
  
|Tagging|||
|:-:|:-:|:-:|
|PK|id||
|FK|task_id|integer|
|FK|tag_id|integer|  
  
|Tag|||
|:-:|:-:|:-:|
|PK|id||
||title|string|  
  
## Herokuへのデプロイ手順（Deploy Process for Heroku）  
ターミナルで以下のコマンドを入力
 
 ```
$ rails assets:precompile RAILS_ENV=production
$ git add --all
$ git commit -m "init"
$ heroku create
$ git push heroku master
$ heroku run rails db:migrate
```