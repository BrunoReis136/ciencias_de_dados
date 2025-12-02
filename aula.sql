--Criando Tabelas

CREATE TABLE usuarios(
    id INT,
    nome VARCHAR(255) NOT NULL COMMENT 'Nome do Usuário',
    email VARCHAR(100) NOT NULL UNIQUE COMMENT 'Email do usuário',
    endereco VARCHAR(100) NOT NULL COMMENT 'Endereço do usuário',
    data_nascimento DATE NOT NULL COMMENT 'Data de nascimento do usuário'
);

CREATE TABLE viagens.destinos (
    id INT,
    nome VARCHAR(255) NOT NULL UNIQUE COMMENT 'Nome do destino',
    descricao VARCHAR(255) NOT NULL COMMENT 'Descrição do destino'
);

CREATE TABLE viagens.reservas (
    id INT COMMENT 'Identificador da reserva',
    id_usuario INT COMMENT 'Referência ao ID do usuário que fez a reserva',
    id_destino INT COMMENT 'Referência ao ID do destino da reserva',
    data DATE COMMENT 'Data da reserva',
    status VARCHAR(255) DEFAULT 'pendente' COMMENT 'Status da reserva (confirmada, pendente, cancelada, etc)'
);


---------------------------------------------------------------------------------------------------------------

-- Inserindo registros na tabela

INSERT INTO  usuarios (id, nome, email, data_nascimento, endereco) VALUES (1,"Bruno Reis","bruhreis136@hotmail.com","1989-08-18","Rua Cangambá, 180");

INSERT INTO  destinos(id, nome, descricao) VALUES (1, "Balneário Camboriú", "Viagem ao Sul com praias e passeios temáticos, incluindo o Beto Carrero World"); 

INSERT INTO reservas(id, id_usuario, id_destino, status, data) VALUES(1, 1, 1, "pendente","2026-12-10"); 
INSERT INTO reservas(id, id_usuario, id_destino, status, data) VALUES(1, 3, 3, "pendente","2026-10-05"); 

--Inserindo dados em massa para seleção
INSERT INTO usuarios (id, nome, email, data_nascimento, endereco) VALUES
(1, 'João Silva', 'joao.silva@example.com', '1990-01-01', 'Rua A'),
(2, 'Maria Santos', 'maria.santos@example.com', '1992-03-15', 'Rua B'),
(3, 'Pedro Almeida', 'pedro.almeida@example.com', '1985-07-10', 'Rua C'),
(4, 'Ana Oliveira', 'ana.oliveira@example.com', '1998-12-25', 'Rua D'),
(5, 'Carlos Pereira', 'carlos.pereira@example.com', '1991-06-05', 'Rua E'),
(6, 'Laura Mendes', 'laura.mendes@example.com', '1994-09-12', 'Rua F'),
(7, 'Fernando Santos', 'fernando.santos@example.com', '1988-02-20', 'Rua G'),
(8, 'Mariana Costa', 'mariana.costa@example.com', '1997-11-30', 'Rua H'),
(9, 'Ricardo Rodrigues', 'ricardo.rodrigues@example.com', '1993-04-18', 'Rua I'),
(10, 'Camila Alves', 'camila.alves@example.com', '1989-08-08', 'Rua J'),
(11, 'Bruno Carvalho', 'bruno.carvalho@example.com', '1995-03-25', 'Rua K'),
(12, 'Amanda Silva', 'amanda.silva@example.com', '1996-12-02', 'Rua L'),
(13, 'Paulo Mendonça', 'paulo.mendonca@example.com', '1999-07-20', 'Rua M'),
(14, 'Larissa Oliveira', 'larissa.oliveira@example.com', '1987-10-15', 'Rua N'),
(15, 'Fernanda Sousa', 'fernanda.sousa@example.com', '1992-05-08', 'Rua O'),
(16, 'Gustavo Santos', 'gustavo.santos@example.com', '1993-09-18', 'Rua P'),
(17, 'Helena Costa', 'helena.costa@example.com', '1998-02-22', 'Rua Q'),
(18, 'Diego Almeida', 'diego.almeida@example.com', '1991-11-27', 'Rua R'),
(19, 'Juliana Lima', 'juliana.lima@example.com', '1997-04-05', 'Rua S'),
(20, 'Rafaela Silva', 'rafaela.silva@example.com', '1996-01-10', 'Rua T'),
(21, 'Lucas Pereira', 'lucas.pereira@example.com', '1986-08-30', 'Rua U'),
(22, 'Fábio Rodrigues', 'fabio.rodrigues@example.com', '1989-03-12', 'Rua V'),
(23, 'Isabela Santos', 'isabela.santos@example.com', '1994-12-07', 'Rua W'),
(24, 'André Alves', 'andre.alves@example.com', '1995-09-28', 'Rua X'),
(25, 'Clara Carvalho', 'clara.carvalho@example.com', '1990-02-15', 'Rua Y'),
(26, 'Roberto Mendes', 'roberto.mendes@example.com', '1992-07-21', 'Rua Z'),
(27, 'Mariana Oliveira', 'mariana.oliveira@example.com', '1997-05-03', 'Av. A'),
(28, 'Gustavo Costa', 'gustavo.costa@example.com', '1998-11-16', 'Av. B'),
(29, 'Lara Sousa', 'lara.sousa@example.com', '1993-06-09', 'Av. C'),
(30, 'Pedro Lima', 'pedro.lima@example.com', '1996-09-27', 'Av. D');


---------------------------------------------------------------------------------------------------------------

--Seleção de dados da tabela
SELECT * FROM usuarios WHERE data_nascimento >= "1990-01-01" ORDER BY data_nascimento;

SELECT * FROM usuarios
WHERE endereco LIKE '%Rua%'; --Seleciona valores que tem o texto "Rua" em qualquer parte


--Update e Delete

UPDATE usuarios SET id = 0 WHERE email = 'bruhreis136@hotmail.com';
UPDATE usuarios SET endereco = 'Rua Dia' WHERE endereco = "Rua D";

DELETE FROM usuarios WHERE nome = "Bruno Reis";

---------------------------------------------------------------------------------------------------------------

-- DROP TABLE e ALTER TABLE
-- Criando uma tabela nova para migrar informações e apagar a tabela antiga
CREATE TABLE usuarios_nova(
    id INT,
    nome VARCHAR(255) NOT NULL COMMENT 'Nome do Usuário',
    email VARCHAR(100) NOT NULL UNIQUE COMMENT 'Email do usuário',
    endereco VARCHAR(200) NOT NULL COMMENT 'Endereço do usuário',
    data_nascimento DATE NOT NULL COMMENT 'Data de nascimento do usuário'
);

-- Migrando dados
INSERT INTO usuarios_nova(id, nome, email, endereco, data_nascimento) SELECT id, nome, email, endereco, data_nascimento FROM usuarios

-- Excluindo tabela
DROP TABLE usuarios;

-- Alterando tabela para renomear
ALTER TABLE usuarios_nova RENAME usuarios;

-- Alterando coluna de tabela diretamente
ALTER TABLE usuarios MODIFY COLUMN endereco VARCHAR(100);

---------------------------------------------------------------------------------------------------------------
-- Chave Primária
--Em criação:
CREATE TABLE usuarios_nova(
    id INT PRIMARY KEY AUTO_INCREMENT
);
--Em alteração
ALTER TABLE usuarios 
MODIFY COLUMN id INT AUTO_INCREMENT,
ADD PRIMARY KEY(id);

ALTER TABLE reservas
MODIFY COLUMN id INT AUTO_INCREMENT,
ADD PRIMARY KEY(id);

ALTER TABLE destinos
MODIFY COLUMN id INT AUTO_INCREMENT,
ADD PRIMARY KEY(id);


-- Chave Estrangeia
--Em criação:
CREATE TABLE reservas_nova(
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,

    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
        ON DELETE CASCADE --Ao deletar, deleta este registro também
        ON UPDATE CASCADE --Ao alterar, altera este registro também
);

--Em alteração:
ALTER TABLE reservas ADD CONSTRAINT fk_reservas_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id);
ALTER TABLE reservas ADD CONSTRAINT fk_reservas_destinos FOREIGN KEY (id_destino) REFERENCES destinos(id);


---------------------------------------------------------------------------------------------------------------

-- Usando SUBSTRING_INDEX para seccionar e redistribuir valores
--Criação de novas colunas
ALTER TABLE usuarios
ADD rua VARCHAR(100),
numero VARCHAR(10),
cidade VARCHAR(50),
estado VARCHAR(20),
pais VARCHAR(30);

--Registrar valores separados com SUBSTRING_INDEX por índice.
UPDATE usuarios SET
rua = SUBSTRING_INDEX(SUBSTRING_INDEX(endereco,",",1),",",-1),
numero = SUBSTRING_INDEX(SUBSTRING_INDEX(endereco,",",2),",",-1),
cidade = SUBSTRING_INDEX(SUBSTRING_INDEX(endereco,",",3),",",-1),
estado = SUBSTRING_INDEX(SUBSTRING_INDEX(endereco,",",4),",",-1),
pais = SUBSTRING_INDEX(SUBSTRING_INDEX(endereco,",",5),",",-1);

--Exclui a coluna anterior
ALTER TABLE usuarios DROP COLUMN endereco;

---------------------------------------------------------------------------------------------------------------

-- Pesquisa Avançada
--Seleciona todos registros da tabela 'usuarios' unindo com os da tabela 'reservas' se id de 'usuarios' for igual id_usuario de 'reservas':
SELECT * FROM usuarios us INNER JOIN reservas rs ON us.id = rs.id_usuario 

--INNER - Somente linhas que correspondem em ambas as tabelas.
--LEFT - Todas as linhas da tabela esquerda (+ correspondências da direita).
--RIGHT - Todas as linhas da tabela direita (+ correspondências da esquerda).
--FULL - Todas as linhas de ambas as tabelas.

-- Sub Consultas:
--Seleciona todos os registros da tabela 'destinos' onde id NÃO ESTÁ entre (seleciona toda a coluna id_destino da tabela reservas pra usar de parâmetro):
SELECT * FROM destinos WHERE id NOT IN (SELECT id_destino FROM reservas);

--Seleciona coluna nome e contagem de todos os registros da tabel 'registros' onde id_usuario é igual ao id da tabela 'usuarios' como uma nova coluna denominada 'contagem_reservas' :
SELECT nome, (SELECT COUNT(*) FROM reservas WHERE id_usuario = usuarios.id) AS contagem_reservas FROM usuarios;

-------------------- (((((( USANDO A PLATAFORMA CLOUDCLUSTERS PARA ESTUDOS.))))))-------------------------
