import 'models/mainListProduct.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:malltiverse_timbu/apis/connectionUrl/apiUrl.dart';
import 'package:malltiverse_timbu/apis/models/listOfProductItem.dart';



class TimbuApiProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get loading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
  }

  Future<MainProduct> getProduct() async {
    setLoading(true);
    var getTimbu =
        '${Timbu().productUrl}?&organization_id=${Timbu().organizationId}&Appid=${Timbu().appId}&Apikey=${Timbu().apiKey}';
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
      notifyListeners();
      return mainProductFromJson(res.body);
    } else {
      setLoading(false);
      notifyListeners();
      return mainProductFromJson(res.body);
    }
  }

  Future<Item2> getAProduct(id) async {
    setLoading(true);
    var getTimbu =
        '${Timbu().productUrl}/${id}?&organization_id=${Timbu().organizationId}&Appid=${Timbu().appId}&Apikey=${Timbu().apiKey}';
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
      notifyListeners();
      return singleItemFromJson(res.body);
    } else {
      setLoading(false);
      notifyListeners();
      return singleItemFromJson(res.body);
    }
  }
}
