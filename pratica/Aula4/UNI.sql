--CREATE SCHEMA UNI
--GO

CREATE TABLE UNI.projeto_investigacao(
	ID									INT CHECK(ID>0) NOT NULL,
	Entidade_financiadora				VARCHAR(50) NOT NULL,
	Nome								VARCHAR(50) NOT NULL,
	Data_fim							DATE NOT NULL,
	Data_inicio							DATE NOT NULL,
	Orçamento							INT CHECK(Orçamento>0) NOT NULL,
	PRIMARY KEY(ID)
);

CREATE TABLE UNI.departamento(
	Nome_unico							VARCHAR(50) NOT NULL,
	Localizacao							VARCHAR(100) NOT NULL,
	PRIMARY KEY(Nome_Unico)
);

CREATE TABLE UNI.professor(
	Categoria_profissional				VARCHAR(50) NOT NULL,
	Area_Cientifica						VARCHAR(50) NOT NULL,
	Nome								VARCHAR(50) NOT NULL,
	P_participacao						INT CHECK(P_participacao >0) NOT NULL,
	N_mec_prof							INT CHECK(N_mec_prof>0) NOT NULL,
	Nome_unico							VARCHAR(50) NOT NULL,
	FOREIGN KEY(Nome_unico) REFERENCES UNI.departamento(Nome_unico),
	PRIMARY KEY(N_mec_prof, Nome_unico)
);

CREATE TABLE UNI.estudante_graduacao(
	Nome								VARCHAR(50) NOT NULL,
	Data_nasc							DATE NOT NULL,
	Nome_unico							VARCHAR(50) NOT NULL,
	N_mec_alun							INT CHECK(N_mec_alun>0) NOT NULL,
	Grau_Formacao						VARCHAR(50) NOT NULL,
	FOREIGN KEY(Nome_unico) REFERENCES UNI.departamento(Nome_unico),
	PRIMARY KEY(N_mec_alun,Nome_unico)
);

CREATE TABLE UNI.gere(
	N_mec_prof							INT CHECK(N_mec_prof>0) NOT NULL,
	ID									INT CHECK(ID>0) NOT NULL,
	Nome_unico							VARCHAR(50) NOT NULL,
	FOREIGN KEY(N_mec_prof,Nome_unico) REFERENCES UNI.professor(N_mec_prof,Nome_unico),
	FOREIGN KEY(ID) REFERENCES UNI.projeto_investigacao(ID),
	PRIMARY KEY (N_mec_prof, ID, Nome_unico)
);

CREATE TABLE UNI.supervisiona(
	N_mec_prof							INT CHECK(N_mec_prof>0) NOT NULL,
	N_mec_alun							INT CHECK(N_mec_alun>0) NOT NULL,
	Nome_unico							VARCHAR(50) NOT NULL,
	FOREIGN KEY(N_mec_prof,Nome_unico) REFERENCES UNI.professor(N_mec_prof,Nome_unico),
	FOREIGN KEY(N_mec_alun,Nome_unico) REFERENCES UNI.estudante_graduacao(N_mec_alun,Nome_unico),
	PRIMARY KEY (N_mec_prof,N_mec_alun, Nome_unico)
);

CREATE TABLE UNI.participa(
	ID									INT CHECK(ID>0) NOT NULL,
	N_mec_alun							INT CHECK(N_mec_alun>0) NOT NULL,
	Nome_unico							VARCHAR(50) NOT NULL,
	FOREIGN KEY(ID) REFERENCES UNI.projeto_investigacao(ID),
	FOREIGN KEY(N_mec_alun,Nome_unico) REFERENCES UNI.estudante_graduacao(N_mec_alun,Nome_unico),
	PRIMARY KEY(ID,N_mec_alun,Nome_unico)
);