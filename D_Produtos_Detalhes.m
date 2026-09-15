let
    // Define a granularidade produto, preço de fabricação e preço de venda.
    AgrupouDetalhesProduto = Table.Group(
        Financials_Origem,
        {"Product", "Manufacturing Price", "Sale Price"},
        {{"Media_Unidades_Vendidas", each List.Average([Units Sold]), Currency.Type}}
    ),
    OrdenouDetalhesProduto = Table.Sort(
        AgrupouDetalhesProduto,
        {{"Product", Order.Ascending}, {"Manufacturing Price", Order.Ascending}, {"Sale Price", Order.Ascending}}
    ),
    AdicionouIndiceDetalhe = Table.AddIndexColumn(OrdenouDetalhesProduto, "ID_Produto_Detalhe", 1, 1, Int64.Type),
    AdicionouIndiceProduto = Table.AddColumn(
        AdicionouIndiceDetalhe,
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
    RenomeouDetalhes = Table.RenameColumns(
        AdicionouIndiceProduto,
        {{"Product", "Produto"}, {"Manufacturing Price", "Preco_Fabricacao"}, {"Sale Price", "Preco_Venda"}}
    ),
    ReordenouColunas = Table.ReorderColumns(
        RenomeouDetalhes,
        {"ID_Produto_Detalhe", "ID_Produto", "Produto", "Preco_Fabricacao", "Preco_Venda", "Media_Unidades_Vendidas"}
    )
in
    ReordenouColunas
