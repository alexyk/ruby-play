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