import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:app_lista_compras_produtos/data/produto_dao.dart';

Future<Database> getDatabase() async {
  final String path = join(
    await getDatabasesPath(),
    "app_lista_produtos_db.db",
  );
  return openDatabase(
    path,
    onCreate: (db, version) {
      /* Cria o banco de dados se ele nao existe */
      db.execute(ProdutoDao.tabelaSql);
    },
    version: 1,
  );
}
