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

  List<String> rescueTypeItems = <String>['شرطي', 'مسعف' , 'رجل اطفاء'];
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
                    'رجاءً قم بملئ النموذج بالكامل' ,
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
                    hintText: 'الاسم بالكامل' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: phoneNumController,
                  decoration: InputDecoration(
                    hintText: 'رقم الهاتف' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                    hintText: 'المدينة' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: fullAddressController,
                  decoration: InputDecoration(
                    hintText: 'العنوان بالتفصيل' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: issueController,
                  decoration: InputDecoration(
                    hintText: 'اشرح الموقف' ,
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
                  hint: Text('اختر نوع الطلب'),
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
                        'تأكيد' ,
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
                    'رجاءً قم بملئ النموذج بالكامل' ,
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
                    hintText: 'نوع الاصابة' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: injuryCountController,
                  decoration: InputDecoration(
                    hintText: 'عدد الاصابات' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    hintText: 'الاسم كاملاً' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: phoneNumController,
                  decoration: InputDecoration(
                    hintText: 'رقم الهاتف' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                    hintText: 'المدينة' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: fullAddressController,
                  decoration: InputDecoration(
                    hintText: 'العنوان بالكامل' ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2) ,
                    ),
                  ),
                ),
                SizedBox(height: 10,) ,
                TextField(
                  controller: issueController,
                  decoration: InputDecoration(
                    hintText: 'اشرح الموقف' ,
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
                  hint: Text('نوع الطلب'),
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
                        'تأكيد' ,
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
                      'رجاءً قم بملئ النموذج بالكامل' ,
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
                      hintText: 'نوع الحريق' ,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2) ,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,) ,
                  TextField(
                    controller: firePlaceController,
                    decoration: InputDecoration(
                      hintText: 'مكان الحريق' ,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2) ,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,) ,
                  TextField(
                    controller: fullNameController,
                    decoration: InputDecoration(
                      hintText: 'الاسم كاملاً' ,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2) ,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,) ,
                  TextField(
                    controller: phoneNumController,
                    decoration: InputDecoration(
                      hintText: 'رقم الهاتف' ,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2) ,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,) ,
                  TextField(
                    controller: cityController,
                    decoration: InputDecoration(
                      hintText: 'المدينة' ,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2) ,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,) ,
                  TextField(
                    controller: fullAddressController,
                    decoration: InputDecoration(
                      hintText: 'العنوان كاملاً' ,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2) ,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,) ,
                  TextField(
                    controller: issueController,
                    decoration: InputDecoration(
                      hintText: 'اشرح الموقف' ,
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
                    hint: Text('نوع الانقاذ'),
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
                          'تأكيد' ,
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
        title: Text('اضافة طلب'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30 , right: 10 , left: 10),
            child: Text(
              'مرحباً بك : عزيزي المواطن , قم بالتعرف على مبادئ الاسعاف الأولي بشكل عام والتي تنص على' ,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black ,
                fontSize: 20 ,
                fontWeight: FontWeight.bold ,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:10 , bottom: 20 , left: 20 , right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  'أولاً: السيطرة على موقع الحدث بشكل تام' ,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.black87 ,
                    fontSize: 18 ,
                    decoration: TextDecoration.none ,
                  ),
                ),
                Text(
                  'ثانياُ: عدم اعتبار الشخص المصاب ميتاً حتى وان زالت مظاهر الحياة عن كالتنفس والنبض' ,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.black87 ,
                    fontSize: 18 ,
                    decoration: TextDecoration.none ,
                  ),
                ),
                Text(
                  'ثالثاً: ابعاد الشخص المصاب عن مصدر الخطر' ,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.black87 ,
                    fontSize: 18 ,
                    decoration: TextDecoration.none ,
                  ),
                ),
                Text(
                  'رابعاً: الاهتمام بعملية انعاش القلب وعملية التنفس الاصطناعي والصدمة' ,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.black87 ,
                    fontSize: 18 ,
                    decoration: TextDecoration.none ,
                  ),
                ),
                Text(
                  'خامساً: العناية بالشخص المصاب قبل وصول الجهات المعنية' ,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.black87 ,
                    fontSize: 18 ,
                    decoration: TextDecoration.none ,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10 , left: 10),
            child: Text(
              'من فضلك قم باختيار نوع الطلب المراد تقديمه' ,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black ,
                fontSize: 20 ,
                fontWeight: FontWeight.bold ,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:10 , right: 10 , left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text(
                    'طلب شرطة' ,
                  ),
                  onPressed: (){
                    policeIssue();
                  },
                ),
                RaisedButton(
                  child: Text(
                    'طلب اسعاف' ,
                  ),
                  onPressed: (){
                    ambulanceIssue();
                  },
                ),
                RaisedButton(
                  child: Text(
                    'طلب حريق' ,
                  ),
                  onPressed: (){
                    fireIssue();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
