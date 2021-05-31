import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:noisepollutionlocator_71/favorite/favorite_shared_preferences.dart';
import 'package:noisepollutionlocator_71/favorite/favorite_ui.dart';
import 'package:noisepollutionlocator_71/favorite/favorites_sort_address.dart';
import 'favorite_adress.dart';
import 'package:flutter/material.dart';
import 'favorites_sort_decibel.dart';
import 'package:noisepollutionlocator_71/translations.dart';

class Favorites extends StatefulWidget {
  @override
  FavoritesState createState() => FavoritesState();
}

class FavoritesState extends State<Favorites> {
  FavoriteSharedPreferences _sharedPref;
  FavoriteUi _ui = FavoriteUi();
  SortDecibel _sortDecibel = SortDecibel();
  SortAddress _sortAddress = SortAddress();

  bool _selectedTab = true;
  List<String> _mapFavorites = <String>[];
  List<String> _ownMeasureFavorites = <String>[];

  @override
  void initState() {
    _sharedPref = FavoriteSharedPreferences(_setStateForSharedPref);
    _sharedPref.update(_mapFavorites, _ownMeasureFavorites);
    super.initState();
  }

  void _setStateForSharedPref(List<String> list, List<String> list2) {
    if (list != null) {
      setState(() => _mapFavorites = list);
    }
    if (list2 != null) {
      setState(() => _ownMeasureFavorites = list2);
    }
  }

  void removeAtList(index) {
    setState(() {
      if (_selectedTab) _mapFavorites.removeAt(index);
      if (!_selectedTab) _ownMeasureFavorites.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                elevation: 0,
                bottom: TabBar(
                  unselectedLabelColor: Colors.grey,
                  onTap: (index) {
                    if (index == 0)
                      setState(() => _selectedTab = true);
                    else
                      setState(() => _selectedTab = false);
                  },
                  indicatorColor: Colors.greenAccent,
                  tabs: [
                    Tab(icon: Icon(Icons.map)),
                    Tab(icon: Icon(Icons.mobile_screen_share_rounded)),
                  ],
                ),
              ),
            ),
            body: sortingAppbar()));
  }

  Column sortingAppbar() {
    return Column(
      children: [
        AppBar(
          title: Row(
            children: [
              IconButton(
                  icon: Icon(
                    Icons.sort_by_alpha_outlined,
                    size: 25,
                  ),
                  onPressed: () => _sortByAddress()),
              SizedBox(width: 220),
              IconButton(
                  icon: Icon(
                    Icons.sort_rounded,
                    size: 25,
                  ),
                  onPressed: () => _sortByDecibel())
            ],
          ),
        ),
        Divider(
          height: 0.8,
          color: Colors.grey,
        ),
        Flexible(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              buildList(this._mapFavorites, context),
              buildList(this._ownMeasureFavorites, context)
            ],
          ),
        ),
      ],
    );
  }

  Widget buildList(List<String> currentFavList, context) {
    return Scaffold(
        body: currentFavList.length == 0
            ? //Center(child: Text('No favorites to display'))
              Center(child: Text(Translations.of(context).text("noFavs")))
            : ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.greenAccent,
                    ),
                itemCount: currentFavList.length,
                itemBuilder: (context, index) {
                  FavoriteAddress currFav = FavoriteAddress();
                  currFav =
                      FavoriteAddress.decodedFavorite(currentFavList[index]);
                  // Use keys for slidable
                  return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: Container(
                        child: ListTile(
                          title: Row(
                            children: [
                              _ui.addressText(currFav.address),
                              Spacer(),
                              _ui.trailingDecibel(
                                  currFav.decibel, _selectedTab, context),
                              //SizedBox(
                                //width: 37,
                              //)
                            ],
                          ),
                          subtitle: _ui.locationText(currFav.location),
                        ),
                      ),
                      secondaryActions: <Widget>[
                        IconSlideAction(
                            //caption: 'Delete',
                            caption: Translations.of(context).text("delete"),
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () {
                              setState(() {
                                if (_selectedTab) _mapFavorites.removeAt(index);
                                if (!_selectedTab) {
                                  _ownMeasureFavorites.removeAt(index);
                                }
                              });
                              setState(() {
                                _sharedPref.removeFavorite(
                                    _mapFavorites, _ownMeasureFavorites);
                              });
                            })
                      ]);
                }));
  }

  void _sortByDecibel() {
    setState(() => _sortDecibel.initSort(
        _mapFavorites, _ownMeasureFavorites, _selectedTab));
    _sharedPref.setLists(_mapFavorites, _ownMeasureFavorites);
  }

  void _sortByAddress() {
    setState(() => _sortAddress.initSort(
        _mapFavorites, _ownMeasureFavorites, _selectedTab));
    _sharedPref.setLists(_mapFavorites, _ownMeasureFavorites);
  }
}
