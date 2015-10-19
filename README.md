# Akayagi

This is Redmine plugin to extend mail settings.  
"Akayagi" means Red Goat in Japanese (赤山羊).

## Versions that is confirmed to working

* Redmine version 3.1.0.stable
* Ruby version 1.9.3-p551 (2014-11-13) [x86_64-linux]
* Rails version 4.2.3

## Getting started

### 1. Install the plugin

```
cd <REDMINE_HOME>/plugins
git clone https://github.com/zaneli/akayagi.git
```

or download source code, unzip (or extract the archive), and move directories to `<REDMINE_HOME>/plugins`.

### 2. Run db migration

```
rake redmine:plugins:migrate RAILS_ENV=<development or production>
```

## Usage

### General Settings

Specify mail prefix.  
![General Settings](http://www.zaneli.com/img/akayagi/akayagi01.png "General Settings")

### Settings per project

Specify mail prefix, from address, to address, cc address and bcc address.  
(It can specify comma-separated multiple address at to, cc and bcc address)  
![Settings per project](http://www.zaneli.com/img/akayagi/akayagi02.png "Settings per project")
