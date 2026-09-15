let
    // Resume cada produto em uma linha e calcula os indicadores solicitados no desafio.
    AgrupadoPorProduto = Table.Group(
        Financials_Origem,
        {"Product"},
        {
            {"Media_Unidades_Vendidas", each List.Average([Units Sold]), Currency.Type},
            {"Media_Valor_Vendas", each List.Average([Sales]), Currency.Type},
            {"Mediana_Valor_Vendas", each List.Median([Sales]), Currency.Type},
            {"Maior_Valor_Venda", each List.Max([Sales]), Currency.Type},
            {"Menor_Valor_Venda", each List.Min([Sales]), Currency.Type}
        }
    ),
    AdicionouIndiceProduto = Table.AddColumn(
        AgrupadoPorProduto,
        "ID_Produto",
        each
            if [Product] = "Carretera" then 0
            else if [Product] = "Montana" then 1
            else if [Product] = "Paseo" then 2
            else if [Product] = "Velo" then 3
            else if [Product] = "VTT" then 4
            else if [Product] = "Amarilla" then 5
            else null,
        Int64.Type
    ),
    RenomeouProduto = Table.RenameColumns(AdicionouIndiceProduto, {{"Product", "Produto"}}),
    ReordenouColunas = Table.ReorderColumns(
        RenomeouProduto,
        {"ID_Produto", "Produto", "Media_Unidades_Vendidas", "Media_Valor_Vendas", "Mediana_Valor_Vendas", "Maior_Valor_Venda", "Menor_Valor_Venda"}
    )
in
    ReordenouColunas
