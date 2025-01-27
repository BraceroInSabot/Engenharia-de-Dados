-- Criação da tabela Categoria
CREATE TABLE Categoria (
    CategoriaID INT PRIMARY KEY,
    Nome VARCHAR(155),
    Ativo BOOL
);

-- Criação da tabela Vendedor
CREATE TABLE Vendedor (
    VendedorID INT PRIMARY KEY,
    Nome VARCHAR(255),
    ValorComissao FLOAT,
    DataNascimento DATE,
    DataAdmissao DATE
);

-- Criação da tabela Venda
CREATE TABLE Venda (
    VendaID INT PRIMARY KEY,
    EmissaoFiscal INT,
    ValorVenda FLOAT,
    ValorDesconto FLOAT,
    DataVenda DATE,
    VendedorID INT,
    TipoPagamento CHAR(3),
    CONSTRAINT FK_Venda_Vendedor FOREIGN KEY (VendedorID) REFERENCES Vendedor (VendedorID)
);

-- Criação da tabela Produtos_Venda
CREATE TABLE Produtos_Venda (
    PVID INT PRIMARY KEY,
    Produto VARCHAR(255),
    CodigoBarra VARCHAR(13),
    Quantidade INT,
    ValorCompra FLOAT,
    DataVencimento DATE,
    CategoriaID INT,
    CONSTRAINT FK_ProdutosVenda_Categoria FOREIGN KEY (CategoriaID) REFERENCES Categoria (CategoriaID)
);
