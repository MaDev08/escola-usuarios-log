/* 
	CREATE DATABASE Escola;
	USE Escola; 
*/

CREATE TABLE usuario(
	id INT PRIMARY KEY IDENTITY,
	nome VARCHAR (100) NOT NULL, 
	login VARCHAR (50) NOT NULL,
	senha VARCHAR(100) NOT NULL,
	email VARCHAR (100),
	data_ultima_alteracao DATETIME
);

-- TABELA DE LOG PARA REGISTRAR AS ALTERAÇÕES DE SENHAS

CREATE TABLE log_de_usuario (
	id INT PRIMARY KEY IDENTITY,
	usuario_id INT NOT NULL,
	login_usuario VARCHAR (50) NOT NULL,
	senha_antiga VARCHAR (100),
	senha_nova VARCHAR (100),
	data_alteracao DATETIME DEFAULT GETDATE(),
	ip_alteracao VARCHAR(50),
	FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);

INSERT INTO usuario (nome, login, senha, email, data_ultima_alteracao)
VALUES
    ('Administrador do Sistema', 'admin', 'SenhaAdmin123@', 'admin@sistema.com', GETDATE()),
    ('JoÃ£o Silva', 'joao.silva', 'J@o123456', 'joao.silva@empresa.com', DATEADD(day, -30, GETDATE())),
    ('Maria Oliveira', 'maria.oliveira', 'M@ria654321', 'maria.oliveira@empresa.com', DATEADD(day, -15, GETDATE())),
    ('Carlos Pereira', 'carlos.pereira', 'C@rlos789', 'carlos.pereira@empresa.com', DATEADD(day, -7, GETDATE())),
    ('Ana Santos', 'ana.santos', 'An@2023!', 'ana.santos@empresa.com', DATEADD(day, -3, GETDATE())),
    ('Pedro Costa', 'pedro.costa', 'P3dr0C0st@', 'pedro.costa@empresa.com', DATEADD(day, -1, GETDATE())),
    ('Fernanda Lima', 'fernanda.lima', 'F3rn@nd@L', 'fernanda.lima@empresa.com', GETDATE()),
    ('Ricardo Almeida', 'ricardo.almeida', 'R1c@rd0A!', 'ricardo.almeida@empresa.com', DATEADD(hour, -5, GETDATE())),
    ('Juliana Martins', 'juliana.martins', 'Ju1i@n@M', 'juliana.martins@empresa.com', DATEADD(hour, -2, GETDATE())),
    ('Roberto Nunes', 'roberto.nunes', 'R0bert0N#', 'roberto.nunes@empresa.com', DATEADD(minute, -30, GETDATE()));

--Verificando os dados inseridos
SELECT * FROM usuario;
SELECT * FROM log_de_usuario;

UPDATE usuario set senha = 'Aula@teste' WHERE id = '1'

-- Criação da Trigger 
CREATE TRIGGER trg_log_alteracao_senha
ON usuario
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Verifica se a coluna senha foi alterada
    IF UPDATE(senha)
    BEGIN
        INSERT INTO log_de_usuario (
            usuario_id,
            login_usuario,
            senha_antiga,
            senha_nova,
            data_alteracao,
            ip_alteracao
        )
        SELECT 
            i.id,
            i.login,
            d.senha,  -- Senha antiga (from DELETED)
            i.senha,  -- Senha nova (from INSERTED)
            GETDATE(),
            -- Pode-se obter o IP do cliente de outras formas (nativo no SQL Server é complexo)
            convert(varchar,CONNECTIONPROPERTY('client_net_address')) AS ip_alteracao
        FROM 
            inserted i
        INNER JOIN 
            deleted d ON i.id = d.id
        WHERE 
            i.senha <> d.senha;  -- Garante que só registra quando a senha realmente mudou
    END
END;



