import 'package:http/http.dart' as http;

abstract class ISlideService {
  Future next();
  Future back();
  Future start();
  Future stop();
}

class SlideService implements ISlideService {
  String baseUrl;
  final String prefixUrl = "api/presentation-controller";
  SlideService({required this.baseUrl});

  @override
  Future back() {
    final url = Uri.parse("$baseUrl/$prefixUrl/back");
    return http.post(url);
  }

  @override
  Future next() {
    final url = Uri.parse("$baseUrl/$prefixUrl/next");
    return http.post(url);
  }

  @override
  Future start() {
    final url = Uri.parse("$baseUrl/$prefixUrl/start");
    return http.post(url);
  }

  @override
  Future stop() {
    final url = Uri.parse("$baseUrl/$prefixUrl/stop");
    return http.post(url);
  }
}
