import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/colors.dart';

class MachineVideo extends StatelessWidget {
  final String machineName;
  final List<String> machineVideo;

  const MachineVideo({super.key, required this.machineName, required this.machineVideo});
  // stateful with init state to get favorite state, add or delete from fav from icon button
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 90,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_rounded)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(machineName,style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 40),),
            ),
            SizedBox(height: 40,),
            for (var videoUrl in machineVideo)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorsManager.goldColorO1, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(videoUrl, fit: BoxFit.cover),
                  ),
                ),
              ),

            SizedBox(height: 10,),
            Row(
              children: [
                Spacer(),
                IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_rounded,size: 40,)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
