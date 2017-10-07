from flask import Flask, request

from twilio.rest import Client

app = Flask(__name__)

# put your own credentials here
ACCOUNT_SID = 'AC3ef723ee1083616bb764cb0838994a18'
AUTH_TOKEN = '046d72ba4056daa49f20088e8eee9bf6'

client = Client(ACCOUNT_SID, AUTH_TOKEN)

@app.route('/', methods=['POST'])
def send_sms():
    message = client.messages.create(to=request.form['To'], from_='+12156082234', body=request.form['Body'])
    return message.sid

if __name__ == '__main__':
    app.run()