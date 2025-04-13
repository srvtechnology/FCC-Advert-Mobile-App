import "dart:io";

import "package:dio/dio.dart";
import "package:fcc_advert_mobile_app/src/client.dart";
import "package:fcc_advert_mobile_app/src/components/app_bar.dart";
import "package:fcc_advert_mobile_app/src/components/auto_detect_button.dart";
import "package:fcc_advert_mobile_app/src/components/button.dart";
import "package:fcc_advert_mobile_app/src/components/image_upload_component.dart";
import "package:fcc_advert_mobile_app/src/components/radio_field.dart";
import "package:fcc_advert_mobile_app/src/components/text_field.dart";
import "package:fcc_advert_mobile_app/src/config/colors.dart";
import "package:fcc_advert_mobile_app/src/constants/form.dart";
import "package:fcc_advert_mobile_app/src/layouts/form_layout.dart";
import "package:fcc_advert_mobile_app/src/services/geo_service.dart";
import "package:fcc_advert_mobile_app/src/services/space_service.dart";
import "package:fcc_advert_mobile_app/src/types/form.dart";
import "package:flutter/material.dart";
import "package:geolocator/geolocator.dart";

class MultiForm extends StatefulWidget {
  static String routename = "/form";

  const MultiForm({super.key});

  @override
  State<MultiForm> createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int totalPages = 4;
  Map<String, dynamic> requestBody = {};
  double width = 0;
  double height = 0;
  String gps_coordinates = "";
  bool _isLoading = true;
  BoardImages? _boardImages;
  final spaceService = SpaceService();
  @override
  void initState(){
    super.initState();
    loadFormConstants();
  }

  Future<void> loadFormConstants() async {
    await FormConstants.init();
    setState(() {
      _isLoading = false;
    });
  }

  List buildPage1Fields(BuildContext context) {
    return [
      CustomTextField(
        label: "Space category",
        hintText: "Select Category",
        buttonType: "dropdown",
        dropdownData: FormConstants.spaceCategory,
        suffixIconInside: Icons.arrow_drop_down,
        onSuffixIconTap: (value){
          print(value);
          requestBody["space_cat_id"] = value.value;
        },
      ),
      CustomTextField(
        label: "Data collection date",
        hintText: "Enter Date",
        suffixIconInside: Icons.calendar_today,
        buttonType: "calendar",
        onSuffixIconTap: (value) {
          requestBody["data_collection_date"] = value;
        },
      ),
      CustomTextField(
        label: "Name of person collecting data",
        hintText: "Enter Name",
        onTextChanged: (value){
          requestBody["name_of_person_collection_data"] = value;
        },
      ),
      CustomTextField(
        label: "Name of advertisement company/agent/organisation",
        hintText: "Enter advertisement company/agent/organisation",
        onTextChanged: (value){
          requestBody["name_of_advertise_agent_company_or_person"] = value;
        },
      ),
      CustomTextField(
        label: "Business Name",
        hintText: "Enter Business Name",
        onTextChanged: (value){
          requestBody["name_of_contact_person"] = value;
        },
      ),
      CustomTextField(
        label: "Telephone",
        hintText: "Enter Telephone",
        onTextChanged: (value){
          requestBody["telephone"] = value;
        },
        type: TextFieldTypeEnum.number,
      ),
      CustomTextField(
        label: "Email",
        hintText: "Enter Email",
        onTextChanged: (value){
          requestBody["email"] = value;
        },
        type: TextFieldTypeEnum.email
      ),
    ];
  }
  List buildPage2Fields(BuildContext context){
    return [
      CustomTextField(
        label: "Location",
        hintText: "Enter Location",
        onTextChanged: (value){
          requestBody["location"] = value;
        },
      ),
      CustomTextField(
        label: "Street/Road No",
        hintText: "Enter Street Name",
        onTextChanged: (value){
          requestBody["stree_rd_no"] = value;
        },
      ),
      CustomTextField(
        label: "Section of road",
        hintText: "Enter Road Section",
        onTextChanged: (value){
          requestBody["section_of_rd"] = value;
        },
      ),
      CustomTextField(
        label: "Landmark",
        hintText: "Enter landmark",
        onTextChanged: (value){
          requestBody["landmark"] = value;
        },
      ),
      CustomTextField(
        label: "GPS Coordinate",
        hintText: "Enter Coordinates",
        value: gps_coordinates,
        trailingIconOutside: Icons.location_on_outlined,
        onTrailingIconTap: (value)async{
          var position = await _getLocation();
          setState(() {
            gps_coordinates = "${position["latitude"]} ${position["longitude"]}";
          });
          requestBody["gps_cordinate"]="${position["latitude"]} ${position["longitude"]}";
        },
      ),
    ];
  }
  List buildPage3Fields(BuildContext context){
    return [
      RadioField(
          propertyTypes: [
            "Private Property",
            "Right of way"
          ],
          title: "Description of property on which advertisement will be situated",
        onButtonTap: (value){
            requestBody["description_property_advertisement"] = value;
        },

      ),
      CustomTextField(
          label: "Advertisement category description",
          hintText: "Enter Description",
          onTextChanged: (value){
            requestBody["advertisement_cat_desc"] = value;
          },
      ),
      CustomTextField(
        label: "Type of Advertisement",
        hintText: "Select Type of Advertisement",
        suffixIconInside: Icons.arrow_drop_down,
        dropdownData: FormConstants.advertisementTypes,
        onSuffixIconTap: (value) {
          requestBody["type_of_advertisement"] = value.value;
        },
        buttonType: "dropdown",
      ),
      RadioField(
        propertyTypes: [
          "Free Standing",
          "Affixed",
          "Others"
        ],
        title: "Position of billboard",
        onButtonTap: (value){
          requestBody["position_of_billboard"] = value;
        },
      ),
      CustomTextField(
          label: "Advertisement width",
          hintText: "Enter Width",
        onTextChanged: (value){

            setState(() {
              width = double.parse(value);
            });
          requestBody["width_advertise"] = value;
        },
      ),
      CustomTextField(
        label: "Advertisement height",
        hintText: "Enter Height",
        onTextChanged: (value){
          setState(() {
            height = double.parse(value);
          });
          requestBody["height_advertise"] = value;
        },
      ),
      // need to change the logic for onChange here
      AdvertisementAreaInput(
          controller: TextEditingController(text:"${width * height}" ),
          onChange: (value){
            print(value);
            requestBody["area_advertise"] = value;
          },
          onAutoDetect: (){

          }),
      CustomTextField(
        label: "Number of advertisement slides",
        hintText: "Enter Number",
        dropdownData: FormConstants.advertisementNumbers,
        suffixIconInside: Icons.arrow_drop_down,
        onSuffixIconTap: (value){
          requestBody["no_advertisement_sides"] = value.value;
        },
        buttonType: "dropdown",
      ),
      CustomTextField(
        label: "Clearance Height",
        hintText: "Enter Clearance Height",
        onTextChanged: (value){
          requestBody["clearance_height_advertise"] = value;
        },
      ),
    ];
  }
  List buildPage4Fields(BuildContext context){
    return[
      CustomTextField(
        label: "Landowner Company/Corporate",
        hintText: "Enter Landowner Company/Corporate",
        onTextChanged: (value){
          requestBody["landowner_company_corporate"] = value;
        },
      ),
      CustomTextField(
        label: "Landowner Name",
        hintText: "Enter owner name",
        onTextChanged: (value){
          requestBody["landowner_name"] = value;
        },
      ),
      CustomTextField(
        label: "Landowner Street Address",
        hintText: "Enter Street Address",
        onTextChanged: (value){
          requestBody["landlord_street_address"] = value;
        },
      ),
      CustomTextField(
        label: "Landowner Telephone",
        hintText: "Enter Telephone",
        onTextChanged: (value){
          requestBody["landlord_telephone"] = value;
        },
        type: TextFieldTypeEnum.number,
      ),
      CustomTextField(
        label: "Landowner Email",
        hintText: "Enter Email",
        onTextChanged: (value){
          requestBody["landlord_email"] = value;
        },
        type: TextFieldTypeEnum.email
      ),
      AdvertisementBoardImages(onImagesChanged: (images){
        _boardImages = images;
      })

    ];
  }


  _getLocation() async {
    try {
      Position position = await getCurrentLocation();
      return {
        "latitude": position.latitude,
        "longitude": position.longitude
      };

    } catch (e) {
      print('Error: $e');
    }
  }

  List<Widget> buildFormPages(BuildContext context){
    return [
      FormLayout(
        title: "Step-1 Basic information",
        child: ListView.builder(
          itemCount: buildPage1Fields(context).length,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: buildPage1Fields(context)[index],
            );
          },
        ),
      ),
      FormLayout(
        title: "Step-2 Advertisement identification ",
        child: ListView.builder(
          itemCount: buildPage2Fields(context).length,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: buildPage2Fields(context)[index],
            );
          },
        ),
      ),
      FormLayout(
        title: "Step-3 Advertisement details ",
        child: ListView.builder(
          itemCount: buildPage3Fields(context).length,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: buildPage3Fields(context)[index],
            );
          },
        ),
      ),
      FormLayout(
        title: "Step-4 Landowner ",
        subtitle: "(If different from the applicant)",
        child: ListView.builder(
          itemCount: buildPage4Fields(context).length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: buildPage4Fields(context)[index],
            );
          },
        ),
      ),
    ];
  }

  void _goNext() {
    if (_currentPage < totalPages - 1) {
      print(requestBody);
      setState(() {
        _currentPage++;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goPrevious() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> uploadImages(int spaceId) async {

    print("here1");
    final formData = FormData();

    formData.fields.add(MapEntry('id', spaceId.toString()));
    print("here12");
    if (_boardImages!.front != null) {
      formData.files.add(MapEntry(
        'image_1',
        await MultipartFile.fromFile(_boardImages!.front!.path,
            filename: _boardImages!.front!.name),
      ));
    }
    print("here1");
    if (_boardImages!.back != null) {
      formData.files.add(MapEntry(
        'image_2',
        await MultipartFile.fromFile(_boardImages!.back!.path,
            filename: _boardImages!.back!.name),
      ));
    }
    print("here2");
    if (_boardImages!.whole != null) {
      formData.files.add(MapEntry(
        'image_3',
        await MultipartFile.fromFile(_boardImages!.whole!.path,
            filename: _boardImages!.whole!.name),
      ));
    }
    print(formData);
    try {
      final response = await apiClient.post(
        '/spacesUpadte',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      if (response.statusCode == 200) {
        print("✅ Images uploaded successfully");
      } else {
        print("⚠️ Upload failed: ${response.statusMessage}");
      }
    } catch (e) {
      print("❌ Upload error: $e");
    }
  }



  void _submit() async{
    // for (var step in form) {
    //   final key = step['key']!;
    //   formData[key] = _controllers[key]?.text ?? '';
    // }

    try{
      var response = await spaceService.createSpace(requestBody);
      if(response["data"]["id"]!=null){
        if(_boardImages==null ) {
          Navigator.pop(context);
          return;
        }
        await uploadImages(response["data"]["id"]);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Space Created Successfully"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
      return;
    }catch(err){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("err: ${err}"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }

  }
  Map<String, dynamic> formData = {
    'name': '',
    'email': '',
    'phone': '',
    'address': '',
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      backgroundColor: AppColors.primaryBackground,
      appBar: CustomAppBar(),
      body: _isLoading?Center(child: CircularProgressIndicator(),):
      LayoutBuilder(builder: (context, constraints){
        return Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(), // Disable swipe
                itemCount: buildFormPages(context).length,
                itemBuilder: (context, index) {

                  return buildFormPages(context)[index];
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              color: AppColors.primaryBackground,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  if (_currentPage > 0)
                    Flexible(child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: customButton(
                        onPressed: _goPrevious,
                        text: "Previous",
                        width: MediaQuery.of(context).size.width * 0.4 < 200
                            ? 200 // Minimum width of 200px for smaller screens
                            : MediaQuery.of(context).size.width * 0.4,
                      ),
                    )
                    ),
                  if (_currentPage < totalPages - 1)
                    Flexible(
                        child: customButton(
                          onPressed: _goNext, text: "Next",width: MediaQuery.of(context).size.width * 0.4 < 200
                            ? 200 // Minimum width of 200px for smaller screens
                            : MediaQuery.of(context).size.width * 0.4,
                        )),
                  if (_currentPage == totalPages - 1)
                    Flexible(child: customButton(onPressed: _submit, text: "Submit")),
                ],
              ),
            )
          ],
        );
      }),
    );;
  }
}
