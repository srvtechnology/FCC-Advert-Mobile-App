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
    OptionItem(value: "Static Billboard", name: "Static Billboard"),

    OptionItem(value: "Digital Billboard", name: "Digital Billboard"),

    OptionItem(value: "LED Billboard", name: "LED Billboard"),

    OptionItem(value: "Mobile Billboard", name: "Mobile Billboard"),

    OptionItem(value: "Bus Shelters", name: "Bus Shelters"),

    OptionItem(value: "Benches", name: "Benches"),

    OptionItem(value: "Trash Bins", name: "Trash Bins"),

    OptionItem(value: "Bus Advertising", name: "Bus Advertising"),

    OptionItem(value: "Taxi Advertising", name: "Taxi Advertising"),

    OptionItem(value: "Sidewalk Signs", name: "Sidewalk Signs"),

    OptionItem(value: "Street Art Advertising", name: "PStreet Art Advertising"),

    OptionItem(value: "Projection Advertising", name: "Projection Advertising"),

    OptionItem(value: "Building Wraps Advertising", name: "Building Wraps Advertising"),
    OptionItem(value: "Bridge and Overpass Banners", name: "Bridge and Overpass Banners"),
    OptionItem(value: "Wall Branding", name: "Wall Branding"),
    OptionItem(value: "Light Boxes", name: "Light Boxes"),
    OptionItem(value: "Roundabouts", name: "Roundabouts"),
    OptionItem(value: "Lampposts", name: "Lampposts"),
    OptionItem(value: "Wall Panels", name: "Wall Panels"),
    OptionItem(value: "Banners", name: "Banners"),
    OptionItem(value: "Totem Advertisement", name: "Totem Advertisement"),
    OptionItem(value: "Wallscapes and Murals", name: "Wallscapes and Murals"),
    OptionItem(value: "Pole Banners / Light Pole", name: "Pole Banners / Light Pole"),
    OptionItem(value: "Mall and Stadium Advertisement", name: "Mall and Stadium Advertisement"),
    OptionItem(value: "Signpost", name: "Signpost"),
    OptionItem(value: "Posters", name: "Posters"),
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


  static final List<OptionItem> agentNameList = [
    OptionItem(value: "general_agent_rate", name: "General Agent Rate"),
    OptionItem(value: "system_agent_rate", name: "System Agent Rate"),
    OptionItem(value: "corporate_agent_rate", name: "Corporate Agent Rate"),
  ];

  static Future<void> init() async {
    try {
      //please change this url sepretly...
      final spaceResponse = await apiClient.get("https://staging.fccadmin.org/server/api/space-categories");
      if (spaceResponse.statusCode == 200 || spaceResponse.statusCode == 201) {
        spaceCategory = List<OptionItem>.from(spaceResponse.data.map((e) => OptionItem(value: e["id"], name: e["name"])));
      }

      //please change this url sepretly...
      final agentResponse = await apiClient.get("https://staging.fccadmin.org/server/api/agent-list");
      if (agentResponse.statusCode == 200 || agentResponse.statusCode == 201) {
        agentList = List<OptionItem>.from(agentResponse.data.map((e) => OptionItem(value: e["id"], name: e["name"])));
        print(agentList);
      }
    } catch (e) {
      print("Failed to fetch form constants: $e");
    }
  }
  static String? getSpaceCategoryNameById(dynamic id) {
    print(spaceCategory.length);
    final match = FormConstants.spaceCategory.firstWhere(
          (option) => option.value == id,
      orElse: () => OptionItem(value: null, name: '-'),
    );
    return match.name;
  }


  static String? getAgentNameById(dynamic id) {
    final match = agentNameList.firstWhere(
          (option) => option.value == id,
      orElse: () => OptionItem(value: null, name: '-'),
    );
    return match.name;
  }

}