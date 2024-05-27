import '../global/global.dart';

class CartMethods {


  separateItemIDsFromUserCartList() {
    //separate ID from Cart user
    List<String>? userCartList = sharedPreferences!.getStringList("userCard");
    print(
        "-------------------user cart List: $userCartList  -------------------");
    List<String> itemIdList = [];
    for (int i = 1; i < userCartList!.length; i++) {
      String item = userCartList[i]; //2414141484:3
      var lastCharacterPositionBeforeColon =
          item.lastIndexOf(":"); //postion of ":"

      //separate ID
      String getItemID =
          item.substring(0, lastCharacterPositionBeforeColon); //2414141484
      itemIdList.add(getItemID);
    }
    print("-------------------user id List: $itemIdList  -------------------");
    return itemIdList;
  }

  separateItemsQuantitiesFromUserCartList() {
    //separate ID from Cart user
    List<String>? userCartList = sharedPreferences!.getStringList("userCard");
    print(
        "-------------------user cart List: $userCartList  -------------------");
    List<int> itemQuantitiesList = [];
    for (int i = 1; i < userCartList!.length; i++) {
      String item = userCartList[i]; //2414141484:3
      var colonAndAfterCharacters = item.split(":").toList(); //[:,5]
      int quantitiyNumber = int.parse(colonAndAfterCharacters[1]); //5

      itemQuantitiesList.add(quantitiyNumber);
    }
    print(
        "-------------------count item List: $itemQuantitiesList  -------------------");
    return itemQuantitiesList;
  }

  separateOrderIDs(List productIDs) {
    //separate ID from Cart user
    List<String>? userCartList = List<String>.from(productIDs);
    print(
        "-------------------user cart List: $userCartList  -------------------");
    List<String> itemIdList = [];
    for (int i = 1; i < userCartList.length; i++) {
      String item = userCartList[i]; //2414141484:3
      var lastCharacterPositionBeforeColon =
          item.lastIndexOf(":"); //postion of ":"

      //separate ID
      String getItemID =
          item.substring(0, lastCharacterPositionBeforeColon); //2414141484
      itemIdList.add(getItemID);
    }
    print("-------------------user id List: $itemIdList  -------------------");
    return itemIdList;
  }

  separateordersQuantities(productIDs) {
    //separate ID from Cart user
    List<String>? userCartList = List<String>.from(productIDs);
    print(
        "-------------------user cart List: $userCartList  -------------------");
    List<String> itemQuantitiesList = [];
    for (int i = 1; i < userCartList.length; i++) {
      String item = userCartList[i].toString(); //2414141484:3
      var colonAndAfterCharacters = item.split(":").toList(); //[:,5]
      int quantitiyNumber = int.parse(colonAndAfterCharacters[1].toString()); //5

      itemQuantitiesList.add(quantitiyNumber.toString());
    }
    print(
        "-------------------count item List: $itemQuantitiesList  -------------------");
    return itemQuantitiesList;
  }
}
