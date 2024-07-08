%processador(MARCA, LINHA, MODELO, VELOCIDADE, CACHE, NUCLEOS, THREADS, SOQUETE, CONSUMO, PRECO)
processador('amd', 'ryzen 7', '5700x3d', 4.1, 96, 8, 16, 'am4', 105, 1345.99).
processador('amd', 'ryzen 7', '7800x3d', 5.0, 104, 8, 16, 'am5', 120, 2999.99).
processador('amd', 'ryzen 7', '5700X', 4.6, 32, 8, 16, 'am4', 65, 1147.99).
processador('amd', 'ryzen 5', '4600G', 4.2, 8, 6, 12, 'am4', 65, 649.90).
processador('intel', 'core i7', '14700KF', 5.6, 33, 8, 28, 'lga1700', 125, 2685.99).
processador('intel', 'core i5', '12400F', 4.4, 18, 6, 12, 'lga1700', 65, 818.80).
processador('intel', 'core i3', 'teste', 3.2, 16, 4, 8, 'am4', 55, 600.00).
processador('amd', 'ryzen 5', '5600G', 4.4, 16, 6, 12, 'am4', 65, 819.96).
processador('intel', 'core i7', '12700K', 5.0, 25, 12, 20, 'lga1700', 1879.99).

%placa_mae(MARCA, MODELO, CHIPSET, FORMATO, SOQUETE, CONSUMO, PRECO)
placa_mae('gigabyte', 'B550M Aorus Elite', 'amd b550', 'micro ATX', 'am4', 120, 726.00).
placa_mae('gigabyte', 'B450M DS3H V2', 'amd b450', 'micro ATX', 'am4', 110, 680.00).
placa_mae('asus', 'TUF Gaming B650M Plus', 'amd b650', 'micro ATX', 'am5', 130, 1469.00).
placa_mae('MSI', 'MAG Z790 TOMAHAWK WIFI', 'intel z790', 'ATX', 'lga1700', 140, 2529.00).
placa_mae('gigabyte', 'teste', 'amd b650', 'micro ATX', 'am4', 130, 1469.00).
placa_mae('MSI', 'A520M-A PRO', 'amd a520', 'micro ATX', 'am4', 90, 379.99).
placa_mae('MSI', 'B450M PRO-VDH MAX', 'amd b450', 'micro ATX', 'am4', 90, 499.99).

%placa_video(FABRICANTE, MARCA, MODELO, CHIPSET, TIPO_MEMORIA, TAM_MEMORIA, CLOCK, CONSUMO, PRECO).
placa_video('MSI', 'NVIDIA', 'GeForce RTX 3060 VENTUS 2X 12GB', 'GeForce RTX 3060', 'GDDR6', 12, 1.3, 170, 1899.90).
placa_video('GALAX', 'NVIDIA', 'GeForce RTX 4060 8GB', 'GeForce RTX 4060', 'GDDR6', 8, 1.8, 115, 2380.00).
placa_video('asus', 'AMD', 'Radeon RX 6600 8GB', 'Radeon RX 6600', 'GDDR6', 8, 2.0, 132, 1299.99).
placa_video('asus', 'AMD', 'RX 580 8GB Dual', 'Radeon RX 580', 'GDDR5', 8, 1.4, 185, 807.90).
placa_video('asus', 'AMD', 'teste', 'Radeon RX 580', 'GDDR5', 8, 1.4, 185, 807.90).
placa_video('afox', 'AMD', 'Radeon RX 550 4GB', 'Radeon RX 550', 'DDR3', 4, 1.2, 65, 585.00).

%regras
compativel(Modelo_Processador, Modelo_Mae):-
  processador(_, _, Modelo_Processador, _, _, _, _, Soquete_Processador, _, _),
  placa_mae(_, Modelo_Mae, _, _, Soquete_Mae, _, _),
  Soquete_Processador == Soquete_Mae.

listar_compatibilidade(Modelo_Processador, Modelo_Mae, Lista):-
  findall(Modelo_Processador-Modelo_Mae,(
  processador(_, _, Modelo_Processador, _, _, _, _, _, _, _),
  placa_mae(_, Modelo_Mae, _, _, _, _, _),
  compativel(Modelo_Processador, Modelo_Mae)),
  Lista
).

consumo_puro(Modelo_Processador, Modelo_Mae, Modelo_Video, Consumo):-
  processador(_, _, Modelo_Processador, _, _, _, _, _, Consumo_Processador, _),
  placa_mae(_, Modelo_Mae, _, _, _, Consumo_Mae, _),
  placa_video(_, _, Modelo_Video, _, _, _, _, Consumo_Video, _),
  Consumo is Consumo_Processador + Consumo_Mae + Consumo_Video.

consumo_recomendado(Modelo_Processador, Modelo_Mae, Modelo_Video, Consumo):-
  consumo_puro(Modelo_Processador, Modelo_Mae, Modelo_Video, ConPuro),
  Consumo is ConPuro * 1.5.

nivel_consumo(Modelo_Processador, Modelo_Mae, Modelo_Video):-
  consumo_puro(Modelo_Processador, Modelo_Mae, Modelo_Video, ConPuro),
  (ConPuro > 650 -> write('Consumo Alto');
  ConPuro > 350 -> write('Consumo Médio');
  write('Consumo Baixo')).

preco_total(Modelo_Processador, Modelo_Mae, Modelo_Video, Preco):-
  compativel(Modelo_Processador, Modelo_Mae),
  processador(_, _, Modelo_Processador, _, _, _, _, _, _, Preco_Processador),
  placa_mae(_, Modelo_Mae, _, _, _, _, Preco_Mae),
  placa_video(_, _, Modelo_Video, _, _, _, _, _, Preco_Video),
  Preco is Preco_Processador + Preco_Mae + Preco_Video.

preco_proce_video(Modelo_Processador, Modelo_Video, Preco):-
  processador(_, _, Modelo_Processador, _, _, _, _, _, _, Preco_Processador),
  placa_video(_, _, Modelo_Video, _, _, _, _, _, Preco_Video),
  Preco is Preco_Processador + Preco_Video.

custo_beneficio(Modelo_Processador, Modelo_Video, CustoBeneficio):-
  preco_proce_video(Modelo_Processador, Modelo_Video, Preco_Total),
  processador(_, _, Modelo_Processador, Velocidade, _, _, _, _, _, _),
  placa_video(_, _, Modelo_Video, _, _, _, Clock_Video, _, _),
  CustoBeneficio is (Velocidade + Clock_Video) / Preco_Total.

custo_beneficio_processador(Modelo_Processador, Custo_Beneficio):-
  processador(_, _, Modelo_Processador, Velocidade, _, _, _, _, _, Preco),
  Custo_Beneficio is Velocidade / Preco.

custo_beneficio_video(Modelo_Video, Custo_Beneficio):-
  placa_video(_, _, Modelo_Video, _, _, _, Clock, _, Preco),
  Custo_Beneficio is Clock / Preco.

%preco min e max e retorna pecas na faixa

faixa_preco_processo_video(PrecoMin, PrecoMax, Lista):-
  PrecoMin < PrecoMax -> findall(
        ModeloProc - ModeloVideo - PrecoTotalInt,
        (processador(_, _, ModeloProc, _, _, _, _, _, _, PrecoProc),
         placa_video(_, _, ModeloVideo, _, _, _, _, _, PrecoVideo),
         PrecoTotal is PrecoProc + PrecoVideo,
         round(PrecoTotal, PrecoTotalInt),
         PrecoTotalInt >= PrecoMin,
         PrecoTotalInt =< PrecoMax),
        Lista
    ).

faixa_preco(PrecoMin, PrecoMax, Lista):-
  PrecoMin < PrecoMax -> findall(
        ModeloProc - ModeloMae - ModeloVideo - PrecoTotalInt,
        (processador(_, _, ModeloProc, _, _, _, _, _, _, PrecoProc),
         placa_video(_, _, ModeloVideo, _, _, _, _, _, PrecoVideo),
         placa_mae(_, ModeloMae, _, _, _, _, PrecoMae),
         PrecoTotal is PrecoProc + PrecoVideo + PrecoMae,
         round(PrecoTotal, PrecoTotalInt),
         PrecoTotalInt >= PrecoMin,
         PrecoTotalInt =< PrecoMax,
         compativel(ModeloProc, ModeloMae)),
        Lista
  ).

faixa_preco_consumo(PrecoMin, PrecoMax):-
  faixa_preco(PrecoMin, PrecoMax, Lista),
  mostrar_consumo(Lista).

mostrar_consumo([]).
mostrar_consumo([ModeloProc-ModeloMae-ModeloVideo-PrecoTotalInt | T]) :-
    consumo_puro(ModeloProc, ModeloMae, ModeloVideo, Consumo),
    format('Processador: ~w, Placa-Mãe: ~w, Placa de Vídeo: ~w, Consumo: ~wW, Preço Total: ~w~n \n', [ModeloProc, ModeloMae, ModeloVideo, Consumo, PrecoTotalInt]),
    mostrar_consumo(T).

faixa_preco_processador(PrecoMin, PrecoMax, Lista):-
  PrecoMin < PrecoMax -> findall(Modelo - Preco,
  (processador(_, _, Modelo, _, _, _, _, _, _, Preco), Preco >= PrecoMin, Preco =< PrecoMax), 
   Lista).

faixa_preco_video(PrecoMin, PrecoMax, Lista):-
  PrecoMin < PrecoMax -> findall(Modelo - Preco,
  (placa_video(_, _, Modelo, _, _, _, _, _, Preco), Preco >= PrecoMin, Preco =< PrecoMax), 
   Lista).
   
%verificação de gargalo
gargalo(Modelo_Processador, Modelo_Video):-
  processador(_, _, Modelo_Processador, Velocidade_CPU, _, _, _, _, _, _),
  placa_video(_, _, Modelo_Video, _, _, _, Clock_Video, _, _),
  (Velocidade_CPU < 3.0, Clock_Video > 1.5 -> write('Possível gargalo: CPU lenta para GPU rápida');
  Velocidade_CPU > 4.0, Clock_Video < 1.5 -> write('Possível gargalo: GPU lenta para CPU rápida');
  write('Sem gargalos aparentes')).

%nivel da configuracao
nivel_config(Modelo_Processador, Modelo_Video):-
  processador(_, _, Modelo_Processador, Velocidade_CPU, _, _, _, _, _, _),
  placa_video(_, _, Modelo_Video, _, _, _, Clock_Video, _, _),
  Soma is Velocidade_CPU + Clock_Video,
  (Soma > 5.5 -> write('Computador Potente');
  Soma > 4.5 -> write('Computador Mediano');
  Soma > 3.5 -> write('Computador Fraco')).
  
%atualização de bios
atualizacao_bios(Modelo_Processador, Modelo_Mae):-
  processador(_, _, Modelo_Processador, _, _, _, _, Soquete_Processador, _, _),
  placa_mae(_, Modelo_Mae, Chipset_Mae, _, Soquete_Mae, _, _),
  (Soquete_Processador == Soquete_Mae,
  (Chipset_Mae == 'amd b450', Soquete_Processador == 'am4' -> write('Atualização de BIOS necessária');
  Chipset_Mae == 'amd b550', Soquete_Processador == 'am4' -> write('Pode ser necessária uma atualização de BIOS');
  write('Atualização de BIOS não necessária'))).