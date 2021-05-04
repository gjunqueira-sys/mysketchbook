using LightGraphs
using GraphPlot
using SimpleWeightedGraphs
using Measurements
using Plots


G =DiGraph(14) #Graph with 20 nodes
layout=(args...)->spring_layout(args...; C=14)

#uncertainty logic

uncertainty = rand(15)
errorBase = 10.0.*uncertainty
#error .= errorBase

errortotal = errorBase .± uncertainty

# start making the edges

add_edge!(G, 1, 2) #error[1]
add_edge!(G, 2, 3) #error[2]
add_edge!(G, 3, 4) #error[3]
add_edge!(G, 4, 5) #error[4]
add_edge!(G, 4, 6) #error[5]
add_edge!(G, 4, 7) #error[6]
add_edge!(G, 5, 8) #error[7]
#add_edge!(G, 5, 9)
#add_edge!(G, 6, 9)
add_edge!(G, 4, 9) #error[8]
add_edge!(G, 9, 11) #error[9]
add_edge!(G, 11, 12) #error[10]
add_edge!(G, 12, 13) ##error[11]
add_edge!(G, 13, 14) ##error[12]
add_edge!(G, 7, 10) ##error[13]
a=[]
a= Array{Measurement{Float64}}(undef, length(p1)+1, 1)
# PATHs
p1 = enumerate_paths(dijkstra_shortest_paths(G, 1, allpaths=true), 14)
p2 = enumerate_paths(dijkstra_shortest_paths(G, 4, allpaths=true), 6)
p3 = enumerate_paths(dijkstra_shortest_paths(G, 4, allpaths=true), 8)
p4 = enumerate_paths(dijkstra_shortest_paths(G, 4, allpaths=true), 10)


# mapping errors 

Dic = Dict([(1, errortotal[1]), (2, errortotal[2]), (3, errortotal[3]), (4, errortotal[4]), (5,errortotal[5]), (6, errortotal[6]), (7, errortotal[7]), (8, errortotal[8]), (9, errortotal[9]), (10, errortotal[10]), (11, errortotal[11]), (12, errortotal[12]), (13,errortotal[13]), (14, errortotal[14])])


#for p in 1:length(p1)
#    a[p+1] = a[p]+ errortotal[p]
#end



#gplot(G, nodelabel = 1:nv(G), edgelabel = 1:ne(G), layout=spring_layout) #
gr()
plot(cumsum(errortotal), title = "Layout Based Commissioning Schedule",
xlabel = "Node/Unit", ylabel = "Time / Hours" , label ="Path unit XX -> YY")


