import 'package:dio/dio.dart';

import '../client.dart';

class LoginService{
  Future<dynamic> login(String email,String password) async{
    try{
      print(email);
      print(password);
      print("Login service called");
      final response = await apiClient.post("/login",data: {
        "email":email,
        "password": password
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "status": response.statusCode,
          "message": "Login Successful!",
          "data": response.data // Include any additional data from the response
        };
      }

      // Handle unexpected status codes
      return {
        "status": response.statusCode,
        "message": response.data?["error"] ?? "Login failed. Please try again."
      };
    }catch(err){
      if (err is DioException) {
        print("Dio error: ${err.message}");
        print("Dio response: ${err.response?.data}");
        print("Status code: ${err.response?.statusCode}");
        return{
          "status": 401,
          "message": err.response?.data["message"]
        };
      } else {
        print("Other error: $err");
      }
      return {
        "status": 500,
        "message": "An error occurred. Please check your connection and try again."
      };
    }
  }
  Future<dynamic> verifyOtp(String otp, String email) async{
    try{
      final response = await apiClient.post("/verify-otp",data: {
        "email":email,
        "otp": otp
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "status": response.statusCode,
          "message": "Login Successful!",
          "data": response.data // Include any additional data from the response
        };
      }

      // Handle unexpected status codes
      return {
        "status": response.statusCode,
        "message": response.data?["error"] ?? "Login failed. Please try again."
      };
    }catch(err){
      return {
        "status": 500,
        "message": "An error occurred. Please check your connection and try again."
      };
    }
  }
}