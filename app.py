from flask import Flask , render_template, request
import subprocess
import mysql.connector

mydb = mysql.connector.connect(user='root', password='TihylfMSQL@24',
                              host='127.0.0.1')

app = Flask(__name__)

@app.route('/')
def home_page():
    return render_template('index.html',output=None,display='False')

@app.route('/query',methods=["POST"])
def query_handler():
    queryString = request.form['query']
    f = open("inputFile.txt", "w")
    f.write(queryString+'\n')
    f.close()
    output = subprocess.check_output("./q", shell=True)
    output = output.decode('ascii')
    print(output)
    if output=='error: syntax error\n':
        return render_template('index.html',output=output,display='True',viewdetails=None,table='False')

    mycursor = mydb.cursor(buffered=True)
    mycursor.execute(output)
    mydb.commit()
    if output.find("SELECT")!=-1 or output.find("SHOW")!=-1:
        columndetails = mycursor.description
        viewdetails = mycursor.fetchall()
        return render_template('index.html',output=output,display='True',viewdetails=viewdetails,columndetails=columndetails,table='True')
    return render_template('index.html',output=output,display='True',viewdetails=None,columndetails=None,table='False')
    
    

if __name__=='__main__':
    app.run(debug=True,port='5000')
