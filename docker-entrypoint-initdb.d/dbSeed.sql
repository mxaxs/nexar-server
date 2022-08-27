CREATE TABLE
    IF NOT EXISTS user (
        id INT NOT NULL,
        name varchar(250) NOT NULL,
        email varchar(250) NOT NULL,
        PRIMARY KEY (id)
    )

insert into
    "users" ("email", "id", "name")
values (
        'maa@uol.com.br',
        1,
        'Marcio Santos'
    )

insert into
    "users" ("email", "id", "name")
values (
        'anajulia@seuemail.com',
        2,
        'Ana Júlia de Deus Silva'
    );