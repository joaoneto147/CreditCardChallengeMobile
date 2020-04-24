import 'package:credit_car_challenge/controllers/user_controller.dart';
import 'package:credit_car_challenge/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class SingUpPage extends StatefulWidget {
  @override
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 10, top: 50),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.purple, Colors.deepPurple]),
              ),
              child: Icon(Icons.person_add, size: 120),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                "Register",
                style: TextStyle(fontSize: 32),
              ),
            ),
            MyCustomTextFormField(
              hint: "Nome",
              icon: Icon(Icons.person_pin),
              controller: _nomeController,
            ),
            SizedBox(height: 10),
            MyCustomTextFormField(
              hint: "E-mail",
              keyboardType: TextInputType.emailAddress,
              icon: Icon(Icons.email),
              controller: _emailController,
            ),
            SizedBox(height: 10),
            MyCustomTextFormField(
              hint: "Senha",
              icon: Icon(Icons.lock),
              passwordField: true,
              controller: _passwordController,
            ),
            SizedBox(height: 10),
            MyCustomTextFormField(
              hint: "Confirmação senha",
              icon: Icon(Icons.lock),
              passwordField: true,
              controller: _confirmPasswordController,
            ),
            SizedBox(height: 10),
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
              child: Consumer<UserController>(
                builder: (context, user, child) => FlatButton(
                  child: Provider.of<UserController>(context, listen: false)
                          .processingRegister
                      ? Center(child: CircularProgressIndicator())
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Sing up",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Icon(Icons.person_add,
                                color: Colors.white, size: 35),
                          ],
                        ),
                  onPressed: () {
                    _singIn(
                        _nomeController.text,
                        _emailController.text,
                        _passwordController.text,
                        _confirmPasswordController.text);
                  },
                  // ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _singIn(String name, email, password, confirmationPassword) async {
    await Provider.of<UserController>(context, listen: false)
        .singUp(name, email, password, confirmationPassword);

    showToast(
        Provider.of<UserController>(context, listen: false).msgCadastroUsuario,
        position: ToastPosition.top);

    if (Provider.of<UserController>(context, listen: false).loggedUser !=
        null) {
      Navigator.pop(context);      
    }
  }
}
