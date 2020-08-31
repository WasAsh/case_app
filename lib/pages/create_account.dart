import 'dart:async';
import 'package:flutter/material.dart';


class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String phone ;

  submit(){
    final form = _formKey.currentState ;
    if(form.validate()){
      form.save() ;
      SnackBar snackBar = SnackBar(content: Text('Welcome !'),);
      _scaffoldKey.currentState.showSnackBar(snackBar) ;
      Timer(Duration(seconds: 3) , (){
        Navigator.pop(context , phone);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Set Your Data'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Center(
                    child: Text(
                      'Enter ur phone number' ,
                      style: TextStyle(
                        fontSize: 25 ,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            autovalidate: true,
                            validator: (val){
                              if(val.trim().length < 6 || val.isEmpty){
                                return('The number is not correct') ;
                              }else if(val.trim().length > 12){
                                return('The number is too long') ;
                              }else{
                                return null ;
                              }
                            },
                            onSaved: (val) => phone = val,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              icon: Icon(Icons.phone) ,
                              labelText: 'Phone number' ,
                              labelStyle: TextStyle(fontSize: 12) ,
                              hintText: '01234567890' ,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.grey ,
                      borderRadius: BorderRadius.circular(7) ,
                    ),
                    child: Center(
                      child: Text(
                        'Submit' ,
                        style: TextStyle(
                          color: Colors.white ,
                          fontSize: 15 ,
                          fontWeight: FontWeight.bold ,
                        ),
                      ),
                    ),
                  ),
                  onTap: submit,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
