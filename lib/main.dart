import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interested Calculator',
    home: SIForm(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey=GlobalKey<FormState>();
  final _minimumPadding = 5.0;
  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  var _currentValueSelected = "Rupees";


  @override
  void initState() {
    super.initState();
    _currentValueSelected=_currencies[0];
  }

  TextEditingController principleController=TextEditingController();
  TextEditingController roiController=TextEditingController();
  TextEditingController termController=TextEditingController();
  var displayResult=" ";

  // var name='Rupees';

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Form(
        key: _formKey,
       // margin: EdgeInsets.all(_minimumPadding * 2),
        child: Padding(padding: EdgeInsets.all(_minimumPadding*2),
        child:ListView(
          children: [
            getImageAsset(),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principleController,
                  validator: ( value)  {
                    if(value!.isEmpty)
                      {
                        return 'Please Enter principle Amount';
                      }
                  },

                  decoration: InputDecoration(
                      labelText: 'Principal',
                      hintText: 'Enter Principal e.g. 12000',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0,


                      ),

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: roiController,
                  validator: (var value){
                    if(value !.isEmpty)
                      {
                        return "Please Enter rate of Interest";
                      }
                  },

                  decoration: InputDecoration(
                      labelText: 'Rate of Interest',
                      hintText: 'In Percent',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color:Colors.yellowAccent,
                        fontSize: 15.0,
                      ) ,

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: termController,
                      validator: (var value){
                        if(value!.isEmpty){
                          return "Please Enter time";
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Term',
                          hintText: 'Time in Year',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                    Container(
                      width: _minimumPadding * 5,
                    ),
                    Expanded(
                        child: DropdownButton<String>(
                      items: _currencies.map((value) {
                        return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(
                            value,
                            style: textStyle,
                          ),
                        );
                      }).toList(),
                      onChanged: (newValueSelected) {
                        setState(() {
                          _onDropDownItemSelected(newValueSelected.toString());
                        });
                      },
                      value: _currentValueSelected,
                    ))
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: Row(
                  children: [
                    Expanded(
                        child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text(
                        'Calculate',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          if(_formKey.currentState!.validate()){
                            this.displayResult=_calculateTotalReturn();
                          }
                         this.displayResult= _calculateTotalReturn();
                        });
                      },
                    )),
                    Expanded(
                        child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Reset',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                    )),
                  ],
                )),
            Padding(
              padding: EdgeInsets.all(_minimumPadding * 2),
              child: Text(
                this.displayResult, style: textStyle,
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/earth.jpg');
    Image image = Image(
      image: assetImage,
      width: 150.0,
      height: 150.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentValueSelected = newValueSelected;
    });
  }

  String _calculateTotalReturn()
  {
    double principle=double.parse(principleController.text);
    double roi=double.parse(roiController.text);
    double term=double.parse(termController.text);
    double totalAmountPayable=principle+(principle*roi*term)/100;
    String result='After $term years,your investment will be worth $totalAmountPayable $_currentValueSelected';
    return result;
  }

  void _reset()
  {
    principleController.text="";
    roiController.text="";
    termController.text="";
    displayResult="";
    _currentValueSelected=_currencies[0];


  }
}
