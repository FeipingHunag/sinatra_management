require 'sinatra'
require 'sinatra/reloader' if development?
require 'mongoid'
require 'slim'
require 'redcarpet'
configure do
  Mongoid.load!("./mongoid.yml")
end

class Page
  include Mongoid::Document
  field :title, type: String
  field :content, type: String
end


get '/pages' do
  @pages = Page.all
  @title = "Simple CMS: Page List"
  slim :index
end

post '/pages' do
  puts params
  page = Page.create(params['page'])
  redirect to("/pages/#{page.id}")
end

get '/pages/new' do
  @page = Page.new
  slim :new
end



get '/pages/:id' do
  @page = Page.find(params[:id])
  @title = @page.title
  slim :show
end


