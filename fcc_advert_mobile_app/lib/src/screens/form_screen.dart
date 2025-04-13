// import 'package:fcc_advert_mobile_app/src/components/text_field.dart';
// import 'package:flutter/material.dart';
//
// class FormScreen extends StatefulWidget {
//   final List<CustomTextField> fields;
//   final VoidCallback onNext;
//   final VoidCallback onPrevious;
//   final Function(Map<String, String>) onSave; // Pass collected data
//
//   FormScreen({
//     required this.fields,
//     required this.onNext,
//     required this.onPrevious,
//     required this.onSave,
//   });
//
//   @override
//   _FormScreenState createState() => _FormScreenState();
// }
//
// class _FormScreenState extends State<FormScreen> {
//
//   // Store form data dynamically
//   Map<String, String> formData = {};
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: ListView(
//             padding: EdgeInsets.all(16),
//             children: widget.fields.map((field) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(field.label, style: TextStyle(fontSize: 16)),
//                   SizedBox(height: 8),
//                   TextFormField(
//                     controller: field.controller,
//                     decoration: InputDecoration(
//                       hintText: field.hintText,
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) => value!.isEmpty ? "Required field" : null,
//                     onSaved: (value) {
//                       formData[field.label] = value ?? "";
//                     },
//                   ),
//                   SizedBox(height: 16),
//                 ],
//               );
//             }).toList(),
//           ),
//         ),
//         // Fixed Navigation Buttons
//         // Container(
//         //   width: double.infinity,
//         //   color: Colors.white,
//         //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         //   child: Row(
//         //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //     children: [
//         //       ElevatedButton(
//         //         onPressed: widget.onPrevious,
//         //         child: Text("Previous"),
//         //       ),
//         //       ElevatedButton(
//         //         onPressed: _saveForm,
//         //         child: Text("Next"),
//         //       ),
//         //     ],
//         //   ),
//         // ),
//       ],
//     );
//   }
// }
