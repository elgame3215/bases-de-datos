DROP DATABASE parcial1;
CREATE DATABASE parcial1;
USE parcial1;

CREATE TABLE personaje (
	escuela		VARCHAR(50),
	nombre_pj 	VARCHAR(50),
	ciudad 		VARCHAR(50),
	CONSTRAINT PK_personaje PRIMARY KEY (
		escuela, nombre_pj
	)
);

CREATE TABLE elemento (
	nombre_elem VARCHAR(50),
	es_Especial BOOLEAN,
	origen 		VARCHAR(50),
	CONSTRAINT PK_elemento PRIMARY KEY (
		nombre_elem
	)
);

CREATE TABLE objeto_magico (
	nombre_obj 	VARCHAR(50),
	momento	 	VARCHAR(50),
	es_Maligno 	BOOLEAN,
	escuela 	VARCHAR(50),
	nombre_pj 	VARCHAR(50),
	CONSTRAINT PK_objeto_magico PRIMARY KEY (
		nombre_obj,
		momento
	),
	CONSTRAINT FK_objeto_magico_personaje FOREIGN KEY (
		escuela,
		nombre_pj
	) REFERENCES personaje (
		escuela,
		nombre_pj
	)
);

CREATE TABLE evento (
	lugar 	VARCHAR(50),
	horario TIME,
	limite 	INT,
	CONSTRAINT PK_evento PRIMARY KEY (
		lugar,
		horario
	)
);

CREATE TABLE activa (
	fecha DATE,
	escuela VARCHAR(50),
	nombre_pj VARCHAR(50),
	nombre_elem VARCHAR(50),
	CONSTRAINT PK_activa PRIMARY KEY (
		fecha,
		escuela,
		nombre_pj,
		nombre_elem
	),
	CONSTRAINT FK_activa_personaje FOREIGN KEY (
		escuela,
		nombre_pj
	) REFERENCES personaje (
		escuela,
		nombre_pj
	),
	CONSTRAINT FK_activa_elemento FOREIGN KEY (
		nombre_elem
	) REFERENCES elemento (
		nombre_elem
	)
);

CREATE TABLE se_usa_en (
	horario TIME,
	lugar VARCHAR(50),
	momento VARCHAR(50),
	nombre_obj VARCHAR(50),
	CONSTRAINT PK_se_usa_en PRIMARY KEY (
		horario,
		lugar
	),
	CONSTRAINT FK_se_usa_en_evento FOREIGN KEY (
		lugar,
		horario
	) REFERENCES evento (
		lugar,
		horario
	),
	CONSTRAINT FK_se_usa_en_objeto_magico FOREIGN KEY (
		nombre_obj,
		momento
	) REFERENCES objeto_magico (
		nombre_obj,
		momento
	)
);

ALTER TABLE evento
	ADD CONSTRAINT CHK_evento_limite CHECK (
		60 <= limite AND limite <= 120
	);

ALTER TABLE personaje
	ADD CONSTRAINT CHK_personaje_ciudad CHECK (
		ciudad IN (
			"Sahara",
			"Tundratown",
			"Rainforest",
			"Savanna"
		)
	)