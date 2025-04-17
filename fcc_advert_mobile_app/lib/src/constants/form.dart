import 'package:fcc_advert_mobile_app/src/client.dart';

class OptionItem {
  final dynamic value;
  final String name;

  OptionItem({
    required this.value,
    required this.name,
  });
}


class FormConstants{
  static List<OptionItem> spaceCategory=[];

  static List<OptionItem> agentList = [];


  static final List<OptionItem> advertisementTypes = [
    OptionItem(value: "Ordinary Billboards", name: "Ordinary Billboards"),
    OptionItem(value: "Digital Billboard", name: "Digital Billboard"),
    OptionItem(value: "Mobile Billboards", name: "Mobile Billboards"),
    OptionItem(value: "Indoors Billboards", name: "Indoors Billboards"),
    OptionItem(value: "Outdoor Billboards", name: "Outdoor Billboards"),
    OptionItem(value: "Wall Branding", name: "Wall Branding"),
    OptionItem(value: "Sign Post", name: "Sign Post"),
    OptionItem(value: "Posters", name: "Posters"),
    OptionItem(value: "Wallscape", name: "Wallscape"),
    OptionItem(value: "Backlit Billboard", name: "Backlit Billboard"),
    OptionItem(value: "Point of Sale", name: "Point of Sale"),
    OptionItem(value: "Retail Advertisement", name: "Retail Advertisement"),
    OptionItem(value: "Other", name: "Other"),
  ];

  static final List<OptionItem> advertisementNumbers = [
    OptionItem(value: "Single", name: "Single"),
    OptionItem(value: "Double", name: "Double"),
    OptionItem(value: "V-shaped", name: "V-shaped"),
    OptionItem(value: "Multiple message", name: "Multiple message"),
    OptionItem(value: "Wall branding", name: "Wall branding"),
    OptionItem(value: "Surface branding", name: "Surface branding"),
    OptionItem(value: "Others", name: "Others"),
  ];

  static Future<void> init() async {
    try {
      final spaceResponse = await apiClient.get("https://fccadmin.org/server/api/space-categories");
      if (spaceResponse.statusCode == 200 || spaceResponse.statusCode == 201) {
        spaceCategory = List<OptionItem>.from(spaceResponse.data.map((e) => OptionItem(value: e["id"], name: e["name"])));
      }

      final agentResponse = await apiClient.get("https://fccadmin.org/server/api/agent-list");
      if (agentResponse.statusCode == 200 || agentResponse.statusCode == 201) {
        agentList = List<OptionItem>.from(agentResponse.data.map((e) => OptionItem(value: e["id"], name: e["name"])));
      }
    } catch (e) {
      print("Failed to fetch form constants: $e");
    }
  }
  static String? getSpaceCategoryNameById(dynamic id) {
    print(spaceCategory.length);
    final match = FormConstants.spaceCategory.firstWhere(
          (option) => option.value == id,
      orElse: () => OptionItem(value: null, name: '-'), // fallback
    );
    return match.name;
  }


  static String? getAgentNameById(dynamic id) {
    final match = agentList.firstWhere(
          (option) => option.value == id,
      orElse: () => OptionItem(value: null, name: '-'),
    );
    return match.name;
  }

}