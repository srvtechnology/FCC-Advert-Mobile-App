import 'package:fcc_advert_mobile_app/src/components/button.dart';
import 'package:fcc_advert_mobile_app/src/components/login_heading.dart';
import 'package:fcc_advert_mobile_app/src/components/otp_text_field.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  static String routename = "/otp";
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final List<TextEditingController> _controllers = List.generate(5, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (index) => FocusNode());

  @override
  void dispose(){
    for (var controller in _controllers){
      controller.dispose();
    }
    for (var focusNode in _focusNodes){
      focusNode.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                // Header
                Expanded(
                  flex: 4,
                    child: customHeader(
                        title: "FCC ADVERT SYSTEM",
                        resolutionText: "Data collection App"
                    )
                ),
                // OTP Input Label

                Expanded(
                  flex: 5,
                    child: Container(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                  'Enter OTP',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    'Please check your email for OTP',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),),
                          // OTP Instruction
                          Expanded(
                            flex: 2,
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.topCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  // children: List.generate(
                                  //   5,
                                  //       (index) => Container(
                                  //     width: 55.0,
                                  //     height: 45.0,
                                  //     alignment: Alignment.center,
                                  //     child: TextField(
                                  //       textAlign: TextAlign.center,
                                  //       keyboardType: TextInputType.number,
                                  //       maxLength: 1,
                                  //       decoration: InputDecoration(
                                  //         counter: Offstage(),
                                  //         enabledBorder: OutlineInputBorder(
                                  //             borderRadius: BorderRadius.circular(8.0),
                                  //             borderSide: BorderSide(color: Color(0xffF1A2F9), width: 2)
                                  //         ),
                                  //         focusedBorder: OutlineInputBorder(
                                  //             borderRadius: BorderRadius.circular(8.0),
                                  //             borderSide: BorderSide(color: Color(0xffF1A2F9), width: 2)
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  children: List.generate(5, (index) {
                                    return OTPTextField(
                                      controller: _controllers[index],
                                      focusNode: _focusNodes[index],
                                      onChanged: (value) {
                                        if (value.length == 1 && index < 4) {
                                          FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                                        }
                                      },
                                      onBackspace: () {
                                        if (index > 0) {
                                          _controllers[index - 1].selection = TextSelection.fromPosition(
                                              TextPosition(offset: _controllers[index - 1].text.length)
                                          );
                                          FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                                        }
                                      },
                                      nextFocusNode: index < 4 ? _focusNodes[index + 1] : null,
                                    );
                                  }),
                                ),
                              )
                          ),
                          Expanded(
                              flex: 8,
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.topLeft,
                                child: Column(
                                  children: [
                                    customButton(onPressed: (){}, text: "Submit"),
                                    SizedBox(height: 16.0),
                                    // Back Link
                                    Container(
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Click to go back.',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          )


                          // OTP Input Fields

                        ],
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}