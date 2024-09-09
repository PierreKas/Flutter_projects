import 'package:flutter/material.dart';
import 'package:pharmacy/controllers/users_controller.dart';
import 'package:pharmacy/models/users.dart';
import 'package:pharmacy/views/users/users_list.dart';

// ignore: must_be_immutable
class UpdateUser extends StatefulWidget {
  String userPhoneNumber;
  UpdateUser({super.key, required this.userPhoneNumber});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final TextEditingController _fullName = TextEditingController();

  TextEditingController _phoneNumber = TextEditingController();

  //final TextEditingController _role = TextEditingController();
  final TextEditingController _sellingPoint = TextEditingController();

  final TextEditingController _password = TextEditingController();

  //final TextEditingController _userState = TextEditingController();
  final TextEditingController _role = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneNumber = TextEditingController(text: widget.userPhoneNumber);
    _fetchUserData();
  }

  void _fetchUserData() async {
    await UsersController().getUserInfo(widget.userPhoneNumber, (User user) {
      setState(() {
        _fullName.text = user.fullName;
        // _password.text = user.password;
        _sellingPoint.text = user.sellingPoint;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 237, 237),
      body: Stack(
        children: [
          Positioned.fill(
              child: Center(
            child: Opacity(
              opacity: 0.2,
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(
                  'assets/logo-no-background.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    const Text(
                      'YEREMIYA PHARMACY',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 73, 71, 71)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Modifiez les informations de l\'utilisateur',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 240.0),
                      child: Text(
                        'Téléphone',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _phoneNumber,
                      cursorColor: Colors.grey,
                      enabled: false,
                      decoration: InputDecoration(
                        // labelText: 'Tél',
                        // labelStyle: const TextStyle(
                        //   color: Color.fromARGB(255, 177, 223, 179),
                        // ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(80.0),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: const Icon(
                          Icons.phone_android_rounded,
                          color: Colors.blue,
                        ),
                        //floatingLabelBehavior: FloatingLabelBehavior.never
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 260.0),
                      child: Text(
                        'Noms',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _fullName,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        //labelText: 'Noms',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(80.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.person, // Adjust icon as needed
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 220.0),
                      child: Text(
                        'Mot de passe',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _password,
                      cursorColor: Colors.grey,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Pas moins de 5 digits',
                        //labelText: 'Mot de passe',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(80.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String phoneNumber = _phoneNumber.text;
                        String password = _password.text;
                        String fullName = _fullName.text;
                        String sellingPoint = _sellingPoint.text;
                        String role = _role.text;
                        // String userState = _userState.text;

                        User updatedUser = User(
                          fullName: fullName,
                          phoneNumber: phoneNumber,
                          password: password,
                          sellingPoint: sellingPoint,
                          role: role,
                          //userState: userState,
                        );

                        UsersController().updateUserInfo(updatedUser, () {});
                        _fullName.clear();
                        _password.clear();
                        _phoneNumber.clear();
                        _role.clear();
                        _sellingPoint.clear();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UsersList()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child: const Text(
                        'Modifier',
                        style: TextStyle(
                          color: Color.fromARGB(255, 238, 237, 237),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
