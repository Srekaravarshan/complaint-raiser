// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'authentication.dart';
// import 'complaintForm.dart';
//
// class dashboardPage extends StatelessWidget {
//   final User user;
//
//   const dashboardPage({Key? key, required this.user}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dashboard'),
//         actions: [InkWell(onTap: () async {
//     await context.read<AuthService>().signOut();
//     }, child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Center(child: Text("Logout", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
//     ))],
//       ),
//
//       body: GridView.count(
//         crossAxisCount: 2,
//         padding: EdgeInsets.all(16),
//         childAspectRatio: 1.5,
//         mainAxisSpacing: 16,
//         crossAxisSpacing: 16,
//         children: [
//           _buildCard(
//             context,
//             'Electricity Department',
//             Icons.power_outlined,
//                 () =>  Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ComplaintForm()),
//                 ),
//           ),
//           _buildCard(
//             context,
//             'Drainage Department',
//             Icons.local_drink_outlined,
//                 () => Navigator.pushNamed(context, '/drainage'),
//           ),
//           _buildCard(
//             context,
//             'Road Department',
//             Icons.directions_car_outlined,
//                 () => Navigator.pushNamed(context, '/road'),
//           ),
//           _buildCard(
//             context,
//             'Ground Water Department',
//             Icons.water_damage_outlined,
//                 () => Navigator.pushNamed(context, '/groundwater'),
//           ),
//           _buildCard(
//             context,
//             'Raise Complaint',
//             Icons.warning_outlined,
//                 () => Navigator.pushNamed(context, '/complaint'),
//           ),
//           _buildCard(
//             context,
//             'Other Departments',
//             Icons.category_outlined,
//                 () => Navigator.pushNamed(context, '/other'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
//     return InkWell(
//       onTap: onTap,
//       child: Card(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon),
//             SizedBox(height: 16),
//             Text(title, style: Theme.of(context).textTheme.headline6),
//           ],
//         ),
//       ),
//     );
//   }
// }
