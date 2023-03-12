import io
import json
import base64
import itertools
import cv2
import numpy as np
from PIL import Image
import networkx as nx
import matplotlib.pyplot as plt

class StoreNavigation:
    def __init__(self,L):
        self.path = L
        self.store = {
            'a':"Apple", 
            'b':"Guava", 
            'c':"Grape", 
            'd':"Cherry",
            'e':"Mango",
            'f':"Tomato",
            'g':"Brinjal",
            'h':"Onion",
            'i':"Carrot",
            'j':"Potato",
            'k':"Soap",
            'l':"Lipstick",
            'm':"Hair Oil",
            'n':"Face Cream",
            'o':"lip Bam",
            'p':"Milk",
            'q':"Butter",
            'r':"Cheese",
            's':"Yogurt",
            't':"Cream"
        }
        self.pos =  { "entry" : (0,0), "a": (0,20) , "b": (0,40) , "c": (0,60) , "d": (0,80) , "e": (0,100) , 
                        "f" : (10,20) , "g" : (10,40) , "h" : (10,60) , "i" : (10,80) , "j" : (10,100) , 
                        "k" : (20,20) , "l" : (20,40) , "m" : (20,60) , "n" : (20,80) , "o" : (20,100) ,
                        "exit" : (30,0), "p" : (30,20) , "q" : (30,40) , "r" : (30,60) , "s" : (30,80), "t" : (30,100)
                    }
        self.graph = { "entry" : [("a",1)],
                       "a" : [("b",1),("entry",1),("f",1)],
                       "b" : [("c",1), ("g",1),("a",1)],
                       "c" : [("b",1), ("d",1),("h",1)],
                       "d" : [("c",1), ("e",1),("i",1)],
                       "e" : [("d",1),("j",1)],
                       "f" : [("a",1),("g",1),("k",1)],
                       "g" : [("b",1),("f",1),("h",1),("l",1)],
                       "h" : [("c",1),("g",1),("i",1),("m",1)],
                       "i" : [("d",1),("h",1),("j",1),("n",1)],
                       "j" : [("e",1),("i",1),("o",1)],
                       "k" : [("f",1),("l",1),("p",1)],
                       "l" : [("g",1),("k",1),("m",1),("q",1)],
                       "m" : [("h",1),("l",1),("n",1),("r",1)],
                       "n" : [("i",1),("m",1),("o",1),("s",1)],
                       "o" : [("j",1),("n",1),("t",1)],
                       "p" : [("k",1),("exit",1),("q",1)],
                       "q" : [("l",1),("p",1),("r",1)],
                       "r" : [("m",1),("q",1),("s",1)],
                       "s" : [("n",1),("r",1),("t",1)],
                       "t" : [("s",1),("o",1)],
                       "exit" : [("p",1)]
                     }
    
        self.MinCost = float('inf')
        self.MinPathL = []
        self.MinPathN = ['Entry']
        self.data = {}
        self.fig=None

        g = nx.Graph()

        for node in self.graph:
            for n in self.graph[node]:
                g.add_edge(node,n[0],length=1)
                
        self.g = g
        
    def findPath(self,arr,l,r):
        if l==r:
            cost = 0
            path = ["entry"]
            for i in range(0,len(arr)-1):
                cost+=nx.shortest_path_length(self.g,arr[i],arr[i+1])
                temp = nx.shortest_path(self.g,arr[i],arr[i+1])
                path.append(temp[1:])
            if cost < self.MinCost:
                self.MinCost = cost
                self.MinPathL = path
        else:
            for i in range(l,r): 
                arr[l], arr[i] = arr[i], arr[l] 
                self.findPath(arr, l+1, r) 
                arr[l], arr[i] = arr[i], arr[l]
                
    def Graph(self):
        fig, ax = plt.subplots(figsize=(10,10)) 
        nx.draw(self.g,self.pos,node_color='k')
        path_edges = list(zip(self.MinPathL,self.MinPathL[1:]))
        nx.draw_networkx(self.g,self.pos,node_size=1000,node_color='k',ax=ax)
        nx.draw_networkx_nodes(self.g,self.pos,nodelist=self.MinPathL,node_color='r',node_size=1000,ax=ax)
        nx.draw_networkx_edges(self.g,self.pos,edgelist=path_edges,edge_color='b',width=5,arrowsize=20,arrows=True,ax=ax)
        self.fig = plt.gcf()
        self.fig = self.fig2img()
        plt.close()
    
    def fig2img(self):
        buf = io.BytesIO()
        self.fig.savefig(buf)
        buf.seek(0)
        img = Image.open(buf)
        return img
    
    def ConvertJson(self):
        self.data['MinPathL'] = self.MinPathL
        for i in self.MinPathL[1:-1]:
            self.MinPathN.append(self.store[i])
        self.MinPathN.append('Exit')
        self.data['MinPathN'] = self.MinPathN
        self.fig.save("ab.png")
        return json.dumps(self.data)
        
        
if __name__=="__main__":
    mustVisitNodes = ["entry","d","e","g","l","r","s","i","t","exit"]
    p = StoreNavigation(mustVisitNodes)
    p.findPath(mustVisitNodes,1,len(mustVisitNodes)-2)
    p.MinPathL = list(itertools.chain.from_iterable(p.MinPathL))
    del p.MinPathL[0:4]
    p.MinPathL[0] = 'entry'
    p.Graph()
    a = p.ConvertJson()
        
    