# bounty

This is the github repo of the mighty bounty website

## installetion

* Ubuntu - https://gorails.com/setup/ubuntu/14.10
* Mac - https://gorails.com/setup/osx/10.11-el-capitan

run
```sh
bundle install
```
```sh
rake db:migrate
rake db:seed
```

## Running localy
### Before run:
```sh
bundle install
```
### staring the server
```sh
rails s
```

## Heroku

### Deploy (after logged in to heroku):

If heroku is not set up with bounty
```sh
heroku git:remote -a bountyapp
```

```sh
git push heroku master
```
### acces to heroku command line

```sh
heroku run YOUR_CODE_HERE
```
