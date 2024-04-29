import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/consts/dimensions_consts.dart';
import 'package:news_app/features/presentation/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  authenticate(){
    var authProvider = Provider.of<UserProvider>(context,listen: false);
    authProvider.authenticateFromDB(context, username.text, password.text);
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Container(
      width: getPhoneWidth(context),
      height: getPhoneHeight(context),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: getPhoneWidth(context) * 0.5,child: Image.asset("assets/images/mmc-logo.png")),
              SizedBox(height: 30,),
              Text(
                "Get The Latest And Updated News Easily With Us",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(color: Colors.black, fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Get The Latest And Updates On The Most Popular And Hot News With Us",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                    color: const Color(0xff989b9c), fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              CupertinoTextField(
                controller: username,
                placeholder: "Email",
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                        color: const Color(0xff989b9c).withOpacity(0.4))),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              ),
              const SizedBox(
                height: 15,
              ),
              CupertinoTextField(
                controller: password,
                placeholder: "Password",
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                        color: const Color(0xff989b9c).withOpacity(0.4))),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: (){
                  authenticate();
                },
                child: Container(
                  width: getPhoneWidth(context),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color(0xff3380ef)),
                  child: Center(
                    child: Text(
                      "Login",
                      style: GoogleFonts.nunito(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.nunito(color: Colors.grey, fontSize: 18),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    "Sign up",
                    style: GoogleFonts.nunito(color:const Color(0xff3380ef),fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
