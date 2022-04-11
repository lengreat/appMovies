// To parse this JSON data, do
//
//     final popularMovie = popularMovieFromMap(jsonString);

import 'dart:convert';
import 'models.dart';
class PopularResponse {
    PopularResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<MoviePopular> results;
    int totalPages;
    int totalResults;

    factory PopularResponse.fromJson(String str) => PopularResponse.fromMap(json.decode(str));

    //String toJson() => json.encode(toMap());

    factory PopularResponse.fromMap(Map<String, dynamic> json) => PopularResponse(
        page: json["page"],
        results: List<MoviePopular>.from(json["results"].map((x) => MoviePopular.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    /*Map<String, dynamic> toMap() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };*/
}

