import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar atau header dari scaffold dashboard
      appBar: AppBar(
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Dashboard'),
              StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.userChanges(),
                  builder: (context, snapshot){
                    return Text('${snapshot.data?.email}', style: TextStyle(fontSize: 10.0 ),);
                  }),
            ],
          ),
        ),
        // mengatur ketinggian atau tebal bayangan
        elevation: .1,
        backgroundColor: Color.fromRGBO(49, 87, 110, 1.0),
      ),
      body: Container(
        // Membuat padding atau jarak berupa padding untuk garis horizontal dan vertikal
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
        // membuat grid atau sebuah kolom secara vertikal ataupun horizontal
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(3.0),
          children: <Widget>[
            // memanggil widget card yang sudah di buat
            makeDashboardItem("Book", Icons.book),
            makeDashboardItem("Book", Icons.book),
            makeDashboardItem("Book", Icons.book),
            makeDashboardItem("Book", Icons.book),
            makeDashboardItem("Book", Icons.book),
            makeDashboardItem("Book", Icons.book)
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Dashboard'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Tambah',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout_outlined),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        // membuat kondisi untuk pengkondisian slected index
        onTap: (int index) {
          switch (index) {
            case 0:

              break;
            case 1:

              break;
            case 2:
              showModal(context);
              break;
          }
          setState(
                () {
              _selectedIndex = index;
            },
          );
        },
      ),
    );
  }

  //Membuat box modal berupa alert untuk menamplilakn pesan stuju / tidak pada saat melakukan logout
  void showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('And ingin logout?'),
        actions: <TextButton>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
          TextButton(
              onPressed: () async{
                Navigator.pop(context);
                await FirebaseAuth.instance.signOut();
              },
              child: const Text('Ya')
          )
        ],
      ),
    );
  }

  Card makeDashboardItem(String title, IconData icon) {
    return Card(
      // mengatur ketinggian bayangan
        elevation: 1.0,
        // mengatur jarak antar card dengan margin
        margin: new EdgeInsets.all(8.0),
        child: Container(
          // memberi dekorasi berupa warna pada masing - masing card
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          // memberi efek splash saat widget di tap
          child: new InkWell(
            onTap: () {},
            child: Column(
              // fungsi ini akan membuat card mengikuti ukuran layar dan hasilnya akan tetap seperti ini
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                // box kosong untuk memberi jarak
                SizedBox(height: 50.0),
                // mengatur icon agar berada di tengah - tengah pembungkusnya
                Center(
                    child: Icon(
                      icon,
                      size: 40.0,
                      color: Colors.black,
                    )),
                // box kosong untuk memberi jarak
                // SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                      new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }
}