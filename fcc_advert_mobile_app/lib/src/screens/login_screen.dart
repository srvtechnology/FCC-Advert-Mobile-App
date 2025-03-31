import 'package:fcc_advert_mobile_app/src/components/button.dart';
import 'package:fcc_advert_mobile_app/src/components/login_heading.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String routename = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose(){
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color as per the image
      body: Center(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          padding: EdgeInsets.all(20),
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                // Title
                Expanded(
                    flex: 4,
                    child:customHeader(
                        title: "FCC ADVERT SYSTEM",
                        resolutionText: "Data collection App"
                    )
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF494949),
                              ),
                            ),
                          )),

                      // Email field
                      Expanded(
                          flex: 6,
                          child:Container(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Email Id",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      TextField(
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                          hintText: "Enter your email id", // Placeholder text inside the field
                                          border: OutlineInputBorder( // Adds a border
                                            borderRadius: BorderRadius.circular(10), // Rounded corners
                                            borderSide: BorderSide(color: Colors.grey), // Border color
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(color: Colors.grey.shade400),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(color: Colors.black, width: 2), // Black border on focus
                                          ),
                                          hintStyle: TextStyle(color: Colors.grey.shade400), // Light grey placeholder text
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      // Password field
                                      Text(
                                        "Password",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      TextField(
                                        controller: _passwordController,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          hintText: "Enter your password", // Placeholder text inside the field
                                          border: OutlineInputBorder( // Adds a border
                                            borderRadius: BorderRadius.circular(10), // Rounded corners
                                            borderSide: BorderSide(color: Colors.grey), // Border color
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(color: Colors.grey.shade400),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(color: Colors.black, width: 2), // Black border on focus
                                          ),
                                          hintStyle: TextStyle(color: Colors.grey.shade400), // Light grey placeholder text
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      customButton(
                                          onPressed: (){
                                            print(_emailController.text);
                                            print(_passwordController.text);
                                          },
                                          text: "Submit"
                                      ),
                                      Container(
                                        width: double.infinity,
                                        alignment: Alignment.topLeft,
                                        child: TextButton(
                                          onPressed: () {
                                            // Add your forgot password logic here
                                          },
                                          child: Text(
                                            "Forgot password? Click to reset.",
                                            style: TextStyle(
                                              color: Color(0xff086EF2),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                      ),

                      // Forgot password link
                    ],
                  ),
                )

                // Sign in text

              ],
            ),
          ),
        ),
      ),
    );
  }
}
