db <- dbConnect(SQLite(), dbname='/Users/jiamingxu/Downloads/coffeedb.db')
dbListTables(db)

sqlCmd = "SELECT * FROM salespeople"
rs = dbGetQuery(db, sqlCmd)
print(rs)

sqlCmd = "SELECT * FROM coffees WHERE price < :x"
query = dbSendQuery(db, sqlCmd)
dbBind(query, params = list(x = 9))
rs = dbFetch(query)
print(rs)

rs <- dbSendQuery(db, "SELECT * FROM coffees")
while (!dbHasCompleted(rs)) {
    df <- dbFetch(rs, n =4)
    print(df)
}

sql <- "INSERT INTO coffees VALUES (null, 'Douwe Egbers', 11.87)"
dbExecute(db, sql)

sql <- "UPDATE salespeople SET last_name='Flintstone' WHERE id = 1"
dbExecute(db, sql)

dbDisconnect(db)
