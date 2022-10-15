class BlogDataModel {
  List<Data>? data;

  BlogDataModel({this.data});

  BlogDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? categoryId;
  String? title;
  String? subTitle;
  String? slug;
  String? description;
  Null? image;
  Null? video;
  String? date;
  String? status;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.categoryId,
      this.title,
      this.subTitle,
      this.slug,
      this.description,
      this.image,
      this.video,
      this.date,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    subTitle = json['sub_title'];
    slug = json['slug'];
    description = json['description'];
    image = json['image'];
    video = json['video'];
    date = json['date'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['image'] = this.image;
    data['video'] = this.video;
    data['date'] = this.date;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
