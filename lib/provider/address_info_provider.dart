import 'package:final_project/models/address_info_model.dart';
import 'package:final_project/provider/base_provider.dart';

class AddressInfoProvider extends BaseProvider {
  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
  }

  // Fetch Data
  Future<List<AddressInfo>> getAllAddressInfo() async {
    try {
      String url = 'users/address-info';
      final response = await get(url);
      if (response.hasError) {
        throw response.body;
      }
      var data = addressInfoFromJson(response.body);
      return data;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  // create Data
  Future<AddressInfo> createAddressInfo(var body) async {
    try {
      String url = 'users/address-info';
      final response = await post(url, body);
      if (response.hasError) {
        throw response.body;
      }
      var data = AddressInfo.fromJson(response.body["data"]);
      return data;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  // update Data
  Future<AddressInfo> updateAddressInfo(var id, var body) async {
    try {
      Map newdata = Map.from(body);
      newdata.remove("_id");
      newdata.remove("userId");

      String url = 'users/address-info/$id';
      final response = await put(url, newdata);
      if (response.hasError) {
        throw response.body["data"];
      }
      var data = AddressInfo.fromJson(response.body["data"]);
      return data;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  // delete Data
  Future<Map<String, dynamic>> deleteAddressInfo(var id) async {
    try {
      String url = 'users/address-info/$id';
      final response = await delete(url);
      if (response.hasError) {
        throw response.body;
      }
      return response.body;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
