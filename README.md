# Hotel Database API using Flask And Mysql Connector

This project is an API for use with an abstract database that i created for use in a hotel.
The ERD for this database is shown below:


<img src="https://i.imgur.com/NsGGJo6.png" width="500" height=auto/>

To run the server in a dev environment, (NEVER IN PROD!) use:
```
flask --app server run --debug
```
To run in PROD use:
```
gunicorn server:app -b 0.0.0.0:8000
```

Update: Now inculded the SQL files to create the MYSQL database, Also amend the information within the config dict to connect to your local MYSQL DB.

##Building Images
When you make a pull request to the main branch, GitHub actions pipline builds new images and pushes to a repo.

##Running 
