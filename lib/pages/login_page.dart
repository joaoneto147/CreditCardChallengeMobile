import 'package:credit_car_challenge/controllers/page_controller.dart';
import 'package:credit_car_challenge/controllers/user_controller.dart';
import 'package:credit_car_challenge/pages/reset_password_page.dart';
import 'package:credit_car_challenge/pages/singup_page.dart';
import 'package:credit_car_challenge/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _percentInputWeight = 0.83;
  final _textEditingControllerEmail = TextEditingController();
  final _textEditingControllerSenha = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.only(left: 40, right: 40),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 240,
                height: 240,
                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "Credit Card",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text(
                "Challenge",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              MyCustomTextFormField(
                hint: "E-mail",
                controller: _textEditingControllerEmail,
                keyboardType: TextInputType.emailAddress,
                icon: Icon(Icons.person),
              ),
              SizedBox(height: 10),
              MyCustomTextFormField(
                hint: "Password",
                passwordField: true,
                controller: _textEditingControllerSenha,
                keyboardType: TextInputType.emailAddress,
                icon: Icon(Icons.person),
                // icon: Icon(CommunityMaterialIcons.credit_card_plus),
              ),
              Container(
                width: MediaQuery.of(context).size.width * _percentInputWeight,
                alignment: Alignment.centerRight,
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  child: Text("Recuperar senha", textAlign: TextAlign.end),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPassword()));
                  },
                ),
              ),
              Container(
                height: 50,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 0.5],
                    colors: [
                      Colors.deepPurple,
                      Colors.purple,
                    ],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Icon(Icons.email, color: Colors.white, size: 35),
                    ],
                  ),
                  onPressed: () {
                    _buttonLoginClick(context);
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  child: Text("Cadastre-se", textAlign: TextAlign.end),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (_) => UserController(),
                          child: SingUpPage(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Container(
              //   alignment: Alignment.center,
              //   child: FlatButton(
              //     padding: EdgeInsets.zero,
              //     child: Text("Teste", textAlign: TextAlign.end),
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => ChangeNotifierProvider(
              //             create: (_) => PurchasesController(),
              //             child: Purshase(creditCardId: 2),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future _buttonLoginClick(BuildContext context) async {
    await Provider.of<UserController>(context, listen: false).loginApi(
        _textEditingControllerEmail.text, _textEditingControllerSenha.text);

    showToast(
        Provider.of<UserController>(context, listen: false).msgCadastroUsuario,
        position: ToastPosition.bottom,
        dismissOtherToast: true);

    if (Provider.of<UserController>(context, listen: false).loggedUser ==
        null) {
      Future.delayed(Duration(milliseconds: 2300), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => PageControllerApp(),
              child: HomePage(),
            ),
          ),
        );
      });
    }
  }
}
