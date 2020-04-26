import 'package:flutter/material.dart';
import 'package:providerapp/main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProviderBaseExampleSolution extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SomeModel model = Provider.of<SomeModel>(context);

    return Scaffold(
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          elevation: 4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                model.name,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                  color: Colors.black,
                ),
              ),
              Text(
                model.address,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 24,
                  height: 1.5,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              RatingWidget(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final feature in model.features)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Text(
                        feature,
                        style: TextStyle(fontSize: 22, color: Colors.grey),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SomeModel model = Provider.of<SomeModel>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        RatingBar(
          initialRating: model.rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
        SizedBox(
          width: 12,
        ),
        Text(
          model.rating.toString(),
          style: TextStyle(
            fontSize: 24,
            color: Colors.amber,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
