--CREATE SCHEMA SNS
--GO

DROP SCHEMA SNS
GO

CREATE TABLE SNS.medico(
	N_sns					INT CHECK(N_sns >=0) NOT NULL,
	Nome					VARCHAR(50) NOT NULL,
	Especialidade			VARCHAR(50) NOT NULL
	PRIMARY KEY (N_sns)
);

CREATE TABLE SNS.paciente(
	N_utente				INT CHECK(N_utente >= 0) NOT NULL,
	Endereco				VARCHAR(100) NOT NULL,
	Nome					VARCHAR(50) NOT NULL,
	Data_nasc				DATE NOT NULL,
	PRIMARY KEY (N_utente)
);

CREATE TABLE SNS.farmacia(
	NIF						INT CHECK(NIF>=0) NOT NULL,
	Nome					VARCHAR(50) NOT NULL,
	Telefone				INT CHECK(Telefone > 0) NOT NULL,
	Endereço				VARCHAR(100) NOT NULL,
	PRIMARY KEY (NIF)
);

CREATE TABLE SNS.farmaceutica(
	N_registo_nacional		INT CHECK(N_registo_nacional >= 0) NOT NULL,
	Telefone				INT CHECK(Telefone > 0) NOT NULL,
	Endereço				VARCHAR(100) NOT NULL,
	Nome					VARCHAR(50) NOT NULL,
	PRIMARY KEY (N_registo_nacional)
);

CREATE TABLE SNS.prescricao(
	N_prescricao			INT CHECK(N_prescricao>=0) NOT NULL,
	Data_pres				DATE NOT NULL,
	NIF_Farmacia			INT CHECK(NIF_Farmacia>=0) NOT NULL,
	N_sns_medico			INT CHECK(N_sns_medico >=0) NOT NULL,
	N_utente				INT CHECK(N_utente >= 0) NOT NULL,
	Data_process			DATE NOT NULL,
	FOREIGN KEY(NIF_Farmacia) REFERENCES SNS.farmacia(NIF),
	FOREIGN KEY(N_sns_medico) REFERENCES SNS.medico(N_sns),
	FOREIGN KEY(N_utente) REFERENCES SNS.paciente(N_utente),
	PRIMARY KEY(N_prescricao, NIF_Farmacia, N_sns_medico, N_utente)
);

CREATE TABLE SNS.farmacos(
	Nome					VARCHAR(50) NOT NULL,
	Nome_unico				VARCHAR(100) NOT NULL,
	NIF_Farmacia			INT CHECK(NIF_Farmacia>=0) NOT NULL,
	N_sns_medico			INT CHECK(N_sns_medico >=0) NOT NULL,
	N_utente				INT CHECK(N_utente >= 0) NOT NULL,
	Farmaceutica			INT CHECK(Farmaceutica >= 0) NOT NULL,
	Formula					VARCHAR(50) NOT NULL,
	N_prescricao			INT NOT NULL,
	FOREIGN KEY(Farmaceutica) REFERENCES SNS.farmaceutica(N_registo_nacional),
	FOREIGN KEY(N_prescricao,NIF_Farmacia, N_sns_medico, N_utente) REFERENCES SNS.prescricao(N_prescricao,NIF_Farmacia, N_sns_medico, N_utente),
	PRIMARY KEY(Nome_unico, Farmaceutica, N_prescricao)
);

CREATE TABLE SNS.venda(
	NIF						INT CHECK(NIF>=0) NOT NULL,
	Nome_Unico				VARCHAR(100) NOT NULL,
	Farmaceutica			INT CHECK(Farmaceutica >= 0) NOT NULL,
	N_prescricao			INT CHECK(N_prescricao >= 0) NOT NULL,
	NIF_Farmacia			INT CHECK(NIF_Farmacia>=0) NOT NULL,
	N_sns_medico			INT CHECK(N_sns_medico >=0) NOT NULL,
	N_utente				INT CHECK(N_utente >= 0) NOT NULL,
	FOREIGN KEY(N_prescricao, NIF_Farmacia, N_sns_medico, N_utente) REFERENCES SNS.prescricao(N_prescricao, NIF_Farmacia, N_sns_medico, N_utente),
	FOREIGN KEY(Nome_Unico, Farmaceutica, N_prescricao) REFERENCES SNS.farmacos(Nome_Unico, Farmaceutica, N_prescricao),
	PRIMARY KEY(NIF, Nome_unico, Farmaceutica, N_prescricao)
);