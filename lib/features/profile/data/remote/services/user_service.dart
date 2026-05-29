import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:intiva_mobile_application/core/network/api/api_endpoints.dart';
import 'package:intiva_mobile_application/features/profile/data/remote/models/user_dto.dart';

part 'user_service.g.dart';

/// Retrofit service for user-profile related API calls.
@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class UserService {
  factory UserService(Dio dio, {String baseUrl}) = _UserService;

  @GET(ApiEndpoints.profile)
  Future<UserDto> getUserProfile();
}
