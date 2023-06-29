import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../constants/app_themes.dart';
import '../../providers/auth_provider.dart';
import '../../routes.dart';
import '../widgets/widgets.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  const OtpScreen({super.key, required this.verificationId});
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class OtpArguments {
  final String verificationId;

  OtpArguments(this.verificationId);
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;
  // final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _OtpScreenState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: _buildForm(context),
          ),
          Positioned(
              top: 50,
              left: AppThemes.contentMargin,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ))
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image.asset(
            //   'assets/images/panipuri.png',
            //   fit: BoxFit.fitWidth,
            //   width: 200,
            // ),
            // const SizedBox(height: 8),
            logo(),

            const SizedBox(height: 30),
            Pinput(
              length: 6,
              showCursor: true,
              defaultPinTheme: PinTheme(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppThemes.primaryColor,
                  ),
                ),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onChanged: (value) {
                otpCode = value;
                print(value);
                print(otpCode);
              },
              onCompleted: (value) {
                setState(() {
                  otpCode = value;
                });
                print(otpCode);
              },
            ),
            const SizedBox(height: 10),
            authProvider.status == Status.authenticating
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : primaryButton(
                    title: 'Submit',
                    onPressed: () async {
                      // if (_formKey.currentState!.validate()) {
                      FocusScope.of(context)
                          .unfocus(); //to hide the keyboard - if any

                      // verifyOtp(context, otpCode!);
                      authProvider.verifyOtp(
                        context: context,
                        verificationId: widget.verificationId,
                        userOtp: otpCode!,
                        onSuccess: () {
                          // checking whether user exists in the db
                          // authProvider.checkExistingUser().then(
                          //   (value) async {
                          //     if (value == true) {
                          // user exists in our app
                          // authProvider.getDataFromFirestore().then(
                          //       (value) => authProvider
                          //           .saveUserDataToSP()
                          //           .then(
                          //             (value) => authProvider
                          //                 .setSignIn()
                          //                 .then(
                          //                   (value) =>
                          Navigator.pushNamedAndRemoveUntil(
                              context, Routes.home, (route) => false);
                          // ),
                          //       ),
                          // );
                          // } else {
                          //   // new user
                          //   Navigator.pushAndRemoveUntil(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               const UserInfromationScreen()),
                          //       (route) => false);
                          // }
                          // },
                          // );
                        },
                      );

                      // bool status =
                      //     await authProvider.signInWithEmailAndPassword(
                      //         _emailController.text,
                      //         _passwordController.text);

                      // if (!status) {
                      //   // _scaffoldKey.currentState!.showSnackBar(const SnackBar(
                      //   //   content: Text("loginTxtErrorSignIn"),
                      //   // ));
                      // } else {
                      //   Navigator.of(context)
                      //       .pushReplacementNamed(Routes.home);
                      // }
                      // }
                    })
            // : ElevatedButton(
            //     child: Text(
            //       "loginBtnSignIn",
            //       style: Theme.of(context).textTheme.button,
            //     ),
            //     onPressed: ),
          ],
        ),
      ),
    );
  }
}
