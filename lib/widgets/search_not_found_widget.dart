import 'package:flutter/material.dart';

import '/styles/app_colors.dart';
import '/styles/styles.dart';

class SearchNotdFoundWidget extends StatelessWidget {
  const SearchNotdFoundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.search_off,
                size: 50,
                color: AppColors.primaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'No results found,\nPlease try different keyword',
                style: bodyText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
