import 'package:built_value/built_value.dart';

part 'name.g.dart';

abstract class Name implements Built<Name, NameBuilder> {
  String get value;

  Name._() {
    if (value.length < 8) {
      throw ArgumentError('Password must be at least 8 characters');
    }

    // final RegExp passwordRegExp = RegExp(
    //   r'^[a-zA-Z0-9]*$',
    // );

    // if (!passwordRegExp.hasMatch(value)) {
    //   throw ArgumentError('Password can only contain alphanumeric characters');
    // }
  }
  factory Name([void Function(NameBuilder) updates]) = _$Name;
}
