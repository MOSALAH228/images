import 'package:flutter/material.dart';
import 'package:wa_photos/constants/my_colos.dart';
import 'package:wa_photos/module/photos_module.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    Key? key,
    required this.searchTextController,
    required this.itemsToDisplay,
    required this.searchedForPhotos,
    required this.photosList,
  }) : super(key: key);

  final TextEditingController searchTextController;
  final List<PhotosModuel> itemsToDisplay;
  final List<PhotosModuel> searchedForPhotos;
  final List<PhotosModuel> photosList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: searchTextController.text.isEmpty
            ? itemsToDisplay.length
            : searchedForPhotos.length,
        itemBuilder: (BuildContext context, int index) {
          final item = itemsToDisplay[index];
          return Container(
            width: double.infinity,
            margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
            padding: const EdgeInsetsDirectional.all(4),
            decoration: BoxDecoration(
              color: MyColors.myWhite,
              borderRadius: BorderRadius.circular(8),
            ),
            child: itemDetails(item, index),
          );
        },
      ),
    );
  }

  GridTile itemDetails(PhotosModuel item, int index) {
    return GridTile(
      footer: Hero(
        tag: item.id,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          color: Colors.black54,
          alignment: Alignment.bottomCenter,
          child: Text(
            searchTextController.text.isEmpty
                ? item.title
                : searchedForPhotos[index].title,
            style: TextStyle(
              height: 1.3,
              fontSize: 16,
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      child: Container(
        child: photosList[index].thumbnailUrl.isNotEmpty
            ? FadeInImage.assetNetwork(
                width: double.infinity,
                height: double.infinity,
                placeholder: "assets/images/loading.gif",
                image: searchTextController.text.isEmpty
                    ? item.thumbnailUrl
                    : searchedForPhotos[index].thumbnailUrl,
                fit: BoxFit.cover,
              )
            : Icon(
                Icons.error,
                size: 18,
              ),
      ),
      header: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          searchTextController.text.isEmpty
              ? item.albumId.toString()
              : searchedForPhotos[index].albumId.toString(),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: MyColors.myWhite,
          ),
        ),
      ),
    );
  }
}
