import '../../config/values/api_keys.dart';

/// Method [init] must be called before using Constants.
class ApiData {
  /// This method must be called before using Constants.
  void init(
      {required String apiKey,
      required String baseUrl,
      required int userProfileId}) {
    _apiKey = apiKey;
    _baseUrl = baseUrl;
    _userProfileId = userProfileId;
  }

  late final String _apiKey;
  late final String _baseUrl;
  late final int _userProfileId;

  String get apiKey => _apiKey;
  String get basUrl => _baseUrl;

  String getStockProfileImageUrl(int profileImageT) =>
      "${_baseUrl}users/get_profile_image?$keyApi=$apiKey&$keyUserProfileId=$_userProfileId&t=$profileImageT";
}
