CREATE TABLE agencia (
	numeroAgencia_numLocal Int,
	numeroAgencia_numSucursal Int,
	nombreAgencia VarChar(50)
	CONSTRAINT PK_agencia PRIMARY KEY (
		numeroAgencia_numLocal,
		numeroAgencia_numSucursal
	)
);

CREATE TABLE paquete (
	nombrePaquete VarChar(50),
	descuento? Boolean,
	precio Float NOT NULL,
	numeroAgencia_numLocal Int,
	numeroAgencia_numSucursal Int,
	CONSTRAINT PK_paquete PRIMARY KEY (nombrePaquete)
	CONSTRAINT FK_paquete_agencia FOREIGN KEY (
		numeroAgencia_numLocal,
		numeroAgencia_numSucursal
	) REFERENCES agencia(
		numeroAgencia_numLocal,
		numeroAgencia_numSucursal
	)
);

CREATE TABLE excursion (
	dia DATE,
	hora TIME,
	nombrePaquete VarChar(50),
	lugar VarChar(50),
	conGuia Boolean,
	CONSTRAINT PK_excursion PRIMARY KEY (
		dia,
		hora
	),
	CONSTRAINT FK_excursion_paquete FOREIGN KEY (
		nombrePaquete
	)
);

CREATE TABLE vuelo (
	aerolinea VarChar(50),
	nroVuelo Int,
	horarioLlegada TIME,
	horarioSalida TIME,
	destino VarChar(50),
	CONSTRAINT PK_vuelo PRIMARY KEY (
		aerolinea,
		nroVuelo
	)
);

CREATE TABLE cliente (
	NroPasaporte Int,
	apellido VarChar(50),
	fecNac DATE,
	tarjetaDeCredito VarChar(50),
	nombrePaquete,
	CONSTRAINT PK_cliente PRIMARY KEY (
		NroPasaporte
	),
	CONSTRAINT FK_cliente_paquete FOREIGN KEY (
		nombrePaquete
	) REFERENCES paquete(
		nombrePaquete
	)
);

CREATE TABLE equipaje (
	nroEquipaje Int,
	NroPasaporte Int,
	marca VarChar(50),
	color VarChar(50),
	tipo VarChar(50),
	peso FLOAT,
	CONSTRAINT PK_equipaje PRIMARY KEY (
		nroEquipaje,
		NroPasaporte
	),
	CONSTRAINT FK_equipaje_cliente FOREIGN KEY (
		NroPasaporte
	) REFERENCES cliente(
		NroPasaporte
	)
);

CREATE TABLE incluye (
	nombrePaquete VarChar(50),
	nroVuelo Int,
	aerolinea VarChar(50),
	CONSTRAINT PK_incluye PRIMARY KEY (
		nombrePaquete,
		nroVuelo,
		aerolinea
	),
	CONSTRAINT FK_incluye_paquete FOREIGN KEY (
		nombrePaquete
	) REFERENCES paquete(
		nombrePaquete
	),
	CONSTRAINT FK_incluye_vuelo FOREIGN KEY (
		nroVuelo,
		aerolinea
	) REFERENCES vuelo(
		nroVuelo,
		aerolinea
	)
);

ALTER TABLE paquete
	ADD CONSTRAINT CHK_paquete_precio CHECK (
		100000 < precio && precio < 200000
	)

ALTER TABLE vuelo
	ADD CONSTRAINT CHK_vuelo_destino CHECK (
		destino IN (
			"San Juan",
			"Mendoza",
			"Jujuy",
			"Salta"
		)
	)