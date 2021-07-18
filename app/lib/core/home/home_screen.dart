import 'package:app/core/home/movie_sliver.dart';
import 'package:app/core/search/search_bar.dart';
import 'package:app/models/movie.dart';
import 'package:app/models/movie_repository.dart';
import 'package:app/viewmodels/auth_viewmodel.dart';
import 'package:app/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AsyncMemoizer<List<Movie>> _recommendationMemoizer;
  late final AsyncMemoizer<List<Movie>> _premiereMemoizer;

  @override
  void initState() {
    super.initState();
    _recommendationMemoizer = AsyncMemoizer();
    _premiereMemoizer = AsyncMemoizer();
  }

  @override
  Widget build(BuildContext context) {
    final authModel = context.read<AuthViewmodel>();
    final movieRepo = context.read<MovieRepository>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: NavigationDrawer(),
        body: NestedScrollView(
          // This is what enables the floating behaviour of the SliverAppBar
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverOverlapAbsorber(
                // This widget takes the overlapping behavior of the SliverAppBar,
                // and redirects it to the SliverOverlapInjector below. If it is
                // missing, then it is possible for the nested "inner" scroll view
                // below to end up under the SliverAppBar even when the inner
                // scroll view thinks it has not been scrolled.
                // This is not necessary if the "headerSliverBuilder" only builds
                // widgets that do not overlap the next sliver.
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  automaticallyImplyLeading: false,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle.light,
                  title: const Text('Página inicial'),
                  // This is the title in the app bar.
                  pinned: true,
                  floating: true,
                  expandedHeight: 150.0,
                  leading: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                      background: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SearchBar(),
                    ),
                  )),
                  actions: [
                    IconButton(
                        onPressed: authModel.signOut, icon: Icon(Icons.logout)),
                  ],
                  // The "forceElevated" property causes the SliverAppBar to show
                  // a shadow. The "innerBoxIsScrolled" parameter is true when the
                  // inner scroll view is scrolled beyond its "zero" point, i.e.
                  // when it appears to be scrolled below the SliverAppBar.
                  // Without this, there are cases where the shadow would appear
                  // or not appear inappropriately, because the SliverAppBar is
                  // not actually aware of the precise position of the inner
                  // scroll views.
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    indicatorColor: Colors.black,
                    // These are the widgets to put in each tab in the tab bar.
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.lightbulb),
                            SizedBox(width: 8.0),
                            Text('Recomendações'),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.local_movies),
                            SizedBox(width: 8.0),
                            Text('Estréias'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            // These are the contents of the tab views, below the tabs.
            children: [
              SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  // This Builder is needed to provide a BuildContext that is
                  // "inside" the NestedScrollView, so that
                  // sliverOverlapAbsorberHandleFor() can find the
                  // NestedScrollView.
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      // The "controller" and "primary" members should be left
                      // unset, so that the NestedScrollView can control this
                      // inner scroll view.
                      // If the "controller" property is set, then this scroll
                      // view will not be associated with the NestedScrollView.
                      // The PageStorageKey should be unique to this ScrollView;
                      // it allows the list to remember its scroll position when
                      // the tab view is not on the screen.
                      key: PageStorageKey<String>('Recomendações'),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          // This is the flip side of the SliverOverlapAbsorber
                          // above.
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(8.0),
                          // In this example, the inner scroll view has
                          // fixed-height list items, hence the use of
                          // SliverFixedExtentList. However, one could use any
                          // sliver widget here, e.g. SliverList or SliverGrid.
                          sliver: Builder(
                            builder: (context) {
                              final recommendations = _recommendationMemoizer
                                  .runOnce(() => movieRepo.loadRecommendations(
                                      authModel.user!.id));
                              // final movies = await moviesRepo.loadRecommendations('1');
                              return MovieSliver(
                                moviesFuture: recommendations,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  // This Builder is needed to provide a BuildContext that is
                  // "inside" the NestedScrollView, so that
                  // sliverOverlapAbsorberHandleFor() can find the
                  // NestedScrollView.
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      // The "controller" and "primary" members should be left
                      // unset, so that the NestedScrollView can control this
                      // inner scroll view.
                      // If the "controller" property is set, then this scroll
                      // view will not be associated with the NestedScrollView.
                      // The PageStorageKey should be unique to this ScrollView;
                      // it allows the list to remember its scroll position when
                      // the tab view is not on the screen.
                      key: PageStorageKey<String>('Estréias'),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          // This is the flip side of the SliverOverlapAbsorber
                          // above.
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(8.0),
                          // In this example, the inner scroll view has
                          // fixed-height list items, hence the use of
                          // SliverFixedExtentList. However, one could use any
                          // sliver widget here, e.g. SliverList or SliverGrid.
                          sliver: Builder(builder: (context) {
                            return MovieSliver(
                              moviesFuture: _premiereMemoizer.runOnce(
                                () => movieRepo.loadReleases(authModel.user!.id),
                              ),
                            );
                          }),
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
