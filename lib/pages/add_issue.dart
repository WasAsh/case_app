import 'package:case_app/models/case.dart';
import 'package:case_app/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';


class AddIssue extends StatefulWidget {

  final Case currentCase ;
  AddIssue({this.currentCase});

  @override
  _AddIssueState createState() => _AddIssueState();
}

class _AddIssueState extends State<AddIssue> {

  TextEditingController issueController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController fullAddressController = TextEditingController();
  TextEditingController injuryTypeController = TextEditingController() ;
  TextEditingController injuryCountController = TextEditingController() ;
  TextEditingController fireTypeController = TextEditingController() ;
  TextEditingController firePlaceController = TextEditingController() ;

  List<String> rescueTypeItems = <String>['Police', 'Ambulance' , 'Firefighting'];
  var selectedRescue;
  String issueId = Uuid().v4() ;

 // for police issue
  createPoliceIssueInFireStore({String issue , String fullAddress , String resType , String fullName , String phone , String city}){
    issueRef.document(issueId).setData({
      'issueId' : issueId ,
      'ownerId' : widget.currentCase.id ,
      'fullName' : fullName ,
      'phone' : phone ,
      'issue' : issue ,
      'city' : city ,
      'fullAddress' : fullAddress ,
      'resType' : resType ,
      'fireType' : null ,
      'firePlace' : null ,
      'injuryCount' : null ,
      'injuryType' : null ,
      'timestamp' : DateTime.now() ,
    });
  }
  submitPoliceIssue() async {
    await createPoliceIssueInFireStore(
      fullName: fullNameController.text,
      phone: phoneNumController.text,
      city: cityController.text,
      issue: issueController.text ,
      fullAddress: fullAddressController.text ,
      resType: selectedRescue ,
    );
    fullNameController.clear();
    phoneNumController.clear();
    cityController.clear();
    issueController.clear();
    fullAddressController.clear() ;
    setState(() {
      issueId = Uuid().v4() ;
    });
  }
  policeIssue() {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.grey,
        barrierLabel: 'Police Issue',
        transitionDuration: Duration(seconds: 1),
        pageBuilder: (_, __, ___) {
          return Material(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Please add your information !' ,
                    style: TextStyle(
                      color: Colors.black ,
                      fontSize: 30 ,
                      fontWeight: FontWeight.bold ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    hintText: 'Please write your Full Name' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: phoneNumController,
                  decoration: InputDecoration(
                    hintText: 'Please write your Phone Number' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                    hintText: 'Please write your City' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: fullAddressController,
                  decoration: InputDecoration(
                    hintText: 'Please write your full address' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: issueController,
                  decoration: InputDecoration(
                    hintText: 'Please write your Issue' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                DropdownButton(
                  items: rescueTypeItems
                      .map((value) => DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  ),
                  ).toList(),
                  onChanged: (selectedRescueType){
                    setState(() {
                      selectedRescue = selectedRescueType ;
                    });
                  },
                  value: selectedRescue,
                  isExpanded: false,
                  hint: Text('Select Rescue Type'),
                ),
                SizedBox(height: 10,) ,
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
                  onTap: submitPoliceIssue,
                ),
              ],
            ),
          );
        }
    );
  }

  //for ambulance issue
  createAmbulanceIssueInFireStore({ String injuryType , String injuryCount , String issue , String fullAddress , String resType , String fullName , String phone , String city}){
    issueRef.document(issueId).setData({
      'issueId' : issueId ,
      'ownerId' : widget.currentCase.id ,
      'fullName' : fullName ,
      'phone' : phone ,
      'issue' : issue ,
      'city' : city ,
      'fullAddress' : fullAddress ,
      'resType' : resType ,
      'fireType' : null ,
      'firePlace' : null ,
      'injuryCount' : injuryCount ,
      'injuryType' : injuryType ,
      'timestamp' : DateTime.now() ,
    });
  }
  submitAmbulanceIssue() async {
    await createAmbulanceIssueInFireStore(
      injuryType: injuryTypeController.text,
      injuryCount: injuryCountController.text,
      fullName: fullNameController.text,
      phone: phoneNumController.text,
      city: cityController.text,
      issue: issueController.text ,
      fullAddress: fullAddressController.text ,
      resType: selectedRescue ,
    );
    injuryCountController.clear();
    injuryTypeController.clear();
    fullNameController.clear();
    phoneNumController.clear();
    cityController.clear();
    issueController.clear();
    fullAddressController.clear() ;
    setState(() {
      issueId = Uuid().v4() ;
    });
  }
  ambulanceIssue() {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.grey,
        barrierLabel: 'Ambulance Issue',
        transitionDuration: Duration(seconds: 1),
        pageBuilder: (_, __, ___) {
          return Material(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Please add your information !' ,
                    style: TextStyle(
                      color: Colors.black ,
                      fontSize: 30 ,
                      fontWeight: FontWeight.bold ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: injuryTypeController,
                  decoration: InputDecoration(
                    hintText: 'Please write Injury Type' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: injuryCountController,
                  decoration: InputDecoration(
                    hintText: 'Please write Injury Count' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    hintText: 'Please write your Full Name' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: phoneNumController,
                  decoration: InputDecoration(
                    hintText: 'Please write your Phone Number' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                    hintText: 'Please write your City' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: fullAddressController,
                  decoration: InputDecoration(
                    hintText: 'Please write your full address' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: issueController,
                  decoration: InputDecoration(
                    hintText: 'Please write your Issue' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                DropdownButton(
                  items: rescueTypeItems
                      .map((value) => DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  ),
                  ).toList(),
                  onChanged: (selectedRescueType){
                    setState(() {
                      selectedRescue = selectedRescueType ;
                    });
                  },
                  value: selectedRescue,
                  isExpanded: false,
                  hint: Text('Select Rescue Type'),
                ),
                SizedBox(height: 10,) ,
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
                  onTap: submitAmbulanceIssue,
                ),
              ],
            ),
          );
        }
    );
  }

  //for fire issue
  createFireIssueInFireStore({ String fireType , String firePlace , String issue , String fullAddress , String resType , String fullName , String phone , String city}){
    issueRef.document(issueId).setData({
      'issueId' : issueId ,
      'ownerId' : widget.currentCase.id ,
      'fullName' : fullName ,
      'phone' : phone ,
      'issue' : issue ,
      'city' : city ,
      'fullAddress' : fullAddress ,
      'resType' : resType ,
      'fireType' : fireType ,
      'firePlace' : firePlace ,
      'injuryCount' : null ,
      'injuryType' : null ,
      'timestamp' : DateTime.now() ,
    });
  }
  submitFireIssue() async {
    await createFireIssueInFireStore(
      fireType: fireTypeController.text,
      firePlace: firePlaceController.text,
      fullName: fullNameController.text,
      phone: phoneNumController.text,
      city: cityController.text,
      issue: issueController.text ,
      fullAddress: fullAddressController.text ,
      resType: selectedRescue ,
    );
    fireTypeController.clear();
    firePlaceController.clear();
    fullNameController.clear();
    phoneNumController.clear();
    cityController.clear();
    issueController.clear();
    fullAddressController.clear() ;
    setState(() {
      issueId = Uuid().v4() ;
    });
  }
  fireIssue() {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.grey,
        barrierLabel: 'Fire Issue',
        transitionDuration: Duration(seconds: 1),
        pageBuilder: (_, __, ___) {
          return Material(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Please add your information !' ,
                      style: TextStyle(
                        color: Colors.black ,
                        fontSize: 30 ,
                        fontWeight: FontWeight.bold ,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,) ,
                  TextField(
                    controller: fireTypeController,
                    decoration: InputDecoration(
                      hintText: 'Please write Fire Type' ,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2) ,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,) ,
                  TextField(
                    controller: firePlaceController,
                    decoration: InputDecoration(
                      hintText: 'Please write Fire Place' ,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2) ,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,) ,
                  TextField(
                    controller: fullNameController,
                    decoration: InputDecoration(
                      hintText: 'Please write your Full Name' ,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2) ,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,) ,
                  TextField(
                    controller: phoneNumController,
                    decoration: InputDecoration(
                      hintText: 'Please write your Phone Number' ,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2) ,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,) ,
                  TextField(
                    controller: cityController,
                    decoration: InputDecoration(
                      hintText: 'Please write your City' ,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2) ,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,) ,
                  TextField(
                    controller: fullAddressController,
                    decoration: InputDecoration(
                      hintText: 'Please write your full address' ,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2) ,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,) ,
                  TextField(
                    controller: issueController,
                    decoration: InputDecoration(
                      hintText: 'Please write your Issue' ,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2) ,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,) ,
                  DropdownButton(
                    items: rescueTypeItems
                        .map((value) => DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    ),
                    ).toList(),
                    onChanged: (selectedRescueType){
                      setState(() {
                        selectedRescue = selectedRescueType ;
                      });
                    },
                    value: selectedRescue,
                    isExpanded: false,
                    hint: Text('Select Rescue Type'),
                  ),
                  SizedBox(height: 10,) ,
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
                    onTap: submitFireIssue,
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Issue'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: (){
              policeIssue();
            },
            child: Text('Police Issue'),
          ),
          SizedBox(height: 10,) ,
          RaisedButton(
            onPressed: (){
              ambulanceIssue();
            },
            child: Text('Ambulance Issue'),
          ),
          SizedBox(height: 10,) ,
          RaisedButton(
            onPressed: (){
              fireIssue();
            },
            child: Text('Fire Issue'),
          ),
          SizedBox(height: 10,) ,
        ],
      ),
    );
  }
}
