import 'package:fcc_advert_mobile_app/src/components/button.dart';
import 'package:fcc_advert_mobile_app/src/components/login_heading.dart';
import 'package:fcc_advert_mobile_app/src/config/colors.dart';
import 'package:fcc_advert_mobile_app/src/screens/otp_screen.dart';
import 'package:fcc_advert_mobile_app/src/utils/Constants.dart';
import 'package:flutter/material.dart';
import '../services/login_service.dart';
class LoginScreen extends StatefulWidget {
  static String routename = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final loginService = LoginService();

  @override
  void initState(){
    super.initState();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
  }
  @override
  void dispose(){
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.primaryBackground, // Background color as per the image
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          behavior: HitTestBehavior.opaque,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: MediaQuery.of(context).viewInsets.bottom, // only padding when keyboard is open
                  ),
                  physics: BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          Expanded(
                              flex: 4,
                              child: customHeader(
                                  title: "FCC ADVERT SYSTEM",
                                  resolutionText: "Data collection App"
                              )
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: double.infinity,
                                      child: Text(
                                        "Sign in",
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.text,
                                          fontFamily: InclusiveSans_Bold
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
                                                      fontSize: 16,
                                                      color: AppColors.text
                                                      ,fontFamily: InclusiveSans_Bold
                                                  ),
                                                ),
                                                SizedBox(height: 5,),
                                                TextField(
                                                  focusNode: _emailFocus,
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
                                                    hintStyle: TextStyle(
                                                        color: AppColors.placeholderText
                                                    ), // Light grey placeholder text
                                                  ),
                                                ),
                                                SizedBox(height: 5,),
                                                // Password field
                                                Text(
                                                  "Password",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 16,
                                                      color: AppColors.text
                                                      ,fontFamily: InclusiveSans_Bold
                                                  ),
                                                ),
                                                SizedBox(height: 5,),
                                                TextField(
                                                  focusNode: _passwordFocus,
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
                                                    hintStyle: TextStyle(
                                                        color: AppColors.placeholderText
                                                    ), // Light grey placeholder text
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
                                                  onPressed: ()async{
                                                    setState(() {
                                                      _isLoading=true;
                                                    });
                                                    if(_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                                                      ScaffoldMessenger.of(
                                                          context).showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              "Fields cannot be empty"),
                                                          backgroundColor: Colors
                                                              .red,
                                                          duration: Duration(
                                                              seconds: 2),
                                                        ),
                                                      );
                                                    }
                                                    else{
                                                      final isValidEmail = RegExp(
                                                          r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"
                                                      ).hasMatch(_emailController.text);

                                                      if(!isValidEmail){
                                                        ScaffoldMessenger.of(
                                                            context).showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                                "Email is not a valid format"),
                                                            backgroundColor: Colors
                                                                .red,
                                                            duration: Duration(
                                                                seconds: 2),
                                                          ),
                                                        );
                                                        setState(() {
                                                          _isLoading=false;
                                                        });
                                                        return;
                                                      }
                                                      var response = await loginService.login(
                                                          _emailController.text,
                                                          _passwordController.text
                                                      );
                                                      if (response["status"] == 200 || response["status"] == 201) {
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                            content: Text("OTP Sent Successfully, Please Check Email!"),
                                                            backgroundColor: Colors.green,
                                                            duration: Duration(seconds: 2),
                                                          ),
                                                        );
                                                        Navigator.pushNamed(
                                                            context,
                                                            OTPScreen.routename,
                                                            arguments: {
                                                              'email': _emailController.text
                                                            }
                                                        );
                                                      }
                                                      else {
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                            content: Text("Login Failed: ${response["message"]}"),
                                                            backgroundColor: Colors.red,
                                                            duration: Duration(seconds: 2),
                                                          ),
                                                        );
                                                      }
                                                    }
                                                    setState(() {
                                                      _isLoading=false;
                                                    });
                                                  },
                                                  text: "Submit",
                                                  child: _isLoading
                                                      ? SizedBox(
                                                    width: 24,
                                                    height: 24,
                                                    child: CircularProgressIndicator(
                                                      color: Colors.white,
                                                      strokeWidth: 2,
                                                    ),
                                                  )
                                                      : null,
                                                ),
                                                /*Container(
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
                                                )*/
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
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

        ),
      ),
    );
  }
}

