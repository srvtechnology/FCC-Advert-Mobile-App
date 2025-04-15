import 'dart:convert';

import "../client.dart";
import 'package:dio/dio.dart';

class SpaceService{

  // axiosClient
  //     .get(⁠ /spaces ⁠, {
  // params: {
  // page: currentPage,
  // limit: perPage,
  // search: searchQuery,
  // from_date: fromDate,
  // to_date: toDate,
  // agent: selectedAgent,
  // },
  // })
  Future<dynamic> get(String? page, String? limit, String? search)async{
    try{
      final response = await apiClient.get(
          "/spaces",
          params: {
            "page": page,
            "limit": limit,
            "search": search
          }
      );
      if(response.statusCode == 200 || response.statusCode ==201){
        return {
          "status": response.statusCode,
          "message": "Space Data",
          "data": response.data["data"], // Include any additional data from the response
          "last_page": response.data["last_page"],

        };
      }
      return {
        "status": response.statusCode,
        "message": response.data?["error"] ?? "Login failed. Please try again."
      };
    }on DioException catch (err) {
      String errorMessage = "An error occurred. Please check your connection and try again.";

      if (err.response != null) {
        if (err.response?.statusCode == 404) {
          // Handle 404 from Dio response
          errorMessage = "Resource not found";
          return {
            "status": 404,
            "message": errorMessage,
            "errorType": "not_found"
          };
        }
        errorMessage = err.response?.data?["message"] ??
            "Server error occurred. Please try again later.";
      } else if (err.type == DioExceptionType.connectionTimeout ||
          err.type == DioExceptionType.receiveTimeout) {
        errorMessage = "Connection timed out. Please check your internet connection.";
      } else if (err.type == DioExceptionType.connectionError) {
        errorMessage = "Network error. Please check your internet connection.";
      }

      return {
        "status": err.response?.statusCode ?? 500,
        "message": errorMessage,
        "errorDetails": err.toString()
      };
    } on Exception catch (e) {
      // Handle any other exceptions
      return {
        "status": 500,
        "message": "Unexpected error occurred. Please try again later.",
        "errorDetails": e.toString() // Optional: for debugging
      };
    }

  }

  Future<dynamic> getSpace(int id) async{
    try{
      final response = await apiClient.get(
        "/space/view/${id}",
      );
      if(response.statusCode == 200 || response.statusCode ==201){
        return {
          "status": response.statusCode,
          "message": "Space Data",
          "data": response.data // Include any additional data from the response
        };
      }
      return {
        "status": response.statusCode,
        "message": response.data?["error"] ?? "Login failed. Please try again."
      };
    }on DioException catch (err) {
      String errorMessage = "An error occurred. Please check your connection and try again.";

      if (err.response != null) {
        if (err.response?.statusCode == 404) {
          // Handle 404 from Dio response
          errorMessage = "Resource Not Found";
          return {
            "status": 404,
            "message": errorMessage,
            "errorType": "not_found"
          };
        }
        errorMessage = err.response?.data?["message"] ??
            "Server error occurred. Please try again later.";
      } else if (err.type == DioExceptionType.connectionTimeout ||
          err.type == DioExceptionType.receiveTimeout) {
        errorMessage = "Connection timed out. Please check your internet connection.";
      } else if (err.type == DioExceptionType.connectionError) {
        errorMessage = "Network error. Please check your internet connection.";
      }

      return {
        "status": err.response?.statusCode ?? 500,
        "message": errorMessage,
        "errorDetails": err.toString()
      };
    } on Exception catch (e) {
      // Handle any other exceptions
      return {
        "status": 500,
        "message": "Unexpected error occurred. Please try again later.",
        "errorDetails": e.toString() // Optional: for debugging
      };
    }
  }

  Future<dynamic> createSpace(Map<String,dynamic> data) async{
    try{
      print(data);
      var response = await apiClient.post(
          "/spaces",
          data: data
      );
      if(response.statusCode == 200 || response.statusCode ==201){
        return {
          "status": response.statusCode,
          "message": "Space Data",
          "data": response.data // Include any additional data from the response
        };
      }
      return {
        "status": response.statusCode,
        "message": response.data?["error"] ?? "Login failed. Please try again."
      };
    }on DioException catch (err) {
      String errorMessage = "An error occurred. Please check your connection and try again.";

      if (err.response != null) {
        if (err.response?.statusCode == 404) {
          // Handle 404 from Dio response
          errorMessage = "Resource Not Found";
          return {
            "status": 404,
            "message": errorMessage,
            "errorType": "not_found"
          };
        }
        errorMessage = err.response?.data?["message"] ??
            "Server error occurred. Please try again later.";
      } else if (err.type == DioExceptionType.connectionTimeout ||
          err.type == DioExceptionType.receiveTimeout) {
        errorMessage = "Connection timed out. Please check your internet connection.";
      } else if (err.type == DioExceptionType.connectionError) {
        errorMessage = "Network error. Please check your internet connection.";
      }

      return {
        "status": err.response?.statusCode ?? 500,
        "message": errorMessage,
        "errorDetails": err.toString()
      };
    } on Exception catch (e) {
      // Handle any other exceptions
      return {
        "status": 500,
        "message": "Unexpected error occurred. Please try again later.",
        "errorDetails": e.toString() // Optional: for debugging
      };
    }
  }
}