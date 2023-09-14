import '../../config/values/api_keys.dart';

/// Personality type. حقیقی یا حقوقی
enum Personality {
  /// حقوقی
  juridical,

  /// حقیقی
  private;

  factory Personality.fromJson(Map<String, dynamic> map) =>
      Personality.values[map[keyPersonalityId]];
}
