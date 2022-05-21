import 'package:final_project/bindings/auth_binding.dart';
import 'package:final_project/bindings/cart_binding.dart';
import 'package:final_project/bindings/checkout_binding.dart';
import 'package:final_project/bindings/home_page_bindding.dart';
import 'package:final_project/bindings/product_detail_binding.dart';
import 'package:final_project/pages/CheckOutPage.dart';
import 'package:final_project/pages/EnterCodePage.dart';
import 'package:final_project/pages/ForgotPasswordPage.dart';
import 'package:final_project/pages/ProductDetail.dart';
import 'package:final_project/pages/RegisterPage.dart';
import 'package:final_project/pages/ResetPasswordPage.dart';
import 'package:get/get.dart';
import 'package:final_project/bindings/dashboard_binding.dart';
import 'package:final_project/pages/DashBoardPage.dart';
import 'package:final_project/pages/HomePage.dart';
import 'package:final_project/pages/CartPage.dart';
import 'package:final_project/pages/ProfilePage.dart';
import 'package:final_project/pages/ShopPage.dart';
import 'package:final_project/pages/Login.dart';

import '../middlewares/enter_code_middleware.dart';
import 'app_routes.dart';

class AppPages {
  static var rootPage = AppRoutes.DASHBOARD;

  static var list = [
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => DashBoardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: AppRoutes.CART,
      page: () => CartPage(),
      binding: CartBinding(),
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => ProfilePage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.CATEGORY,
      page: () => ShopPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.PRODUCT_DETAIL,
      page: () => ProductDetail(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.FORGOT_PASSWORD,
      page: () => const ForgotPage(),
      binding: AuthBinding(),
    ),
    GetPage(
        name: AppRoutes.ENTER_CODE,
        page: () => const EnterCodePage(),
        binding: AuthBinding(),
        middlewares: [EnterCodeMiddleware()]),
    GetPage(
      name: AppRoutes.RESET_PASSWORD,
      page: () => const ResetPasswordPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => const RegisterPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.CHECKOUT,
      page: () => CheckoutPage(),
      binding: CheckoutBinding(),
    ),
  ];
}
