//

import 'dart:convert';
import 'dart:io';

extension FileToString on File {
  Future<String> toBase64String() async {
    // Convert image to bytes
    var bytes = await readAsBytes();

    // Encode the bytes
    final str = base64Encode(bytes);

    return str;
  }
}
