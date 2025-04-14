import 'dart:async';
import 'package:fcc_advert_mobile_app/src/components/app_bar.dart';
import 'package:fcc_advert_mobile_app/src/config/colors.dart';
import 'package:fcc_advert_mobile_app/src/constants/form.dart';
import 'package:fcc_advert_mobile_app/src/screens/main.dart';
import 'package:fcc_advert_mobile_app/src/utils/time.dart';
import 'package:flutter/material.dart';

class AdvertisementDetailPage extends StatelessWidget {
  final AdData ads;

  AdvertisementDetailPage({
    super.key,
    required this.ads
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: AppColors.primaryBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _basicInformationSection(context, ads),
            _advertisementSection(context, ads),
            _advertisementDetailsSection(context, ads),
            _landownerDetailsSection(context, ads),
            AdImagePreview(
              frontImage: ads.image1,
              backImage: ads.image2,
              wholeImage: ads.image3,
            )
          ],
        ),
      ),
    );
  }


  Widget _basicInformationSection(BuildContext context, AdData ad) {
    return _cardLayout("Basic Information", _buildSectionCard(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _customText("Space ID: ${ad.id}"),
        _customText("Space category: ${FormConstants.getSpaceCategoryNameById(ad.spaceCategoryId) ?? "NA"}"),
        _customText("Data collection date: ${TimeUtils.getTime(DateTime.parse(ad.dataCollectionDate!)) ?? "NA"}"),
        _customText("Name of the person collecting data: ${ad.dataCollectionDate?? "NA"} "),
        _customText("Advertisement agent/company: ${ad.advertiseAgent?? "NA"}"),
        _customText("Contact person: ${ad.contactPerson?? "NA"}"),
        _customText("Telephone: ${ad.telephone?? "NA"}"),
        _customText("Email: ${ad.email?? "NA"}"),
        _customText("Space created by: ${ad.createdByUser!.name?? "NA"}"),
        _customText("Space created by user ID: ${ad.createdUserId?? "NA"}"),
      ],
    ),));
  }
  Widget _advertisementSection(BuildContext context, AdData ad){
    return _cardLayout("Advertisement Identification", _buildSectionCard(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _customText("Location: ${ad.location ?? "NA"}"),
            _customText("Street/Road No: ${ad.streetRdNo ?? "NA"}"),
            _customText("Section of road: ${ad.sectionOfRd ?? "NA"}"),
            _customText("Landmark: ${ad.landmark ?? "NA"}"),
            _customText("GPS Coordinate: ${ad.gpsCoordinate ?? "NA"}"),
          ],
        )
    ));
  }

  Widget _cardLayout(String title, Widget child){
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
         child
        ],
      ),
    );
  }


  Widget _advertisementDetailsSection(BuildContext context, AdData ad){
    return _cardLayout("Advertisement Details Section", _buildSectionCard(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _customText("Description Property: ${ad.description ?? "NA"}"),
            _customText("Advertisement Category: ${ad.advertisementCategory ?? "NA"}"),
            _customText("Position of Billboard: ${ad.positionOfBillboard ?? "NA"}"),
            _customText("Length: ${ad.length ?? "NA"}"),
            _customText("Width: ${ad.width ?? "NA"}"),
            _customText("Area: ${(ad.width ?? 0) * (ad.length ?? 0)}"),
          ],
        )
    ));
  }
  Widget _landownerDetailsSection(BuildContext context, AdData ad){
    return _cardLayout("Landowner Details",  _buildSectionCard(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _customText("Landowner Company: ${ad.landownerCompany ?? "NA"}"),
            _customText("Landowner Name: ${ad.landownerName ?? "NA"}"),
            _customText("Landowner Street Address: ${ad.landlordStreetAddress ?? "NA"}"),
            _customText("Landowner Telephone: ${ad.landlordTelephone ?? "NA"}"),
            _customText("Landowner Email: ${ad.landlordEmail ?? "NA"}")
          ],
        )
    ));
  }
  Widget _customText(String text){
    return Text(text, style: TextStyle(
      fontWeight: FontWeight.w500
    ),);
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
              errorBuilder: (context, error, stackTrace) =>
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

  Widget _buildImage(BuildContext context,String? imageUrl, String label) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100 ,
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
        const Text("Images", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
              _buildImage(context,frontImage, "Front view"),
              _buildImage(context,backImage, "Back view"),
              _buildImage(context,wholeImage, "Whole view"),
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
            return Image(
              image: snapshot.data!,
              width: width,
              height: height,
              fit: BoxFit.fitWidth,
            );
          }
        },
      ),
    );
  }
}


