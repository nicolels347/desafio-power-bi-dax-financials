let
    // Mantém as combinações únicas de segmento e país que detalham cada venda.
    SelecionouDetalhes = Table.SelectColumns(Financials_Origem, {"Segment", "Country"}),
    RemoveuDuplicatas = Table.Distinct(SelecionouDetalhes),
    OrdenouDetalhes = Table.Sort(RemoveuDuplicatas, {{"Segment", Order.Ascending}, {"Country", Order.Ascending}}),
    AdicionouIndiceDetalhe = Table.AddIndexColumn(OrdenouDetalhes, "ID_Detalhe", 1, 1, Int64.Type),
    RenomeouDetalhes = Table.RenameColumns(AdicionouIndiceDetalhe, {{"Segment", "Segmento"}, {"Country", "Pais"}}),
    ReordenouColunas = Table.ReorderColumns(RenomeouDetalhes, {"ID_Detalhe", "Segmento", "Pais"})
in
    ReordenouColunas
