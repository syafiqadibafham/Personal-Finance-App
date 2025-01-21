// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'name.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Name extends Name {
  @override
  final String value;

  factory _$Name([void Function(NameBuilder)? updates]) =>
      (new NameBuilder()..update(updates))._build();

  _$Name._({required this.value}) : super._() {
    BuiltValueNullFieldError.checkNotNull(value, r'Name', 'value');
  }

  @override
  Name rebuild(void Function(NameBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NameBuilder toBuilder() => new NameBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Name && value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Name')..add('value', value))
        .toString();
  }
}

class NameBuilder implements Builder<Name, NameBuilder> {
  _$Name? _$v;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  NameBuilder();

  NameBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Name other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Name;
  }

  @override
  void update(void Function(NameBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Name build() => _build();

  _$Name _build() {
    final _$result = _$v ??
        new _$Name._(
          value: BuiltValueNullFieldError.checkNotNull(value, r'Name', 'value'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
