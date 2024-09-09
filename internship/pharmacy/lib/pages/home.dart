import 'package:flutter/material.dart';
import 'package:pharmacy/controllers/users_controller.dart';
import 'package:pharmacy/pages/login_page.dart';
import 'package:pharmacy/views/products/products_list.dart';
import 'package:pharmacy/views/selling/selling_form.dart';
import 'package:pharmacy/views/users/users_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 237, 237),
      appBar: AppBar(
        title: const Text(
          'YEREMIYA PHARMACY',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
        ),
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu_outlined));
        }),
        backgroundColor: const Color.fromARGB(255, 238, 237, 237),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu'),
            ),
            if (UsersController.userRole.toLowerCase() == 'admin')
              ListTile(
                title: const Text('Utilisateurs'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UsersList()),
                  );
                },
              ),
            if (UsersController.userRole.toLowerCase() != 'seller')
              ListTile(
                title: const Text('Produits'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductsList()),
                  );
                },
              ),
            ListTile(
              title: const Text('Ventes'),
              onTap: () {
/**
 * 
 *  DateTime? pickedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2025),
                        initialDate: DateTime(2024));
                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate = pickedDate;
                        _searchedDate.text =
                            _selectedDate!.toIso8601String().split('T').first;
                      });
                    }
 */
                // setState(() {
                //         _selectedDate = pickedDate;
                //         _searchedDate.text =
                //             _selectedDate!.toIso8601String().split('T').first;
                //       });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SellingForm()),
                );
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
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
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                const Text(
                  'Nos produits disponibles',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color.fromARGB(255, 71, 69, 69)),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 110,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'assets/dawa-1.jpg',
                                        width: 90,
                                        height: 90,
                                      ),
                                    ),
                                    const Text(
                                      'Papaverine',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Prix:',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          '000 Fc',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 110,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'assets/dawa.jpg',
                                        width: 90,
                                        height: 90,
                                      ),
                                    ),
                                    const Text(
                                      'Paracetamol',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Prix:',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          '000 Fc',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 110,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'assets/dawa2.jpg',
                                        width: 90,
                                        height: 90,
                                      ),
                                    ),
                                    const Text(
                                      'Artequick',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Prix:',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          '000 Fc',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        ////////////////
                        ///
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 110,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'assets/dawa-1.jpg',
                                        width: 90,
                                        height: 90,
                                      ),
                                    ),
                                    const Text(
                                      'Papaverine',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Prix:',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          '000 Fc',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 110,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'assets/dawa.jpg',
                                        width: 90,
                                        height: 90,
                                      ),
                                    ),
                                    const Text(
                                      'Paracetamol',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Prix:',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          '000 Fc',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 110,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'assets/dawa2.jpg',
                                        width: 90,
                                        height: 90,
                                      ),
                                    ),
                                    const Text(
                                      'Artequick',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Prix:',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          '000 Fc',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        /////////////////////////////
                        ///
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 110,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'assets/dawa-1.jpg',
                                        width: 90,
                                        height: 90,
                                      ),
                                    ),
                                    const Text(
                                      'Papaverine',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Prix:',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          '000 Fc',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 110,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'assets/dawa.jpg',
                                        width: 90,
                                        height: 90,
                                      ),
                                    ),
                                    const Text(
                                      'Paracetamol',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Prix:',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          '000 Fc',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 110,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'assets/dawa2.jpg',
                                        width: 90,
                                        height: 90,
                                      ),
                                    ),
                                    const Text(
                                      'Artequick',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Prix:',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          '000 Fc',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        ///////////////////////////////////
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 110,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'assets/dawa-1.jpg',
                                        width: 90,
                                        height: 90,
                                      ),
                                    ),
                                    const Text(
                                      'Papaverine',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Prix:',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          '000 Fc',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 110,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'assets/dawa.jpg',
                                        width: 90,
                                        height: 90,
                                      ),
                                    ),
                                    const Text(
                                      'Paracetamol',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Prix:',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          '000 Fc',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 110,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'assets/dawa2.jpg',
                                        width: 90,
                                        height: 90,
                                      ),
                                    ),
                                    const Text(
                                      'Artequick',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Prix:',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          '000 Fc',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
