require 'sinatra'
require 'sinatra/reloader' if development?  # 開発環境のみ、reloader を使用する
require 'active_record'
require 'active_support/core_ext/time'

# DB設定ファイルの読み込み
ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection(:development)

class Post < ActiveRecord::Base
end


get '/' do
  @posts = Post.all.order(id: "DESC")
  erb :index
end

get '/create' do
  erb :create
end

post '/post' do
  name = params['name']
  content = params['content']
  post = Post.new
  post.name = name
  post.content = content
  post.save
  erb :post
end

