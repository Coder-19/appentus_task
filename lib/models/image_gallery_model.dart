// the code below is used to create a class to get the properties for
// displaying the data in the image gallery screen
class ImageGalleryModel{
  // the proeprty below is used to get the author name
  String? authorName;

  // the proeprty below is used to get the image path
  String? imagePath;

  // the proeprty below is used to get the height of the image
  int? height;

  // the property below is used to get the width of the image
  int? width;

  // initializing the above properties using the dart constructor
  ImageGalleryModel({
    this.imagePath,
    this.authorName,
    this.width,
    this.height,
});

  //the code below is used to create a factory method to convert the json
  // from the api to dart objects
  factory ImageGalleryModel.fromJSON(Map<String,dynamic> json){
    return ImageGalleryModel(
      imagePath: json['download_url'],
      authorName: json['author'],
      width: json['width'],
      height: json['height'],
    );
  }
}