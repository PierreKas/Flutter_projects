// import 'package:flutter/material.dart';
// import 'package:pharmacy/models/users.dart';

// class UserInfo extends StatelessWidget {
//   User user;
//   UserInfo({super.key, required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Stack(
//         children: [
//           Positioned.fill(
//               child: Center(
//             child: Opacity(
//               opacity: 0.3,
//               child: SizedBox(
//                 width: 200,
//                 height: 200,
//                 child: Image.asset(
//                   'assets/logo-no-background.png',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           )),
//           Container(
//             child: const Column(
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.person),
//                     //Text(${user.fullName})
//                   ],
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
