import 'package:code_challenge/app/modules/search_module/search_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final SearchscreenController controller = Get.put(SearchscreenController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent.withOpacity(0.4),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/images/bbLogo.png",
              height: 40,
            ),
          ),
          title: Text(
            "Beauty Brands",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/images/profile.png",
                height: 40,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.pinkAccent.withOpacity(0.4)),
                ),
                child: Obx(() {
                  return TextField(
                    controller: controller.searchproductController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                      suffixIcon: controller.searchQuery.value.isNotEmpty
                          ? IconButton(
                        icon: Image.asset(
                          "assets/images/close.png",
                          height: 15,
                          width: 15,
                        ),
                        onPressed: () {
                          controller.clearSearch();
                        },
                      )
                          : null,
                    ),
                    onChanged: (value) {
                      controller.onTextChanged(value);
                    },
                  );
                }),
              ),


              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Obx(() {
                    if (controller.isSearch.value) {
                      return Center(child: CupertinoActivityIndicator(
                        radius: 24,
                        color: Colors.pinkAccent.shade400,
                      ));
                    } else {
                      var productList = controller.productList;
                      if (productList.isEmpty) {
                        return Center(
                          child: Text(
                            "No products found",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        );
                      } else {
                        return GridView.builder(
                          itemCount: productList.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.55,
                          ),
                          itemBuilder: (context, index) {
                            var product = productList[index];
                            return Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 1 / 0.99,
                                        child: Image.network(
                                          product['imageUrl'],
                                          fit: BoxFit.fill,errorBuilder: (context, error, stackTrace) {
                                            print("ERROR : $error");
                                            return Icon(Icons.error);
                                          },
                                        ),
                                      ),
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Image.asset(
                                          "assets/images/favUnselected.png",
                                          height: 25,
                                          color: Colors.pink.withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4),
                                          child: Text(
                                            product['title'] ?? "No Title",
                                            style: TextStyle(fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          "Variant : ${product['variantRank'] ??
                                              'N/A'}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,

                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          child: product['rating'] != 0.0
                                              ? Row(
                                            children: [
                                              ...List.generate(
                                                product['rating']?.toInt() ?? 0,
                                                    (ratingIndex) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 4),
                                                    child: Image.asset(
                                                      "assets/images/rating.png",
                                                      height: 20,
                                                    ),
                                                  );
                                                },
                                              ),
                                              if ((product['rating'] ?? 0) %
                                                  1 != 0)
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 4),
                                                  child: Image.asset(
                                                    "assets/images/ratingHalf.png",
                                                    height: 20,
                                                  ),
                                                ),
                                            ],
                                          )
                                              : SizedBox.shrink(),
                                        ),


                                        Row(
                                          children: [
                                            Text(
                                              "₹${product['originalPrice'] ??
                                                  '0'}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                decoration: TextDecoration
                                                    .lineThrough,
                                                color: Colors.grey,
                                              ),
                                            ),
                                           SizedBox(width: 10,),
                                            Text(
                                              "₹${product['currentPrice'] ??
                                                  '0'}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.pink,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

