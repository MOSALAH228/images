import 'package:flutter/material.dart';
import 'package:wa_photos/constants/my_colos.dart';
import 'package:wa_photos/module/photos_module.dart';
import 'package:wa_photos/services/photoapi.dart';
import 'package:wa_photos/widgets/item_widget.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum SortOption {
  albumId,
  title,
}

SortOption currentSortOption = SortOption.albumId;

class _MyHomePageState extends State<MyHomePage> {
  //the orignal List from photos module
  List<PhotosModuel> photosList = [];
  bool isLoading = true;

  Future<void> getData() async {
    photosList = await PhotosApi().getPhotosData();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  //varaibles that iam going to use for searching for a photo
  List<PhotosModuel> searchedForPhotos = [];
  bool isSearching = false;
  final searchTextController = TextEditingController();

  //function for seraching images using textcontroller
  void searchingForImages(String searchedPhoto) {
    searchedForPhotos = photosList
        .where((image) =>
            image.albumId.toString().toLowerCase().startsWith(searchedPhoto) ||
            image.title.toString().toLowerCase().startsWith(searchedPhoto))
        .toList();
    setState(() {
      isSearching = true;
    });
  }

  //function for Sorting images using albumid and title
  void sortImages() {
    setState(() {
      switch (currentSortOption) {
        case SortOption.albumId:
          // Sort the photos by album ID
          photosList.sort((a, b) => a.albumId.compareTo(b.albumId));
          break;
        case SortOption.title:
          // Sort the photos by photo title
          photosList.sort((a, b) => a.title.compareTo(b.title));
          break;
      }
    });
  }

  //using for pagination
  int currentPage = 1;

  int get totalPages {
    final itemsPerPage = 10;
    return (photosList.length / itemsPerPage).ceil();
  }

  @override
  Widget build(BuildContext context) {
    //varaibles that iam going to use for navigate to other pages using navigation
    final itemsPerPage = 10;
    final startIndex = (currentPage - 1) * itemsPerPage;
    final totalItems = photosList.length;

    if (startIndex >= totalItems) {
      return Center(
        child: CircularProgressIndicator(
          color: MyColors.myYellow,
        ),
      );
    }

    final endIndex = startIndex + itemsPerPage;
    final itemsToDisplay = photosList.sublist(startIndex, endIndex);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: Text(
          "Images",
          style: TextStyle(
            color: MyColors.myGrey,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            buildSearchController(),
            SizedBox(
              height: 5,
            ),
            ItemWidget(
              searchTextController: searchTextController,
              itemsToDisplay: itemsToDisplay,
              searchedForPhotos: searchedForPhotos,
              photosList: photosList,
            ),
            buildPaginationButtons(),
            buildSortingButtons(),
          ],
        ),
      ),
    );
  }

  TextField buildSearchController() {
    return TextField(
      controller: searchTextController,
      cursorColor: MyColors.myYellow,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: MyColors.myYellow,
        ),
        suffixIcon: isSearching
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isSearching = false;
                    searchTextController.clear();
                  });
                },
                icon: Icon(
                  Icons.clear,
                  color: MyColors.myYellow,
                ),
              )
            : null,
        hintText: "Search For An Image....",
        hintStyle: TextStyle(color: MyColors.myYellow, fontSize: 18),
      ),
      style: TextStyle(color: MyColors.myYellow, fontSize: 18),
      onChanged: (searchedPhoto) {
        searchingForImages(searchedPhoto);
      },
    );
  }

  Container buildPaginationButtons() {
    final isFirstPage = currentPage == 1;
    final isLastPage = currentPage == totalPages;

    return Container(
      color: MyColors.myYellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
            ),
            onPressed: isFirstPage
                ? null
                : () {
                    setState(() {
                      if (currentPage > 1) {
                        currentPage--;
                      }
                    });
                  },
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
            ),
            onPressed: isLastPage
                ? null
                : () {
                    setState(() {
                      currentPage++;
                    });
                  },
          ),
        ],
      ),
    );
  }

  DropdownButton<SortOption> buildSortingButtons() {
    return DropdownButton<SortOption>(
      style: TextStyle(
        color: MyColors.myYellow,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      iconEnabledColor: MyColors.myWhite,
      value: currentSortOption,
      onChanged: (SortOption? newValue) {
        setState(() {
          currentSortOption = newValue!;
          sortImages();
        });
      },
      items: SortOption.values.map((SortOption option) {
        String displayText;
        switch (option) {
          case SortOption.albumId:
            displayText = 'Sort with ID';
            break;
          case SortOption.title:
            displayText = 'Sort with Title';
            break;
        }
        return DropdownMenuItem<SortOption>(
          value: option,
          child: Text(displayText),
        );
      }).toList(),
    );
  }
}
