import 'package:client/models/camera_url/camera_url.dart';
import 'package:client/models/credential/credential.dart';
import 'package:client/models/label_order/label_order.dart';
import 'package:client/models/user/user.dart';
import 'package:client/services/api_response/api_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class APIClient {
  factory APIClient(Dio dio, {String baseUrl}) = _APIClient;

  // Auth
  @POST('/api/auth/login')
  Future<ApiResponse<Credential>> login(@Body() Map<String, dynamic> body);

  @POST('/api/auth/revoke')
  Future<ApiResponse<dynamic>> logout();

  @POST("/api/auth/register")
  Future<ApiResponse<User>> register(@Body() Map<String, dynamic> body);

  @POST('/api/auth/refresh_token')
  Future<ApiResponse<Credential>> refreshToken();

  // User
  @GET('/api/users')
  Future<ApiResponse<User>> getUser();

  @PATCH('/api/users')
  Future<ApiResponse<User>> updateInfoUser(@Body() Map<String, dynamic> body);

  @GET('/api/users/{userId}')
  Future<ApiResponse<User>> getUserById(@Path("userId") String userId);

  // Camera url
  @PATCH("/api/camera-url/{cameraUrlId}/inactive")
  Future<ApiResponse<CameraUrl>> inactiveCameraUrl(
      @Path("cameraUrlId") String cameraUrlId);

  @GET("/api/camera-url")
  Future<ApiResponse<List<CameraUrl>>> getAllCameraUrl();

  @GET("/api/camera-url/active")
  Future<ApiResponse<List<CameraUrl>>> getAllActiveCameraUrl();

  @GET("/api/camera-url/{cameraUrlId}")
  Future<ApiResponse<CameraUrl>> getCameraUrlById(
      @Path("cameraUrlId") String cameraUrlId);

  @GET("/api/camera-url/search")
  Future<ApiResponse<List<CameraUrl>>> searchCameraUrl({
    @Query("ssid") String? ssid,
  });

  // Label order
  @POST("/api/label-order/{userId}/default-label")
  Future<ApiResponse<List<LabelOrder>>> createDefaultLabel(
      @Path("userId") String userId);

  @GET("/api/label-order/{userId}")
  Future<ApiResponse<List<LabelOrder>>> getLabelByUser(
      @Path("userId") String userId);

  @PATCH("/api/label-order/{userId}/change-order")
  Future<ApiResponse<List<LabelOrder>>> changeLabelOrder(
      @Path("userId") String userId, @Body() Map<String, dynamic> body);
}
