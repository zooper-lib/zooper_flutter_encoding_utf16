import 'dart:typed_data';

import 'constants.dart';

abstract class Utf16Decoder {
  /// Identifies whether a List of bytes starts (based on offset) with a
  /// little-endian byte-order marker (BOM).
  static bool hasUtf16leBom(List<int> utf16EncodedBytes, [int offset = 0, int? length]) {
    var end = length != null ? offset + length : utf16EncodedBytes.length;
    return (offset + 2) <= end &&
        utf16EncodedBytes[offset] == littleEndianBOM[0] &&
        utf16EncodedBytes[offset + 1] == littleEndianBOM[1];
  }

  /// Identifies whether a List of bytes starts (based on offset) with a
  /// big-endian byte-order marker (BOM).
  static bool hasUtf16beBom(List<int> utf16EncodedBytes, [int offset = 0, int? length]) {
    var end = length != null ? offset + length : utf16EncodedBytes.length;
    return (offset + 2) <= end &&
        utf16EncodedBytes[offset] == bigEndianBOM[0] &&
        utf16EncodedBytes[offset + 1] == bigEndianBOM[1];
  }

  String decode(List<int> utf16EncodedBytes, [int offset = 0, int? length]);
}

class Utf16LittleEndianDecoder extends Utf16Decoder {
  @override
  String decode(List<int> utf16EncodedBytes, [int offset = 0, int? length]) {
    if (Utf16Decoder.hasUtf16leBom(utf16EncodedBytes, offset, length)) {
      offset = offset + 2;
    }

    length ??= utf16EncodedBytes.length - offset;

    var sublist = utf16EncodedBytes.sublist(offset, offset + length);

    var utf16CodeUnits = Uint8List.fromList(sublist).buffer.asUint16List();
    return String.fromCharCodes(utf16CodeUnits);
  }
}

class Utf16BigEndianDecoder extends Utf16Decoder {
  @override
  String decode(List<int> utf16EncodedBytes, [int offset = 0, int? length]) {
    if (Utf16Decoder.hasUtf16beBom(utf16EncodedBytes, offset, length)) {
      offset = offset + 2;
    }

    length ??= utf16EncodedBytes.length - offset;

    var sublist = utf16EncodedBytes.sublist(offset, offset + length);
    sublist = _switchCharacters(sublist);

    var utf16CodeUnits = Uint8List.fromList(sublist).buffer.asUint16List();
    return String.fromCharCodes(utf16CodeUnits);
  }

  List<int> _switchCharacters(List<int> utf16EncodedBytes) {
    List<int> sublist;

    if (utf16EncodedBytes.length % 2 == 1) {
      sublist = utf16EncodedBytes.sublist(0, utf16EncodedBytes.length - 1);
    } else {
      sublist = utf16EncodedBytes.sublist(0, utf16EncodedBytes.length - 0);
    }

    for (int i = 0; i < sublist.length; i += 2) {
      var temp = sublist[i];
      sublist[i] = sublist[i + 1];
      sublist[i + 1] = temp;
    }

    return sublist;
  }
}
