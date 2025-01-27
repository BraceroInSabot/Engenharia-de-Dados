-- Inserir dados na tabela Categoria
INSERT INTO Categoria (CategoriaID, Nome, Ativo)
VALUES
(1, 'Eletrodomésticos', TRUE),
(2, 'Eletrônicos', TRUE),
(3, 'Informática', TRUE),
(4, 'Celulares', TRUE),
(5, 'Acessórios', TRUE),
(6, 'Áudio', TRUE),
(7, 'Iluminação', TRUE),
(8, 'Televisores', TRUE),
(9, 'Segurança', TRUE),
(10, 'Cozinha', TRUE),
(11, 'Ar-Condicionado', TRUE),
(12, 'Ventiladores', TRUE),
(13, 'Aquecedores', TRUE),
(14, 'Lavanderia', TRUE),
(15, 'Automação Residencial', TRUE);

-- Inserir dados na tabela Vendedor
INSERT INTO Vendedor (VendedorID, Nome, ValorComissao, DataNascimento, DataAdmissao)
VALUES
(1, 'João Silva', 5.0, '1990-01-01', '2020-05-15'),
(2, 'Maria Oliveira', 4.5, '1985-09-10', '2018-03-20'),
(3, 'Pedro Santos', 6.0, '1992-06-18', '2021-07-01'),
(4, 'Ana Lima', 5.5, '1995-03-25', '2019-11-10');

-- Inserir 50 vendas na tabela Venda
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..50 LOOP
        INSERT INTO Venda (VendaID, EmissaoFiscal, ValorVenda, ValorDesconto, DataVenda, VendedorID, TipoPagamento)
        VALUES 
        (
            i,
            100000 + i,
            (RANDOM() * (5000 - 500) + 500)::NUMERIC(10, 2),
            (RANDOM() * (200 - 20) + 20)::NUMERIC(10, 2),
            CURRENT_DATE - (i % 30),
            (1 + (i % 4)), -- Distribui entre os 4 vendedores
            CASE 
                WHEN i % 3 = 0 THEN 'PIX'
                WHEN i % 3 = 1 THEN 'DIN'
                ELSE 'CRD'
            END
        );
    END LOOP;
END $$;

-- Inserir entre 50 e 100 produtos na tabela Produtos_Venda
DO $$
DECLARE
    i INT;
    total INT := (50 + RANDOM() * 50)::INT; -- Número aleatório entre 50 e 100
BEGIN
    FOR i IN 1..total LOOP
        INSERT INTO Produtos_Venda (PVID, Produto, CodigoBarra, Quantidade, ValorCompra, DataVencimento, CategoriaID)
        VALUES
        (
            i,
            CASE 
                WHEN i % 5 = 0 THEN 'Air Fryer'
                WHEN i % 5 = 1 THEN 'Notebook'
                WHEN i % 5 = 2 THEN 'Smartphone'
                WHEN i % 5 = 3 THEN 'Smart TV'
                ELSE 'Micro-ondas'
            END,
            LPAD((TRUNC(RANDOM() * 10000000000000)::TEXT), 13, '0'),
            (1 + RANDOM() * 20)::INT,
            (RANDOM() * (3000 - 300) + 300)::NUMERIC(10, 2),
            CURRENT_DATE + (i % 365),
            (1 + (i % 15)) -- Distribui entre as 15 categorias
        );
    END LOOP;
END $$;
