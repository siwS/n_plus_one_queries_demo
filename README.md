# README

This is a demo app for the N+1 queries presentation.

To try the app locally:

1. Clone the repo `git@github.com:siwS/n_plus_one_queries_demo.git`
2. Run `bundle install`
3. Run `bin/rails db:setup` and `bin/rails db:seed` to seed the DB
4. Start the server `bin/rails s`
5. Go to http://127.0.0.1:3000/contact to confirm the DB is seeded  properly and you can see some data
6. Fire up a console `bin/rails console`
7. Go to the db/notes.rb file for the notes of the presentation and the N+1 queries