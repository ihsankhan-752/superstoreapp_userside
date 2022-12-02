import 'package:flutter/material.dart';
import 'package:superstore_app/utils/functions/functions.dart';
import 'package:superstore_app/views/home/pdt_detail_screen.dart';

class ProductModel extends StatefulWidget {
  final dynamic products;

  const ProductModel({Key? key, this.products}) : super(key: key);

  @override
  State<ProductModel> createState() => _ProductModelState();
}

class _ProductModelState extends State<ProductModel> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateToPageWithPush(
          context,
          ProductDetailScreen(
            productInfo: widget.products,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(minHeight: 100, maxHeight: 250),
                    child: Image(
                        image:
                            NetworkImage(widget.products['productImages'][0])),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 05),
                    child: Text(
                      widget.products['pdtName'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "\$ ",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              widget.products['price'].toStringAsFixed(2),
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
