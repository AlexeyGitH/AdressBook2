class PostContact {
  final String status;
  final String contact;
  final String image;
  final String department;
  final String corporation;
  final String position;
  final String workphone;
  final String mobilephone;
  final String birthdate;
  final String mail;
  PostContact(
      {this.status,
      this.contact,
      this.image,
      this.department,
      this.corporation,
      this.position,
      this.workphone,
      this.mobilephone,
      this.birthdate,
      this.mail});
  factory PostContact.fromJson(Map<String, dynamic> json) {
    return new PostContact(
      status: json['STATUS'],
      contact: json['CONTACT'],
      image: json['IMAGE'],
      department: json['DEPARTMENT'],
      corporation: json['CORPORATION'],
      position: json['POSITION'],
      workphone: json['WORKPHONE'],
      mobilephone: json['MOBILEPHONE'],
      birthdate: json['BIRTHDATE'],
      mail: json['MAIL'],
    );
  }
}
