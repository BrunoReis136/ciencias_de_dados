dict1 = dict(key = 1, idade = 36) #declaração explícita de dicionário

dados_pessoais = {'nome':'Bruno', "idade":36, 'curso':'ciência de dados'} #declaração implícita de diconário

dados_pessoais['nome']
dados_pessoais['idade']
dados_pessoais['curso']

dados_pessoais['curso'] = 'Python com ciência de dados.'

contatos = {
    1:{'nome':'Alberto','telefone':'1111-2222'},
    2:{'nome':'Bruce','telefone':'2222-3333'},
    3:{'nome':'Carl','telefone':'3333-4444'}
}

nome_contato1 = contatos[1]['nome']

for i in contatos:
    print(contatos[i]['nome'])

for chave,valor in contatos.items():
    print(chave,valor['nome'])  


copia = contatos.copy()

limpo = copia.clear()


for contato in contatos:
    contatos[contato].update({
        'enredeço' : ' - ',
        'email': ' - '
    })

print(contatos)

contatos.get('chave inexistente') #não encontrando a chave, retorna none e segue o programa sem erro
contatos.get('chave incexistente',{}) #não encontrando a chave, e retorna um dicionário vazio

contatos.items() 

print(contatos.keys()) #retorna lista de chaves
contatos.values() #retorna lista com todos os valores sem as chaves



contatos.pop('valor inexistente', 'inexistente') #não encontrando a chave, retorna mensagem

contatos.popitem() #exclui o primeiro item do dicionário

contatos.setdefault('telefone','0000-0000') #define valor padrão caso não seja informado

if "telefone" in contatos[1]:
    print('Contato 1 tem a chave telefone')

'''Adicionando um novo item com campos preenchidos em padrão'''

modelo_contato = {
    'nome' : ' - ',
    'telefone' : ' - ',
    'endereço' : ' - ',
    'email' : ' - '
}

novo_contato = modelo_contato.copy()

novo_contato['nome'] = 'Denis'
novo_contato['endereço'] = 'Rua 2'

contatos[len(contatos) + 1 ] = novo_contato

print(f'\n\n Lista com novo contato: \n\n')
for contato in contatos:
    print(contatos[contato])