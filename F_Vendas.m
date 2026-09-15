let
    // Cria a fato de vendas e incorpora somente as chaves das dimensões e as métricas da transação.
    AdicionouChaveVenda = Table.AddIndexColumn(Financials_Origem, "SK_ID", 1, 1, Int64.Type),
    AdicionouIndiceProduto = Table.AddColumn(
        AdicionouChaveVenda,
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
    AdicionouIndiceDesconto = Table.AddColumn(
        AdicionouIndiceProduto,
        "ID_Desconto",
        each if [Discount Band] = "None" then 0 else if [Discount Band] = "Low" then 1 else if [Discount Band] = "Medium" then 2 else if [Discount Band] = "High" then 3 else null,
        Int64.Type
    ),
    JuntouDetalhes = Table.NestedJoin(
        AdicionouIndiceDesconto,
        {"Segment", "Country"},
        D_Detalhes,
        {"Segmento", "Pais"},
        "DimDetalhes",
        JoinKind.LeftOuter
    ),
    ExpandiuDetalhes = Table.ExpandTableColumn(JuntouDetalhes, "DimDetalhes", {"ID_Detalhe"}, {"ID_Detalhe"}),
    JuntouDetalhesProduto = Table.NestedJoin(
        ExpandiuDetalhes,
        {"Product", "Manufacturing Price", "Sale Price"},
        D_Produtos_Detalhes,
        {"Produto", "Preco_Fabricacao", "Preco_Venda"},
        "DimProdutoDetalhes",
        JoinKind.LeftOuter
    ),
    ExpandiuDetalhesProduto = Table.ExpandTableColumn(JuntouDetalhesProduto, "DimProdutoDetalhes", {"ID_Produto_Detalhe"}, {"ID_Produto_Detalhe"}),
    SelecionouColunas = Table.SelectColumns(
        ExpandiuDetalhesProduto,
        {"SK_ID", "ID_Produto", "ID_Desconto", "ID_Detalhe", "ID_Produto_Detalhe", "Product", "Units Sold", "Sale Price", "Discount Band", "Segment", "Country", "Gross Sales", "Discounts", "Sales", "COGS", "Profit", "Date"}
    ),
    RenomeouColunas = Table.RenameColumns(
        SelecionouColunas,
        {
            {"Product", "Produto"}, {"Units Sold", "Unidades_Vendidas"}, {"Sale Price", "Preco_Venda"},
            {"Discount Band", "Faixa_Desconto"}, {"Segment", "Segmento"}, {"Country", "Pais"},
            {"Gross Sales", "Vendas_Brutas"}, {"Discounts", "Desconto"}, {"Sales", "Vendas"},
            {"Profit", "Lucro"}, {"Date", "Data"}
        }
    ),
    ReordenouColunas = Table.ReorderColumns(
        RenomeouColunas,
        {"SK_ID", "ID_Produto", "ID_Desconto", "ID_Detalhe", "ID_Produto_Detalhe", "Produto", "Unidades_Vendidas", "Preco_Venda", "Faixa_Desconto", "Segmento", "Pais", "Vendas_Brutas", "Desconto", "Vendas", "COGS", "Lucro", "Data"}
    )
in
    ReordenouColunas
