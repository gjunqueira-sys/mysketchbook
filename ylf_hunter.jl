using CSV
export CSV, PooledString
using DataFrames
using Dates

data_past = CSV.read("LaborForecastingEmployeeUtilization02232021.csv", DataFrame)
name_past  = collect(data_past[:,3])

hours_month_past  = collect(data_past[:,6])

data_past[findfirst(name_past .== name_past[2]),: ]

dic_past = Dict()



[dic_past[all_names] = data_past[findfirst(name_past .== all_names),: ] for all_names in name_past] #builds dictionary for past data

#--------------------------------------------------------------------------------------

data_now = CSV.read("LaborForecastingEmployeeUtilization03032021.csv", DataFrame)

name_now = collect(data_now[:,3])

dic_now = Dict()

[dic_now[all_names] = data_now[findfirst(name_now .== all_names),: ] for all_names in name_now] #builds baseline dictionary

dic_result = Dict()

[dic_result[all_names] = [(parse(Int64, filter(c -> c!=',', dic_now[all_names][6])))- (parse(Int64, filter(c -> c!=',', dic_past[all_names][6])))
, (parse(Int64, filter(c -> c!=',', dic_now[all_names][9])))- (parse(Int64, filter(c -> c!=',', dic_past[all_names][9])))
, (parse(Int64, filter(c -> c!=',', dic_now[all_names][12])))- (parse(Int64, filter(c -> c!=',', dic_past[all_names][12])))] for all_names in name_past]

sort(collect(values(dic_result)))

dataout = sort(collect(zip(values(dic_result), keys(dic_result))))

df = DataFrame(dataout)
first(df,5)




CSV.write("ylfhunter_03032021_official.csv", df)
