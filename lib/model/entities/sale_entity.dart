abstract class SaleEntity {
  SaleEntity({
    this.salesPersonCode = '',
    this.salesPersonName = '',
    this.email = '',
    this.phone = '',
    this.lineManagerID = '',
    this.status = 1,
  });

  String? salesPersonCode;
  String? salesPersonName;
  String? email;
  String? phone;
  String? lineManagerID;
  int? status;
}
