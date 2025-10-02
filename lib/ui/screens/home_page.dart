import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/restaurant_list_provider.dart';
import '../../providers/theme_provider.dart';
import '../widgets/restaurant_card.dart';
import '../../providers/view_mode_provider.dart';
import '../../common/api_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final viewModeProvider = Provider.of<ViewModeProvider>(context);

    bool isDarkMode =
        themeProvider.themeMode == ThemeMode.dark ||
        (themeProvider.themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Restoran'),
        actions: [
          IconButton(
            icon: Icon(
              viewModeProvider.viewMode == ViewMode.list
                  ? Icons.grid_view
                  : Icons.view_list,
            ),
            onPressed: () {
              viewModeProvider.toggleViewMode();
            },
          ),
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Consumer<RestaurantListProvider>(
        builder: (context, provider, _) {
          final state = provider.state;
          return switch (state) {
            ApiLoading() => const Center(child: CircularProgressIndicator()),
            ApiError(:final message) => Center(child: Text(message)),
            ApiSuccess(:final data) =>
              data.isEmpty
                  ? const Center(child: Text('Tidak ada data restoran'))
                  : AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeIn,
                          ),
                          child: ScaleTransition(
                            scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOut,
                              ),
                            ),
                            child: child,
                          ),
                        );
                      },
                      child: viewModeProvider.viewMode == ViewMode.list
                          ? ListView.builder(
                              key: const ValueKey('list_view'),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return RestaurantCard(restaurant: data[index]);
                              },
                            )
                          : GridView.builder(
                              key: const ValueKey('grid_view'),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 3 / 4,
                                  ),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return RestaurantCard(restaurant: data[index]);
                              },
                            ),
                    ),
          };
        },
      ),
    );
  }
}
