class BillP {
  int? id;
  String date;
  String time;
  int status;
  double totalprice;
  int? userid;
  String? name;
  BillP({
    this.id,
    required this.date,
    required this.time,
    required this.status,
    required this.totalprice,
    this.userid,
    this.name,
  });
}
