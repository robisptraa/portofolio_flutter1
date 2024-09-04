import 'package:flutter/material.dart';

void main() {
  runApp(MyPortfolioApp());
}

class MyPortfolioApp extends StatefulWidget {
  @override
  _MyPortfolioAppState createState() => _MyPortfolioAppState();
}

class _MyPortfolioAppState extends State<MyPortfolioApp> {
  bool _darkMode = false;
  double _fontSize = 16.0;

  void _updateSettings(bool darkMode, double fontSize) {
    setState(() {
      _darkMode = darkMode;
      _fontSize = fontSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Personal Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: _darkMode ? Brightness.dark : Brightness.light,
      ),
      home: PortfolioPage(
        updateSettings: _updateSettings,
        fontSize: _fontSize,
      ),
    );
  }
}
class PortfolioPage extends StatefulWidget {
  final Function(bool, double) updateSettings;
  final double fontSize;

  PortfolioPage({required this.updateSettings, required this.fontSize});

  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Robi Portfolio'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          PortfolioContent(fontSize: widget.fontSize),
          SearchContent(),
          ProfileContent(),
          SettingsContent(
            updateSettings: widget.updateSettings,
            fontSize: widget.fontSize,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}

class PortfolioContent extends StatelessWidget {
  final double fontSize;

  PortfolioContent({required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/pap.jpg'),
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: Text(
              'Robi Saputra',
              style: TextStyle(
                fontSize: fontSize + 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: Text(
              'Future Leader',
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'About Robi?',
            style: TextStyle(
              fontSize: fontSize + 6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Nama saya Robi saputra Saya adalah seorang Siswa di SMK PI dan saya adalah Seorang pelajar programner,dan sedang prakerin di PT.Sarana Pactindo di divisi quality ansurance saya seseorang yg gemar berorganisasi dan saya memiliki banyak perngalaman di berbagai bidang yg saya tekuni "management organisasi,IT,elektronik bahkan otomotif',
            style: TextStyle(fontSize: fontSize),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Chip(label: Text('IT Knowledge')),
              Chip(label: Text('Leadership')),
              Chip(label: Text('Technical')),
              Chip(label: Text('Public Speaking')),
              Chip(label: Text('Engineering')),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Projects',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          ProjectCard(
            title: 'Project IT',
            description: 'QA Concept tester, Development Web, Development Mobile Apps, Development Desktop App.',
          ),
          ProjectCard(
            title: 'Project Robotic',
            description: 'IoT, Micro Controller, C++ Language, Design PCB Wiring.',
          ),
          ProjectCard(
            title: 'Project Organization',
            description: 'Management Member/Jobdesk, Event Management, Cadreization Management.',
          ),
          ProjectCard(
            title: 'Project Technologies',
            description: ':)',
          ),
        ],
      ),
    );
  }
}

class SearchContent extends StatefulWidget {
  @override
  _SearchContentState createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _allItems = [
    'Project IT',
    'Project Robotic',
    'Project Organization',
    'Project Technologies'
  ];
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
    _controller.addListener(_filterItems);
  }

  void _filterItems() {
    final query = _controller.text.toLowerCase();
    setState(() {
      _filteredItems = _allItems
          .where((item) => item.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_filterItems);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredItems[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/pap2.jpg'),
          ),
          SizedBox(height: 16),
          Text(
            'Robi Saputra',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Ingin jadi orang sukses',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 16),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('robibalisaputra123@gmail.com'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('+62 81572344146'),
          ),
          ListTile(
            leading: Icon(Icons.location_city),
            title: Text('Bandung, Indonesia'),
          ),
        ],
      ),
    );
  }
}

class SettingsContent extends StatefulWidget {
  final Function(bool, double) updateSettings;
  final double fontSize;

  SettingsContent({required this.updateSettings, required this.fontSize});

  @override
  _SettingsContentState createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  bool _darkMode = false;
  bool _notifications = true;
  double _fontSize = 16.0;

  @override
  void initState() {
    super.initState();
    _fontSize = widget.fontSize;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          SwitchListTile(
            title: Text('Dark Mode'),
            value: _darkMode,
            onChanged: (bool value) {
              setState(() {
                _darkMode = value;
                widget.updateSettings(_darkMode, _fontSize);
              });
            },
          ),
          SwitchListTile(
            title: Text('Notifications'),
            value: _notifications,
            onChanged: (bool value) {
              setState(() {
                _notifications = value;
              });
            },
          ),
          SizedBox(height: 16),
          Text(
            'Font Size',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Slider(
            value: _fontSize,
            min: 10.0,
            max: 30.0,
            divisions: 20,
            label: _fontSize.round().toString(),
            onChanged: (double value) {
              setState(() {
                _fontSize = value;
                widget.updateSettings(_darkMode, _fontSize);
              });
            },
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;

  ProjectCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
