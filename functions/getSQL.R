# A function to extract data from Vertica Warehouse to a DataFrame.
# Requires User, Password, and connection details as function arguments for added security.

getSQL <-
  function(sqlText,
           user,
           password,
           dClass,
           cPath,
           connString) {
    if (!require('RJDBC'))
      install.packages('RJDBC')
    library('RJDBC')
    if (!require('RCurl'))
      install.packages('RCurl')
    library('RCurl')
    if (!require('getPass'))
      install.packages('getPass')
    library('getPass')
    if (missing(dClass)) {
      dClass <- getPass(msg = "Enter the Driver Class: ")
    }
    if (missing(cPath)) {
      cPath <- getPass(msg = "Enter the Class Path: ")
    }
    if (missing(connString)) {
      cPath <- getPass(msg = "Enter the Connection String: ")
    }
    if (missing(user)) {
      user <- getPass(msg = "Enter your Vertica username: ")
    }
    if (missing(password)) {
      password <- getPass(msg = "Enter your Vertica password: ")
    }
    
    vDriver <-
      JDBC(driverClass = dClass, classPath = cPath)
    
    vertica <-
      dbConnect(vDriver,
                connString,
                user,
                password)
    queryResults <- dbGetQuery(vertica, sqlText)
    return(queryResults)
    
  }
