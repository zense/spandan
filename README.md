# Spandan 2016 

## Contribution Instructions

Please follow these things: 
* Don't commit changes made to: "database.yml"
* Please don't push code to the master branch of this repository even if you have access to it. Fork from zense/spandan
and then add whatever changes you want to. 

If you are getting merge conflict in files like "schema.rb" or "Gemfile.lock" then use this to fix problems : 
```sh
# For resolving schema.rb conflict
git checkout HEAD schema.rb
rake db:migrate

# For resolving Gemfile.lock conflicts
git checkout HEAD Gemfile.lock
bundle install 
```
