import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory/model/product.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;

  ProductList({this.products});

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text('Nenhum produto cadastrado')
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: products.length,
            itemBuilder: (ctx, index) {
              final pr = products[index];
              return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text('R\$${pr.saleValue}'),
                          ),
                        ),
                      ),
                      title: Text(
                        '${pr.product}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        'qnt ${pr.amount} - Data ${DateFormat('dd MMMM y').format(pr.date)}',
                      )));
            },
          );
  }
}
