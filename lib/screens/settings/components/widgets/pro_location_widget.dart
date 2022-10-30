import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'package:emedDoctor/config/app_colors.dart';
import 'package:emedDoctor/widgets/custom_button.dart';

class ProLocationWidget extends StatefulWidget {
  final String? locationNameText;
  final String? addressText;
  final Function()? onTap;

  const ProLocationWidget({Key? key,
    required this.onTap,
    this.locationNameText = 'Colombo center',
    this.addressText = 'Address text',
}) : super(key: key);

  @override
  State<ProLocationWidget> createState() => _ProLocationWidgetState();
}

class _ProLocationWidgetState extends State<ProLocationWidget> {

  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        const Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(6.9271, 79.8612),
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: AppColors.primary.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// map box
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: GoogleMap(
                zoomControlsEnabled: false,
                onMapCreated: _onMapCreated,
                markers: _markers,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(6.9271, 79.8612),
                  zoom: 12,
                ),
              ),
            ),
          ),

          /// location name text
          const SizedBox(height: 16.0),
          const Text('Location name:',
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.primary,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(widget.locationNameText!,
            style: const TextStyle(
              fontSize: 15.0,
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          /// location address text
          const SizedBox(height: 16.0),
          const Text('Address:',
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.primary,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(widget.addressText!,
            style: const TextStyle(
              fontSize: 15.0,
              color: AppColors.lightBlack,
              fontWeight: FontWeight.w500,
            ),
          ),

          /// edit buuton
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.centerRight,
            child: CustomButton(
              onTap: widget.onTap,
              btnText: 'Edit',
              width: 70.0,
              height: 36.0,
              btnColor: AppColors.secondary,
              fontColor: AppColors.white,
              borderColor: AppColors.secondary,
              radius: 6.0,
            ),
          ),
        ],
      ),
    );
  }
}
