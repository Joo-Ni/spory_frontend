// import 'package:flutter/material.dart';
// import '../tab/tab_page.dart';

// class AuthGate extends StatelessWidget {
//   const AuthGate({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final providers = [EmailAuthProvider()];

//     void onSignedIn() {
//       Navigator.pushReplacementNamed(context, '/profile');
//     }

//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         // User is not signed in
//         if (!snapshot.hasData) {
//           return SignInScreen(
//               providers: providers,
//               actions: [
//                 AuthStateChangeAction<UserCreated>((context, state) {
//                   // Put any new user logic here
//                   onSignedIn();
//                 }),
//                 AuthStateChangeAction<SignedIn>((context, state) {
//                   onSignedIn();
//                 }),
//               ],
//               headerBuilder: (context, constraints, _) {
//                 return const Center(
//                   child: Text(
//                     'SPORY',
//                     style: TextStyle(fontSize: 40),
//                   ),
//                 );
//               });
//         }
//         // Render your application if authenticated
//         return const TabPage();
//       },
//     );
//   }
// }
