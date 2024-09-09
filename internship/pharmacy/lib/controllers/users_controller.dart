import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy/database/users_db/database_helper.dart';
import 'package:pharmacy/models/users.dart';
import 'package:pharmacy/pages/home.dart';

class UsersController {
  static List<User> usersList = [];
  static String userRole = '';
  String userStatus = '';

  Future<void> addUser(User user, Function callback) async {
    if (user.fullName.isEmpty) {
      Fluttertoast.showToast(msg: 'Complète le nom de l\'utilisateur');
      return;
    }

    if (user.phoneNumber.isEmpty) {
      Fluttertoast.showToast(msg: 'Complète le numéro de l\'utilisateur');
      return;
    }

    if (user.fullName.isEmpty) {
      Fluttertoast.showToast(msg: 'Complète le nom de l\'utilisateur');
      return;
    }
    try {
      UsersDatabaseHelper dbHelper = UsersDatabaseHelper();
      await dbHelper.addUserToDB(user);
      usersList.add(user);
      callback();

      Fluttertoast.showToast(msg: 'Utilisateur ajouté');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Erreur lors de l\'ajout de l\'utilisateur');
    }
  }

  Future<void> getUsers(Function callback) async {
    try {
      UsersDatabaseHelper dbHelper = UsersDatabaseHelper();
      List<Map<String, dynamic>> usersData = await dbHelper.getUsersToDB();

      // usersList.clear();
      print(usersData);

      usersList = usersData.map((userData) {
        return User(
          fullName: userData['Full_name'],
          phoneNumber: userData['phone_number'],
          role: userData['role'],
          sellingPoint: userData['selling_point'],
          password: userData['pwd'],
          userState: userData['user_state'],
        );
      }).toList();

      callback();
      //Fluttertoast.showToast(msg: 'Utilisateurs récupérés avec succès');
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Erreur lors de la récupération des utilisateurs');
      print(e);
    }
  }

  Future<void> getUsers2(Function(List<User>) callback) async {
    try {
      UsersDatabaseHelper dbHelper = UsersDatabaseHelper();
      List<Map<String, dynamic>> usersData = await dbHelper.getUsersToDB();

      // usersList.clear();
      print(usersData);

      usersList = usersData.map((userData) {
        return User(
          fullName: userData['Full_name'],
          phoneNumber: userData['phone_number'],
          role: userData['role'],
          sellingPoint: userData['selling_point'],
          password: userData['pwd'],
          userState: userData['user_state'],
        );
      }).toList();

      callback(usersList);
      //Fluttertoast.showToast(msg: 'Utilisateurs récupérés avec succès');
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Erreur lors de la récupération des utilisateurs');
      print(e);
    }
  }

  Future<void> login(
      String phoneNumber, String password, BuildContext context) async {
    try {
      UsersDatabaseHelper dbHelper = UsersDatabaseHelper();
      Map<String, dynamic>? userData =
          await dbHelper.getAuthenticationData(phoneNumber, password);

      // usersList.clear();
      print('Raw product data: $userData');

      if (userData != null) {
        print('Utilisateur trouvé');
        userRole = userData['role'];
        userStatus = userData['user_state'];
        if (userStatus.toLowerCase() == 'approved') {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const Home();
          }));
        } else {
          print(userStatus);
          Fluttertoast.showToast(msg: userStatus);
          Fluttertoast.showToast(
              msg: 'Tu n\'es pas autorisé d\'acceder au system',
              textColor: Colors.white,
              backgroundColor: Colors.blue);
        }
      } else {
        Fluttertoast.showToast(msg: 'Cet utilisateur n\'a pas été touvé');
      }
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(
          msg: 'Erreur lors de la récupération des données de l\'utilisateur');
    }
  }

  Future<void> getUserInfo(String phoneNumber, Function callback) async {
    try {
      UsersDatabaseHelper dbHelper = UsersDatabaseHelper();
      Map<String, dynamic>? userData =
          await dbHelper.getUserInfoToDB(phoneNumber);

      // usersList.clear();
      print('Raw product data: $userData');

      if (userData != null) {
        User user = User(
          fullName: userData['Full_name'] as String,
          phoneNumber: userData['phone_number'] as String,
          sellingPoint: (userData['selling_point'] as String),
          password: (userData['pwd'] as String),
          role: userData['role'] as String,
          userState: userData['user_state'] as String,
        );
        callback(user);
      } else {
        Fluttertoast.showToast(
            msg: 'No product found with the code: $phoneNumber');
      }
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(
          msg: 'Erreur lors de la récupération des données de l\'utilisateur');
    }
  }

  Future<void> updateUserInfo(User user, Function callback) async {
    if (user.password.isEmpty || user.fullName.isEmpty) {
      Fluttertoast.showToast(msg: 'Veuillez remplir tous les champs requis');
      return;
    }
    try {
      UsersDatabaseHelper dbHelper = UsersDatabaseHelper();
      await dbHelper.updateUserInfoInTheDB(user);
      int index =
          usersList.indexWhere((p) => p.phoneNumber == user.phoneNumber);
      if (index != -1) {
        usersList[index] = user;
      }
      callback();
      getUsers(callback);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Erreur lors de la mise à jour des données de l\'utilisateur');
    }
  }

  Future<void> updateUserStatus(
      String phoneNumber, String userState, Function callback) async {
    try {
      UsersDatabaseHelper dbHelper = UsersDatabaseHelper();
      await dbHelper.updateUserStatusInTheDB(phoneNumber, userState);
      int index = usersList.indexWhere((p) => p.phoneNumber == phoneNumber);
      if (index != -1) {
        usersList[index].userState = userState;
      }
      callback();
      getUsers2((List<User> users) {
        usersList = users;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Erreur lors du changement du statut');
    }
  }
}
