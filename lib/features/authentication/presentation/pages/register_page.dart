import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/authentication/presentation/cubits/auth_cubit.dart';
import '../components/my_button.dart';
import '../components/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;
  const RegisterPage({super.key, required this.togglePages});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
 // text controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  final confirmPwdController = TextEditingController();

  //register button pressed
  void register(){
    final String name = nameController.text;
    final String email = emailController.text;
    final String pwd = pwdController.text;
    final String confirmpwd = confirmPwdController.text;

    //auth cubit
    final authCubit = context.read<AuthCubit>();

    //ensure the fields are not empty
    if (name.isNotEmpty && email.isNotEmpty && pwd.isNotEmpty &&
        confirmpwd.isNotEmpty) {
      
      // ensure passwords match
      if(pwd == confirmpwd){
        authCubit.register(name, email, pwd);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
      }

    }else{
      // fields are empty
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please complete all fields')));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    pwdController.dispose();
    confirmPwdController.dispose();
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

                //create account message
                Text(
                  "Let's create an account for you",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                //name textfield
                MyTextField(
                  controller: nameController,
                  hintText: "Name",
                  obscureText: false,
                ),

                const SizedBox(height: 15),

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

                const SizedBox(height: 15),

                MyTextField(
                  controller: confirmPwdController,
                  hintText: "Confirm password ",
                  obscureText: true,
                ),

                const SizedBox(height: 35),

                //register button
                MyButton(
                  onTap: register, 
                  text: "Register"),

                const SizedBox(height: 50),

                //already a member? login now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.togglePages,
                      child: Text(
                        " Login now",
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
      ),
    );
  }
}