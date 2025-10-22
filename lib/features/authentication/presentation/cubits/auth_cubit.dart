/*

Auth Cubit: State Management, this file handle the user states

*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/authentication/domain/entities/app_user.dart';
import 'package:social_app/features/authentication/domain/repos/auth_repo.dart';
import 'package:social_app/features/authentication/presentation/cubits/auth_states.dart';

class AuthCubit extends Cubit<AuthState>{
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}): super(AuthInitial()); // super appelle le constructeur de Cubit et lui passe l'état initial

  //check if user is already authenticated
  void checkAuth() async{
    final AppUser? user = await authRepo.getCurrentUser();

    if(user != null){
      _currentUser = user;
      emit(Authenticated(user)); //emit change l'état courant du Cubit
    }else{
      emit(Unauthenticated());
    }
  }
  
  //get current user
  AppUser? get currentUser => _currentUser;

  //login with email + pwd
  Future<void> login(String email, String pwd) async{
    try{
      emit(AuthLoading());
      final user = await authRepo.loginWithEmailPassword(email, pwd);
        
      if(user != null){
        _currentUser = user;
        emit(Authenticated(user));
      }else{
        emit(Unauthenticated());
      }
    }catch(e){
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  //register with email + pwd
  Future<void> register(String name, String email, String pwd) async{
    try {
      emit(AuthLoading());
      final user = await authRepo.registerWithEmailPassword(name, email, pwd);

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  //logout
  Future<void> logout() async{
    authRepo.logout();
    emit(Unauthenticated());
  }
}