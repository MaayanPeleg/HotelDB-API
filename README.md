# Hotel Database API using Flask And Mysql Connector

This project is an API for use with an abstract database that i created for use in a hotel.
The ERD for this database is shown below:
<img src="https://i.imgur.com/NsGGJo6.png" width="100" height=auto/>

To run the server in a dev environment, (NEVER IN PROD!) use:
```
flask --app server run --debug
```
To run in PROD use:
```
gunicorn server:app -b 0.0.0.0:8000
```