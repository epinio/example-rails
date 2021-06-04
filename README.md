# README

This is a sample Ruby on Rails application that can be deployed on Kubernetes
using [Epinio](https://github.com/epinio/epinio/).

## Preparation

This repository was created following these steps:

1. Create a new Rails application:

```
$ rails new epinio-rails-sample
$ cd epinio-rails-sample
```

2. Create the encrypted credentials file for the "production" environment

```
$ rails credentials:edit --environment production
```

3. Put the generated `config/credentials/production.key` value in the
RAILS_MASTER_KEY environment variable

```
cat << EOF > project.toml
[[build.env]]
RAILS_MASTER_KEY="$(cat config/credentials/production.key)"
EOF
```

!!! Warning: You shouldn't commit your master key in git. We do this here because
this application is just a demonstration on how Epinio works with Rails and we
don't store any important secrets in the credentials file. You should add `project.toml`
to `.gitignore` if you follow this guide to avoid checking the master key in git.

## Deploy

You should already got a cluster with Epinio installed on it. Follow the
[Epinio documentation](https://github.com/epinio/epinio/#quick-start) if you
need to do that first.

Next step is to create a database for your Rails application. Let's use Epinio's
in-cluster services to provision an instance of Mariadb:


Enable incluster services:
```
$ epinio enable services-incluster
```

Provision a Mariadb service named "rails-database":
```
$ epinio service create rails-database mariadb 10-3-22
```

Now push the rails application with Epinio and bind the new database service
at the same time:

```
$ epinio push rails-example -b rails-database
```



##  TODO:

- cache image? (to make pushes faster)
- RAILS_MASTER_KEY?
- Ruby/rails/epinio/whatever versions?

### Original Rails readme
This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
