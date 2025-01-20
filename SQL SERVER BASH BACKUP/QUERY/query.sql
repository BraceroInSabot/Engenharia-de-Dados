-- Verificar e criar tabela Produto
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Produto' AND type = 'U')
BEGIN
    CREATE TABLE Produto (
        CodigoProduto INT IDENTITY(1,1) PRIMARY KEY,
        NomeProduto VARCHAR(255),
        Quantidade INT NOT NULL,
        Preco NUMERIC(6,2)
    );
END;

-- Verificar e criar tabela Cliente
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Cliente' AND type = 'U')
BEGIN
    CREATE TABLE Cliente (
        CodigoCliente INT IDENTITY(1,1) PRIMARY KEY,
        NomeCliente VARCHAR(255),
        Ativo BIT
    );
END;

-- Verificar e criar tabela Venda
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Venda' AND type = 'U')
BEGIN
    CREATE TABLE Venda (
        CodigoVenda INT IDENTITY(1,1) PRIMARY KEY,
        Preco NUMERIC(6,2),
        DataVenda DATE
    );
END;

-- Verificar e criar tabela Venda_Produto
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Venda_Produto' AND type = 'U')
BEGIN
    CREATE TABLE Venda_Produto (
        CodigoVenda INT,
        CodigoProduto INT,
        CodigoCliente INT,
        Quantidade INT,
        CONSTRAINT PK_Venda_Produto_CodigoVenda FOREIGN KEY (CodigoVenda) REFERENCES Venda(CodigoVenda),
        CONSTRAINT PK_Venda_Produto_CodigoProduto FOREIGN KEY (CodigoProduto) REFERENCES Produto(CodigoProduto),
        CONSTRAINT PK_Venda_Produto_CodigoCliente FOREIGN KEY (CodigoCliente) REFERENCES Cliente(CodigoCliente)
    );
END;


-- Inserindo dados na tabela Produto
INSERT INTO Produto (NomeProduto, Quantidade, Preco) VALUES ('Coca-Cola', 10, 12.50);
INSERT INTO Produto (NomeProduto, Quantidade, Preco) VALUES ('Chocolate Garoto', 25, 2.50);
INSERT INTO Produto (NomeProduto, Quantidade, Preco) VALUES ('Batman', 1, 9999.99);

-- Inserindo dados na tabela Cliente
INSERT INTO Cliente (NomeCliente, Ativo) VALUES ('Batman', 1);
INSERT INTO Cliente (NomeCliente, Ativo) VALUES ('Jorge', 1);
INSERT INTO Cliente (NomeCliente, Ativo) VALUES ('Bill Gates', 0);

-- Inserindo dados na tabela Venda
INSERT INTO Venda (Preco, DataVenda) VALUES (12.50, '2024-11-06');
INSERT INTO Venda (Preco, DataVenda) VALUES (17.50, '2024-11-01');

-- Inserindo dados na tabela Venda_Produto
INSERT INTO Venda_Produto (CodigoProduto, CodigoVenda, CodigoCliente, Quantidade) VALUES (1, 1, 1, 1);
INSERT INTO Venda_Produto (CodigoProduto, CodigoVenda, CodigoCliente, Quantidade) VALUES (1, 2, 3, 1);
INSERT INTO Venda_Produto (CodigoProduto, CodigoVenda, CodigoCliente, Quantidade) VALUES (1, 2, 3, 2);
