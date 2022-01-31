import 'dart:convert';

class Job {
  String title;
  String company;
  String location;
  String description;
  String link;
  String logo;
  Job({
    required this.title,
    required this.company,
    required this.location,
    required this.description,
    required this.link,
    required this.logo,
  });

  Job copyWith({
    String? title,
    String? company,
    String? location,
    String? description,
    String? link,
    String? logo,
  }) {
    return Job(
      title: title ?? this.title,
      company: company ?? this.company,
      location: location ?? this.location,
      description: description ?? this.description,
      link: link ?? this.link,
      logo: logo ?? this.logo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'company': company,
      'location': location,
      'description': description,
      'link': link,
      'logo': logo,
    };
  }

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      title: map['title'] ?? '',
      company: map['company'] ?? '',
      location: map['location'] ?? '',
      description: map['description'] ?? '',
      link: map['link'] ?? '',
      logo: map['logo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Job.fromJson(String source) => Job.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Job(title: $title, company: $company, location: $location, description: $description, link: $link, logo: $logo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Job &&
        other.title == title &&
        other.company == company &&
        other.location == location &&
        other.description == description &&
        other.link == link &&
        other.logo == logo;
  }

  @override
  int get hashCode {
    return title.hashCode ^ company.hashCode ^ location.hashCode ^ description.hashCode ^ link.hashCode ^ logo.hashCode;
  }
}
