import 'package:http/http.dart' as http;

abstract class ISlideService {
  Future next();
  Future back();
  Future start();
  Future stop();
}

class SlideService implements ISlideService {
  String baseUrl;
  SlideService({required this.baseUrl});

  @override
  Future back() {
    final url = Uri.parse("$baseUrl/back");
    return http.get(url);
  }

  @override
  Future next() {
    final url = Uri.parse("$baseUrl/next");
    return http.get(url);
  }

  @override
  Future start() {
    final url = Uri.parse("$baseUrl/start");
    return http.get(url);
  }

  @override
  Future stop() {
    final url = Uri.parse("$baseUrl/stop");
    return http.get(url);
  }
}

// const baseURL = "http://192.168.1.111:5000";
