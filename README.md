# Assumptions:

 * Ruby is installed

 * Rails is installed

 * Git is installed

 * Postgres

# Project Setup

* Go to the required directory to clone the application and run 'git clone https://github.com/GaneshMadhu/tickets.git'.

* cd 'project root directory'

* run 'bundle install' to install the dependencies.

* configure the database.yml with adapter as 'postgresql' and proper access to the database.

* run 'rake db:create' and then migrate the database.

* run 'rake db:seed' to seed the database with the initial data.

* start the server and visit the application (http://localhost:3000/ - with default port)

```sh
git clone https://github.com/GaneshMadhu/tickets.git
cd tickets
bundle install
rake db:create
rake db:migrate
rake db:seed
```

# CLI Interface

**Note:** Please make sure to seed the database with rake db:seed.

Inside the application directory, run 'ruby lib/ticket_manager.rb' to check the functionality through Command Line Interface.

```sh
ruby lib/ticket_manager.rb
```

# Unite Testing

Test Suite has been added with RSpec and Capybara.

  - run 'rspec spec' to cover all the test cases.

  - run 'rspec spec/controllers' to test the controller functionalities.

  - run 'rspec spec/features' to test the feature specs.

```sh
rspec spec
rspec spec/controllers
rspec spec/features
```
