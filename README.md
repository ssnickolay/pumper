[![Build Status](https://travis-ci.org/ssnikolay/pumper.svg?branch=master)](https://travis-ci.org/ssnikolay/pumper)

Pumper
======

**Pumper**

## Installation

Add it to your .gemspec:

```ruby
spec.add_development_dependency 'pumper'
```

Run the following command to install it:

```sh
$ bundle install
```

Or install without gemspec:

```sh
$ gem install pumper
```

## Usage

Basic **Pumper** use:

+ your_gem
    - your_gem.gemspec
    - ...
+ rails_project
    - app
    - Gemfile
    - ...

```sh
$ pwd
=> /Users/admin/Projects/your_gem
$ pumper -p rails_project
=>
rm -rf pkg && bundle exec rake build
your_gem 0.0.1 built to pkg/your_gem-0.0.1.gem.
gem uninstall your_gem --all -x
gem install ./pkg/your_gem-0.0.1.gem && cd /Users/admin/Projects/rails_project && bundle install
Successfully installed your_gem-0.0.1
1 gem installed
Success bump current gem
```

### Options

 Option                   | Description
------------------------- |:-----------------------------------------------------------
 `--project`              | Path to ruby project where need update current gem
 `--absolute_path`        | If project path is absolute
 `--gemspec`              | Path to .gemspec (default search in current folder *.gemspec)
 `--gemset`               | Gemset name (if you use RVM)
 `--vendor`               | If project gems stored in the vendor/cache

Example:

```sh
$ pumper --project rails_project --gemset ruby-2.1.0@rails_project --vendor
=>
rm -rf pkg && bundle exec rake build
your_gem 0.0.1 built to pkg/your_gem-0.0.1.gem.
rvm ruby-2.1.0@my-app exec gem uninstall your_gem --all -x
Successfully uninstalled your_gem-0.0.1
cp pkg/* /Users/admin/Project/rails_project/vendor/cache && cd /Users/admin/Project/rails_project && rvm ruby-2.1.0@rails_project exec bundle install --local
Installing your_gem 0.0.1
Success bump current gem
```
