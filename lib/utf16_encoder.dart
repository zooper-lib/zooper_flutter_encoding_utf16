import 'dart:typed_data';

import 'constants.dart';

abstract class Utf16Encoder {
  List<int?> encode(String input, [bool writeBOM = false]);
}

class Utf16LittleEndianEncoder extends Utf16Encoder {
  @override
  List<int?> encode(String input, [bool writeBOM = false]) {
    var utf16CodeUnits = input.codeUnits;
    var bomList = writeBOM ? littleEndianBOM : <int>[];

    var encoding = Uint16List.fromList(utf16CodeUnits).buffer.asUint8List();

    return <int>[
      ...bomList,
      ...encoding,
    ];
  }
}

class Utf16BigEndianEncoder extends Utf16Encoder {
  @override
  List<int?> encode(String input, [bool writeBOM = false]) {
    var utf16CodeUnits = input.codeUnits;
    var bomList = writeBOM ? bigEndianBOM : <int>[];

    var encoding = Uint16List.fromList(utf16CodeUnits).buffer.asUint8List();

    var inverted = _switchCharacters(encoding);

    return <int>[
      ...bomList,
      ...inverted,
    ];
  }

  List<int> _switchCharacters(List<int> utf16EncodedBytes) {
    List<int> sublist;

    if (utf16EncodedBytes.length % 2 == 1) {
      sublist = utf16EncodedBytes.sublist(0, utf16EncodedBytes.length - 1);
    } else {
      sublist = utf16EncodedBytes.sublist(0, utf16EncodedBytes.length);
    }

    for (int i = 0; i < sublist.length; i += 2) {
      var temp = sublist[i];
      sublist[i] = sublist[i + 1];
      sublist[i + 1] = temp;
    }

    return sublist;
  }
}
