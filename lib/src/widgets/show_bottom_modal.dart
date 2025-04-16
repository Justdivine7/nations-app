import 'package:flutter/material.dart';
import 'package:nations_app/src/widgets/lists.dart';

class ShowBottomModal extends StatelessWidget {
  final void Function(String continent)? onContinentSelected;
  final void Function(Map<String, int> populationRange)?
  onPopulationRangeSelected;
  final void Function(Map<String, String> sizeRange)? onSizeRangeSelected;
  const ShowBottomModal({
    super.key,
    this.onContinentSelected,
    this.onPopulationRangeSelected,
    this.onSizeRangeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          showDragHandle: true,
          enableDrag: true,
          // backgroundColor: ,
          isScrollControlled: true,
          context: context,
          builder:
              (context) => SizedBox(
                child: DraggableScrollableSheet(
                  minChildSize: 0.32,
                  // maxChildSize: 0.,
                  initialChildSize: 0.32,
                  expand: false,
                  builder:
                      (context, scrollController) => Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildHeader(context),
                            SizedBox(height: 6),
                            Expanded(
                              child: ListView.builder(
                                controller: scrollController,

                                itemCount: categoriesList.length,
                                itemBuilder: (context, index) {
                                  final name = categoriesList[index];
                                  return ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0,
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      if (name == 'Continent') {
                                        _showContinentsModal(
                                          context,

                                          onContinentSelected,
                                        );
                                      }
                                      if (name == 'Population') {
                                        _showPopulationModal(
                                          context,
                                          onPopulationRangeSelected,
                                        );
                                      }
                                      if (name == 'Size') {
                                        _showSizesModal(
                                          context,
                                          onSizeRangeSelected,
                                        );
                                      }
                                    },
                                    title: Text(name, style: TextStyle()),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                ),
              ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(Icons.filter_alt_outlined),
            SizedBox(width: 10),
            Text('Filter'),
          ],
        ),
      ),
    );
  }

  // TRIGGER BUTTON TO SHOW BOTTOM MODAL
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Filter',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(Icons.close_rounded, color: Colors.grey, size: 16),
          ),
        ),
      ],
    );
  }
  // LOGIC FOR SHOWING CONTINENTS

  void _showContinentsModal(
    BuildContext context,

    void Function(String continent)? onContinentSelected,
  ) {
    showModalBottomSheet(
      showDragHandle: true,
      enableDrag: true,
      // backgroundColor: ,
      isScrollControlled: true,
      context: context,
      builder:
          (context) => SizedBox(
            child: DraggableScrollableSheet(
              minChildSize: 0.4,
              maxChildSize: 0.45,
              initialChildSize: 0.4,
              expand: false,
              builder:
                  (context, scrollController) => Padding(
                    padding: EdgeInsets.all(16),
                    child: Expanded(
                      child: ListView.builder(
                        controller: scrollController,

                        itemCount: continentsList.length,
                        itemBuilder: (context, index) {
                          final name = continentsList[index];
                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            onTap: () {
                              Navigator.pop(context);
                              // FOR CONTINENT SELECTION
                              if (onContinentSelected != null) {
                                onContinentSelected(name);
                              }
                            },
                            title: Text(name, style: TextStyle()),
                          );
                        },
                      ),
                    ),
                  ),
            ),
          ),
    );
  }

  // LOGIC FOR SHOWING POPULATION SIZE

  void _showPopulationModal(
    BuildContext context,

    void Function(Map<String, int> populationRange)? onPopulationRangeSelected,
  ) {
    showModalBottomSheet(
      showDragHandle: true,
      enableDrag: true,
      isScrollControlled: true,
      context: context,
      builder:
          (context) => SizedBox(
            child: DraggableScrollableSheet(
              minChildSize: 0.4,
              maxChildSize: 0.6,
              initialChildSize: 0.45,
              expand: false,
              builder:
                  (context, scrollController) => Padding(
                    padding: EdgeInsets.all(16),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: populationList.length,
                      itemBuilder: (context, index) {
                        final range = populationList[index];
                        final min = range['min']!;
                        final max = range['max']!;
                        String formatNumber(int num) {
                          if (num >= 1000000000) {
                            return '${(num ~/ 1000000000)}bn';
                          } else {
                            return '${(num ~/ 1000000)}m';
                          }
                        }

                        final label =
                            '${formatNumber(min)} - ${formatNumber(max)}';
                        return ListTile(
                          title: Text(label),
                          onTap: () {
                            Navigator.pop(context);
                            debugPrint('Selected: $label');
                            if (onPopulationRangeSelected != null) {
                              onPopulationRangeSelected(range);
                            }
                          },
                        );
                      },
                    ),
                  ),
            ),
          ),
    );
  }

  int parseArea(String areaString) {
    return int.tryParse(
          areaString.replaceAll(' km²', '').replaceAll(' ', ''),
        ) ??
        0;
  }

  // FILTERING FOR LAND MASS SIZE IN SQUARE KILOMETERS
  void _showSizesModal(
    BuildContext context,
    void Function(Map<String, String> sizeRange)? onSizeRangeSelected,
  ) {
    showModalBottomSheet(
      showDragHandle: true,
      enableDrag: true,
      isScrollControlled: true,
      context: context,
      builder:
          (context) => SizedBox(
            child: DraggableScrollableSheet(
              minChildSize: 0.4,
              maxChildSize: 0.6,
              initialChildSize: 0.45,
              expand: false,
              builder:
                  (context, scrollController) => Padding(
                    padding: EdgeInsets.all(16),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: sizeList.length,
                      itemBuilder: (context, index) {
                        final range = sizeList[index];
                        final min = parseArea(range['min']!);
                        final max = parseArea(range['max']!);

                        final label =
                            '${(min ~/ 1000)}km² - ${(max ~/ 1000)}km²';
                        return ListTile(
                          title: Text(label),
                          onTap: () {
                            Navigator.pop(context);
                            debugPrint('Selected: $label');
                            if (onSizeRangeSelected != null) {
                              onSizeRangeSelected(range);
                            }
                          },
                        );
                      },
                    ),
                  ),
            ),
          ),
    );
  }
}
