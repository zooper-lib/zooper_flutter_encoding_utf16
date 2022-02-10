# zooper_flutter_encoding_utf16

Helper classes to encode and decode UTF16 string to List<int>.
It also supports encoding/decoding emojis.

This lib was created for another package and is specialized for this,
but it can be used anywhere. Also I am not a UTF-Pro, I just needed
an en/decoder and implemented a basic one.

If you find issues or need some other features, please fill the issue tracker.

Also I appreciate Pull Requests!

## Getting started

### Importing

Add this line to your `pubspec.yaml`:

``` yaml
zooper_flutter_encoding_utf16: <latest>
```

and inside your dart class:

``` dart 
import 'package:zooper_flutter_encoding_utf16/zooper_flutter_encoding_utf16.dart';
```

## Usage

``` dart
// Decide which encoder you want to use
// BigEndian or LittleEndian
final encoder = UTF16BE();

var bytes = encoder.encode('Hello World');

// bytes = [0, 72, 0, 101, 0, 108, 0, 108, 0, 111, 0, 32, 0, 87, 0, 111, 0, 114, 0, 108, 0, 100]
```

## Buy me a Coffee if you like this package

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/donate?hosted_button_id=Q4QALYJXEDH5Q)