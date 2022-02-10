import 'package:flutter_test/flutter_test.dart';

import 'package:zooper_flutter_encoding_utf16/zooper_flutter_encoding_utf16.dart';

void main() {
  var text1 = 'Hello World';
  var text2 = 'Hello 🌎';
  var text3 = 'Chào thế giới';

  var beBytes1 = <int>[0, 72, 0, 101, 0, 108, 0, 108, 0, 111, 0, 32, 0, 87, 0, 111, 0, 114, 0, 108, 0, 100];
  var beBytes2 = <int>[0, 72, 0, 101, 0, 108, 0, 108, 0, 111, 0, 32, 216, 60, 223, 14];
  var beBytes3 = <int>[
    0,
    67,
    0,
    104,
    0,
    224,
    0,
    111,
    0,
    32,
    0,
    116,
    0,
    104,
    30,
    191,
    0,
    32,
    0,
    103,
    0,
    105,
    30,
    219,
    0,
    105
  ];

  var leBytes1 = <int>[72, 0, 101, 0, 108, 0, 108, 0, 111, 0, 32, 0, 87, 0, 111, 0, 114, 0, 108, 0, 100, 0];
  var leBytes2 = <int>[72, 0, 101, 0, 108, 0, 108, 0, 111, 0, 32, 0, 60, 216, 14, 223];
  var leBytes3 = <int>[
    67,
    0,
    104,
    0,
    224,
    0,
    111,
    0,
    32,
    0,
    116,
    0,
    104,
    0,
    191,
    30,
    32,
    0,
    103,
    0,
    105,
    0,
    219,
    30,
    105,
    0,
  ];

  test('Encoding | Big Endian | Text 1', () {
    final encoder = UTF16BE();

    var bytes = encoder.encode(text1);
    expect(bytes, beBytes1);
  });

  test('Encoding | Big Endian | Text 2', () {
    final encoder = UTF16BE();

    var bytes = encoder.encode(text2);
    expect(bytes, beBytes2);
  });

  test('Encoding | Big Endian | Text 3', () {
    final encoder = UTF16BE();

    var bytes = encoder.encode(text3);
    expect(bytes, beBytes3);
  });

  test('Encoding | Little Endian | Text 1', () {
    final encoder = UTF16LE();

    var bytes = encoder.encode(text1);
    expect(bytes, leBytes1);
  });

  test('Encoding | Little Endian | Text 2', () {
    final encoder = UTF16LE();

    var bytes = encoder.encode(text2);
    expect(bytes, leBytes2);
  });

  test('Encoding | Little Endian | Text 3', () {
    final encoder = UTF16LE();

    var bytes = encoder.encode(text3);
    expect(bytes, leBytes3);
  });
}
