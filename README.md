# Salt Edge Test App

## Features

- Sign Up and Sign In, store user in local db
- Create SaltEdge customer on Sign Up
- Create connection to fake_bank and stored in local db
- Show accounts for signed user 
- Show transaction for each accounts
- Show connection history for signed user 


## Tech

Dillinger uses a number of open source projects to work properly:

- [Ruby on Rails] - server-side web application framework written in Ruby 
- [Twitter Bootstrap] - great UI boilerplate for modern web apps
- [DataTables] - plug-in for create ajax tables
- [Devise] - flexible authentication solution for Rails based on Warden
- [httparty] - gem for making API requests
- [jQuery] - duh


## Installation

Salt Edge Test App requires [Ruby](https://github.com/ruby/ruby) v2.7.1 and [Rails]() v6.1.6 to run.

Install the dependencies and devDependencies and start the server.

```sh
cd salt_edge_test
bundle install
rails s
```