class Account {
  Account({
    this.accountId,
    this.title,
    this.budget,
    this.expense,
    this.balance,
    this.adjusted,
    this.createdAt,
    this.updatedAT,
    Map<String,dynamic> json,
  }){
    if(json!=null){
      fromJson(json);
    }
  }

  String accountId;
  String title;
  double budget;
  double expense;
  double balance;
  double adjusted;
  DateTime createdAt;
  DateTime updatedAT;

  void fromJson(Map<String,dynamic> json){
    accountId = json['account_id'];
    title = json['title'];
    budget = json['budget'];
    expense = json['expense'];
    balance = json['balance'];
    adjusted = json['adjusted'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAT = DateTime.parse(json['updated_at']);
  }

  Map<String,dynamic> toJson(){
    const Map<String,dynamic> map = <String,dynamic>{};
    map['account_id'] = accountId;
    map['title'] = title;
    map['budget'] = budget;
    map['expense'] = expense;
    map['balance'] = balance;
    map['adjusted'] = adjusted;
    map['created_at'] = createdAt.toString();
    map['updated_at'] = updatedAT.toString();
    return map;
  }

}
