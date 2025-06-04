class UserModel {
  final int id;
  final String firstName;

  final String lastName;
  final String maidenName;      
  final String email;
  final String phone;
  final String image;
  final String gender;
  final int age;
  final String birthDate;      
  final Address address;
  final Company company;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.maidenName,
    required this.email,
    required this.phone,
    required this.image,
    required this.gender,
    required this.age,
    required this.birthDate,
    required this.address,
    required this.company,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      maidenName: json['maidenName'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      gender: json['gender'],
      age: json['age'],
      birthDate: json['birthDate'],  // exact key from API
      address: Address.fromJson(json['address']),
      company: Company.fromJson(json['company']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'maidenName': maidenName,
      'email': email,
      'phone': phone,
      'image': image,
      'gender': gender,
      'age': age,
      'birthDate': birthDate,
      'address': address.toJson(),
      'company': company.toJson(),
    };
  }
}

class Address {
  final String address;
  final String city;
  final String postalCode;
  final String state;

  Address({
    required this.address,
    required this.city,
    required this.postalCode,
    required this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      postalCode: json['postalCode'] ?? '',
      state: json['state'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'city': city,
      'postalCode': postalCode,
      'state': state,
    };
  }
}

class Company {
  final String name;
  final String title;

  Company({
    required this.name,
    required this.title,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'] ?? '',
      title: json['title'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
    };
  }
} 