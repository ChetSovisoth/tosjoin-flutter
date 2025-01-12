import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';

class CloudflareR2Service {
  // Access keys should be stored securely, e.g., using environment variables or a secure vault.
  final String _accessKeyId =
      '732db35ca1b8d74350dfa3b84abacecc'; // Replace with secure method
  final String _secretAccessKey =
      '8da42cba6811ed232f6f90a86be9a9a37e749d569803c99659fd54fc7dd6d331'; // Replace with secure method
  final String _endpoint =
      'https://pub-d28028f0e9f14b90a25f80f2800b14d5.r2.dev';
  // final String _bucketName = 'tosjoin';

  // Generate the signature for the request
  String _generateSignature(String stringToSign) {
    final key = utf8.encode(_secretAccessKey);
    final hmac = Hmac(sha256, key); // HMAC-SHA256
    final digest = hmac.convert(utf8.encode(stringToSign));
    return digest.toString();
  }

  // Construct the image URL
  String getImageUrl(String fileName) {
    return '$_endpoint/$fileName';
  }

  // Generate the Authorization header
  String _getAuthorizationHeader(String method, String resourcePath) {
    final now = DateTime.now().toUtc().toIso8601String();
    final stringToSign = '$method\n\n\n$now\n/$resourcePath';
    final signature = _generateSignature(stringToSign);
    return 'AWS $_accessKeyId:$signature';
  }

  // Upload a file to Cloudflare R2
  Future<bool> uploadFile(String fileName, Uint8List fileBytes,
      {String contentType = 'application/octet-stream'}) async {
    final url = Uri.parse('$_endpoint/$fileName');
    final headers = {
      'x-amz-date': DateTime.now().toUtc().toIso8601String(),
      'Authorization': _getAuthorizationHeader('PUT', fileName),
      'Content-Type': contentType,
    };

    try {
      final response = await http.put(url, headers: headers, body: fileBytes);

      if (response.statusCode == 200) {
        print('File uploaded successfully');
        return true;
      } else {
        print(
            'Failed to upload file: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error occurred while uploading the file: $e');
      return false;
    }
  }

  // Download a file from Cloudflare R2
  Future<Uint8List?> downloadFile(String fileName) async {
    final url = Uri.parse('$_endpoint/$fileName');
    final headers = {
      'x-amz-date': DateTime.now().toUtc().toIso8601String(),
      'Authorization': _getAuthorizationHeader('GET', fileName),
    };

    try {
      final response =
          await http.get(url, headers: headers).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        print('File downloaded successfully');
        return response.bodyBytes;
      } else {
        print(
            'Failed to download file: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error occurred while downloading the file: $e');
      return null;
    }
  }
}
