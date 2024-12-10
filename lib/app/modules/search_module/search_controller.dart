import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../networking/api_client.dart';

class SearchscreenController extends GetxController{
RxBool isSearch = false.obs;
RxList<dynamic> productList = <dynamic>[].obs;
TextEditingController searchproductController = TextEditingController();
var searchQuery = ''.obs;
final baseUrl = 'https://eu2.contabostorage.com/eabb361130e04e0c98e8b88a22721601:bb2/';
@override
void onInit() {
  print("On init");
  super.onInit();
  fetchList();
}
void onTextChanged(String value) {
  searchQuery.value = value;
  if (value.length >= 2) {
    searchForProduct(value);
  } else if (value.isEmpty) {
    fetchList();
  }
}

void clearSearch() {
  searchproductController.clear();
  searchQuery.value = '';
  fetchList();
}
Future<void> fetchList() async {
  isSearch.value = true;

  var client = RestApiClient();

  try {
    var response = await client.getProduct();

    if (response != null && response is Map<String, dynamic>) {
      if (response['success'] == true) {
        isSearch.value = false;

        var productList = response['data'] as List<dynamic>;
        print("productList=====>${productList}");

        this.productList.clear();

        for (var product in productList) {
          if (product is Map<String, dynamic>) {
            var productName = product['title'];
            var variants = product['variants'] as List<dynamic>?;
            var rating = product['averageRating'] ?? 0.0;

            if (variants != null && variants.isNotEmpty) {
              var variant = variants[0];

              var originalPrice = variant['originalPrice'];



              
              var currentPrice = variant['currentPrice'];
              var image = variant['thumbnail'] ?? "assets/images/logo.jpg";
              var variantRank = variant['variantRank'] ?? 0;
              var imageUrl = generateImageUrl(
                  baseUrl: baseUrl,
                  imagePath: image,
              );
              print("Title==>${productName}");
              print("OriginalPrice====>${originalPrice}");
              print("OfferPrice====>${currentPrice}");
              print("Image===>${imageUrl}");
              print("Rating===>${rating}");
              print("VariantRank===>${variantRank}");

              this.productList.add({
                'title': productName,
                'originalPrice': originalPrice,
                'currentPrice': currentPrice,
                'thumbnail': image,
                'rating': rating,
                'variantRank': variantRank,
                'imageUrl':imageUrl,

              });
            }
          }
        }
      } else {
        isSearch.value = false;
        print("Request failed: ${response['message']}");
      }
    } else {
      isSearch.value = false;
      print("Response format is incorrect.");
    }
  } catch (e) {
    isSearch.value = false;
    print("Error occurred: $e");
  }
}
Future<void> searchForProduct(String query) async {
  var client = RestApiClient();

  try {
    var response = await client.searchProduct(query);

    if (response != null && response is Map<String, dynamic>) {
      if (response['success'] == true) {
        isSearch.value = false;

        var productList = response['data']['products'] as List<dynamic>;
        print("productList=====>${productList}");

        this.productList.clear();

        for (var product in productList) {
          if (product is Map<String, dynamic>) {
            var productName = product['title'];
            var variants = product['variants'] as List<dynamic>?;
            var rating = product['averageRating'] ?? 0.0;

            if (variants != null && variants.isNotEmpty) {
              var variant = variants[0];
              var originalPrice = variant['originalPrice'];
              var currentPrice = variant['currentPrice'];
              var image = variant['thumbnail'] ?? "assets/images/logo.jpg";
              var variantRank = variant['variantRank'] ?? 0;
              var imageUrl = generateImageUrl(
                baseUrl: baseUrl,
                imagePath: image,
              );
              print("Title==>${productName}");
              print("OriginalPrice====>${originalPrice}");
              print("OfferPrice====>${currentPrice}");
              print("Image===>${imageUrl}");
              print("Rating===>${rating}");
              print("VariantRank===>${variantRank}");

              this.productList.add({
                'title': productName,
                'originalPrice': originalPrice,
                'currentPrice': currentPrice,
                'thumbnail': image,
                'rating': rating,
                'variantRank': variantRank,
                'imageUrl':imageUrl,

              });
            }
          }
        }
      } else {
        isSearch.value = false;
        print("Request failed: ${response['message']}");
      }
    } else {
      isSearch.value = false;
      print("Response format is incorrect.");
    }
  } catch (e) {
    print("Error during product search: $e");
  }
}

String generateImageUrl({
  required String baseUrl,
  required String imagePath,
  int width = 256,
  int height = 318,
  int quality = 75,
  String outputFormat = 'webp',
}) {
  final encodedPath = Uri.encodeComponent('$baseUrl$imagePath');

  final imageUrl = 'https://wsrv.nl/?url=$encodedPath&width=$width&quality=$quality&height=$height&output=$outputFormat';

  return imageUrl;
}


}


