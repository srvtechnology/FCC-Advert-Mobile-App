import 'package:fcc_advert_mobile_app/src/components/app_bar.dart';
import 'package:fcc_advert_mobile_app/src/components/button.dart';
import 'package:fcc_advert_mobile_app/src/components/text_field.dart';
import 'package:fcc_advert_mobile_app/src/config/colors.dart';
import 'package:fcc_advert_mobile_app/src/constants/form.dart';
import 'package:fcc_advert_mobile_app/src/screens/advertisement_detail_screen.dart';
import 'package:fcc_advert_mobile_app/src/screens/multi_form.dart';
import 'package:fcc_advert_mobile_app/src/services/space_service.dart';
import 'package:fcc_advert_mobile_app/src/utils/Constants.dart';
import 'package:flutter/material.dart';

import '../utils/time.dart';

class AdvertisementListPage extends StatefulWidget {
  static String routename = "/list";
  @override
  _AdvertisementListPageState createState() => _AdvertisementListPageState();
}

class _AdvertisementListPageState extends State<AdvertisementListPage> {
  final TextEditingController _searchController = TextEditingController();
  final _scrollController = ScrollController();
  List<AdData> _ads = [];
  List<AdData> _allAds = [];
  bool _isLoading = true;
  final spaceService = SpaceService();
  late int currentPage;
  late int limit;
  String? searchId;

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    limit = 5;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent&&
          !_isLoading) {
          fetchAds();
      }
    });
    fetchAds();
  }

  Future<void> fetchAds() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await spaceService.get(
        currentPage.toString(),
        "",
        ""
      );// Replace with your API endpoint
      print(response["data"]);
      if (response["status"] == 200) {
        print("refresh");
        final List<dynamic> data = response["data"];
        if(data.length==_allAds.length){
          print("here same length");
          setState(() {
            _isLoading = false;
          });
          return;
        }
        if(currentPage != response["last_page"]){
          currentPage+=1;
          setState(() {
            _allAds.addAll(data.map((json) {
              return AdData.fromJson(json);
            }).toList());
            _ads.addAll(data.map((json) {
              return AdData.fromJson(json);
            }).toList());
            _isLoading = false;
          });
        }else{
          setState(() {
            _allAds = data.map((json) {
              return AdData.fromJson(json);
            }).toList();
            _ads = data.map((json) {
              return AdData.fromJson(json);
            }).toList();
            _isLoading = false;
          });
        }


      } else {
        throw Exception('Failed to load ads');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading ads: $e')),
      );
    }
  }

  void _filterAdsById(String query) {
    if (query.isEmpty) {
      setState(() {
        _ads = List.from(_allAds);
      });
      return;
    }

    final filtered = _allAds.where((ad) => ad.id.toString().contains(query)).toList();

    setState(() {
      _ads = filtered;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(
        isProfile: true,
      ),
      backgroundColor: AppColors.primaryBackground,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0,bottom:8.0,left: 8.0,right: 8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: CustomTextField(
                    disableLabel: true,
                    hintText: "Search space by ID",
                    onTextChanged: (value) {
                      _filterAdsById(value);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: _ads.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AdvertisementDetailPage(ads: _ads[index]),
                            ),
                          );
                        },
                        child: AdvertisementCard(ad: _ads[index]),
                      );
                    },
                  ),
                ),
                if (_isLoading)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.iconColor,
        shape: const CircleBorder(), // 👈 Ensures circle
        onPressed: () {
          Navigator.pushNamed(context, MultiForm.routename).then((_) async {
            await fetchAds();
          });
        },
        child: Icon(
          Icons.add,
          size: 30,
          color: AppColors.primaryBackground,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, );

  }
}

class AdData {
  final int id;
  final String? dataCollectionDate;
  final String? nameOfPersonCollectingData;
  final String? advertiseAgent;
  final String? contactPerson;
  final String? telephone;
  final String? email;
  final String? location;
  final String? streetRdNo;
  final String? sectionOfRd;
  final String? landmark;
  final String? gpsCoordinate;
  final String? description;
  final String? advertisementCategory;
  final String? typeOfAdvertisement;
  final String? positionOfBillboard;
  final double? length;
  final double? width;
  final double? area;
  final String? advertisementSides;
  final int? clearanceHeight;
  final String? illuminationStatus;
  final String? certifiedGeorgiaLicensed;
  final String? landownerCompany;
  final String? landownerName;
  final String? landlordStreetAddress;
  final String? landlordTelephone;
  final String? landlordEmail;
  final String? createdAt;
  final String? updatedAt;
  final int? spaceCategoryId;
  final String? otherAdvertisementSides;
  final String rate;
  final String? image1;
  final String? image2;
  final String? image3;
  final String? otherAdvertisementSidesNo;
  final String? businessName;
  final String? businessAddress;
  final String? businessContact;
  final int? createdUserId;

  final CreatedByUser? createdByUser;

  AdData({
    required this.id,
    this.dataCollectionDate,
    this.nameOfPersonCollectingData,
    this.advertiseAgent,
    this.contactPerson,
    this.telephone,
    this.email,
    this.location,
    this.streetRdNo,
    this.sectionOfRd,
    this.landmark,
    this.gpsCoordinate,
    this.description,
    this.advertisementCategory,
    this.typeOfAdvertisement,
    this.positionOfBillboard,
    this.length,
    this.width,
    this.area,
    this.advertisementSides,
    this.clearanceHeight,
    this.illuminationStatus,
    this.certifiedGeorgiaLicensed,
    this.landownerCompany,
    this.landownerName,
    this.landlordStreetAddress,
    this.landlordTelephone,
    this.landlordEmail,
    this.createdAt,
    this.updatedAt,
    this.spaceCategoryId,
    this.otherAdvertisementSides,
    required this.rate,
    this.image1,
    this.image2,
    this.image3,
    this.otherAdvertisementSidesNo,
    this.businessName,
    this.businessAddress,
    this.businessContact,
    this.createdUserId,
    this.createdByUser,
  });

  factory AdData.fromJson(Map<String, dynamic> json) {
    print(json);
    return AdData(
      id: json['id'],
      dataCollectionDate: json['data_collection_date'],
      nameOfPersonCollectingData: json['name_of_person_collection_data'],
      advertiseAgent: json['name_of_advertise_agent_company_or_person'],
      contactPerson: json['name_of_contact_person'],
      telephone: json['telephone'],
      email: json['email'],
      location: json['location'],
      streetRdNo: json['stree_rd_no'],
      sectionOfRd: json['section_of_rd'],
      landmark: json['landmark'],
      gpsCoordinate: json['gps_cordinate'],
      description: json['description_property_advertisement'],
      advertisementCategory: json['advertisement_cat_desc'],
      typeOfAdvertisement: json['type_of_advertisement'],
      positionOfBillboard: json['position_of_billboard'],
      length: tryParseDouble(json['lenght_advertise']),
      width: tryParseDouble(json['width_advertise']),
      area: tryParseDouble(json['area_advertise']),
      advertisementSides: json['no_advertisement_sides'],
      clearanceHeight: json['clearance_height_advertise'],
      illuminationStatus: json['illuminate_nonilluminate'],
      certifiedGeorgiaLicensed: json['certified_georgia_licensed'],
      landownerCompany: json['landowner_company_corporate'],
      landownerName: json['landowner_name'],
      landlordStreetAddress: json['landlord_street_address'],
      landlordTelephone: json['landlord_telephone'],
      landlordEmail: json['landlord_email'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      spaceCategoryId: json['space_cat_id'],
      otherAdvertisementSides: json['other_advertisement_sides'],
      rate: json['rate'] ?? '0',
      image1: json['image_1'],
      image2: json['image_2'],
      image3: json['image_3'],
      otherAdvertisementSidesNo: json['other_advertisement_sides_no'],
      businessName: json['business_name'],
      businessAddress: json['business_address'],
      businessContact: json['business_contact'],
      createdUserId: json['created_user_id'],
      createdByUser: json['created_by_user'] != null
          ? CreatedByUser.fromJson(json['created_by_user'])
          : null,
    );
  }
}

class CreatedByUser {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String userType;
  final String createdAt;
  final String updatedAt;
  final String? otp;

  CreatedByUser({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.userType,
    required this.createdAt,
    required this.updatedAt,
    this.otp,
  });

  factory CreatedByUser.fromJson(Map<String, dynamic> json) {
    return CreatedByUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      userType: json['user_type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      otp: json['otp'],
    );
  }
}

// Helper to safely parse double
double? tryParseDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

class AdvertisementCard extends StatelessWidget {
  final AdData ad;

  AdvertisementCard({required this.ad});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cardbg,
      margin: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child:Image.network(
              "https://fccadmin.org/server/storage/${ad.image1}",
              width: double.infinity,
              height: 100,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                print(error);
                return Image.asset('assets/banner_dummy.png',
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.fill,); // Add a placeholder image in assets
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                  child: Text(
                    'Space ID - ${ad.id}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(fontFamily: REGULAR),
                  ),
                ),
                SizedBox(height: 1,),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                  child: Text(
                    'Space Name - ${ad.landownerName}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(fontFamily: REGULAR),
                  ),
                ),

                SizedBox(height: 1,),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                  child: Text(
                    'Space Catg. - ${FormConstants.getSpaceCategoryNameById(ad.spaceCategoryId) ?? "NA"}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(fontFamily: REGULAR),
                  ),
                ),
                SizedBox(height: 1,),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                  child: Text(
                    'DOC - ${TimeUtils.getTime(ad.dataCollectionDate!) ?? "NA"}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(fontFamily: REGULAR),
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}