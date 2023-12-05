import 'package:client/models/label_order/label_order.dart';
import 'package:client/services/api_response/api_response.dart';
import 'package:client/services/apis/api_client.dart';

class LabelRepository {
  APIClient apis;
  LabelRepository({required this.apis});

  Future<ApiResponse<List<LabelOrder>>> changeOrder(
      String userId, LabelOrder label1, LabelOrder label2) {
    return apis.changeLabelOrder(userId, {
      "swap_labels": [
        label1.toJson(),
        label2.toJson(),
      ]
    });
  }
}
