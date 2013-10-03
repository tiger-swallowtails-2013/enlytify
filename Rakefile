require 'sinatra/activerecord/rake'
require 'faker'
require_relative 'app/app.rb'

desc "Create postgres database"
task "db:create" do
  exec("createdb #{DB_NAME}")
end

desc "Drop the postgres database"
task "db:drop" do
  exec("dropdb #{DB_NAME}")
end

desc  "Seed the database"
task "db:seed" do
  20.times do 
    person_index = rand(5) + 1
    Talk.create(topic: Faker::Company.catch_phrase,
        speaker: DBC::User.find(person_index).name,
        date: DateTime.now,
        description:Faker::Lorem.paragraph,
        resources: (Faker::Internet.url) * 4,
        phase: rand(5),
        speaker_id: person_index,
      )
  end
  20.times do 
    person_index = rand(5) + 1
    Talk.create(topic: Faker::Company.catch_phrase,
        speaker: DBC::User.find(person_index).name,
        date: (DateTime.now + 1),
        description:Faker::Lorem.paragraph,
        resources: (Faker::Internet.url) * 4,
        phase: rand(5),
        speaker_id: person_index,
      )
  end
end
