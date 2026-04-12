class Event {
  final String name;
  final String desc;
  final String img;
  final String info;
  final List<Package> package;

  Event({
    required this.name,
    required this.desc,
    required this.img,
    required this.info,
    required this.package,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    name: json['name'],
    desc: json['desc'],
    img: json['img'],
    info: json['info'] ?? '',
    package: (json['package'] as List? ?? [])
        .map((p) => Package.fromJson(p))
        .toList(),
  );
}

class Package {
  final String title;
  final String desc;
  final double basePrice;
  final double perPerson;

  Package({
    required this.title,
    required this.desc,
    required this.basePrice,
    required this.perPerson,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    title: json['title'],
    desc: json['desc'],
    basePrice: json['basePrice'],
    perPerson: json['perPerson'],
  );
}
