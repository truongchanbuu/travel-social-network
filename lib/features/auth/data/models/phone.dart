import 'package:formz/formz.dart';

enum PhoneValidationError {
  invalid,
}

class Phone extends FormzInput<String, PhoneValidationError> {
  const Phone.pure() : super.pure('');
  const Phone.dirty([super.value = '']) : super.dirty();

  // Regex for phone number validation
  // This pattern matches:
  // - Optional plus sign
  // - Optional country code
  // - 9-11 digits
  // Examples: +84123456789, 0123456789, 84123456789
  static final RegExp _phoneRegExp = RegExp(r'^\+?([0-9]{2})?[0-9]{9,11}$');

  @override
  PhoneValidationError? validator(String? value) {
    final cleanNumber = (value ?? '').replaceAll(RegExp(r'[\s\-()]'), '');

    return _phoneRegExp.hasMatch(cleanNumber)
        ? null
        : PhoneValidationError.invalid;
  }

  static String formatPhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'[\s\-()]'), '');

    // You can add your specific formatting logic here
    // Example: Convert 84123456789 to +84 123 456 789
    if (cleaned.length >= 11) {
      final countryCode = cleaned.substring(0, 2);
      final rest = cleaned.substring(2);
      return '+$countryCode ${rest.replaceAllMapped(RegExp(r'.{3}'), (match) => '${match.group(0)} ').trim()}';
    }

    return cleaned
        .replaceAllMapped(RegExp(r'.{3}'), (match) => '${match.group(0)} ')
        .trim();
  }

  static String cleanPhone(String phone) {
    return phone.replaceAll(RegExp(r'[\s\-()+]'), '');
  }
}
