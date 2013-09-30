require 'sinatra/activerecord/rake'
require_relative 'app.rb'

desc "Create postgres database"
task "db:create" do
  exec("createdb #{DB_NAME}")
end

desc "Drop the postgres database"
task "db:drop" do
  exec("dropdb #{DB_NAME}")
end

