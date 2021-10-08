class ContactItem {
  final int id;
  final String status;
  final String firstname;
  final String middlename;
  final String lastname;
  final String image;
  final String department;
  final String corporation;
  final String position;
  final String workphone;
  final String mobilephone;
  final String birthdate;
  final String mail;

  ContactItem(
      { required this.id,
        required this.status,
        required this.firstname,
        required this.middlename,
        required this.lastname,
        required this.image,
        required this.department,
        required this.corporation,
        required this.position,
        required this.workphone,
        required this.mobilephone,
        required this.birthdate,
        required this.mail});

  factory ContactItem.fromJson(Map<String, dynamic> parsedJson) {
    return new ContactItem(
      id: parsedJson['Id'],
      status: parsedJson['Status'],
      firstname: parsedJson['FirstName'],
      middlename: parsedJson['MiddleName'],
      lastname: parsedJson['LastName'],
      image: parsedJson['LastName'],
      department: parsedJson['Department'],
      corporation: parsedJson['Corporation'],
      position: parsedJson['Position'],
      workphone: parsedJson['WorkPhone'],
      mobilephone: parsedJson['MobilePhone'],
      birthdate: parsedJson['BirthDate'],
      mail: parsedJson['Mail'],
    );
  }
}

class ContactServer {
  final int countlist;
  final List<ContactItem> contacts;
  ContactServer({required this.countlist, required  this.contacts});

  factory ContactServer.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['ContactList'] as List;

    return new ContactServer(
      countlist: parsedJson['Count'],
      contacts: list.map((i) => ContactItem.fromJson(i)).toList(),
    );
  }
}

class ParamFilter {
  String fio;
  String corporation;
  String departament;
  String phone;
  String typephone;

  ParamFilter(
      {required this.fio,
       required this.corporation,
       required this.departament,
       required this.phone,
       required this.typephone});
}
