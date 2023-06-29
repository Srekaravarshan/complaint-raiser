// import 'package:complaint_raiser/dashboardPage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'authentication.dart';
// import 'package:provider/provider.dart';
// import 'signupPage.dart';
// class loginPage extends StatelessWidget {
//   TextEditingController _phoneController = new TextEditingController();
//   TextEditingController _passwordController = new TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text('Login'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//              Padding(
//               padding: EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: _phoneController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Phone',
//                 ),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Password',
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 // await context
//                 //     .read<AuthService>()
//                 //     .signUpWithGoogle();
//                 // final User? _firebaseUser =
//                 // Provider.of<User?>(context, listen: false);
//               },
//               child: const Text('Login'),
//             ),
//             InkWell(
//               onTap: () async {
//                 await context
//                     .read<AuthService>()
//                     .signInWithPhone(_phoneController.text.trim(), context);
//                 // await addressRef.doc(_firebaseUser.uid).set({
//                 //   'addresses': [],
//                 //   'userId': _firebaseUser.uid
//                 // });
//               },
//               child: Container(
//                 height: 50,
//                 decoration: const BoxDecoration(
//                     color: Color(0xFF004CFF),
//                     borderRadius:
//                     BorderRadius.all(Radius.circular(4))),
//                 child: const Center(
//                   child: Text(
//                     'Sign up with google',
//                     style: TextStyle(
//                         color: Colors.white, fontSize: 14),
//                   ),
//                 ),
//               ),
//             ),
//             TextButton(
//               onPressed: () async {
//                 // await addressRef.doc(_firebaseUser.uid).set({
//                 //   'addresses': [],
//                 //   'userId': _firebaseUser.uid
//                 // });
//               },
//               child: const Text('Create an account'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
