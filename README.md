
#DJ Charts a Sinatra Application


#Introduction

This is a CRUD (Create, Read, Update and Delete) web app with a back-end built in Sinatra as my second project for the Flatiron School, Web Developer program.

The app is designed for users (a.k.a DJ's or record collectors) keep track of and share their top record charts and at the same time, add and keep track of their record collection.

Visitors do not need to be logged in to view the chart and record database, however, a user must be logged in and authenticated in order to edit and/or delete his/her chart/records. Also a logged in user can only add or edit their own content. For user authentication, username and password validators were created with a combination of Ruby and RegEx.


#Installation and Usage

Github repository of the project: https://github.com/asabogal/dj-charts-sinatra-app

After cloning the repository:

$ bundle install

Run migrations:

$ rake db:migrate

Host on local server:

$ shotgun

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/asabogal/dj-charts-sinatra-app. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
