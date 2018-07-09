source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem "rails", "5.1.4"
gem "puma", "3.9.1"
gem "sass-rails", "5.0.6"
gem "uglifier", "3.2.0"
gem "coffee-rails", "4.2.2"
gem "jquery-rails", "4.3.1"
gem "turbolinks", "5.0.1"
gem "jbuilder", "2.7.0"
gem "bcrypt"
gem "bootstrap-sass", "3.3.7"
gem "config"
gem "faker", "1.7.3"
gem "carrierwave"
gem "flex-slider-rails"
gem "kaminari"

group :development, :test do
  gem "sqlite3", "1.3.13"
  gem "byebug", "9.0.6", platform: :mri
end

group :development do
  gem "web-console", "3.5.1"
  gem "listen", "3.1.5"
  gem "spring", "2.0.2"
  gem "spring-watcher-listen", "2.0.1"
end

group :test do
  gem "rails-controller-testing", "1.0.2"
  gem "minitest", "5.10.3"
  gem "minitest-reporters", "1.1.14"
  gem "guard", "2.13.0"
  gem "guard-minitest", "2.4.4"
end

group :production do
  gem "pg", "0.18.4"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
