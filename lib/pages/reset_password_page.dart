import 'package:credit_car_challenge/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(        
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10, top: 50),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.purple, Colors.deepPurple]),
              ),
              child: Icon(Icons.lock_open, size: 150),
            ),
            Text(
              "Forgot Your Password?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            SizedBox(height: 20),
            Text(
              "Confirm your email and we'll send the instructions.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 19),
            ),
            SizedBox(height: 20),
            MyCustomTextFormField(
              hint: "E-mail",
              keyboardType: TextInputType.emailAddress,
              icon: Icon(Icons.person),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 0.5],
                        colors: [Colors.deepPurple, Colors.purple]),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Reset password",
                          style: TextStyle(fontSize: 20),
                        ),
                        Icon(
                          Icons.lock_outline,
                          color: Colors.white,
                          size: 25,
                        )
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
