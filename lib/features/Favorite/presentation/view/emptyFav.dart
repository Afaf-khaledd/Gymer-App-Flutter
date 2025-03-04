import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/assets.dart';

class EmptyFav extends StatelessWidget {
  const EmptyFav({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetsManager.favEmptyImage),
          SizedBox(height: 30,),
          Text("Looks Like You Don’t\n Have Any Favorites Yet!",style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black45,),textAlign: TextAlign.center,),
          SizedBox(height: 35,),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(AssetsManager.arrowIcon),
              SizedBox(width: 27,)
            ],
          ),
        ],
      ),
    );
  }
}
