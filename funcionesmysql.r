


leemysqltable <- function(database, sqltable)
{

  ########################################################################
  ##USAGE:                                                              ##
  ##    lee los datos de una tabla MySQL y los devuelve en un dataframe ##
  ##                                                                    ##
  ##INPUT                                                               ##
  ##    database: Base de datos en donde se encuentra la tabla          ##
  ##    sqltable: Tabla que queremos descargar en el dataframe          ##
  ##OUTPUT                                                              ##
  ##    extract.data: datafrmae con los datos de la tabla.              ##
  ########################################################################
  
  source("login_credentials.R")
  require(RMySQL);require(DBI);require(data.table)
  
  db_driver <- MySQL()
  db_name <- database
  
  mydb <-  dbConnect(db_driver, user = db_user, password = db_password,
                     dbname = db_name, host = db_host, port = db_port)
  
  sqltext <- paste0("SELECT * FROM ",sqltable )
  
  rs <- dbSendQuery(mydb, sqltext)
  
  extract.data <-  fetch(rs, n = -1)
  
  dbDisconnect(mydb)
  
  return(extract.data)
  
}


sendmysqlquery <- function(database, sqltext)
{

  ########################################################################
  ##USAGE:                                                              ##
  ##    envía una sentencia sql a una base de datos MySQL               ##
  ##                                                                    ##
  ##INPUT                                                               ##
  ##    database: Base de datos en donde se encuentra la tabla          ##
  ##    sqltext: Sentencia SQL                                          ##
  ##OUTPUT                                                              ##
  ##                                                                    ##
  ########################################################################
  
  source("login_credentials.R")
  require(RMySQL);require(DBI);require(data.table)
  
  db_driver <- MySQL()
  db_name <- database
  
  mydb <-  dbConnect(db_driver, user = db_user, password = db_password,
                     dbname = db_name, host = db_host, port = db_port)
  
  rs <- dbSendQuery(mydb, sqltext)
  
  extract.data <-  fetch(rs, n = -1)
  
  dbDisconnect(mydb)
  
  return(extract.data)
  
}


escribemysqltable <- function(database, sqltable, df)
{
  ###################################################################
  ##USAGE:                                                         ##
  ##    escribe un dataframe en modo append dentro de una tabla    ##
  ##                                                               ##
  ##INPUT:                                                         ##                      
  ##    database: Base de datos en donde se encuentra la tabla     ##
  ##    sqltable: Tabla que queremos descargar en el dataframe     ##
  ##    sd: datafrma que queremos almacenar dentro de la tabla     ##
  ##OUTPUT                                                         ##
  ##                                                               ##
  ###################################################################
  
  source("login_credentials.R")
  require(RMySQL);require(DBI);require(data.table)
  
  db_driver <- MySQL()
  db_name <- database
  
  mydb <-  dbConnect(db_driver, user = db_user, password = db_password,
                     dbname = db_name, host = db_host, port = db_port)
  
  dbWriteTable(mydb, df, name=sqltable, row.names=FALSE, append = TRUE)
  
  
  dbDisconnect(mydb)
}
