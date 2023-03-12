# lime.software

This repository contains the source for the website hosted at https://lime.software/

It is a static website generated with jekyll.

## Prerequisites

You need ruby and gem before starting. Specifically you need ruby 2.3.7.

```bash
# check version of ruby
ruby --version
```

If you have ruby 2.3.7 installed you can generate the site.

If not, it is recommended to use rvm (Ruby enVironment Manager) to install older versions of ruby, however this is not a necessity.

## Generate the site

From the root of the repository do the following.

```bash
# install bundler
gem install bundler

# install gems
bundle install

# build site and watch files for changes, you will be able to see the site at http://127.0.0.1:4000/
bundle exec jekyll serve
```
