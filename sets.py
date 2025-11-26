carros = {"gol","palio"} #indicação implícita de set(conjunto)

cores1 = set(('azul','preto','amarelo','amarelo')) #indicações explícitas de sets
cores2 = set(('vermelho','preto','amarelo','cinza','laranja','marrom'))

cores2.add('azul')



print(f'\nConjuntos:\n{cores1}\n{cores2}\n\n')

print(f' Union - {cores1.union(cores2)}')
print(f' Intersection - {cores1.intersection(cores2)}')
print(f' Difference - {cores1.difference(cores2)}')
print(f' Symmetric_difference - {cores1.symmetric_difference(cores2)}')
print(f' Is_Sub_Set -{cores1.issubset(cores2)}')
print(f' Is_Super_Set - {cores1.issuperset(cores2)}')

print(f'\n Lista 2 completa: \n{cores2}')

cores2.discard('marrom')
print(f'\nDiscard marrom : {cores2}')

cores2.pop()
cores2.pop()
print(f'\nPop duas vezes : {cores2}')


