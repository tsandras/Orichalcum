# Orichalcum *(POC website)*

### ENV
* Rails 5.0.0
* ruby 2.3.0
* Postgres 9.5

### Install on Mac OS
```sh
brew install ruby-2.3.0
brew install postgres
// for paperclip
brew install imagemagick
// for rails-erd
brew install graphviz
gem install rails
gem install bundler
rails new Orichalcum --database=postgresql
bundle install
initdb /path/to/directory
pg_ctl -D /path/to/directory start
rake db:create:all
rails server
```

### TODO
```sh
annotate
rubocop
```

### Model pattern
1) Attributs
2) Relations
3) Validations
4) Scopes
5) Callbacks
6) Public methods
7) Protected methods
8) Private methods

### Domain Model
Run `rake generate_erd` to regenerate (must have graphvis).
![](/public/erd.png)
