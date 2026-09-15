# Como gerar o arquivo PBIX

O repositório já inclui o projeto editável `Projeto_Financials.pbip`. A conversão para o formato binário PBIX é feita pelo próprio Power BI Desktop.

1. Extraia o ZIP para uma pasta curta, por exemplo `C:\PowerBI\Projeto_Financials`.
2. Instale ou atualize o Power BI Desktop.
3. Em **Arquivo > Opções e configurações > Opções > Recursos de visualização**, habilite **Power BI Project PBIP** se a sua versão ainda apresentar essa opção.
4. Abra `Projeto_Financials.pbip`.
5. Aceite a aplicação das alterações externas, caso o Power BI solicite.
6. Selecione **Atualizar** e confira os controles de `docs/validacao_dados.md`.
7. Abra a Exibição de Modelo e confirme os cinco relacionamentos `1:*`.
8. Use **Arquivo > Salvar como** e escolha `Projeto_Financials.pbix`.

Os dados estão incorporados no projeto para que a abertura não dependa de um caminho local. A planilha original também está em `data/Financial_Sample.xlsx` para documentação e reprodução manual.
