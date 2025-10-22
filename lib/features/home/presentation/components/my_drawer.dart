import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/authentication/presentation/cubits/auth_cubit.dart';
import 'package:social_app/features/home/presentation/components/my_drawer_title.dart';
import 'package:social_app/features/profile/presentation/pages/profil_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            
            //logo (PAS de padding - reste centré)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            // divider line (pas de padding)
            Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),

            
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0), // ← Padding à gauche
                child: Column(
                  children: [
                    // home title
                    MyDrawerTitle(
                      title: "H O M E", 
                      icon: Icons.home, 
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    
                    //profile title
                    MyDrawerTitle(
                      title: "P R O F I L E", 
                      icon: Icons.person, 
                      onTap: () {
                        Navigator.of(context).pop();

                        // get current user id
                        final user = context.read<AuthCubit>().currentUser;
                        
                        if (user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilPage(uid: user.uid),
                            )
                          );
                        }
                      }
                    ),

                    //search title
                    MyDrawerTitle(
                      title: "S E A R C H", 
                      icon: Icons.search, 
                      onTap: () {}
                    ),

                    // settings title
                    MyDrawerTitle(
                      title: "S E T T I N G S", 
                      icon: Icons.settings, 
                      onTap: () {}
                    ),

                    const Spacer(),

                    // logout title
                    MyDrawerTitle(
                      title: "L O G O U T", 
                      icon: Icons.logout, // ← Corrigé (était Icons.login)
                      onTap: () => context.read<AuthCubit>().logout(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
