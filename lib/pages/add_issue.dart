import 'package:case_app/models/case.dart';
import 'package:case_app/pages/home.dart';
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
  TextEditingController fullAddressController = TextEditingController();
  TextEditingController resTypeController = TextEditingController();
  String issueId = Uuid().v4() ;


  createIssueInFireStore({String issue , String fullAddress , String resType}){
    issueRef.document(issueId).setData({
      'issueId' : issueId ,
      'ownerId' : widget.currentCase.id ,
      'displayName' : widget.currentCase.displayName ,
      'phone' : widget.currentCase.phone ,
      'issue' : issue ,
      'fullAddress' : fullAddress ,
      'resType' : resType ,
      'timestamp' : DateTime.now() ,
    });
  }

  submitIssue() async {
    await createIssueInFireStore(
      issue: issueController.text ,
      fullAddress: fullAddressController.text ,
      resType: resTypeController.text ,
    );
    issueController.clear();
    fullAddressController.clear() ;
    resTypeController.clear() ;
    setState(() {
      issueId = Uuid().v4() ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Issue'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: ListView(
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
            controller: issueController,
            decoration: InputDecoration(
              hintText: 'Please write your issue' ,
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
            controller: resTypeController,
            decoration: InputDecoration(
              hintText: 'Rescue Type ( Police , Fire , Ambulance , Savage )' ,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2) ,
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
            onTap: submitIssue,
          ),
        ],
      ),
    );
  }
}
