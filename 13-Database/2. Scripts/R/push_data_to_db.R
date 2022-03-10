
rm(list = ls())

# Load cac package can thiet

rm(list = ls())
library(DBI)
library(odbc)
library(tictoc)
library(tidyverse)


# Kiểm tra các kết nối để sử dụng cho argument Driver trong hàm dbConnect
odbc::odbcListDrivers()

#-------------------------------------------------------------------------------

# Kết nối vào DB
con <- dbConnect(odbc(),
                 Driver = "SQL Server",
                 Server = "VM-DC-JUMPSRV77\\IFRS9", # chu y phai dung 2 dau gach ngang
                 Database = "DB_CUSTOMER",
                 # UID = "sa",
                 # PWD = "******",
                 Port = 1433)

# Đẩy dữ liệu vào DB
dbWriteTable(con, sql_tbl_name , df[1500001:nrow(df), ], append = TRUE)



