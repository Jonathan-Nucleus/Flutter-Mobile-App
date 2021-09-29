import 'package:client/app.dart';
import 'package:client/screens/home/home.dart';
import 'package:client/screens/home/product-details.dart';
import 'package:client/screens/home/seller-shop.dart';
import 'package:client/screens/message/chat.dart';
import 'package:client/screens/message/rooms.dart';
import 'package:client/screens/myshop/edit-info.dart';
import 'package:client/screens/myshop/edit-number.dart';
import 'package:client/screens/myshop/edit-password.dart';
import 'package:client/screens/myshop/edit-product.dart';
import 'package:client/screens/myshop/edit-profile.dart';
import 'package:client/screens/myshop/followers.dart';
import 'package:client/screens/myshop/following.dart';
import 'package:client/screens/myshop/my-cart-details.dart';
import 'package:client/screens/myshop/my-products-details.dart';
import 'package:client/screens/myshop/myshop.dart';
import 'package:client/screens/myshop/notfcn-setting.dart';
import 'package:client/screens/myshop/notifications.dart';
import 'package:client/screens/myshop/settings.dart';
import 'package:client/screens/search/no-results.dart';
import 'package:client/screens/search/search-bar-results.dart';
import 'package:client/screens/search/search-results.dart';
import 'package:client/screens/search/search.dart';
import 'package:client/screens/start/login.dart';
import 'package:client/screens/start/registration.dart';
import 'package:client/screens/start/verification.dart';
import 'package:client/screens/upload/upload.dart';
import "package:flutter/material.dart";
import 'package:page_transition/page_transition.dart';

const String LoginRoute = '/login';
const String VerificationRoute = '/verification';
const String RegistrationRoute = '/registration';
const String HomeRoute = '/home';
const String AppRoute = '/app';

const String SearchRoute = '/search';
const String UploadRoute = '/upload';
const String MessagesRoute = '/messages';
const String MyshopRoute = '/myshop';

const String FollowersRoute = '/followers';
const String FollowingRoute = '/following';
const String NotificationsRoute = '/notifications';
const String SettingsRoute = '/settings';
const String MyProductdetailsRoute = '/myproductdetails';
const String MyCartdetailsRoute = '/mycartdetails';

const String EditprofileRoute = '/editprofile';
const String EditinfoRoute = '/editinfo';
const String EditnotiRoute = '/editnotification';
const String EditProductRoute = '/editproduct';

const String EditnumberRoute = '/editnumber';
const String EditpasswordRoute = '/editpassword';

const String ChatRoute = '/chat';

const String SearchresultsRoute = '/searchresults';
const String SearchpageRoute = '/searchpage';
const String SearchBarRoute = '/searchbarresults';

const String SellershopRoute = '/sellershop';
const String ProductdetailsRoute = '/productdetails';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute:
        return PageTransition(
          child: App(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case LoginRoute:
        return PageTransition(
          child: Login(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case VerificationRoute:
        return PageTransition(
          child: Verification(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case RegistrationRoute:
        return PageTransition(
          child: Registration(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case HomeRoute:
        return PageTransition(
          child: Home(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case SearchRoute:
        return PageTransition(
          child: Search(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case UploadRoute:
        return PageTransition(
          child: UploadProduct(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case MessagesRoute:
        return PageTransition(
          child: Rooms(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case MyshopRoute:
        return PageTransition(
          child: MyShop(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case FollowersRoute:
        return PageTransition(
          child: Followers(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case FollowingRoute:
        return PageTransition(
          child: Following(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case NotificationsRoute:
        return PageTransition(
          child: Notifications(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case SettingsRoute:
        return PageTransition(
          child: Settings(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case EditprofileRoute:
        return PageTransition(
          child: EditProfile(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case EditinfoRoute:
        return PageTransition(
          child: EditInfo(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case EditnotiRoute:
        return PageTransition(
          child: NotificationSettings(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case EditnumberRoute:
        return PageTransition(
          child: EditNumber(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case EditpasswordRoute:
        return PageTransition(
          child: EditPassword(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case ChatRoute:
        return PageTransition(
          child: Chat(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case SearchresultsRoute:
        return PageTransition(
          child: SearchResults(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case SearchpageRoute:
        return PageTransition(
          child: Search(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case SellershopRoute:
        return PageTransition(
          child: SellerShop(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case ProductdetailsRoute:
        return PageTransition(
          child: ProductDetails(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case MyProductdetailsRoute:
        return PageTransition(
          child: MyProductDetails(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case MyCartdetailsRoute:
        return PageTransition(
          child: MyCartDetails(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case SearchBarRoute:
        return PageTransition(
          child: SearchBarResuts(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      case EditProductRoute:
        return PageTransition(
          child: EditProduct(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
          duration: Duration(milliseconds: 200),
        );
        break;
      default:
        return null;
    }
  }
}
