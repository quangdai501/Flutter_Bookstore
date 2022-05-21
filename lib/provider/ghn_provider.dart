import 'package:get/get.dart';

class GHNProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://dev-online-gateway.ghn.vn/shiip/public-api/';
    httpClient.addRequestModifier<void>((request) async {
      request.headers['token'] = 'e4822a9f-4eba-11ec-ac64-422c37c6de1b';
      request.headers['ShopId'] = '83990';
      request.headers['Content-Type'] = 'application/json';
      request.headers['Content-Type'] = 'text/plain';
      return request;
    });
  }

  // Fetch province
  Future<dynamic> getProvince() async {
    try {
      String url = 'master-data/province';
      final response = await get(url);

      var data = response.body['data'];
      if (response.status.hasError) {
        throw data;
      }
      return data;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  // Fetch district
  Future<dynamic> getDistrict(var provinceID) async {
    try {
      String url = 'master-data/district?province_id=$provinceID';
      final response = await get(url);

      var data = response.body['data'];
      if (response.status.hasError) {
        throw data;
      }
      return data;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  // Fetch ward
  Future<dynamic> getWard(var districtID) async {
    try {
      String url = 'master-data/ward?district_id=$districtID';
      final response = await get(url);

      var data = response.body['data'];
      if (response.status.hasError) {
        throw data;
      }
      return data;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  // Fetch shoppng fee
  Future<dynamic> getShippingFee(var body) async {
    try {
      String url = 'v2/shipping-order/fee';
      final response = await post(url, body);

      var data = response.body['data'];
      if (response.status.hasError) {
        throw data;
      }
      return data["total"];
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
