

class RosterModel {
  final bool withError;
  final String shortMessage;
  var currentPage,lastpage;
  final List<RosterResult> result;

  RosterModel({
    this.withError,
    this.currentPage,this.lastpage,
    this.result,
    this.shortMessage,
  });

  factory RosterModel.fromJson(Map<String, dynamic> json) {
    return RosterModel(
      withError: json['error'],
      shortMessage: json['message'],
       currentPage: json['current_page']??0,
        lastpage: json['last_page']??0,
      result: (json['data'] as List)
              .map((e) => RosterResult.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class RosterResult {
  var id,clientId,employeeId,status,dateTo,dateFrom;
 
  RosterSite userResult;
  // List<CommentReplies> commentReplies;
  RosterResult(
      {this.id,
      this.userResult,
     this.status,this.clientId,this.dateFrom,this.dateTo,this.employeeId
      });

  factory RosterResult.fromJson(Map<String, dynamic> json) {
    return RosterResult(
      
      userResult:
          json['site'] != null ? RosterSite.fromJson(json['site']) : null,
      id: json['id'] ?? "",
      employeeId: json['employee_id'] ?? "",
      clientId: json['client_id'] ?? "",
      dateFrom: json['date_from'] ?? "",
      dateTo: json['date_to'] ?? "",
      status: json['status'] ?? "",
      
    );
  }
}

class RosterSite {
  var id,siteName,clientName,remarks,shiftStart,shiftEnd;

  RosterSite(
      {this.id,
 
      this.clientName,this.remarks,this.shiftEnd,this.shiftStart,this.siteName});

  factory RosterSite.fromJson(Map<String, dynamic> json) {
    return RosterSite(
      
      id: json['id'] ?? "",
      siteName: json['site_name'] ?? "",
      clientName: json['client_name'] ?? "",
      remarks: json['remarks'] ?? "",
      shiftEnd: json['shift_end'] ?? "",
      shiftStart: json['shift_start'] ?? "",
      
    );
  }
}
