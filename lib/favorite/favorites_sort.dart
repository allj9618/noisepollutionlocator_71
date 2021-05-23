import 'package:flutter/cupertino.dart';

abstract class SortFavoritesSort {

  bool _mapIsSorted = false;
  bool _ownMeasureIsSorted = false;

  initSort(List<String> mapFavList, List<String> ownMeasureFavList,
      bool selectedTabIsMap) {
    return _checkWhatListToSort(selectedTabIsMap, mapFavList, ownMeasureFavList);
  }

  _checkWhatListToSort(bool selectedTabIsMap, List<String> mapFavList, List<String> ownMeasureFavList) {
    if (selectedTabIsMap)
      return _sortOrReverse(mapFavList, selectedTabIsMap);
    else
      return _sortOrReverse(ownMeasureFavList, selectedTabIsMap);
  }

  _sortOrReverse(List<String> currentListToSort, bool _selectedTabIsMap) {
    if (_currentList(_selectedTabIsMap) == true) {
      _setSortedOrReversedFalse(_selectedTabIsMap);
      return sortReversed(currentListToSort);
    } else {
      _setSortedOrReversedTrue(_selectedTabIsMap);
      return sort(currentListToSort);
    }
  }

  @protected
  sort(List<String> currentListToSort);

  @protected
  sortReversed(List<String> currentListToSort);

  _setSortedOrReversedFalse(bool _selectedTabIsMap) {
    if (_selectedTabIsMap)
      _mapIsSorted = false;
    else
      _ownMeasureIsSorted = false;
  }

  _setSortedOrReversedTrue(bool _selectedTabIsMap) {
    if (_selectedTabIsMap)
      _mapIsSorted = true;
    else
      _ownMeasureIsSorted = true;
  }

  _currentList(bool _selectedTabIsMap) {
    if (_selectedTabIsMap)
      return _mapIsSorted;
    else
      return _ownMeasureIsSorted;
  }
}




