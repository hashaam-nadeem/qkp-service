class UserDataModel {
  final UserResult result;

  UserDataModel({
    this.result,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      result: UserResult.fromJson(json),
    );
  }
}

class UserResult {
  var id, name, email, status,contact,licenceNo,address,dateFrom,dateTo;

  UserResult({this.address,this.contact,this.dateFrom,this.dateTo,this.email,this.id,this.licenceNo,this.name,this.status});

  factory UserResult.fromJson(Map<String, dynamic> json) {
    return UserResult(
      id: json['id'] ?? "",
      name: json['employee_name'] ?? "",
      email: json['email'] ?? "",
      status: json['status'] ?? "",
      address: json['address'] ?? "",
      licenceNo: json['sia_liscense_no'] ?? "",
      contact: json['Contact_no'] ?? "",
      dateFrom: json['date_from'] ?? "",
      dateTo: json['date_to'] ?? "",
    );
  }
}


class Statess {
  var name;

  Statess({
    this.name,
  });

  factory Statess.fromJson(Map<String, dynamic> json) {
    return Statess(name: json['name'] ?? "");
  }
}
