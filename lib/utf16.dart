import 'dart:convert';
import 'dart:core';

import 'constants.dart';
import 'utf16_encoder.dart';
import 'utf16_decoder.dart';

abstract class UTF16 extends Encoding {
  /// Gets the BOM
  List<int> get bom;

  /// Encodes a [String]
  ///
  /// BOM will not be written
  @override
  List<int> encode(String input) => encoder.convert(input);

  /// Encodes a [String] with the BOM
  List<int> encodeWithBOM(String input);

  /// Decodes a [List] of [int]
  @override
  String decode(List<int> encoded) => decoder.convert(encoded);

  /// The name of the Encoding
  @override
  String get name;
}

abstract class UTF16Encoder extends Converter<String, List<int>> {
  List<int> encode(String input, [bool writeBOM = false]);
}

abstract class UTF16Decoder extends Converter<List<int>, String> {
  String decode(List<int> input);
}

class UTF16LE extends UTF16 {
  @override
  List<int> get bom => littleEndianBOM;

  @override
  UTF16Decoder get decoder => _LittleEndianDecoder();

  @override
  UTF16Encoder get encoder => _LittleEndianEncoder();

  @override
  List<int> encodeWithBOM(String input) => encoder.encode(input, true);

  @override
  String get name => 'utf16le';
}

class UTF16BE extends UTF16 {
  @override
  List<int> get bom => bigEndianBOM;

  @override
  UTF16Decoder get decoder => _BigEndianDecoder();

  @override
  UTF16Encoder get encoder => _BigEndianEncoder();

  @override
  String get name => 'utf16be';

  @override
  List<int> encodeWithBOM(String input) => encoder.encode(input, true);
}

class _LittleEndianDecoder extends UTF16Decoder {
  @override
  String convert(List<int> input) => decode(input);

  @override
  String decode(List<int> input) {
    var decoder = Utf16LittleEndianDecoder();
    return decoder.decode(input);
  }
}

class _LittleEndianEncoder extends UTF16Encoder {
  @override
  List<int> convert(String input) => encode(input);

  @override
  List<int> encode(String input, [bool writeBOM = false]) {
    var encoder = Utf16LittleEndianEncoder();
    return encoder.encode(input, writeBOM).cast<int>();
  }
}

class _BigEndianDecoder extends UTF16Decoder {
  @override
  String convert(List<int> input) => decode(input);

  @override
  String decode(List<int> input) {
    var decoder = Utf16BigEndianDecoder();
    return decoder.decode(input);
  }
}

class _BigEndianEncoder extends UTF16Encoder {
  @override
  List<int> convert(String input) => encode(input);

  @override
  List<int> encode(String input, [bool writeBOM = false]) {
    var encoder = Utf16BigEndianEncoder();
    return encoder.encode(input, writeBOM).cast<int>();
  }
}
