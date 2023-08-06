class TaskModel{
   int ? id ;
   String ? title ;
   String? time ;
   String? date ;
   String? status ;
  TaskModel({
   required this.id,
   required this.status,
    required this.title,
    required  this.time,
    required this.date});

  TaskModel.fromJson(Map<String,dynamic> json){
    id = json["id"];
    title = json["title"];
    time = json["time"];
    date = json["date"];
    status = json["status"];
  }
}