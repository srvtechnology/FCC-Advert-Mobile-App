import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import './storage.dart';
import "../main.dart";

class ApiClient {
  late Dio _dio;

  String? _token;

  Map<String,dynamic>? profile;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://staging.fccadmin.org/server/api",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );

    // Add interceptors if needed
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async{
        if (_token == null) {
          _token = await localStorageService.getToken(); // Load token if not set
        }
        if (_token != null) {
          options.headers["Authorization"] = "Bearer $_token";
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) async{
        if (e.response?.statusCode == 401) {
          ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
            SnackBar(
              content: Text("Session expired. Please login again."),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
          await _handleUnauthorized();
        }
        return handler.next(e);
      },
    ));
  }

  Future<void> initializeToken() async {
    _token = await localStorageService.getToken();
  }

  // Set token dynamically and store it in local storage
  Future<void> setToken(String token) async {
    _token = token;
    await localStorageService.saveToken(token);
  }

  Future<void> setProfile(Map<String,dynamic> data) async{
    profile = data;
    await localStorageService.setProfile(data);
  }

  Future getProfile() async{
    if(profile!=null){
      return profile;
    }
    var data = await localStorageService.getProfile();
    profile = data;
    return profile;
  }

  Future isToken()async{
    var token = await localStorageService.getToken();
    if(token!=null)return true;
    return false;
  }
  // Clear token on logout
  Future<void> clearToken() async {
    _token = null;
    await localStorageService.clearToken();
    await localStorageService.clearProfile();
  }

  // GET Request
  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    return await _dio.get(endpoint, queryParameters: params);
  }

  // POST Request
  Future<Response> post(String endpoint, {dynamic data, Options? options}) async {
    return await _dio.post(endpoint, data: data, options: options);
  }

  Future<void> _handleUnauthorized() async {
    // Clear the token
    await clearToken();

    // Redirect to login page using the global navigator key
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      '/login',
          (route) => false, // Removes all previous routes
    );
  }
  // PUT Request
  Future<Response> put(String endpoint, {dynamic data}) async {
    print(endpoint);
    print(data);
    return await _dio.put(endpoint, data: data);
  }

  // DELETE Request
  Future<Response> delete(String endpoint) async {
    return await _dio.delete(endpoint);
  }
}

// Singleton instance
final apiClient = ApiClient();
