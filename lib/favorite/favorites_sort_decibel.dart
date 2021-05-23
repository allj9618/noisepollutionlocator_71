import 'favorite_adress.dart';
import 'favorites_sort.dart';

class SortDecibel extends SortFavoritesSort {
   @override
  sort(List<String> currentListToSort) {
    currentListToSort.sort((b, a) {
      FavoriteAddress currFav1 = FavoriteAddress.decodedFavorite(b);
      FavoriteAddress currFav2 = FavoriteAddress.decodedFavorite(a);
      return currFav1.decibel.compareTo(currFav2.decibel);
    });
  }

   @override
  sortReversed(List<String> currentListToSort) {
    currentListToSort.sort((a, b) {
      FavoriteAddress currFav1 = FavoriteAddress.decodedFavorite(b);
      FavoriteAddress currFav2 = FavoriteAddress.decodedFavorite(a);
      return currFav1.decibel.compareTo(currFav2.decibel);
    });
  }
}