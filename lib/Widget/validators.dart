import 'package:form_field_validator/form_field_validator.dart';

final nameValidator = RequiredValidator(errorText: '*required');
final brandValidator = MultiValidator([
  RequiredValidator(errorText: '*required'),
  // BrandPatternValidator(r"^[a-zA-Z]",
  //     errorText: 'Incorrent format,do not use numbers')
]);

final phoneValidator = MultiValidator([
  RequiredValidator(errorText: '*required'),
  MinLengthValidator(13, errorText: 'Format: +254712345678'),
  MaxLengthValidator(13, errorText: 'Enter a valid Mobile number'),
]);
final emailValidator = MultiValidator([
  RequiredValidator(errorText: '*required'),
  PatternValidator(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      errorText: 'Incorrent email address')
]);

final passwordValidator = MultiValidator(
  [
    RequiredValidator(errorText: '*required'),
    MinLengthValidator(6, errorText: 'password must be at least 6 digits long'),
  ],
);

final incorrectValidator = RequiredValidator(errorText: '*Incorrect entry');

final priceValidator = MultiValidator([
  RequiredValidator(errorText: '*required'),
  MinLengthValidator(1, errorText: 'Format: 1234567890'),
  MaxLengthValidator(6, errorText: 'Enter a valid price'),
]);
