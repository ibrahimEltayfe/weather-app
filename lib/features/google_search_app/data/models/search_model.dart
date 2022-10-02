class SearchModel{
  String? title;
  String? link;
  String? description;
  Cite? cite;

  SearchModel(
      {this.title,
        this.link,
        this.description,
        this.cite});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
        title : json['title'],
        link : json['link'],
        description : json['description'],
        cite : json['cite'] != null ? Cite.fromJson(json['cite']) : null,
    );
  }
}

class Cite {
  String? domain;
  String? span;

  Cite({this.domain, this.span});

  factory Cite.fromJson(Map<String, dynamic> json) {
    return Cite(
        domain: json['domain'],
        span:   json['span']
    );
  }
}