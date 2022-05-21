import 'package:final_project/models/order_model.dart';
import 'package:final_project/provider/base_provider.dart';

class MyOrderProvider extends BaseProvider {
  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
  }

  // Fetch Data
  Future<List<Order>> getAllOrder(var id, [var type]) async {
    try {
      String url = 'orders/mine/' + id + '?type=' + type.toString();
      final response = await get(url);
      if (response.hasError) {
        throw response.body;
      }
      var data = orderFromJson(response.body);
      return data;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  // create order
  Future<dynamic> createOrder(var body) async {
    try {
      String url = 'orders/createOrder';
      final response = await post(url, body);
      if (response.hasError) {
        throw response.body;
      }
      var data = Order.fromJson(response.body);
      return data;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  // send mail
  Future<dynamic> sendMail(var body) async {
    try {
      String url = 'orders/sendmail';
      final response = await post(url, body);
      if (response.hasError) {
        throw response.body;
      }
      return response.body;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
