[![Build Status](https://travis-ci.org/ssnikolay/pumper.svg?branch=master)](https://travis-ci.org/ssnikolay/pumper)

Pumper
======

**Pumper** helps quickly update developed gem (e.g. &lt;your_gem>)in dependent project (which uses bundler).

**Pumper** do:

1. Update &lt;your_gem>'s version in Gemfile of project.

2. Remove any old versions of &lt;your_gem>.

3. Install new build of &lt;your_gem>.

Supports install gem to vendor/cache folder and using RVM (see [Options](#options))

## Installation

Add it to your .gemspec:

```ruby
spec.add_development_dependency 'pumper'
```

And run the following command to install it:

```sh
$ bundle install
```

Or install without gemspec:

```sh
$ gem install pumper
```

## Usage

For basic usage **Pumper** you need to go to gem folder and run:

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

### <a name="options"></a> Options

 Option                   | Description
------------------------- |:-----------------------------------------------------------
 `--project`              | Path to ruby project where &lt;your_gem> needs update
 `--absolute_path`        | If project path is absolute
 `--gemset`               | Gemset name (if you use RVM)
 `--vendor`               | If project gems stored in the vendor/cache
 `--config`               | If you want to use special config for updating project


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

#### Config option

For use `--config` option you need to put `.pumper.yml` to &lt;your_gem> folder and write something like this:

```yml
projects:
  rails_project:
    path: /Users/admin/Projects/rails_project
    absolute_path: true
    gemset: ruby-2.1.0
    vendor: true
```

and run

```sh
$ pumper --config
```