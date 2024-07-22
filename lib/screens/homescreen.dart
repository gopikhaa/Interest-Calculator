import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _formkey = GlobalKey<FormState>();
  var _currencies = ["Dollar", "Rupees", "Pound"];
  var _currentSelectedItem = "Rupees";
  var displayResult = "";
  TextEditingController pricipalcontroller = TextEditingController();
  TextEditingController roicontroller = TextEditingController();
  TextEditingController termcontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Intreset Calculator"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body:Form(
        key: _formkey,
        child:  ListView(
          padding: EdgeInsets.all(20.0),
          children: [
            Image.asset(
              "assets/images/finance.jpg",
              width: 350,
              height: 200,
            ),
            SizedBox(height: 10.0,),
            TextFormField(
                keyboardType: TextInputType.number,
                controller: pricipalcontroller,
                validator: (value){
                  if(value!.isEmpty){
                    return "Please enter principal amount";
                  }
                },
                decoration: InputDecoration(
                    labelText: "Principle Amount",
                    hintText: "Enter a principle amount eg 15000",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)))),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
                keyboardType: TextInputType.number,
                controller: roicontroller,
                validator: (value){
                  if(value!.isEmpty){
                    return "Please enter rate of interest";
                  }
                },
                decoration: InputDecoration(
                    labelText: "Rate of Interest",
                    hintText: "Enter in percentage eg 15",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)))),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: termcontroller,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please enter term";
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Term",
                          hintText: "Term in years eg 10",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)))),
                ),
                Expanded(
                  child: DropdownButton(
                    items: _currencies.map((value) {
                      return DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (newSelectedValue) {
                      this._currentSelectedItem = newSelectedValue!;
                    },
                    value: _currentSelectedItem,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (){
                    setState(() {
                      if(_formkey.currentState!.validate()){
                      this.displayResult = calculatedInterest();
                      }

                    });
                  },
                  child: Text("Calculate",style: TextStyle(backgroundColor: Colors.blue),),),
                SizedBox(height: 10.0,),
                ElevatedButton(
                  onPressed: (){
                    setState(() {
                      resetFields();
                    });
                  },
                  child: Text("Reset",style: TextStyle(backgroundColor: Colors.blue),),),
              ],
            ),
            SizedBox(height: 20.0,),
            Center(child: Text("$displayResult")),
          ],
        ),
      )
    );
  }
  String calculatedInterest(){
    double principal = double.parse(pricipalcontroller.text);
    double roi = double.parse(roicontroller.text);
    double term = double.parse(termcontroller.text);
    double total = principal+(principal+roi+term)/100;
    String result = "After $term years your investment will be worth of $total in $_currentSelectedItem";
    return result;

  }
  void resetFields(){
    pricipalcontroller.text = "";
    roicontroller.text = "";
    termcontroller.text = "";
    _currentSelectedItem = _currencies[0];
    displayResult = "";


  }
}
