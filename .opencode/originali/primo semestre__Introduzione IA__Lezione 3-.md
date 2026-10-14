LABORATORIO

Node $diverso$ stato:
- Il noto si trova all'interno dell'albero. Codifica il path che permette di raggiungerlo
- Lo stato è la rappresentazione dello stato nello spazio degli stati

> [!note]
> Un albero ha un solo nodo, altrimenti si parla di grafo

La soluzione è lista di azioni mentre il path è la lista di nodi dallo stato iniziale fino a quello finale

> [!note]
> Algoritmi possono essere fatti sia su albero che su grafo. Per il primo è necessario implementare algoritmi per trovare se ci sono cicli. I grafi hanno nella struttura dati il flag per capire se un nodo è già stato esplorato o meno (sempre per vedere se ci sono cicli)

```Python
#BFS su grafo

def breadth_search_graph(problem: Problem) -> Node:

#inizializzazione

node = Node(problem.initial)

if problem.goal_test(node.state):

return node

frontier = deque([node])

explored = set(node.state)

print("Frontier BFS:")

  

#scorrimento frontiera

while frontier:

node = frontier.popleft()

#estrazione del nodo da deque

  

#analisi dei figli

for child in node.expand(problem):

  

# verifica anticipata del goal

if problem.goal_test(child.state):

print("Last Expanded: ", node)

print("Explored node in BFS: ", len(explored))

return child

  

#se non l'ho già esplorato e non è già in frontiera

if child.state not in explored:

explored.add(child.state)

frontier.append(child)

print("Added", child)

  

return None
```

```Python
# DFS su grafo

def depth_search_graph(problem: Problem) -> Node:

#inizializzazione

node = Node(problem.initial)

  

frontier = [node] #LIFO

explored = set()

print("Frontier BFS:")

  

#scorrimento frontiera

while frontier:

node = frontier.pop()

#estrazione del nodo da deque

if problem.goal_test(node.state):

print("Last Expanded: ", node)

print("Explored node in BFS: ", len(explored))

return node

  

#analisi dei figli

explored.add(node.state)

for child in node.expand(problem):

  

#se non l'ho già esplorato e non è già in frontiera

if child.state in explored:

explored.add(child.state)

frontier.append(child)

print("Added", child)

  

return None
```

> [!note]
> La DFS non ha condizioni di ottimalità

