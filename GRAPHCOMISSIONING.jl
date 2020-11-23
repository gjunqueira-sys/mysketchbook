using LightGraphs
using GraphPlot
using SimpleWeightedGraphs
using Measurements


G =SimpleWeightedGraph(14) #Graph with 20 nodes
layout=(args...)->spring_layout(args...; C=14)

#uncertainty logic

uncertainty = rand(15)
errorBase = 10.0.*uncertainty
error .= errorBase

errortotal = errorBase .± uncertainty

# start making the edges

add_edge!(G, 1, 2, error[1])
add_edge!(G, 2, 3, error[2])
add_edge!(G, 3, 4, error[3])
add_edge!(G, 4, 5, error[4])
add_edge!(G, 4, 6, error[5])
add_edge!(G, 4, 7, error[6])
add_edge!(G, 5, 8, error[7])
#add_edge!(G, 5, 9)
#add_edge!(G, 6, 9)
add_edge!(G, 4, 9, error[8])
add_edge!(G, 9, 11, error[9])
add_edge!(G, 11, 12, error[10])
add_edge!(G, 12, 13, error[11])
add_edge!(G, 13, 14, error[12])
add_edge!(G, 7, 10, error[13])


gplot(G, nodelabel = 1:nv(G), edgelabel = 1:ne(G), layout=spring_layout) #

