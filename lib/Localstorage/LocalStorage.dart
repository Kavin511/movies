import 'package:localstorage/localstorage.dart';

class WishListStorage {
  final LocalStorage storage = new LocalStorage('wishList');
  void  addWishList(value) {
   storage.setItem("wishList", value);
  }
  getWishList() {
    return storage.getItem("wishList");
  }
  getAllKeys()
  {
    return storage.getItem("key");
  }
}
