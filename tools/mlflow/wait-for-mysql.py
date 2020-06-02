import mysql.connector
import time
import os

done = False
while(True): 
    mydb = mysql.connector.connect(host=os.environ['MYSQL_HOST'],user=os.environ['MYSQL_USER'],passwd=os.environ['MYSQL_PASSWORD'])
    mycursor = mydb.cursor()
    mycursor.execute("SHOW DATABASES LIKE 'mlflow'")
    for x in mycursor: 
        done = True
        break
    if done:
        break 
    time.sleep(1)