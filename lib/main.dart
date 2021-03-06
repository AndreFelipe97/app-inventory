import 'dart:math';
import 'dart:io';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory/components/product_form.dart';
import 'package:inventory/components/product_list.dart';
import 'package:inventory/components/sale_form.dart';
import 'package:inventory/components/sale_list.dart';
import 'package:inventory/model/product.dart';
import 'package:inventory/model/sale.dart';

void main() => runApp(InvetortyApp());

class InvetortyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', ''),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 23,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Product> _products = [];
  final List<Sale> _sales = [];
  bool _showListSale = false;

  _addProduct(String product, int amount, double purchaseValue,
      double saleValue, double profit, DateTime date) {
    final newProduct = Product(
      id: Random().nextDouble().toString(),
      product: product,
      amount: amount,
      purchaseValue: purchaseValue,
      saleValue: saleValue,
      profit: profit,
      date: date,
    );

    setState(() {
      _products.add(newProduct);
    });

    Navigator.of(context).pop();
  }

  _addSale(String product, double price, int amount, DateTime date) {
    final newSale = Sale(
      product: product,
      price: price,
      amount: amount,
      date: date,
    );

    setState(() {
      _sales.add(newSale);
    });

    Navigator.of(context).pop();
  }

  _openProductFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return SingleChildScrollView(child: ProductForm(_addProduct));
        });
  }

  _openSaleFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return SingleChildScrollView(child: SaleForm(_addSale));
        });
  }

  Widget _getIconButton(IconData icon, Function fn) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: fn,
            child: Icon(icon),
          )
        : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final actions = <Widget>[
      _getIconButton(
          Platform.isIOS ? CupertinoIcons.money_dollar : Icons.attach_money,
          () => _openSaleFormModal(context)),
      _getIconButton(Platform.isIOS ? CupertinoIcons.add : Icons.add,
          () => _openProductFormModal(context)),
    ];

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Estoque'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          )
        : AppBar(
            title: Text('Estoque'),
            actions: actions,
          );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = Center(
      child: Container(
        height: availableHeight * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: availableHeight * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Exibir vendas'),
                  Switch(
                      value: _showListSale,
                      onChanged: (value) {
                        setState(() {
                          _showListSale = !_showListSale;
                        });
                      }),
                ],
              ),
            ),
            !_showListSale
                ? Container(
                    height: availableHeight * .9,
                    child: ProductList(
                      products: _products,
                    ),
                  )
                : Container(
                    height: availableHeight * .9,
                    child: SaleList(
                      sales: _sales,
                    ),
                  ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
          );
  }
}
