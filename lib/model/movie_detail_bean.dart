import 'dart:convert' show json;

///影视条目详情
class MovieDetailBean {

  bool collection;
  String current_season;
  var do_count;
  var episodes_count;
  var seasons_count;
  var collect_count;
  var comments_count;
  var photos_count;
  var ratings_count;
  var reviews_count;
  var wish_count;
  bool has_schedule;
  bool has_ticket;
  bool has_video;
  String alt;
  String douban_site;
  String id;
  String mainland_pubdate;
  String mobile_url;
  String original_title;
  String pubdate;
  String schedule_url;
  String share_url;
  String subtype;
  String summary;
  String title;
  String website;
  String year;
  List<String> aka;
  List<String> blooper_urls;
  List<Blooper> bloopers;
  List<Cast> casts;
  List<dynamic> clip_urls;
  List<dynamic> clips;
  List<String> countries;
  List<Director> directors;
  List<String> durations;
  List<String> genres;
  List<String> languages;
  List<Photo> photos;
  List<PopularComment> popular_comments;
  List<PopularReview> popular_reviews;
  List<String> pubdates;
  List<String> tags;
  List<String> trailer_urls;
  List<Blooper> trailers;
  List<dynamic> videos;
  List<Writer> writers;
  _Image images;
  Rating rating;

  MovieDetailBean.fromParams({this.collection, this.current_season, this.do_count, this.episodes_count, this.seasons_count, this.collect_count, this.comments_count, this.photos_count, this.ratings_count, this.reviews_count, this.wish_count, this.has_schedule, this.has_ticket, this.has_video, this.alt, this.douban_site, this.id, this.mainland_pubdate, this.mobile_url, this.original_title, this.pubdate, this.schedule_url, this.share_url, this.subtype, this.summary, this.title, this.website, this.year, this.aka, this.blooper_urls, this.bloopers, this.casts, this.clip_urls, this.clips, this.countries, this.directors, this.durations, this.genres, this.languages, this.photos, this.popular_comments, this.popular_reviews, this.pubdates, this.tags, this.trailer_urls, this.trailers, this.videos, this.writers, this.images, this.rating});

  factory MovieDetailBean(jsonStr) => jsonStr == null ? null : jsonStr is String ? new MovieDetailBean.fromJson(json.decode(jsonStr)) : new MovieDetailBean.fromJson(jsonStr);

  MovieDetailBean.fromJson(jsonRes) {
    collection = jsonRes['collection'];
    current_season = jsonRes['current_season'];
    do_count = jsonRes['do_count'];
    episodes_count = jsonRes['episodes_count'];
    seasons_count = jsonRes['seasons_count'];
    collect_count = jsonRes['collect_count'];
    comments_count = jsonRes['comments_count'];
    photos_count = jsonRes['photos_count'];
    ratings_count = jsonRes['ratings_count'];
    reviews_count = jsonRes['reviews_count'];
    wish_count = jsonRes['wish_count'];
    has_schedule = jsonRes['has_schedule'];
    has_ticket = jsonRes['has_ticket'];
    has_video = jsonRes['has_video'];
    alt = jsonRes['alt'];
    douban_site = jsonRes['douban_site'];
    id = jsonRes['id'];
    mainland_pubdate = jsonRes['mainland_pubdate'];
    mobile_url = jsonRes['mobile_url'];
    original_title = jsonRes['original_title'];
    pubdate = jsonRes['pubdate'];
    schedule_url = jsonRes['schedule_url'];
    share_url = jsonRes['share_url'];
    subtype = jsonRes['subtype'];
    summary = jsonRes['summary'];
    title = jsonRes['title'];
    website = jsonRes['website'];
    year = jsonRes['year'];
    aka = jsonRes['aka'] == null ? null : [];

    for (var akaItem in aka == null ? [] : jsonRes['aka']){
      aka.add(akaItem);
    }

    blooper_urls = jsonRes['blooper_urls'] == null ? null : [];

    for (var blooper_urlsItem in blooper_urls == null ? [] : jsonRes['blooper_urls']){
      blooper_urls.add(blooper_urlsItem);
    }

    bloopers = jsonRes['bloopers'] == null ? null : [];

    for (var bloopersItem in bloopers == null ? [] : jsonRes['bloopers']){
      bloopers.add(bloopersItem == null ? null : new Blooper.fromJson(bloopersItem));
    }

    casts = jsonRes['casts'] == null ? null : [];

    for (var castsItem in casts == null ? [] : jsonRes['casts']){
      casts.add(castsItem == null ? null : new Cast.fromJson(castsItem));
    }

    clip_urls = jsonRes['clip_urls'] == null ? null : [];

    for (var clip_urlsItem in clip_urls == null ? [] : jsonRes['clip_urls']){
      clip_urls.add(clip_urlsItem);
    }

    clips = jsonRes['clips'] == null ? null : [];

    for (var clipsItem in clips == null ? [] : jsonRes['clips']){
      clips.add(clipsItem);
    }

    countries = jsonRes['countries'] == null ? null : [];

    for (var countriesItem in countries == null ? [] : jsonRes['countries']){
      countries.add(countriesItem);
    }

    directors = jsonRes['directors'] == null ? null : [];

    for (var directorsItem in directors == null ? [] : jsonRes['directors']){
      directors.add(directorsItem == null ? null : new Director.fromJson(directorsItem));
    }

    durations = jsonRes['durations'] == null ? null : [];

    for (var durationsItem in durations == null ? [] : jsonRes['durations']){
      durations.add(durationsItem);
    }

    genres = jsonRes['genres'] == null ? null : [];

    for (var genresItem in genres == null ? [] : jsonRes['genres']){
      genres.add(genresItem);
    }

    languages = jsonRes['languages'] == null ? null : [];

    for (var languagesItem in languages == null ? [] : jsonRes['languages']){
      languages.add(languagesItem);
    }

    photos = jsonRes['photos'] == null ? null : [];

    for (var photosItem in photos == null ? [] : jsonRes['photos']){
      photos.add(photosItem == null ? null : new Photo.fromJson(photosItem));
    }

    popular_comments = jsonRes['popular_comments'] == null ? null : [];

    for (var popular_commentsItem in popular_comments == null ? [] : jsonRes['popular_comments']){
      popular_comments.add(popular_commentsItem == null ? null : new PopularComment.fromJson(popular_commentsItem));
    }

    popular_reviews = jsonRes['popular_reviews'] == null ? null : [];

    for (var popular_reviewsItem in popular_reviews == null ? [] : jsonRes['popular_reviews']){
      popular_reviews.add(popular_reviewsItem == null ? null : new PopularReview.fromJson(popular_reviewsItem));
    }

    pubdates = jsonRes['pubdates'] == null ? null : [];

    for (var pubdatesItem in pubdates == null ? [] : jsonRes['pubdates']){
      pubdates.add(pubdatesItem);
    }

    tags = jsonRes['tags'] == null ? null : [];

    for (var tagsItem in tags == null ? [] : jsonRes['tags']){
      tags.add(tagsItem);
    }

    trailer_urls = jsonRes['trailer_urls'] == null ? null : [];

    for (var trailer_urlsItem in trailer_urls == null ? [] : jsonRes['trailer_urls']){
      trailer_urls.add(trailer_urlsItem);
    }

    trailers = jsonRes['trailers'] == null ? null : [];

    for (var trailersItem in trailers == null ? [] : jsonRes['trailers']){
      trailers.add(trailersItem == null ? null : new Blooper.fromJson(trailersItem));
    }

    videos = jsonRes['videos'] == null ? null : [];

    for (var videosItem in videos == null ? [] : jsonRes['videos']){
      videos.add(videosItem);
    }

    writers = jsonRes['writers'] == null ? null : [];

    for (var writersItem in writers == null ? [] : jsonRes['writers']){
      writers.add(writersItem == null ? null : new Writer.fromJson(writersItem));
    }

    images = jsonRes['images'] == null ? null : new _Image.fromJson(jsonRes['images']);
    rating = jsonRes['rating'] == null ? null : new Rating.fromJson(jsonRes['rating']);
  }

  @override
  String toString() {
    return '{"collection": $collection,"current_season": ${current_season != null?'${json.encode(current_season)}':'null'},"do_count": $do_count,"episodes_count": $episodes_count,"seasons_count": $seasons_count,"collect_count": $collect_count,"comments_count": $comments_count,"photos_count": $photos_count,"ratings_count": $ratings_count,"reviews_count": $reviews_count,"wish_count": $wish_count,"has_schedule": $has_schedule,"has_ticket": $has_ticket,"has_video": $has_video,"alt": ${alt != null?'${json.encode(alt)}':'null'},"douban_site": ${douban_site != null?'${json.encode(douban_site)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"mainland_pubdate": ${mainland_pubdate != null?'${json.encode(mainland_pubdate)}':'null'},"mobile_url": ${mobile_url != null?'${json.encode(mobile_url)}':'null'},"original_title": ${original_title != null?'${json.encode(original_title)}':'null'},"pubdate": ${pubdate != null?'${json.encode(pubdate)}':'null'},"schedule_url": ${schedule_url != null?'${json.encode(schedule_url)}':'null'},"share_url": ${share_url != null?'${json.encode(share_url)}':'null'},"subtype": ${subtype != null?'${json.encode(subtype)}':'null'},"summary": ${summary != null?'${json.encode(summary)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"website": ${website != null?'${json.encode(website)}':'null'},"year": ${year != null?'${json.encode(year)}':'null'},"aka": $aka,"blooper_urls": $blooper_urls,"bloopers": $bloopers,"casts": $casts,"clip_urls": $clip_urls,"clips": $clips,"countries": $countries,"directors": $directors,"durations": $durations,"genres": $genres,"languages": $languages,"photos": $photos,"popular_comments": $popular_comments,"popular_reviews": $popular_reviews,"pubdates": $pubdates,"tags": $tags,"trailer_urls": $trailer_urls,"trailers": $trailers,"videos": $videos,"writers": $writers,"images": $images,"rating": $rating}';
  }
}

class Rating {

  var max;
  var min;
  var average;
  String stars;
  RatingDetails details;

  Rating.fromParams({this.max, this.min, this.average, this.stars, this.details});

  Rating.fromJson(jsonRes) {
    max = jsonRes['max'];
    min = jsonRes['min'];
    average = jsonRes['average'];
    stars = jsonRes['stars'];
    details = jsonRes['details'] == null ? null : new RatingDetails.fromJson(jsonRes['details']);
  }

  @override
  String toString() {
    return '{"max": $max,"min": $min,"average": $average,"stars": ${stars != null?'${json.encode(stars)}':'null'},"details": $details}';
  }
}

class RatingDetails {

  var d1;
  var d2;
  var d3;
  var d4;
  var d5;

  RatingDetails.fromParams({this.d1, this.d2, this.d3, this.d4, this.d5});

  RatingDetails.fromJson(jsonRes) {
    d1 = jsonRes['1'];
    d2 = jsonRes['2'];
    d3 = jsonRes['3'];
    d4 = jsonRes['4'];
    d5 = jsonRes['5'];
  }

  @override
  String toString() {
    return '{"1": $d1,"2": $d2,"3": $d3,"4": $d4,"5": $d5}';
  }
}

class _Image {

  String large;
  String medium;
  String small;

  _Image.fromParams({this.large, this.medium, this.small});

  _Image.fromJson(jsonRes) {
    large = jsonRes['large'];
    medium = jsonRes['medium'];
    small = jsonRes['small'];
  }

  @override
  String toString() {
    return '{"large": ${large != null?'${json.encode(large)}':'null'},"medium": ${medium != null?'${json.encode(medium)}':'null'},"small": ${small != null?'${json.encode(small)}':'null'}}';
  }
}

class Writer {

  String alt;
  String id;
  String name;
  String name_en;
  WriterAvatars avatars;

  Writer.fromParams({this.alt, this.id, this.name, this.name_en, this.avatars});

  Writer.fromJson(jsonRes) {
    alt = jsonRes['alt'];
    id = jsonRes['id'];
    name = jsonRes['name'];
    name_en = jsonRes['name_en'];
    avatars = jsonRes['avatars'] == null ? null : new WriterAvatars.fromJson(jsonRes['avatars']);
  }

  @override
  String toString() {
    return '{"alt": ${alt != null?'${json.encode(alt)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"name_en": ${name_en != null?'${json.encode(name_en)}':'null'},"avatars": $avatars}';
  }
}

class WriterAvatars {

  String large;
  String medium;
  String small;

  WriterAvatars.fromParams({this.large, this.medium, this.small});

  WriterAvatars.fromJson(jsonRes) {
    large = jsonRes['large'];
    medium = jsonRes['medium'];
    small = jsonRes['small'];
  }

  @override
  String toString() {
    return '{"large": ${large != null?'${json.encode(large)}':'null'},"medium": ${medium != null?'${json.encode(medium)}':'null'},"small": ${small != null?'${json.encode(small)}':'null'}}';
  }
}

//class Trailer {
//
//  String alt;
//  String id;
//  String medium;
//  String resource_url;
//  String small;
//  String subject_id;
//  String title;
//
//  Trailer.fromParams({this.alt, this.id, this.medium, this.resource_url, this.small, this.subject_id, this.title});
//
//  Trailer.fromJson(jsonRes) {
//    alt = jsonRes['alt'];
//    id = jsonRes['id'];
//    medium = jsonRes['medium'];
//    resource_url = jsonRes['resource_url'];
//    small = jsonRes['small'];
//    subject_id = jsonRes['subject_id'];
//    title = jsonRes['title'];
//  }
//
//  @override
//  String toString() {
//    return '{"alt": ${alt != null?'${json.encode(alt)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"medium": ${medium != null?'${json.encode(medium)}':'null'},"resource_url": ${resource_url != null?'${json.encode(resource_url)}':'null'},"small": ${small != null?'${json.encode(small)}':'null'},"subject_id": ${subject_id != null?'${json.encode(subject_id)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'}}';
//  }
//}

class PopularReview {

  String alt;
  String id;
  String subject_id;
  String summary;
  String title;
  PopularReviewAuthor author;
  PopularReviewRating rating;

  PopularReview.fromParams({this.alt, this.id, this.subject_id, this.summary, this.title, this.author, this.rating});

  PopularReview.fromJson(jsonRes) {
    alt = jsonRes['alt'];
    id = jsonRes['id'];
    subject_id = jsonRes['subject_id'];
    summary = jsonRes['summary'];
    title = jsonRes['title'];
    author = jsonRes['author'] == null ? null : new PopularReviewAuthor.fromJson(jsonRes['author']);
    rating = jsonRes['rating'] == null ? null : new PopularReviewRating.fromJson(jsonRes['rating']);
  }

  @override
  String toString() {
    return '{"alt": ${alt != null?'${json.encode(alt)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"subject_id": ${subject_id != null?'${json.encode(subject_id)}':'null'},"summary": ${summary != null?'${json.encode(summary)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"author": $author,"rating": $rating}';
  }
}

class PopularReviewRating {

  var max;
  var min;
  var value;

  PopularReviewRating.fromParams({this.max, this.min, this.value});

  PopularReviewRating.fromJson(jsonRes) {
    max = jsonRes['max'];
    min = jsonRes['min'];
    value = jsonRes['value'];
  }

  @override
  String toString() {
    return '{"max": $max,"min": $min,"value": $value}';
  }
}

class PopularReviewAuthor {

  String alt;
  String avatar;
  String id;
  String name;
  String signature;
  String uid;

  PopularReviewAuthor.fromParams({this.alt, this.avatar, this.id, this.name, this.signature, this.uid});

  PopularReviewAuthor.fromJson(jsonRes) {
    alt = jsonRes['alt'];
    avatar = jsonRes['avatar'];
    id = jsonRes['id'];
    name = jsonRes['name'];
    signature = jsonRes['signature'];
    uid = jsonRes['uid'];
  }

  @override
  String toString() {
    return '{"alt": ${alt != null?'${json.encode(alt)}':'null'},"avatar": ${avatar != null?'${json.encode(avatar)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"signature": ${signature != null?'${json.encode(signature)}':'null'},"uid": ${uid != null?'${json.encode(uid)}':'null'}}';
  }
}

class PopularComment {

  var useful_count;
  String content;
  String created_at;
  String id;
  String subject_id;
  PopularCommentAuthor author;
  PopularCommentRating rating;

  PopularComment.fromParams({this.useful_count, this.content, this.created_at, this.id, this.subject_id, this.author, this.rating});

  PopularComment.fromJson(jsonRes) {
    useful_count = jsonRes['useful_count'];
    content = jsonRes['content'];
    created_at = jsonRes['created_at'];
    id = jsonRes['id'];
    subject_id = jsonRes['subject_id'];
    author = jsonRes['author'] == null ? null : new PopularCommentAuthor.fromJson(jsonRes['author']);
    rating = jsonRes['rating'] == null ? null : new PopularCommentRating.fromJson(jsonRes['rating']);
  }

  @override
  String toString() {
    return '{"useful_count": $useful_count,"content": ${content != null?'${json.encode(content)}':'null'},"created_at": ${created_at != null?'${json.encode(created_at)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"subject_id": ${subject_id != null?'${json.encode(subject_id)}':'null'},"author": $author,"rating": $rating}';
  }
}

class PopularCommentRating {

  var max;
  var min;
  var value;

  PopularCommentRating.fromParams({this.max, this.min, this.value});

  PopularCommentRating.fromJson(jsonRes) {
    max = jsonRes['max'];
    min = jsonRes['min'];
    value = jsonRes['value'];
  }

  @override
  String toString() {
    return '{"max": $max,"min": $min,"value": $value}';
  }
}

class PopularCommentAuthor {

  String alt;
  String avatar;
  String id;
  String name;
  String signature;
  String uid;

  PopularCommentAuthor.fromParams({this.alt, this.avatar, this.id, this.name, this.signature, this.uid});

  PopularCommentAuthor.fromJson(jsonRes) {
    alt = jsonRes['alt'];
    avatar = jsonRes['avatar'];
    id = jsonRes['id'];
    name = jsonRes['name'];
    signature = jsonRes['signature'];
    uid = jsonRes['uid'];
  }

  @override
  String toString() {
    return '{"alt": ${alt != null?'${json.encode(alt)}':'null'},"avatar": ${avatar != null?'${json.encode(avatar)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"signature": ${signature != null?'${json.encode(signature)}':'null'},"uid": ${uid != null?'${json.encode(uid)}':'null'}}';
  }
}

class Photo {

  String alt;
  String cover;
  String icon;
  String id;
  String image;
  String thumb;

  Photo.fromParams({this.alt, this.cover, this.icon, this.id, this.image, this.thumb});

  Photo.fromJson(jsonRes) {
    alt = jsonRes['alt'];
    cover = jsonRes['cover'];
    icon = jsonRes['icon'];
    id = jsonRes['id'];
    image = jsonRes['image'];
    thumb = jsonRes['thumb'];
  }

  @override
  String toString() {
    return '{"alt": ${alt != null?'${json.encode(alt)}':'null'},"cover": ${cover != null?'${json.encode(cover)}':'null'},"icon": ${icon != null?'${json.encode(icon)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"image": ${image != null?'${json.encode(image)}':'null'},"thumb": ${thumb != null?'${json.encode(thumb)}':'null'}}';
  }
}

class Director {

  String alt;
  String id;
  String name;
  String name_en;
  DirectorAvatars avatars;

  Director.fromParams({this.alt, this.id, this.name, this.name_en, this.avatars});

  Director.fromJson(jsonRes) {
    alt = jsonRes['alt'];
    id = jsonRes['id'];
    name = jsonRes['name'];
    name_en = jsonRes['name_en'];
    avatars = jsonRes['avatars'] == null ? null : new DirectorAvatars.fromJson(jsonRes['avatars']);
  }

  @override
  String toString() {
    return '{"alt": ${alt != null?'${json.encode(alt)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"name_en": ${name_en != null?'${json.encode(name_en)}':'null'},"avatars": $avatars}';
  }
}

class DirectorAvatars {

  String large;
  String medium;
  String small;

  DirectorAvatars.fromParams({this.large, this.medium, this.small});

  DirectorAvatars.fromJson(jsonRes) {
    large = jsonRes['large'];
    medium = jsonRes['medium'];
    small = jsonRes['small'];
  }

  @override
  String toString() {
    return '{"large": ${large != null?'${json.encode(large)}':'null'},"medium": ${medium != null?'${json.encode(medium)}':'null'},"small": ${small != null?'${json.encode(small)}':'null'}}';
  }
}

class Cast {

  String alt;
  String id;
  String name;
  String name_en;
  CastAvatars avatars;

  Cast.fromParams({this.alt, this.id, this.name, this.name_en, this.avatars});

  Cast.fromJson(jsonRes) {
    alt = jsonRes['alt'];
    id = jsonRes['id'];
    name = jsonRes['name'];
    name_en = jsonRes['name_en'];
    avatars = jsonRes['avatars'] == null ? null : new CastAvatars.fromJson(jsonRes['avatars']);
  }

  @override
  String toString() {
    return '{"alt": ${alt != null?'${json.encode(alt)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"name_en": ${name_en != null?'${json.encode(name_en)}':'null'},"avatars": $avatars}';
  }
}

class CastAvatars {

  String large;
  String medium;
  String small;

  CastAvatars.fromParams({this.large, this.medium, this.small});

  CastAvatars.fromJson(jsonRes) {
    large = jsonRes['large'];
    medium = jsonRes['medium'];
    small = jsonRes['small'];
  }

  @override
  String toString() {
    return '{"large": ${large != null?'${json.encode(large)}':'null'},"medium": ${medium != null?'${json.encode(medium)}':'null'},"small": ${small != null?'${json.encode(small)}':'null'}}';
  }
}

class Blooper {

  String alt;
  String id;
  String medium;
  String resource_url;
  String small;
  String subject_id;
  String title;

  Blooper.fromParams({this.alt, this.id, this.medium, this.resource_url, this.small, this.subject_id, this.title});

  Blooper.fromJson(jsonRes) {
    alt = jsonRes['alt'];
    id = jsonRes['id'];
    medium = jsonRes['medium'];
    resource_url = jsonRes['resource_url'];
    small = jsonRes['small'];
    subject_id = jsonRes['subject_id'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"alt": ${alt != null?'${json.encode(alt)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"medium": ${medium != null?'${json.encode(medium)}':'null'},"resource_url": ${resource_url != null?'${json.encode(resource_url)}':'null'},"small": ${small != null?'${json.encode(small)}':'null'},"subject_id": ${subject_id != null?'${json.encode(subject_id)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'}}';
  }
}
