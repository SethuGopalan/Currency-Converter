from flask import Flask,request
from flask_restful import Resource ,Api
from currency_converter import CurrencyConverter

app=Flask(__name__)

api=Api(app)

class find_Cur(Resource):

    def get(self):
        Cur_value=request.args.get('value1',type=float)
        Cur_type=request.args.get('first_cur',type=str)
        Cur_count=request.args.get('sec_Cur',type=str)

        if Cur_value is None or Cur_type is None or Cur_count is None:

            return {"Error" : "Pleaseenter values to find the currencey value"},400

        Curencey=CurrencyConverter()
        rate=Curencey.convert(Cur_value,Cur_type,Cur_count)

        return {'rate' :rate}

api.add_resource(find_Cur,'/Cur')
    
if __name__== "__main__":
    app.run(host="0.0.0.0", port=5000)
    