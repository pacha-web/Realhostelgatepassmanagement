import 'package:flutter/material.dart';

class ViewHistoryPage extends StatefulWidget {
  @override
  _ViewHistoryPageState createState() => _ViewHistoryPageState();
}

class _ViewHistoryPageState extends State<ViewHistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> goneHomeHistory = [
    {
      'date': '2025-08-01',
      'entries': [
        {'name': 'Arun Kumar', 'status': 'Out'},
        {'name': 'Divya R', 'status': 'In'},
      ]
    },
    {
      'date': '2025-07-31',
      'entries': [
        {'name': 'Suresh M', 'status': 'Out'},
        {'name': 'Jeni M', 'status': 'In'},
      ]
    },
  ];

  final List<Map<String, dynamic>> otherActivityHistory = [
    {
      'date': '2025-08-01',
      'entries': [
        {'name': 'John Paul', 'status': 'In'},
        {'name': 'Meena', 'status': 'Out'},
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget buildHistoryList(List<Map<String, dynamic>> historyData) {
    return ListView.builder(
      itemCount: historyData.length,
      itemBuilder: (context, index) {
        final dayData = historyData[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                dayData['date'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ...dayData['entries'].map<Widget>((entry) {
              return ListTile(
                title: Text(entry['name']),
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: entry['status'] == 'Out'
                        ? Colors.green
                        : Colors.red,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    entry['status'],
                    style: TextStyle(
                      color: entry['status'] == 'Out'
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View History'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Gone Home'),
            Tab(text: 'Other Activity'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildHistoryList(goneHomeHistory),
          buildHistoryList(otherActivityHistory),
        ],
      ),
    );
  }
}
