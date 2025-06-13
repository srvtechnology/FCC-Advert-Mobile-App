import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';

class CameraToolPage extends StatefulWidget {
  final String url;

  const CameraToolPage({Key? key, required this.url}) : super(key: key);

  @override
  State<CameraToolPage> createState() => _CameraToolPageState();
}

class _CameraToolPageState extends State<CameraToolPage> {
  late InAppWebViewController _webViewController;
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    await Permission.camera.request();
    await Permission.microphone.request();
  }

  Future<void> fetchCacheData() async {
    try {
      final response = await _dio.get('https://fccadmin.org/server/api/get-cache');
      if (response.statusCode == 200) {
        final result = response.data;
        print("📦 Dio Response: $result");
         Navigator.pop(context, result);
      } else {
        print("❌ Dio error: ${response.statusCode}");
      }
    } catch (e) {
      print("❗ Dio Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Camera Tool")),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(widget.url)),
        initialSettings: InAppWebViewSettings(
          javaScriptEnabled: true,
          useHybridComposition: true,
          allowFileAccess: true,
          allowContentAccess: true,
        ),
        androidOnPermissionRequest: (controller, origin, resources) async {
          return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT,
          );
        },
        onWebViewCreated: (controller) {
          _webViewController = controller;

          controller.addJavaScriptHandler(
            handlerName: 'onImageAnalyzed',
            callback: (args) {
              final result = args[0];
              print("✅ JS Handler: height = ${result['height']}, width = ${result['width']}");
            },
          );
        },
        onConsoleMessage: (controller, message) {
          final msg = message.message;
          print("🖥️ Console Message: $msg");

          if (msg.startsWith("HEIGHT_WIDTH:")) {
            try {
              final jsonStr = msg.replaceFirst("HEIGHT_WIDTH:", "");
              final data = jsonDecode(jsonStr);
              print("📐 Parsed: Height = ${data['height']}, Width = ${data['width']}");

              // 🔁 Call GET API using Dio
              fetchCacheData();
            } catch (e) {
              print("❌ JSON parsing error: $e");
            }
          }
        },
      ),
    );
  }
}
