# frozen_string_literal: true

namespace :dummy_data do
  task create: :environment do
    puts "Create dummy data"

    Rake::Task["dummy_data:create_user"].invoke
    Rake::Task["dummy_data:create_devices"].invoke
    Rake::Task["dummy_data:create_assigns"].invoke

    puts "Create dummy data successfully"
  end

  task create_user: :environment do
    puts "Next, you should create user"
    20.times do |_n|
      name = Faker::Name.name
      email = Faker::Internet.email
      password = "12345678"
      created_at = (rand * 40).days.ago
      User.create(name: name, email: email, password: password, created_at: created_at)
    end
    puts "create user successfully!"
  end

  task create_devices: :environment do
    puts "Next, you should create devices"
    100.times do |_n|
      name = Faker::Device.model_name
      code = Faker::Device.serial
      created_at = (rand * 40).days.ago
      Device.create! name: name, code: code, created_at: created_at
    end
    puts "create devices successfully!"
  end

  task create_assigns: :environment do
    50.times do |_n|
      user = User.all.to_a.sample
      devices = Device.all.to_a.sample
      end_at = (rand * 30).days.ago
      Assign.create! user: user, device: devices, end_at: end_at
    end
  end
end
