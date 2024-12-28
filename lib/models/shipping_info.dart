class ShippingInfo {
  final String fullName;
  final String phoneNumber;
  final String address;
  final String province;
  final String district;
  final String ward;
  final String email;
  final String? notes;

  ShippingInfo({
    required this.fullName,
    required this.phoneNumber,
    required this.address,
    required this.province,
    required this.district,
    required this.ward,
    required this.email,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'address': address,
      'province': province,
      'district': district,
      'ward': ward,
      'email': email,
      'notes': notes,
    };
  }

  @override
  String toString() {
    return 'ShippingInfo(fullName: $fullName, phoneNumber: $phoneNumber, address: $address, province: $province, district: $district, ward: $ward, email: $email, notes: $notes)';
  }
}
