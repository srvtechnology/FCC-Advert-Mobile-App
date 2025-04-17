import 'dart:async';
import 'package:fcc_advert_mobile_app/src/components/app_bar.dart';
import 'package:fcc_advert_mobile_app/src/config/colors.dart';
import 'package:fcc_advert_mobile_app/src/constants/form.dart';
import 'package:fcc_advert_mobile_app/src/screens/main.dart';
import 'package:fcc_advert_mobile_app/src/utils/Constants.dart';
import 'package:fcc_advert_mobile_app/src/utils/time.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdvertisementDetailPage extends StatefulWidget {
  final AdData ads;

  AdvertisementDetailPage({super.key, required this.ads});

  @override
  State<AdvertisementDetailPage> createState() =>
      _AdvertisementDetailPageState();
}

class _AdvertisementDetailPageState extends State<AdvertisementDetailPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    setState(() {
      _isLoading = true;
    });
    if (FormConstants.spaceCategory.isEmpty) {
      await FormConstants.init();
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(isTrack: false),
      backgroundColor: AppColors.primaryBackground,
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  // Scrollable content
                  Positioned.fill(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _basicInformationSection(context, widget.ads),
                          _advertisementSection(context, widget.ads),
                          _advertisementDetailsSection(context, widget.ads),
                          _landownerDetailsSection(context, widget.ads),
                          AdImagePreview(
                            frontImage: widget.ads.image1,
                            backImage: widget.ads.image2,
                            wholeImage: widget.ads.image3,
                          ),
                          SizedBox(height: 50), // bottom spacing if needed
                        ],
                      ),
                    ),
                  ),

                  // Overlapping Track Button
                  Positioned(
                    top: 0,
                    right: 16,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        height: 25,
                        width: 120,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (widget.ads.gpsCoordinate!.isNotEmpty) {
                              List<String> parts = widget.ads.gpsCoordinate!
                                  .split(" ");
                              double latitude = double.parse(parts[0]);
                              double longitude = double.parse(parts[1]);

                              openMap(latitude, longitude);
                            }
                          },
                          label: Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                            ),
                            child: Text(
                              "Track",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: InclusiveSans_Bold,
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.iconColor,
                            foregroundColor: AppColors.primaryBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
  Future<void> openMap(double lat, double lng) async {
    try {
      final Uri url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
      );
      print(">>>>map url $url");

      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching map: $e');
      // Optional: show user-friendly feedback
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("Could not open Google Maps")),
      // );
    }
  }


  Widget _basicInformationSection(BuildContext context, AdData ad) {
    print(FormConstants.getSpaceCategoryNameById(ad.spaceCategoryId));
    return _cardLayout(
      "Basic Information",
      _buildSectionCard(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _customText("Space ID: ${ad.id}"),
            _customText(
              "Space category: ${FormConstants.getSpaceCategoryNameById(ad.spaceCategoryId) ?? "NA"}",
            ),
            _customText(
              "Data collection date: ${TimeUtils.getTime(ad.dataCollectionDate!) ?? "NA"}",
            ),
            _customText(
              "Name of the person collecting data: ${ad.nameOfPersonCollectingData ?? "NA"} ",
            ),
            _customText(
              "Advertisement agent/company: ${ad.advertiseAgent ?? "NA"}",
            ),
            _customText("Contact person: ${ad.contactPerson ?? "NA"}"),
            _customText("Telephone: ${ad.telephone ?? "NA"}"),
            _customText("Email: ${ad.email ?? "NA"}"),
            _customText("Space created by: ${ad.createdByUser!.name ?? "NA"}"),
            _customText(
              "Space created by user ID: ${ad.createdUserId ?? "NA"}",
            ),
          ],
        ),
      ),
    );
  }

  Widget _advertisementSection(BuildContext context, AdData ad) {
    return _cardLayout(
      "Advertisement Identification",
      _buildSectionCard(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _customText("Location: ${ad.location ?? "NA"}"),
            _customText("Street/Road No: ${ad.streetRdNo ?? "NA"}"),
            _customText("Section of road: ${ad.sectionOfRd ?? "NA"}"),
            _customText("Landmark: ${ad.landmark ?? "NA"}"),
            _customText("GPS Coordinate: ${ad.gpsCoordinate ?? "NA"}"),
          ],
        ),
      ),
    );
  }

  Widget _cardLayout(String title, Widget child) {
    return Padding(
      padding: const EdgeInsets.only(left:3.0,bottom: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: Light_MEDIUM,
            ),
          ),
          child,
        ],
      ),
    );
  }

  Widget _advertisementDetailsSection(BuildContext context, AdData ad) {
    return _cardLayout(
      "Advertisement Details Section",
      _buildSectionCard(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _customText("Description Property: ${ad.description ?? "NA"}"),
            _customText(
              "Advertisement Category: ${ad.advertisementCategory ?? "NA"}",
            ),
            _customText(
              "Position of Billboard: ${ad.positionOfBillboard ?? "NA"}",
            ),
            _customText("Length: ${ad.length ?? "NA"}"),
            _customText("Width: ${ad.width ?? "NA"}"),
            _customText("Area: ${ad.area ?? "NA"}"),
          ],
        ),
      ),
    );
  }

  Widget _landownerDetailsSection(BuildContext context, AdData ad) {
    return _cardLayout(
      "Landowner Details",
      _buildSectionCard(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _customText("Landowner Company: ${ad.landownerCompany ?? "NA"}"),
            _customText("Landowner Name: ${ad.landownerName ?? "NA"}"),
            _customText(
              "Landowner Street Address: ${ad.landlordStreetAddress ?? "NA"}",
            ),
            _customText("Landowner Telephone: ${ad.landlordTelephone ?? "NA"}"),
            _customText("Landowner Email: ${ad.landlordEmail ?? "NA"}"),
          ],
        ),
      ),
    );
  }

  Widget _customText(String text) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.w500, fontFamily: REGULAR),
    );
  }

  Widget _buildImageCard(String label, String imageUrl) {
    return Card(
      margin: const EdgeInsets.only(right: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Image.network(
              imageUrl,
              width: 100,
              height: 150,
              fit: BoxFit.fitHeight,
              errorBuilder:
                  (context, error, stackTrace) =>
                      Container(width: 100, height: 100, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(label, style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(Widget child) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  String labelFromIndex(int index) {
    switch (index) {
      case 0:
        return "Front view";
      case 1:
        return "Back view";
      case 2:
        return "Whole view";
      default:
        return "View ${index + 1}";
    }
  }
}

class AdImagePreview extends StatelessWidget {
  final String? frontImage;
  final String? backImage;
  final String? wholeImage;

  // Provide a default/fallback image asset or network URL
  final String fallbackImage = 'https://via.placeholder.com/150';

  const AdImagePreview({
    super.key,
    this.frontImage,
    this.backImage,
    this.wholeImage,
  });

  Widget _buildImage(BuildContext context, String? imageUrl, String label) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          child: Center(
            child: TimeoutImage(
              imageUrl: "https://fccadmin.org/server/storage/${imageUrl}" ?? "",
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Images",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildImage(context, frontImage, "Front view"),
              _buildImage(context, backImage, "Back view"),
              _buildImage(context, wholeImage, "Whole view"),
            ],
          ),
        ),
      ],
    );
  }
}

class TimeoutImage extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;

  const TimeoutImage({
    super.key,
    this.imageUrl,
    this.width = 100,
    this.height = 50,
  });

  Future<ImageProvider?> _loadImage(String? url) async {
    if (url == null || url.isEmpty) {
      // Invalid URL provided
      throw 'Invalid image URL';
    }

    final networkImage = NetworkImage(url);
    final completer = Completer<ImageProvider>();

    final imageStream = networkImage.resolve(const ImageConfiguration());
    final listener = ImageStreamListener(
      (info, _) => completer.complete(networkImage),
      onError: (error, _) => completer.completeError(error!),
    );

    imageStream.addListener(listener);

    try {
      final image = await completer.future.timeout(const Duration(seconds: 5));
      imageStream.removeListener(listener);
      return image;
    } catch (_) {
      imageStream.removeListener(listener);
      throw 'Image loading failed or timed out';
    }
  }

  void _previewImage(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: InteractiveViewer(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imageUrl!),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: FutureBuilder<ImageProvider?>(
        future: _loadImage(imageUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData) {
            return const Icon(Icons.error_outline_rounded);
          } else {
            return GestureDetector(
              onTap: () => _previewImage(context),
              child: Image(
                image: snapshot.data!,
                width: width,
                height: height,
                fit: BoxFit.fitWidth,
              ),
            );
          }
        },
      ),
    );
  }
}
