-- Usuários --
CREATE USER 'Mohamad'@'localhost' IDENTIFIED BY 'admin';
CREATE USER 'Gabriel'@'localhost' IDENTIFIED BY 'gerente';
CREATE USER 'Vinicius'@'localhost' IDENTIFIED BY 'atendimento';
CREATE USER 'Luca'@'localhost' IDENTIFIED BY 'manutencao';
CREATE USER 'Isabella'@'localhost' IDENTIFIED BY 'analistadados';
CREATE USER 'Vitor'@'localhost' IDENTIFIED BY 'agentecheckin';

-- Papéis --
CREATE ROLE `admin`;
CREATE ROLE gerente_operacoes;
CREATE ROLE atendimento_cliente;
CREATE ROLE tecnico_manutencao;
CREATE ROLE analista_dados;
CREATE ROLE agente_checkin;


-- Conceder Papel aos Usuários --
GRANT `admin` TO 'Mohamad'@'localhost';
GRANT gerente_operacoes TO 'Gabriel'@'localhost';
GRANT atendimento_cliente TO 'Vinicius'@'localhost';
GRANT tecnico_manutencao TO 'Luca'@'localhost';
GRANT analista_dados TO 'Isabella'@'localhost';
GRANT agente_checkin TO 'Vitor'@'localhost';


-- Privilégios aos Papéis--
-- Admin --
/* Justificativa: O administrador tem privilégio global para realizar qualquer operação. */
GRANT ALL PRIVILEGES ON *.* TO `admin` WITH GRANT OPTION;

-- Gerente --
/* Justificativa: O gerente de operações precisa gerenciar informações de todas as tabelas do banco 
pois ele é responsável pelo gerenciamento das operações diárias e acompanhamento de voos */
GRANT SELECT,INSERT, UPDATE, DELETE ON controledetrafego.* TO gerente_operacoes;

-- Atendimento --
/* O atendente ao cliente precisa acessar informações sobre pessoas, passageiros, funcionários, contatos, 
viagens e rotas para conseguir atender os clientes com eficiência */
GRANT SELECT ON controledetrafego.people TO atendimento_cliente;
GRANT SELECT ON controledetrafego.passenger TO atendimento_cliente;
GRANT SELECT ON controledetrafego.employee TO atendimento_cliente;
GRANT SELECT ON controledetrafego.contact TO atendimento_cliente;
GRANT SELECT ON controledetrafego.trip TO atendimento_cliente;
GRANT SELECT ON controledetrafego.route TO atendimento_cliente;

-- Manutenção --
/* Justificativa: O técnico de manutenção precisa acessar informações sobre funcionários manutenções e aviões. De funcionário para saber seu ID, 
Aviões para conhecer os aviões, de manutenção para fazer seu trabalho corretamente */
GRANT SELECT ON controledetrafego.employee TO tecnico_manutencao;
GRANT SELECT(id, model, company_id) ON controledetrafego.plane TO tecnico_manutencao;
GRANT SELECT, INSERT, UPDATE, DELETE ON controledetrafego.maintenance TO tecnico_manutencao;

-- Analista de Dados --
/* Justificativa: O analista de dados precisa de acesso de leitura a todas as tabelas para análise de dados. */
GRANT SELECT ON controledetrafego.* TO analista_dados;

-- Agente de Checkin --
/* Justificativa: O agente de check-in precisa acessar informações sobre pessoas, passageiros, funcionários, viagens e rotas 
para verfificar e atualizar o check-in dos passageiros e funcionários, realizando seu trabalho. */
GRANT SELECT ON controledetrafego.people TO agente_checkin;
GRANT SELECT ON controledetrafego.passenger TO agente_checkin;
GRANT SELECT ON controledetrafego.employee TO agente_checkin;
GRANT SELECT, UPDATE ON controledetrafego.trip TO agente_checkin;
GRANT SELECT ON controledetrafego.route TO agente_checkin;

-- Definir a Role como Default do Usuário --
ALTER USER 'Mohamad'@'localhost' DEFAULT ROLE `admin`;
ALTER USER 'Gabriel'@'localhost' DEFAULT ROLE gerente_operacoes;
ALTER USER 'Vinicius'@'localhost'DEFAULT ROLE atendimento_cliente;
ALTER USER 'Luca'@'localhost' DEFAULT ROLE tecnico_manutencao;
ALTER USER 'Isabella'@'localhost' DEFAULT ROLE analista_dados;
ALTER USER 'Vitor'@'localhost' DEFAULT ROLE agente_checkin;
