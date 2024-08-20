import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy/database/users_db/database_helper.dart';
import 'package:pharmacy/models/users.dart';

class UsersController {
  static List<User> usersList = [];

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
      DatabaseHelper dbHelper = DatabaseHelper();
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
      DatabaseHelper dbHelper = DatabaseHelper();
      List<Map<String, dynamic>> usersData = await dbHelper.getUsersToDB();

      // usersList.clear();

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
      Fluttertoast.showToast(msg: 'Utilisateurs récupérés avec succès');
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Erreur lors de la récupération des utilisateurs');
    }
  }
}
