#Stray Pet Placement

##General Overview

  This is a Ruby **Command Line Interface** application that allows multiple animal shelters to intake new stray animals, coordinate available placements of strays in foster care by sharing data between area animal shelters and all registered foster homes. New shelters may also add themselves to the database. The system also permits foster homes to join the database and select unfostered animals.

##Getting Started

  **Stray Pet Placement** uses several Ruby gems, including sinatra-activerecord, require_all, and rainbow. You will need to run `bundle install` before running the program.

  Additionally, in order to access the database and utilize the seed data provided, you will need to run `rake db:migrate` and `rake db:seed` before running the program.

  To execute the program, run `ruby bin/run.rb` from the top-level directory.

##Future Features

  **Stray Pet Placement** is a work-in-progress with an every-growing set of features.  Currently planned expansions include:

    1. Tracking facility capacities
    2. Monitoring and recording animal disposition
    3. Expanding the variety of species assignments that can be made
    4. The ability to leave comments regarding individual animals

##How to use it

  Once inside the **Command Line Interface**, follow the on-screen instructions to interact with the database.  Generally, pressing 0 from most menus will exit the system and retun you to the terminal.

  Feel free to create, read, update, or delete the rows in the database.  If you wish to restore to the initial seed data, delete the file *db/development.db* and enter both `rake db:migrate` and `rake db:seed` into your terminal.

##Built with

  This program was built in Ruby.

##How to contribute

  1. Fork it ( https://github.com/aubreeabril/guided-module-one-final-project-dc-web-071618/fork )
  2. Create your feature branch (`git checkout -b my-new-feature`)
  3. Commit your changes (`git commit -am 'Add some feature'`)
  4. Push to the branch (`git push origin my-new-feature`)
  5. Create a new Pull Request

  This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to be cool about feedback.

##Authors

  **Stray Pet Placement** is the work of [Laura Adam (Whynotski)](https://github.com/whynotski), [Aubree Abril(aubreeabirl)](https://github.com/aubreeabril), and [Jon Schulman(DontJar)](https://github.com/DontJar).

##Special thanks

  Sam, Rob, Paul, and all of the DC_071618 cohort!
