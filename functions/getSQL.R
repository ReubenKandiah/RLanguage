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
    vDriver <-
      JDBC(driverClass = dClass, classPath = cPath)
    if (missing(user)) {
      usr <- getPass(msg = "Enter your Vertica username: ")
    } else{
      usr <- user
    }
    if (missing(password)) {
      pwd <- getPass(msg = "Enter your Vertica password: ")
    } else {
      pwd <- password
    }
    
    vertica <-
      dbConnect(vDriver,
                connString,
                usr,
                pwd)
    queryResults <- dbGetQuery(vertica, sqlText)
    return(queryResults)
    
  }
