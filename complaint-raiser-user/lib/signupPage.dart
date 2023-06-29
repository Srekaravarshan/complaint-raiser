// import 'package:complaint_raiser/loginPage.dart';
// import 'package:flutter/material.dart';
//
// import 'authentication.dart';
//
// class signupPage extends StatelessWidget {
//   TextEditingController _emailController = new TextEditingController();
//   TextEditingController _nameController = new TextEditingController();
//   TextEditingController _passwordController = new TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('Sign Up'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Name',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Email',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Password',
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // var res = AuthService().signinUser(
//                 //     email: _emailController.text,
//                 //     password: _passwordController.text);
//                 // print(res);
//               },
//               child: Text('Sign Up'),
//             ),
//             TextButton(
//
//               onPressed: () {
//                 // var res = AuthService().signupUser(
//                 //     email: _emailController.text,
//                 //     password: _passwordController.text);
//                 // print(res);
//               },
//               child: Text('Already have an account? Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
