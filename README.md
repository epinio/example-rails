# README

This is a sample Ruby on Rails application that can be deployed on Kubernetes
using [Epinio](https://github.com/epinio/epinio/).

## Preparation

1. Create the encrypted credentials file

```
$ EDITOR=vi rails credentials:edit
```

The contents of the opened file should look something like this:

```
secret_key_base: e01281a074dd079e27024412060e8ed5366d1b34a438d07042c1bd325da9459180ac0f1d365e654a7d8695d7b610fc1cee359d254d147283e3bee364bb668646
```

Save and exit the file (`:qw!`)

This command created a `config/master.key` file which is the key to decrypt the
generated `config/credentials.yml.enc` file.

!!! Warning: The file `config/master.key` should not be committed in git. You
should put it in `.gitignore` (which we already did on this project).

You will need the contents of the `master.key` file laters in this guide.

## Deploy

You should already got a cluster with Epinio installed on it. Follow the
[Epinio documentation](https://github.com/epinio/epinio/blob/main/docs/user/tutorials/quickstart.md) if you
need to do that first.

Next step is to create a database for your Rails application. Let's use helm
to deploy a postgresql database inside the cluster:

```
$ helm install postgres bitnami/postgresql --set volumePermissions.enabled=true,postgresqlUsername=myuser,postgresqlPassword=mypassword,postgresqlDatabase=production
```

Create a new application on Epinio:

```
$ epinio apps create rails-example
```

Create a service with Epinio to allow the application to access the database:

```
$ epinio configuration create mydb username myuser password mypassword host postgres-postgresql.default.svc.cluster.local port 5432
```

Create an environment variable for RAILS_MASTER_KEY (https://edgeguides.rubyonrails.org/security.html#custom-credentials):

```
$ epinio apps env set rails-example RAILS_MASTER_KEY $(cat config/master.key)
```

(look at the output and make sure the value of the environment variable matches
the contents of the `config/master.key` file.)

Now push the rails application with Epinio and bind the new database service
at the same time:

```
$ epinio push -n rails-example -b mydb
```

If everything works as expected, the application deployment should finish soon
and the command should print the url of your app. Visit that in your browser
and see the greeting message.


##  TODO:

- Ruby/rails/epinio/whatever versions?
