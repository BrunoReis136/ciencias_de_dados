# import pandas as pd

import pandas as pd
import random as rnd
from datetime import datetime, timedelta

listas = pd.read_csv('nomes_sobrenomes.csv',dtype=str)
nomes_masc = listas['nome_masculino'].dropna()
nomes_fem = listas['nome_feminino'].dropna()
sobrenomes = listas['sobrenome'].dropna()

data_min = datetime.today().replace(year=datetime.today().year - 70)
data_max = datetime.today().replace(year=datetime.today().year - 18)

def name_generator():
    genero = rnd.choice(['masculino','feminino'])
    nome = rnd.choice(nomes_masc) if genero == 'masculino' else rnd.choice(nomes_fem)

    nome_duplo = rnd.choice([True,False])
    if nome_duplo:
        nome_meio = rnd.choice(nomes_masc) if genero == 'masculino' else rnd.choice(nomes_fem)
        nome_inicio = [nome,nome_meio]
    else:
        nome_inicio = [nome]

    sobrenome = rnd.choice(sobrenomes)
    sobrenome_duplo = rnd.choice([True, False])
    if sobrenome_duplo:
        sobrenome = [sobrenome, rnd.choice(sobrenomes)]
    else:
        sobrenome = [sobrenome]

    nome_completo = ' '.join(nome_inicio + sobrenome)

    return nome_completo.title()


def data_aleatoria():
    tempo = data_max - data_min
    segundos_aleatorios = rnd.randrange(int(tempo.total_seconds()))
    data_nasc = data_min + timedelta(seconds=segundos_aleatorios)
    return data_nasc.date()

qtd = 25

nomes_gerados = [name_generator() for _ in range(qtd)]

df = pd.DataFrame(nomes_gerados, columns=["nome"])

datas_nasc = [data_aleatoria() for _ in range(qtd)]

df['data_nascimento'] = datas_nasc

df['idade'] = df['data_nascimento'].apply(lambda d: (datetime.today().date() - d).days//365)

df['tempo_servico'] = df['idade'].apply(lambda t: rnd.randint(0,t-18))

df['vendas_mensais'] = [rnd.randint(100,5000) for _ in range(len(df))]

df

df.sort_values(by="vendas_mensais",inplace=True)


vendas = []

qtd_vendas = 80

produtos = {
    "Notebook Gamer Alienware X17": 18999.99,
    "Notebook Apple MacBook Pro M3 Max 16\"": 24999.00,
    "iPhone 16 Pro Max 1TB": 13999.00,
    "Samsung Galaxy Z Fold 6": 12499.00,
    "Monitor 4K UltraWide LG 49\"": 8999.90,
    "PlayStation 5 Pro Edição Colecionador": 6999.00,
    "Xbox Series X Diablo Edition": 6499.00,
    "PC Gamer RTX 4090 Watercooler Custom": 27999.15,
    "Headset Sennheiser HD 820": 9999.00,
    "Câmera Sony A7 IV Corpo": 13999.00,
    "Drone DJI Mavic 3 Pro": 18499.00,
    "Smart TV OLED LG 77\"": 19999.00,
    "Apple Vision Pro": 28999.00,
    "Projetor 4K Epson Cinema Pro": 16999.90,
    "Som Ambiente Bose Lifestyle 650": 23999.75
}

for _ in range(qtd_vendas):
    produto,valor = rnd.choice(list(produtos.items()))
    data = datetime.today() - timedelta(days=rnd.randint(0,29))

    vendas.append({
        'funcionario':rnd.choice(df['nome']),
        'produto':produto,
        'valor': valor,
        'data': data.date()
    })


df_vendas = pd.DataFrame(vendas)
df_vendas['data'] = pd.to_datetime(df_vendas['data'])

dias = {
    0: 'Segunda',
    1: 'Terça',
    2: 'Quarta',
    3: 'Quinta',
    4: 'Sexta',
    5: 'Sábado',
    6: 'Domingo'
}


df_vendas['dia_semana'] = df_vendas['data'].dt.weekday.map(dias)

df_vendas['nome_simples'] = df_vendas["funcionario"].astype(str).apply(lambda x: x.split()[0] if x.strip() != '' else None)

'''print(df_vendas)
print(10 * '\n')
print("Lista por Funcionário - Valores")
print(df_vendas.groupby('Funcionário')['Valor'].sum().sort_values(ascending=False))
print(10 * '\n')
print("Lista por Datas - Valores")
print(df_vendas.groupby(["Data","Dia_Semana"])['Valor'].sum().sort_values(ascending=False))'''

df['comissao_por_tempo'] = df["tempo_servico"].apply(lambda x: 'Junior' if x<=2 else ('Pleno' if x <=5 else "Senior"))

df.sort_values(by='tempo_servico',ascending=False,inplace=True)

df.reset_index(drop=True, inplace=True)

df.drop(columns='vendas_mensais', inplace=True)


df_vendas_com_dados = df_vendas.merge(
    df[['nome', 'comissao_por_tempo']],
    left_on='funcionario',
    right_on='nome',
    how='left'
)



taxas_comissao = {
    'Junior':0.05,
    'Pleno': 0.075,
    'Senior': 0.1
}

df_vendas_com_dados['valor_comissionado'] = round(df_vendas_com_dados['valor'] + (df_vendas_com_dados['valor'] * (df_vendas_com_dados['comissao_por_tempo'].map(taxas_comissao))),2)

print(2*'\n', 50*'_')

df_final = df_vendas_com_dados.groupby(['funcionario','comissao_por_tempo'])['valor_comissionado'].sum()
print(df_final.sort_values(ascending=False))
