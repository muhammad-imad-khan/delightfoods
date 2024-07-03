import 'package:DelightFoods/Auth/AuthScreens/register.dart';
import 'package:DelightFoods/Auth/AuthScreens/login.dart';
import 'package:DelightFoods/Dashboard/customDashboard.dart';
import 'package:DelightFoods/charts/BarChart/barChartMonthly.dart';
import 'package:DelightFoods/charts/BarChart/barChartYearly.dart';
import 'package:DelightFoods/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:DelightFoods/Auth/LoginAuthProvider.dart';
import 'package:provider/provider.dart';
import 'package:DelightFoods/Product/product_page.dart';
import 'package:DelightFoods/Order/Order_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginAuthProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Delight Foods',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/intro',
        routes: {
          '/intro': (context) => IntroPage(),
          '/register': (context) => Register(),
          '/login': (context) => Login(),
          '/main': (context) => MainPage(),
          '/product': (context) => ProductPage(),
          '/order': (context) => OrderPage(),
          '/monthly': (context) => BarChartMonthly(),
          '/yearly': (context) => BarChartYearly(),
        },
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delight Foods'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Delight Foods',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Product'),
              onTap: () {
                Navigator.pushNamed(context, '/product');
              },
            ),
            ListTile(
              title: Text('Order'),
              onTap: () {
                Navigator.pushNamed(context, '/order');
              },
            ),
            ListTile(
              title: Text('Monthly Report'),
              onTap: () {
                Navigator.pushNamed(context, '/monthly');
              },
            ),
            ListTile(
              title: Text('Yearly Report'),
              onTap: () {
                Navigator.pushNamed(context, '/yearly');
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Dashboard"),
              SizedBox(height: 20), // Add some spacing
              BarChartYearly(),
            ],
          ),
        ),
      ),
    );
  }
}
