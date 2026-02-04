import 'package:flutter/material.dart';

void main() {
  runApp(EasternApp());
}

class EasternApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eastern Supermarket',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
    );
  }
}

/* ================= LOGIN SCREEN ================= */

class LoginScreen extends StatelessWidget {
  final TextEditingController id = TextEditingController();
  final TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("EASTERN SUPERMARKET PVT LTD")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Staff Login",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            TextField(
              controller: id,
              decoration: InputDecoration(
                  labelText: "Staff ID", border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: pass,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Password", border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Login"),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => HomeScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}

/* ================= HOME SCREEN ================= */

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eastern Supermarket"),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => Navigator.pop(context))
        ],
      ),
      body: GridView.count(
        padding: EdgeInsets.all(20),
        crossAxisCount: 2,
        children: [
          MenuCard(
              title: "Mark Attendance",
              icon: Icons.qr_code,
              page: AttendanceScreen()),
          MenuCard(
              title: "Report Loss",
              icon: Icons.warning,
              page: LossScreen()),
          MenuCard(
              title: "View Records",
              icon: Icons.list,
              page: RecordsScreen()),
          MenuCard(
              title: "Owner Panel",
              icon: Icons.admin_panel_settings,
              page: OwnerScreen()),
        ],
      ),
    );
  }
}

/* ================= MENU CARD ================= */

class MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget page;

  MenuCard({required this.title, required this.icon, required this.page});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      child: Card(
        elevation: 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

/* ================= ATTENDANCE SCREEN ================= */

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<String> records = [];

  final TextEditingController name = TextEditingController();
  final TextEditingController section = TextEditingController();

  void mark(String action) {
    setState(() {
      records.add(
          "$action - ${name.text} - ${section.text} - ${DateTime.now()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Attendance")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
                controller: name,
                decoration: InputDecoration(labelText: "Staff Name")),
            TextField(
                controller: section,
                decoration: InputDecoration(labelText: "Section")),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () => mark("IN"), child: Text("IN")),
                ElevatedButton(
                    onPressed: () => mark("OUT"), child: Text("OUT")),
              ],
            ),
            Expanded(
              child: ListView(
                children:
                    records.map((e) => ListTile(title: Text(e))).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/* ================= LOSS SCREEN ================= */

class LossScreen extends StatefulWidget {
  @override
  _LossScreenState createState() => _LossScreenState();
}

class _LossScreenState extends State<LossScreen> {
  List<String> losses = [];

  final TextEditingController name = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController reason = TextEditingController();

  void addLoss() {
    setState(() {
      losses.add(
          "${name.text} lost ₹${amount.text} because ${reason.text}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Report Loss")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
                controller: name,
                decoration: InputDecoration(labelText: "Staff Name")),
            TextField(
                controller: amount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Loss Amount ₹")),
            TextField(
                controller: reason,
                decoration: InputDecoration(labelText: "Reason")),
            SizedBox(height: 10),
            ElevatedButton(onPressed: addLoss, child: Text("Save Loss")),
            Expanded(
              child: ListView(
                children:
                    losses.map((e) => ListTile(title: Text(e))).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/* ================= RECORDS SCREEN ================= */

class RecordsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Records")),
      body: Center(
        child: Text(
            "All attendance & losses will appear here once backend is added."),
      ),
    );
  }
}

/* ================= OWNER PANEL ================= */

class OwnerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Owner Panel")),
      body: Center(
        child: Text(
          "Future version: analytics, late report, shrink report, QR scanner.",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
