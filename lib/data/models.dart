class PersonalInfo {
  final String name;
  final String title;
  final String description;
  final String avatarPath;
  final List<String> skills;
  final ContactInfo contact;

  const PersonalInfo({
    required this.name,
    required this.title,
    required this.description,
    required this.avatarPath,
    required this.skills,
    required this.contact,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      avatarPath: json['avatarPath'] ?? '',
      skills: List<String>.from(json['skills'] ?? []),
      contact: ContactInfo.fromJson(json['contact'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'description': description,
      'avatarPath': avatarPath,
      'skills': skills,
      'contact': contact.toJson(),
    };
  }
}

class ContactInfo {
  final String email;
  final String github;
  final String linkedin;
  final String? website;
  final String? phone;

  const ContactInfo({
    required this.email,
    required this.github,
    required this.linkedin,
    this.website,
    this.phone,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      email: json['email'] ?? '',
      github: json['github'] ?? '',
      linkedin: json['linkedin'] ?? '',
      website: json['website'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'github': github,
      'linkedin': linkedin,
      'website': website,
      'phone': phone,
    };
  }
}
