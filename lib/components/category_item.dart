import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import 'package:meals/models/category.dart';
import 'package:meals/screens/categories_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem(this.category);

  void _selectCategory(BuildContext context) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (_) {
    //       return CategoriesMealsScreen(category);
    //     },
    //   ),
    // );

    // =========== CHAMADA DE ROTA NOMEADA ========================================
    // * Definimos nossa rota dentro de routes:, passando o nome da rota e como ele 
    // vai criar o componente. 
    // Ou seja, agora não passamos mais o atributo no CONSTRUTOR do COMPONENTE, agora
    // estamos pegando o atributo a partir do ModalRoute.of(context)?.settings.arguments
    // e ai eu consigo pegar a category(categoria) e vai continuar funcionando normalmente
    // so que agora  usando uma rota nomeada.

    // * Cria-se então um pushNamed (rota nomeada), passando o NOME DA ROTA e o argumnents:
    // que nesse caso aqui é o category(a categoria). Mas pode ser qualquer coisa
    // além de um valor primitivo/objeto seu/meu -> que é o que consumo em arguments: .
    // =========== CHAMADA DE ROTA NOMEADA ========================================

    Navigator.of(context).pushNamed(
      '/categories-meals',
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(category.title),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.5),
              category.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
