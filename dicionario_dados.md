# Dicionário de dados

## Financials_Origem

Consulta de staging oculta. Conserva as 700 linhas da amostra, corrige o espaço no nome da coluna `Sales`, substitui a faixa de desconto nula por `None` e define os tipos.

## D_Produtos

Granularidade: uma linha por produto. Contém `ID_Produto`, `Produto` e os indicadores solicitados: médias, mediana, maior e menor valor de venda.

## D_Produtos_Detalhes

Granularidade: uma linha por combinação de produto, preço de fabricação e preço de venda. A média de unidades vendidas resume as transações dessa combinação.

## D_Descontos

Granularidade: uma linha por faixa de desconto. Guarda a chave da faixa e seus valores médio, mínimo e máximo de desconto.

## D_Detalhes

Granularidade: uma linha por combinação de segmento e país. Esses atributos foram separados da fato para evitar repetição no uso analítico.

## D_Calendario

Tabela calculada em DAX com `CALENDAR`. Possui uma linha para cada dia entre a menor e a maior data de venda, além de ano, trimestre, mês, dia e dia da semana.

## F_Vendas

Granularidade: uma linha por transação da planilha de origem. As chaves estrangeiras conectam a fato às cinco dimensões. Os campos textuais repetidos foram mantidos ocultos para auditoria e compatibilidade com o enunciado.
