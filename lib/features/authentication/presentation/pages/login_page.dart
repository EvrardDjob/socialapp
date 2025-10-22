/* 

LOGIN PAGE

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/authentication/presentation/components/my_button.dart';
import 'package:social_app/features/authentication/presentation/components/my_text_field.dart';
import 'package:social_app/features/authentication/presentation/cubits/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePages;
  const LoginPage({super.key, required this.togglePages,
  }); //constructeur qui accepte une clé optionnelle pour identifier le widget

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> { //signifie que ce State es lié à un widget de type LoginPage

  // text controllers
  final emailController = TextEditingController();
  final pwdController = TextEditingController();

  //login button pressed
  void login(){
    final String email = emailController.text;
    final String pwd = pwdController.text;

    // auth cubit
    final authCubit = context.read<AuthCubit>();

    //ensure that the email & pwd fiels are not empty
    if(email.isNotEmpty && pwd.isNotEmpty){
      // login!
      authCubit.login(email, pwd);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please enter both email and password")
      ));
    }
  }

  // clean all the ressources like initState(), the constructor
  @override
  void dispose(){
    emailController.dispose();
    pwdController.dispose();
    super.dispose();
  }
  
  // this method buil the UI
  @override
  Widget build(BuildContext context) {

    //Scaffold 
    return Scaffold(

      //body
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Icon(
                  Icons.lock_open_rounded, 
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
            
                const SizedBox(height: 50),
            
                //welcome back msg
                Text(
                  "Welcome back, you've been missed",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16
                  ),
                ),
            
                const SizedBox(height: 25),
                
                //email textfield
                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),

                const SizedBox(height: 15),

                // password textfield
                MyTextField(
                  controller: pwdController,
                  hintText: "Password",
                  obscureText: true,
                ),
                
                const SizedBox(height: 30),

                //login button
                MyButton(
                  onTap: login, 
                  text: "Login"
                ),

                const SizedBox(height: 50),

                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                    GestureDetector(
                      onTap: widget.togglePages,
                      child: Text(
                        " Register now",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),
        ),
      )
    );
  }
}