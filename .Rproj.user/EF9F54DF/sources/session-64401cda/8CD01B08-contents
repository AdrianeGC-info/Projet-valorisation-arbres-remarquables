library(visNetwork)
library(tidyverse)

# Load data from CSV files
nodes_vis <- read_csv("data/nodes_arbres-2.csv")
edges_vis <- read_csv("data/edges_arbres-2.csv")

visNetwork(nodes_vis, 
           edges_vis,
           main = "Origine des arbres",
           height = "500px", 
           width = "100%")

# 1. Highlight nearest nodes
visNetwork(nodes_vis, edges_vis, height = "500px", width = "100%") %>% 
  visOptions(highlightNearest = TRUE) %>%
  visLayout(randomSeed = 123)

# 2. Select by node ID
visNetwork(nodes_vis, edges_vis, height = "500px", width = "100%") %>% 
  visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE) %>%
  visLayout(randomSeed = 123)

# 3. Select by a column (e.g., "group")
visNetwork(nodes_3, edges_3, height = "500px", width = "100%") %>%
  visOptions(selectedBy = "group") %>%
  visLayout(randomSeed = 123)

# 5. Customize options for node selection and highlighting
visNetwork(nodes_vis, edges_vis, height = "500px", width = "100%") %>% 
  visOptions(highlightNearest = TRUE, 
             nodesIdSelection = list(enabled = TRUE,
                                     selected = "8",
                                     values = c(5:10),
                                     style = 'width: 200px; height: 26px;
                                 background: #f8f8f8;
                                 color: darkblue;
                                 border:none;
                                 outline:none;')) %>%
  visLayout(randomSeed = 123)

# 6. Enable data manipulation features
visNetwork(nodes_vis, edges_vis, height = "500px", width = "100%") %>% 
  visOptions(manipulation = TRUE) %>%
  visLayout(randomSeed = 123)

# 7. Use igraph layout for network visualization
visNetwork(nodes_vis, edges_vis, height = "500px") %>%
  visIgraphLayout() %>%
  visNodes(size = 10)

# Use igraph layout with a circular arrangement
visNetwork(nodes_vis, edges_vis, height = "500px") %>%
  visIgraphLayout(layout = "layout_in_circle") %>%
  visNodes(size = 10) %>%
  visOptions(highlightNearest = list(enabled = T, hover = T), 
             nodesIdSelection = T)
