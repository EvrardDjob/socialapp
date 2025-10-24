import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/authentication/data/firebase_auth_repo.dart';
import 'package:social_app/features/authentication/presentation/cubits/auth_cubit.dart';
import 'package:social_app/features/authentication/presentation/cubits/auth_states.dart';
import 'package:social_app/features/profile/data/firebase_profile_repo.dart';
import 'package:social_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:social_app/features/storage/data/cloudinary_storage_repo.dart';
import 'features/authentication/presentation/pages/auth_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'themes/light_mode.dart';

class MyApp extends StatelessWidget {

  //auth Repo
  final firebaseAuthRepo = FirebaseAuthRepo();

  // storage Repo
  final cloudinaryStorageRepo = CloudinaryStorageRepo();

  // profile repo
  final firebaseProfilRepo = FirebaseProfileRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //provide cubits to app
    return MultiBlocProvider(
      providers: [
        // auth cubit
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authRepo: firebaseAuthRepo)..checkAuth(),
        ),

        // profile cubit
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(
            profileRepo: firebaseProfilRepo,
            storageRepo: cloudinaryStorageRepo,
          ),
          
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
