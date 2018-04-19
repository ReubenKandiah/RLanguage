ga_extract <-
  function(clientID,
           clientSecret,
           profile,
           fDate,
           tDate,
           metric,
           dimension,
           filter,
           fetchBy) {
    if (!require('getPass'))
      install.packages('getPass')
    require('getPass')
    if (!require('RGA'))
      install.packages('RGA')
    require('RGA')
    if (missing(clientID)) {
      clientID <- getPass(msg = "Enter the Client ID: ")
    }
    if (missing(clientSecret)) {
      clientID <- getPass(msg = "Enter the Client Secret: ")
    }
    ga_token <-
      authorize(client.id = clientID, client.secret = clientSecret)
    if (missing(filter)) {
      dataset <- get_ga(
        profileId = profile,
        start.date = as.character(fDate),
        end.date = as.character(tDate),
        metrics = metric,
        dimensions = dimension,
        fetch.by = fetchBy
      )
    } else {
      dataset <- get_ga(
        profileId = profile,
        start.date = as.character(fDate),
        end.date = as.character(tDate),
        metrics = metric,
        dimensions = dimension,
        filters = filter,
        fetch.by = fetchBy
      )
    }
    return(dataset)
  }
