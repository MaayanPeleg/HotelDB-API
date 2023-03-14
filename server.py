# run with "flask --app server run --debug" or "python server.py"
#In deployement use "gunicorn server:app -b 0.0.0.0:8000" 
import mysql.connector as mysql #pip install mysql-connector-python
from flask import Flask #pip install flask

app = Flask(__name__)
#This is the information to connect to the DB
config = { #change to your DB info
    'user': 'root',
    'password': 'ABC123',
    'host': 'localhost',
    'database': 'Hotel'
}

def connGenJSON(query, *args):
    #'connect to DB
    with mysql.connect(**config) as conn:
        cursor = conn.cursor()
        if args:
            cursor.execute(query, (args[0],))
        else:
            cursor.execute(query)
        #Get Flield names
        field_headers = [i[0] for i in cursor.description]
        JSONlist = []
        #Generate JSON
        #rec is each of the records
        for rec in cursor.fetchall():
            #Adds a dict object to the list
            JSONlist.append(dict((field_headers[i], rec[i]) for i in range(len(field_headers))))
    
        return JSONlist

@app.route('/guest/<guestid>/')
def get_guestid(guestid):
    #Output JSON
    JSONout = {}
    #Generate JSON and SELECts data from database
    JSONout['guests'] = connGenJSON('''
        SELECT *
        FROM Guest g
        JOIN City c ON c.Zipcode = g.Zipcode
        WHERE g.GuestID = %s;
        ''', guestid)

    #send requested information
    return JSONout
    

@app.route('/guest/')
def guest():
    #Output Json
    JSONout = {}
    #Generate JSON and SELECts data from database
    JSONout['guests'] = connGenJSON('''
        SELECT *
        FROM Guest g
        JOIN City c ON c.Zipcode = g.Zipcode;
        ''')

    #send requested information
    return JSONout


@app.route('/reservation/')
def reservation():
    #Output Json
    JSONout = {}
    #Generate JSON and SELECts data from database
    JSONout['reservations'] = connGenJSON('''SELECT res.ReservationID,
          res.StartDate, 
          res.EndDate, 
          g.FirstName, 
          g.LastName, 
          g.GuestID, 
          group_concat(rr.RoomNumber) AS rooms
        FROM Reservation res
        JOIN Guest g ON g.GuestID = res.GuestID
        JOIN RoomReservation rr ON rr.ReservationID = res.ReservationID
        GROUP BY res.ReservationID;''')

    #Get rooms for reservation, get multiple fields per feild in sql query
    #make rooms a list for each reservation
    for res in JSONout['reservations']:
        res['rooms'] = res['rooms'].split(',')

    return JSONout
        
@app.route('/reservation/<resid>/')
def get_reservation(resid):
    #Output Json
    JSONout = {}
    #Gets all reservations and their geust
    #Generate JSON
    JSONout['reservations'] = connGenJSON('''SELECT
         res.ReservationID,
         res.StartDate,
         res.EndDate,
         g.FirstName,
         g.LastName,
         g.GuestID,
         group_concat(rr.RoomNumber) AS rooms
        FROM Reservation res
        JOIN Guest g ON g.GuestID = res.GuestID
        JOIN RoomReservation rr ON rr.ReservationID = res.ReservationID
        WHERE res.ReservationID = %s;''', resid)

    #Get rooms for reservation
    #make rooms a list for each reservation
    for res in JSONout['reservations']:
        res['rooms'] = res['rooms'].split(',')

    return JSONout


@app.route('/room/')
def room():
    #Output Json
    JSONout = {}
    #get all room info
    #Generate JSON and SELECts data from database
    JSONout['rooms'] = connGenJSON('''
        SELECT
         r.*,
         t.MaxOccupancy,
         t.Name as Type,
         t.StandardOccupancy,
         gp.Price,
         gp.PriceExtraPerson
        FROM Room r
        JOIN `Type` t ON t.typeID = r.TypeID
        JOIN get_price gp ON gp.RoomNumber = r.RoomNumber;
        ''')

    return JSONout

@app.route('/room/<roomnum>')
def get_room(roomnum):
    #Output Json
    JSONout = {}
    #get all room info
    #Generate JSON and SELECts data from database
    JSONout['rooms'] = connGenJSON('''
        SELECT
         r.*,
         t.MaxOccupancy,
         t.Name as Type,
         t.StandardOccupancy,
         gp.Price,
         gp.PriceExtraPerson
        FROM Room r
        JOIN `Type` t ON t.typeID = r.TypeID
        JOIN get_price gp ON gp.RoomNumber = r.RoomNumber
        WHERE r.RoomNumber = %s;
        ''', roomnum)

    return JSONout
    
@app.route('/type/')
def type():
    #Output Json
    JSONout = {}
    #get all type info
    #Generate JSON and SELECts data from database
    JSONout['type'] = connGenJSON('''
        SELECT
         *
        FROM `Type`;
        ''')
    
    return JSONout

@app.route('/type/<typeid>')
def get_type(typeid):
    #Output Json
    JSONout = {}
    #get all type info
    #Generate JSON and SELECts data from database
    JSONout['type'] = connGenJSON('''
        SELECT
         *
        FROM `Type`
        WHERE TypeID = %s;''', typeid)
    
    return JSONout

#OLD METHOD OF SELECTING DATA AND GEN JSON
'''def genJSON(cursor):
    #Get Flield names
    field_headers = [i[0] for i in cursor.description]
    JSONlist = []
    #Generate JSON
    #rec is each of the records
    for rec in cursor.fetchall():
        #Adds a dict object to the list
        JSONlist.append(dict((field_headers[i], rec[i]) for i in range(len(field_headers))))
    
    return JSONlist

@app.route('/TABLE/')
def TABLE():
    #Output Json
    JSONout = {}
    #connects to database
    with mysql.connect(**config) as conn:
        cursor = conn.cursor()
        # retrieves guest information
        cursor.execute(
        SELECT *
        FROM TABLE;
        )
        #Generate JSON
        JSONout['TABLE'] = genJSON(cursor)

        #send requested information
        return JSONout'''

@app.route('/')
def index():
    #Output Json
    JSONout = {}
    #Generates JSON and connects to DB
    JSONout['tables'] = connGenJSON('''
        SHOW TABLES;
        ''')

    return JSONout

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8000, debug=True)
  