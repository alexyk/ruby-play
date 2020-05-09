# Ruby Version Management

## Chruby

### Basics
* list possible versions with `ruby-install list`
* install with `ruby-install <type> <version>` for example: `ruby-install ruby 2.5.9`
* list installations with `chruby`
* use installation with `chruby_use <name>` for example: `chruby_use ruby-2.5.9`

### Gem Migration
* list installations with `chruby`
* ???


## RVM

### Basics
* **TODO**

### Gem Migration
* copy single gem with `rvm gemset copy <version-source@app> <version-dest@app>` for exmaple `rvm gemset copy 2.1.1@myapplication 2.1.2@myapplication`
* mirgate all with `rvm migrate <installation-source> <installation-dest>` for example `rvm migrate 2.1.1 jruby-1.7.12`

### Version Updrage
* update all gems with `rvm gemset update`
* **upgrade ruby version** with `rvm upgrade <old-version> <new-version>` for example `rvm upgrade 2.1.1 2.1.2`

# Information

## Random Projects and Repos
https://github.com/madzhuga/rails_workflow_demo/  
### Combined with React
https://github.com/kelvinr/React-Todo
### Workflows
https://github.com/rails-engine/flow_core
### Tools
https://github.com/morshedalam/rename
https://github.com/jcrisp/rails_refactor
### Repos
https://github.com/ruby
https://github.com/rails
#### Random
https://github.com/jcrisp?tab=repositories

## Reference

### Ruby
https://rubymonk.com

### Rails
https://guides.rubyonrails.org/getting_started.html

### SASS/SCSS
https://sass-lang.com/documentation/style-rules

## Articles
https://thoughtbot.com/blog/rails-patch-change-the-name-of-the-id-parameter-in