import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/authentication/data/firebase_auth_repo.dart';
import 'package:social_app/features/authentication/presentation/cubits/auth_cubit.dart';
import 'package:social_app/features/authentication/presentation/cubits/auth_states.dart';
import 'package:social_app/features/profile/data/firebase_profile_repo.dart';
import 'package:social_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'features/authentication/presentation/pages/auth_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'themes/light_mode.dart';

class MyApp extends StatelessWidget {

  //auth Repo
  final authRepo = FirebaseAuthRepo();

  // profile repo
  final profilRepo = FirebaseProfileRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //provide cubits to app
    return MultiBlocProvider(
      providers: [
        // auth cubit
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
        ),

        // profile cubit
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(profileRepo: profilRepo),
          
        ),
      ], 
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState){
            print(authState);
            
            //unauthenticated -> auth page (login/register)
            if(authState is Unauthenticated){
              return const AuthPage();
            }

            if(authState is Authenticated){
              return const HomePage();
            }
            
            else{
              //loading...
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }, 

          // listen for errors...
          listener: (context, state){
            if(state is AuthError){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error happened, check your informations!")));
            }
          },
        ),
      ),
    );
  }
}
