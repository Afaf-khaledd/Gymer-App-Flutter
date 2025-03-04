import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/assets.dart';
import 'package:gymer/core/utils/colors.dart';
import 'package:gymer/features/MachineRecognition/presentation/views/machineVideo.dart';

class FavCard extends StatelessWidget {
  final String machineName;
  final List<String> machineVideo;
  const FavCard({super.key, required this.machineName, required this.machineVideo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 11),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute<void>(
            builder: (BuildContext context) => MachineVideo(machineName: machineName, machineVideo: machineVideo),
          ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(11),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                spreadRadius: 1,
                offset: const Offset(0, 5),
              ),
            ],
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withOpacity(0.4),
                width: 1.6,
              ),
            ),
          ),
          child: ListTile(
            title: Text(machineName,style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 17),),
            leading: Image.asset(AssetsManager.gymMachine1),
            trailing: IconButton(onPressed: (){}, icon: Icon(Icons.favorite_rounded,color: ColorsManager.goldColorO1,)),
          ),
        ),
      ),
    );
  }
}
