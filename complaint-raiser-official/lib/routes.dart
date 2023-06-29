
import 'package:flutter/material.dart';
import 'ui/auth/otp_screen.dart';
import 'ui/auth/signin_screen.dart';
import 'ui/complaints/complaint_screen.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  static const String login = '/login';
  static const String otp = '/otp';
  static const String complaintForm = '/complaintForm';
  static const String complaint = '/complaint';
  static const String home = '/';

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        {
          return MaterialPageRoute(builder: (context) => SignInScreen());
        }
      // case home:
      //   {
      //     return MaterialPageRoute(builder: (context) => NavScreen());
      //   }
      // case menu:
      //   {
      //     return MaterialPageRoute(builder: (context) => MenuScreen());
      //   }
      // case history:
      //   {
      //     return MaterialPageRoute(builder: (context) => HistoryScreen());
      //   }
      // case cash:
      //   {
      //     return MaterialPageRoute(builder: (context) => CashScreen());
      //   }
      // case upi:
      //   {
      //     return MaterialPageRoute(builder: (context) => UpiPaymentScreen());
      //   }
      // case store:
      //   {
      //     return MaterialPageRoute(builder: (context) => StoreScreen());
      //   }
      case otp:
        {
          OtpArguments args = settings.arguments as OtpArguments;
          return MaterialPageRoute(
              builder: (context) =>
                  OtpScreen(verificationId: args.verificationId));
        }
      case complaint:
        {
          ComplaintArguments args = settings.arguments as ComplaintArguments;
          return MaterialPageRoute(
              builder: (context) =>
                  ComplaintScreen(complaint: args.complaint));
        }
      // case product:
      //   {
      //     ProductArguments args = settings.arguments as ProductArguments;
      //     return MaterialPageRoute(
      //         builder: (context) => ProductScreen(product: args.product, id: args.id));
      //   }
      // case checkout:
      //   {
      //     CheckoutArguments args = settings.arguments as CheckoutArguments;
      //     return MaterialPageRoute(
      //         builder: (context) => CheckoutScreen(price: args.price));
      //   }
      default:
        throw FormatException("Route not found");
    }
  }
}
