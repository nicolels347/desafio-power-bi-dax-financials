let
    // Resume as faixas de desconto e cria uma chave inteira para o relacionamento.
    AgrupouFaixas = Table.Group(
        Financials_Origem,
        {"Discount Band"},
        {
            {"Desconto_Medio", each List.Average([Discounts]), Currency.Type},
            {"Desconto_Minimo", each List.Min([Discounts]), Currency.Type},
            {"Desconto_Maximo", each List.Max([Discounts]), Currency.Type}
        }
    ),
    AdicionouIndiceDesconto = Table.AddColumn(
        AgrupouFaixas,
        "ID_Desconto",
        each if [Discount Band] = "None" then 0 else if [Discount Band] = "Low" then 1 else if [Discount Band] = "Medium" then 2 else if [Discount Band] = "High" then 3 else null,
        Int64.Type
    ),
    RenomeouFaixa = Table.RenameColumns(AdicionouIndiceDesconto, {{"Discount Band", "Faixa_Desconto"}}),
    ReordenouColunas = Table.ReorderColumns(RenomeouFaixa, {"ID_Desconto", "Faixa_Desconto", "Desconto_Medio", "Desconto_Minimo", "Desconto_Maximo"})
in
    ReordenouColunas
