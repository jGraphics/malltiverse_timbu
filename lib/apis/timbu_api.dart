import 'models/mainListProduct.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:malltiverse_timbu/apis/connectionUrl/apiUrl.dart';



class TimbuApiProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get loading => _isLoading;

  
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<MainProduct> getProductByCategory(String category) async {
    setLoading(true);
    var getTimbu =
        '${Timbu().productUrl}?&organization_id=${Timbu().organizationId}&Appid=${Timbu().appId}&Apikey=${Timbu().apiKey}&category=$category';
    if (kDebugMode) {
      print(getTimbu);
    }
    var res = await http.get(
      Uri.parse(getTimbu),
      headers: {
        'Content-Type': "application/json",
      },
    );

    if (res.statusCode == 200) {
      setLoading(false);
      return mainProductFromJson(res.body);
    } else {
      setLoading(false);
      throw Exception('Failed to load products');
    }
  }

  getAProduct(String s) {}
}