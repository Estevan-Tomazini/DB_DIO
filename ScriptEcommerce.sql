-- Criação de BD para E-commerce
drop database ecommerce;
create database ecommerce;
use ecommerce;

-- tabelas 
-- Cliente 
create table Cliente (
	idCliente int auto_increment primary key,
    Nome varchar(12) not null,
    NomeMeio varchar(12),
    Sobrenome varchar(20) not null,
    CPF char(12) not null unique,
    -- poderia ser "constraint unique_cpf_cliente unique (CPF)"
    Endereço varchar(120),
    DataNascimento date not null,
    data_cadastro date
    );

-- Pedido
CREATE TABLE Pedido (
	idPedido INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	id_PedidoCliente INT NOT NULL,
    StatusPedido ENUM("Cancelado", "Confirmado", "Em processamento") NOT NULL,
    Descrição VARCHAR(120) NOT NULL,
    Frete FLOAT,
    RelaçãoProdutoPedido_Produto_idProduto INT NOT NULL,
    Pagamentos_idPagamentos INT NOT NULL,
    Pagamentos_Cliente_idCliente INT NOT NULL,
    data_cadastro date
);
-- Produto
create table Produto (
	idProduto int not null primary key,
    Categoria varchar(45) not null,
    Descrição varchar(45) not null,
    Valor float not null,
    data_cadastro date
);
-- Estoque
create table Estoque (
	idEstoque int not null primary key,
    Localização varchar (120) not null,
    Quantidade int not null,
    ValorFrete float ,
    data_cadastro date
);

-- RelaçãoProdutoPedido
create table RelaçãoProdutoPedido (
	Produto_idProduto int not null primary key,
    Quantidade varchar(45),
    StatusProduto enum("Disponível", "Indisponível") not null,
    data_cadastro date
);

-- ProdutoEmEstoque
CREATE TABLE ProdutoEmEstoque (
	idProdutoEmEstoque INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Produto_idProduto INT NOT NULL,
    Estoque_idEstoque INT NOT NULL,
    Quantidade VARCHAR(45),
    ProdutoEmEstoque ENUM("Disponível", "Indisponível") NOT NULL,
    data_cadastro date
);

-- ProdutoEmEstoque
CREATE TABLE ProdutoPorVendedorTerceiro (
	idProdutoPorVendedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Produto_idProduto INT NOT NULL,
    Terceiro_idVendedor INT NOT NULL,
    Quantidade INT,
    data_cadastro date
);

-- Fornecedor
create table Fornecedor (
	idFornecedor int not null primary key,
    RazãoSocial varchar (45) not null,
    CNPJ varchar (15) not null,
    ContatoFornecedor varchar (45) not null,
    data_cadastro date
    
);

-- DiponibilizandoProduto
CREATE TABLE DisponibilizandoProduto (
    idDisponibilizandoProduto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Produto_idProduto INT NOT NULL,
    Fornecedor_idFornecedor INT NOT NULL,
    data_cadastro date
);

-- TerceiroVendedor
create table TerceiroVendedor (
	idTerceiroVendedor int not null primary key,
    RazãoSocial varchar(45) not null,
    Localização varchar(45) not null,
    NomeFantasia varchar (45) not null,
    data_cadastro date
);

-- adicionais como Pagamento, criar esquema tambem

create table Pagamento(
	id_Cliente int not null,
    id_Pagamento int not null,
    TipoPagamento enum ("Crédito", "Débito", "2 cartões", "PIX", "Dinheiro") not null,
	LimiteDisponível float not null,
    primary key (id_Cliente, id_Pagamento),
    data_cadastro date

);

GRANT SELECT ON information_schema.* TO root@localhost;

INSERT into Cliente (Nome, NomeMeio, Sobrenome, CPF, Endereço, DataNascimento, data_cadastro)
	VALUES ("Joao", "beira", "Candido","023654848414", "08/10/2008", 12/05/2022), 
	("Ana", "", "Conda","023654848415", "08/07/2001", 13/05/2022), 
    ("Bruno", "Sinestra", "Buffo","023654848424", "03/09/1952", 14/05/2022), 
    ("Joana", "Al", "Berg","023654848314", "18/10/1974", 12/06/2022), 
    ("Katrina", "muito", "Pouca","023654849414", "28/12/2008", 12/07/2022),
    ("Joao", "Bettega", "Apanhado","023654848414", "13/11/2011", 12/08/2022);
    
INSERT into Pedido (idPedido, id_PedidoCliente, StatusPedido, Descrição, Frete, RelaçãoProdutoPedido_Produto_idProduto, Pagamentos_idPagamentos, Pagamentos_Cliente_idCliente)
	VALUES (NULL, 1, 'Confirmado', 'Compra de um notebook', 100, 1, 1, 1),
    (NULL, 2, 'Cancelado', 'Cancelou compra de calcinha', 100, 2, 2, 2),
    (NULL, 3, 'Em processamento', 'Compra de 2 kg de frango', 100, 3, 3, 3),
    (NULL, 4, 'Confirmado', 'Compra de um escravo ANCAP', 100, 4, 4, 4),
    (NULL, 5, 'Confirmado', 'Compra de uma glock', 600, 5, 5, 5),
    (NULL, 6, 'Em processamento', 'Compra de uma S10', 1000, 6, 6, 6),
    (NULL, 7, 'Cancelado', 'Cancelou compra de 1 caixa de Derby', 5, 7, 7, 7);
    
INSERT into Produto (idProduto, Categoria, Descrição, Valor)
	VALUES (1, 'Eletrônicos', 'Notebook', 2000),
	(2, 'Eletrônicos', 'Telefone celular', 1000),
	(3, 'Eletrônicos', 'Tablet', 1500),
	(4, 'Eletrônicos', 'TV', 3000),
	(5, 'Eletrônicos', 'Geladeira', 2500),
	(6, 'Eletrônicos', 'Fogão', 1000);
    
INSERT into Estoque (idEstoque, Localização, Quantidade, ValorFrete)
	values (1, 'São Paulo', 100, 50),
	(2, 'Rio de Janeiro', 50, 25),
	(3, 'Belo Horizonte', 25, 15),
	(4, 'Salvador', 10, 10),
	(5, 'Fortaleza', 5, 5),
	(6, 'Recife', 2, 2);
    
INSERT into RelaçãoProdutoPedido (Produto_idProduto, Quantidade, StatusProduto)
	VALUES (1, 1, 'Disponível'),
	(2, 2, 'Disponível'),
	(3, 3, 'Disponível'),
	(4, 4, 'Disponível'),
	(5, 5, 'Disponível'),
	(6, 6, 'Disponível');
    
INSERT into ProdutoEmEstoque (idProdutoEmEstoque, Produto_idProduto, Estoque_idEstoque, Quantidade, ProdutoEmEstoque)
	VALUES (1, 1, 1, 10, 'Disponível'),
	(2, 2, 2, 5, 'Disponível'),
	(3, 3, 3, 2, 'Disponível'),
	(4, 4, 4, 1, 'Disponível'),
	(5, 5, 5, 1, 'Disponível'),
	(6, 6, 6, 2, 'Disponível');
    
INSERT into Fornecedor (idFornecedor, RazãoSocial, CNPJ, ContatoFornecedor)
	VALUES (1, 'Samsung', '12.345.678/9001-01', '(11) 9999-9999'),
	(2, 'LG', '23.456.789/0001-02', '(21) 9888-8888'),
	(3, 'Apple', '34.567.890/1001-03', '(31) 9777-7777'),
	(4, 'Sony', '45.678.901/2001-04', '(41) 9666-6666'),
	(5, 'Motorola', '56.789.012/3001-05', '(51) 9555-5555');
    
INSERT into DisponibilizandoProduto (idDisponibilizandoProduto, Produto_idProduto, Fornecedor_idFornecedor)
	VALUES (1, 1, 1),
	(2, 2, 2),
	(3, 3, 3),
	(4, 4, 4),
	(5, 5, 5);

-- Querries:
-- 1 - Buscar cliente por CPF específico
SELECT * FROM Cliente WHERE CPF = '12345678901';
-- 2 - Buscar produtos por categoria
SELECT * FROM Produto WHERE Categoria = 'Eletrônicos';
-- 3 - Buscar produtos com estoque pequeno
SELECT * FROM Estoque WHERE Quantidade < 10;
-- 4 - Buscar por produtos com disponibilidade 
SELECT * FROM RelaçãoProdutoPedido WHERE StatusProduto = 'Disponível';
-- 5 - Buscar produtos disponíveis em estoque
SELECT * FROM ProdutoEmEstoque WHERE Produto_idProduto = 1 AND Estoque_idEstoque = 1;
-- 6 - Buscar produto vendido por vendedor conveniado 
SELECT * FROM ProdutoPorVendedorTerceiro WHERE Terceiro_idVendedor = 1;
-- 7 - Buscar fornecedor por razão social
SELECT * FROM Fornecedor WHERE RazãoSocial = 'Empresa X';
-- 8 - Buscar produto disponível no distribuídora
SELECT * FROM DisponibilizandoProduto WHERE Produto_idProduto = 1 AND Fornecedor_idFornecedor = 1;
-- 9 - Buscar vendedor conveniado pela razão social e localidade
SELECT * FROM TerceiroVendedor WHERE RazãoSocial = 'Empresa X' AND Localização = 'Curitiba';
-- 10 -  Mostrar tudo de cliente join pedido
SELECT * FROM Cliente c JOIN Pedido p ON c.idCliente = p.id_PedidoCliente;
-- 11 - Mostrar todos os produtos em estoque por Id
SELECT * FROM Produto p JOIN Estoque e ON p.idProduto = e.Produto_idProduto;
-- 12 - Mostra relação de produto pedido junto com a entidade Produto, mostrando id do vendedor conveniado
SELECT * FROM RelaçãoProdutoPedido rp JOIN Produto p ON rp.Produto_idProduto = p.idProduto;
-- 13 - Mostra produto do parceiro com a entidade Produto
SELECT * FROM ProdutoPorVendedorTerceiro pvt JOIN TerceiroVendedor tv ON pvt.Terceiro_idVendedor = tv.idTerceiroVendedor;
-- 14 - Mostra produto disponibilizado com a entidade fornecedor por id
SELECT * FROM DisponibilizandoProduto dp JOIN Fornecedor f ON dp.Fornecedor_idFornecedor = f.idFornecedor;



show tables;
show databases;
use information_schema;
show tables;
desc table_constraints;