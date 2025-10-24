import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/authentication/domain/entities/app_user.dart';
import 'package:social_app/features/authentication/presentation/cubits/auth_cubit.dart';
import 'package:social_app/features/profile/presentation/components/bio_box.dart';
import 'package:social_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:social_app/features/profile/presentation/cubits/profile_states.dart';
import 'package:social_app/features/profile/presentation/pages/edit_profil_page.dart';

class ProfilPage extends StatefulWidget {
  final String uid;
  const ProfilPage({super.key, required this.uid});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {

  // cubits
  late final authCubit = context.read<AuthCubit>();
  late final profileCubit = context.read<ProfileCubit>();
  
  // current user
  late AppUser? currentUser = authCubit.currentUser;

  // on startup
  @override
  void initState(){
    super.initState();

    //load user profile data
    profileCubit.fetchUserProfile(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state){
        // loaded
        if(state is ProfileLoaded){
          // get the loaded user
          final user = state.profileUser;

          // scaffold
          return Scaffold(
            //app bar
            appBar: AppBar(
              title: Text(user.name),
              foregroundColor: Theme.of(context).colorScheme.primary,
              actions: [
                //edit profile button
                IconButton(
                  onPressed: ()=> Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context)=> EditProfilPage(user: user)
                  )),
                  icon: const Icon(Icons.settings),
                )
              ],
            ),

            //body
            body: Column(
              children: [
                const SizedBox(height: 25),
                  
                //email
                Text(
                    user.email,
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
            
                const SizedBox(height: 25),
            
                //profile pic
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  height: 120,
                  width: 120,
                  padding: const EdgeInsets.all(25),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      size: 72,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
            
                const SizedBox(height: 20),
            
                //bio box
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Row(
                    children: [
                      Text(
                        "Bio",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 7),
                        
                BioBox(text: user.bio),

                //posts

                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 25),
                  child: Row(
                    children: [
                      Text(
                        "Posts",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          );
        }

        // loading...
        else if(state is ProfileLoading){
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            )
          );
        }else{
          // print('je refuse juste');
          return const Center(
            child: Text("No profile found..."),
          );
          
        }
      },
    );
  }
}