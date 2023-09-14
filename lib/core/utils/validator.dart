/// Common validators for forms.
class Validator {
  static String? requiredValidate(String? value, String nullMessage,
          [String? Function(String? value)? validate]) =>
      value == null || value.isEmpty ? nullMessage : validate?.call(value);
  static String? requiredNumericValidate(num? value, String nullMessage,
          [String? Function(num? value)? validate]) =>
      value == null || value <= 0 ? nullMessage : validate?.call(value);
}
