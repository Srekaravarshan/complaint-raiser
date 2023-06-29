import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../constants/app_themes.dart';
import '../../providers/auth_provider.dart';
import '../widgets/components/primary_button.dart';
import '../widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController _phoneController;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    print('signin======================================');
    _phoneController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    print('signin======================================');
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.white.withOpacity(0.2),
            AppThemes.primaryColor.withOpacity(0.2)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Align(
          alignment: Alignment.center,
          child: _buildForm(context),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Widget _buildForm(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppThemes.contentMargin),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Image.asset(
                //   'assets/images/panipuri.png',
                //   fit: BoxFit.fitWidth,
                //   width: 200,
                // ),
                const SizedBox(height: 8),
                logo(),
                const SizedBox(height: 30),
                SizedBox(
                  height: 60,
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: GoogleFonts.merienda(),
                    // style: Theme.of(context).textTheme.bodyText1,
                    validator: (value) => (value!.isEmpty && value.length != 10)
                        ? "Enter valid phone number"
                        : null,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: AppThemes.primaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: AppThemes.primaryColor,
                          ),
                        ),
                        fillColor: AppThemes.light,
                        filled: true,
                        // isDense: true,
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: AppThemes.subColor,
                        ),
                        labelStyle: TextStyle(color: AppThemes.primaryColor),
                        hintText: "Phone number",
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide:
                                BorderSide(color: AppThemes.primaryColor))),
                  ),
                ),
                const SizedBox(height: 12),
                authProvider.status == Status.authenticating
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : primaryButton(
                        title: 'Sign in',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context)
                                .unfocus(); //to hide the keyboard - if any
                            String phoneNumber = _phoneController.text.trim();
                            authProvider.signInWithPhone(
                                context, "+91$phoneNumber");
                          }
                        }),

                // SizedBox(
                //     width: double.infinity,
                //     height: 60,
                //     child: ElevatedButton(
                //         style: ButtonStyle(
                //             shape: MaterialStateProperty.all<
                //                     RoundedRectangleBorder>(
                //                 RoundedRectangleBorder(
                //                     borderRadius:
                //                         BorderRadius.circular(25.0))),
                //             elevation: MaterialStateProperty.all(0),
                //             backgroundColor:
                //                 MaterialStateProperty.all<Color>(
                //                     AppThemes.primaryColor)),
                //         child: const Text(
                //           "Sign in",
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold, fontSize: 18),
                //         ),
                //         onPressed:  ),
              ],
            ),
          ),
        ));
  }
}
