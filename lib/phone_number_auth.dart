import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthentication extends StatefulWidget {
  const PhoneAuthentication({Key? key}) : super(key: key);

  @override
  State<PhoneAuthentication> createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  var firebase_auth = FirebaseAuth.instance;
  bool isCodeSent = false;
  String verificationId='';
  var phoneNumberController = TextEditingController();
  var codeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
//////////////////////Phone Number Authentication Completed//////////
  PhoneNumberAuthCompleted(BuildContext context, String sms_code)async{

     PhoneAuthCredential credential = PhoneAuthProvider.credential(
         verificationId: verificationId,
         smsCode: sms_code);
     
     firebase_auth.signInWithCredential(credential).then((UserCredential value){
       print('User credential : ${value.user.toString()}');
     });
  }
  /////////////////////Phone Number Authentication////////////////
  VerifyPhoneNumber(BuildContext context) async {
    String phoneNum=phoneNumberController.text.toString();
    try{
      await firebase_auth.verifyPhoneNumber(
        phoneNumber:phoneNum,
        timeout: const Duration(seconds: 30),
        verificationCompleted: (PhoneAuthCredential credential) {
          this.verificationId= credential.verificationId!;
          setState(() {
            codeController.text = credential.smsCode!;
          });
          print('Hello Firebase Auth : ${credential.smsCode}');
          PhoneNumberAuthCompleted(context,credential.smsCode!);
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Phone Authentication failed! : ${e.toString()}');
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId=verificationId;
          setState(() {
            isCodeSent=true;
          });
          print('Phone Authentication code Sent');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('Phone Authentication Code Auto Retrieval Timeout');
        },
      );
    }on FirebaseAuthException catch(error, _){
      print('Phone FirebaseAuthException : ${error.toString()}');
    }catch(e){
      print('Phone Authentication Error : ${e.toString()}');
    }
  }


  @override
  Widget build(BuildContext context) {

    GestureTapCallback onTap = (){
      if(!isCodeSent){
        VerifyPhoneNumber(context);
      }else{
        String codesent=codeController.text;
        PhoneNumberAuthCompleted(context,codesent);
      }
    };

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 8,
        backgroundColor: Color(0xFF0099DD),
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text('Phone Authentication'),
        ),
      ),
      body: Container(
        height: double.infinity,
        color: Color(0xff4974a5).withOpacity(0.9),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 5),
                          child: TextFormField(
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                decoration: TextDecoration.none,
                                decorationThickness: 0,
                              ),
                              controller: phoneNumberController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.phone_android_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 15,letterSpacing:1),
                                border: InputBorder.none,

                              ))))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                      color:Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 5),
                        child: TextFormField(
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20,decoration: TextDecoration.none,
                              decorationThickness: 0,
                                letterSpacing : 2.0
                            ),
                            controller: codeController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.sms_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                              labelText: 'Your Code',
                              labelStyle:
                                  TextStyle(color: Colors.white, fontSize: 15,letterSpacing: 1),
                              border: InputBorder.none,
                            )))),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xFF0099DD),
                ),
                child: TextButton(
                    onPressed:onTap,
                    child:Text(
                      isCodeSent ? 'Verify Code' : 'Verify your Phone Number',
                      style:
                          TextStyle(fontSize: 14, color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
