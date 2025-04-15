import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nations_app/src/model/app_model.dart';
import 'package:nations_app/src/screen/country_info.dart';

class CountryTile extends StatelessWidget {
  final Country country;
  final TextEditingController searchController;

  const CountryTile({
    super.key,
    required this.country,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;

    return ListTile(
      leading: SizedBox(
        width: size.width* 0.12,
        height: size.height*0.05,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CachedNetworkImage(
            imageUrl: country.href!.flag,
            fit: BoxFit.cover,
            placeholder:
                (context, url) => Center(
                  child: Transform.scale(
                    scale: 0.4,
                    child: CircularProgressIndicator(),
                  ),
                ),
            errorWidget:
                (context, url, error) => Center(child: Icon(Icons.flag_circle)),
          ),
        ),
      ),
      title: Text(country.name, style: TextStyle(fontWeight: FontWeight.bold),),
      subtitle: Text(country.capital),
      onTap: () {
        
        searchController.clear();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CountryInfo(country: country),
          ),
        );
      },
    );
  }
}
