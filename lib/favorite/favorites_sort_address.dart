import 'favorite_adress.dart';
import 'favorites_sort.dart';

class SortAddress extends SortFavoritesSort {
  @override
  sort(List<String> currentListToSort) {
    currentListToSort.sort((b, a) {
      FavoriteAddress currFav1 = FavoriteAddress.decodedFavorite(b);
      FavoriteAddress currFav2 = FavoriteAddress.decodedFavorite(a);
      return currFav1.address.compareTo(currFav2.address);
    });
  }
  @override
  sortReversed(List<String> currentListToSort) {
    currentListToSort.sort((a, b) {
      FavoriteAddress currFav1 = FavoriteAddress.decodedFavorite(b);
      FavoriteAddress currFav2 = FavoriteAddress.decodedFavorite(a);
      return currFav1.address.compareTo(currFav2.address);
    });
  }
}
