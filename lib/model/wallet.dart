class Wallet {

  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;
  int _sum;

  Wallet(this._title,  this._date, this._priority, this._sum, [this._description ]);
  Wallet.withId(this._id, this._title,  this._date, this._priority, this._sum, [this._description ]);

  int get sum => _sum;

  int get priority => _priority;

  String get date => _date;

  String get description => _description;

  String get title => _title;

  int get id => _id;

  set title(String newTitle) {
    if(newTitle.length<=255){
      _title = newTitle;
    }
  }
  set  description(String newDescription) {
    if(newDescription.length<=255){
      _title = newDescription;
    }
  }

  set priority(int newPriority){
    if(newPriority >= 1 && newPriority <= 2 ){
      this._priority =newPriority;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set sum(int newSum) {
    this._sum = newSum;
  }

// Convert a Wallet object into Map object

  Map<String,dynamic> toMap(){

    var map = Map<String,dynamic>();
    if(id !=null){
      map['id']=_id;
    }

    map['title'] =_title;
    map['description'] =_description;
    map['priority'] =_priority;
    map['date'] =_date;
    map['sum']= _sum;

    return map;

  }
// Extract a Wallet object from Map object

  Wallet.fromMapObject(Map<String,dynamic>map ){

    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority =  map['priority'] ;
    this._date =   map['date'];
    this._sum = map['sum'];
  }


}