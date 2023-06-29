import 'package:complaint_raiser_corp/auth_widget_builder.dart';
import 'package:complaint_raiser_corp/services/firestore_database.dart';
import 'package:complaint_raiser_corp/services/storage_database.dart';
import 'package:complaint_raiser_corp/ui/nav/nav.dart';
import 'package:complaint_raiser_corp/ui/complaints/raise_complaint_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'constants/app_themes.dart';
import 'models/user_model.dart';
import 'providers/auth_provider.dart';
import 'routes.dart';
import 'ui/auth/signin_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({required Key key
      // , required this.databaseBuilder
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(
        'myapppp----------------------------------------------------------------------------');
    return AuthWidgetBuilder(
      builder: (BuildContext context, AsyncSnapshot<UserModel> userSnapshot) {
        return MultiProvider(
            providers: [
              Provider<FirestoreDatabase>(
                  create: (context) => FirestoreDatabase()),
              Provider<StorageDatabase>(create: (context) => StorageDatabase()),
            ],
            builder: (context, snapshot) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                onGenerateRoute: Routes.generateRoute,
                theme: ThemeData(
                    // colorScheme: ColorScheme.light(),
                    colorSchemeSeed: AppThemes.primaryColor,
                    textTheme: GoogleFonts.montserratTextTheme(),
                    scaffoldBackgroundColor: AppThemes.light,
                    bottomNavigationBarTheme:
                        const BottomNavigationBarThemeData(
                            backgroundColor: AppThemes.primaryColor,
                            elevation: 0,
                            unselectedItemColor: Colors.white54,
                            selectedItemColor: AppThemes.light),
                    appBarTheme: const AppBarTheme(
                      elevation: 0,
                      foregroundColor: AppThemes.dark,
                      backgroundColor: AppThemes.light,
                      iconTheme: IconThemeData(color: AppThemes.dark),
                    ),
                    inputDecorationTheme:
                        InputDecorationTheme(border: OutlineInputBorder())),
                home: Consumer<AuthProvider>(
                  builder: (_, authProviderRef, __) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.active) {
                      print(userSnapshot.data?.uid);
                      return userSnapshot.hasData &&
                              userSnapshot.data?.uid != 'null'
                          ? const NavScreen()
                          : const NavScreen();
                    }

                    return const Material(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              );
            });
      },
      key: const Key('AuthWidget'),
    );
  }
}
