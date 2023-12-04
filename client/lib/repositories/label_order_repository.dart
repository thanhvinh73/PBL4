import 'package:client/models/label_order/label_order.dart';
import 'package:client/services/api_response/api_response.dart';
import 'package:client/services/apis/api_client.dart';
import 'package:client/shared/enum/label_order.dart';

class LabelRepository {
  APIClient apis;
  LabelRepository({required this.apis});

  Future<ApiResponse<List<LabelOrder>>> changeOrder(
      String userId, LabelOrderEnum label1, LabelOrderEnum label2) {
    return apis.changeLabelOrder(userId, {
      "swap_labels": [label1.name.toUpperCase(), label2.name.toUpperCase()]
    });
  }
}
