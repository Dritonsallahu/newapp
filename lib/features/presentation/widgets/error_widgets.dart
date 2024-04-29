import 'package:flutter/material.dart';
import 'package:news_app/features/presentation/providers/post_provider.dart';
import 'package:news_app/features/presentation/providers/request_network_provider.dart';
import 'package:provider/provider.dart';

showBottomModalError(context, error) {
  var r = Provider.of<PostProvider>(context,listen: false);
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 25, left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: 50,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Center(
              child: Text(error),
            ),
          ),
        );
      }).then((value) {
    r.returnFailedStatus();
  });
}
