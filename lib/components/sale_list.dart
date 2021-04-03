import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory/model/sale.dart';

class SaleList extends StatelessWidget {
  final List<Sale> sales;

  SaleList({this.sales});

  @override
  Widget build(BuildContext context) {
    return sales.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text('Nenhuma venda cadastrada'),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: sales.length,
            itemBuilder: (ctx, index) {
              final sl = sales[index];
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
                        child: Text('R\$${sl.price}'),
                      ),
                    ),
                  ),
                  title: Text(
                    '${sl.product}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                      'qnt ${sl.amount} - Data ${DateFormat('dd MMMM y').format(sl.date)}'),
                ),
              );
            },
          );
  }
}
