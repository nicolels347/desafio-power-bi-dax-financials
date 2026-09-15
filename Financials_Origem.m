let
    Fonte = Excel.Workbook(File.Contents(pCaminhoArquivo), null, true),
    TabelaFinancials = Fonte{[Item="financials", Kind="Table"]}[Data],
    NomesLimpos = Table.TransformColumnNames(TabelaFinancials, each Text.Trim(_)),
    FaixaSemNulos = Table.ReplaceValue(NomesLimpos, null, "None", Replacer.ReplaceValue, {"Discount Band"}),
    TiposDefinidos = Table.TransformColumnTypes(FaixaSemNulos, {{"Date", type date}}, "en-US")
in
    TiposDefinidos
