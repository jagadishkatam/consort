library(DiagrammeR)

DiagrammeR::grViz("
digraph {
  
  
  ranksep=0.5; size = '7.5,7.5';
  
  {
    node [shape=plaintext shape='box' style='filled' fillcolor='lightblue']
    Enrollment -> Allocation [color='white']
    followup [label='Follow-up']
    Analysis1 [label='' color='white' style='filled' fillcolor='white']
    Analysis2 [label='' color='white' style='filled' fillcolor='white']
    Analysis3 [label='' color='white' style='filled' fillcolor='white']
    //Analysis4 [label='' color='white' style='filled' fillcolor='white']
    Analysis [label='Analysis']
    
    Allocation -> Analysis1 [color='white']
    
    Analysis1 -> followup [color='white']
    followup -> Analysis3 [color='white']
    Analysis3 -> Analysis [color='white']
    //Analysis4 -> Analysis [color='white']
  }
  
  node1 [shape='box' style='filled' fillcolor='white' label='Assessed for eligibility']
  
  node2 [shape='box' style='filled' fillcolor='white' label='Randomized']  
  
  node3 [shape='box' style='filled' fillcolor='white' label='Allocated to intervention'] 
  node4 [shape='box' style='filled' fillcolor='white' label='Received intervention I'] 
  node5 [shape='box' style='filled' fillcolor='white' label='Received intervention II'] 
  node6 [shape='box' style='filled' fillcolor='white' label='Followed up']
  node61 [shape='box' style='filled' fillcolor='white' label='Followed up']
  node7 [shape='box' style='filled' fillcolor='white' label='Analysis']
    node71 [shape='box' style='filled' fillcolor='white' label='Analysis']
    node46 [shape='box' style='filled' fillcolor='white' label='Discontinued intervention\nor\nLost to Follow-up']
  node561 [shape='box' style='filled' fillcolor='white' label='Discontinued intervention\nor\nLost to Follow-up']
  
  node [label='' shape='point' color='black']; 
  hidden1; hidden2; hidden3; hidden4; hidden5; hidden34; hidden35;
  
  node [shape=box ]
  
  node21 [label='Excluded']
  node35 [label='Did not receive intervention']
  node34 [label='Did not receive intervention']
  node67 [label='Not Analysed']
    node6171 [label='Not Analysed']

    

node2 -> node3
//node3 -> node4
//node3 -> node5
//node4 -> node6
//node5 -> node61
//node6 -> node7
//node61 -> node71
{rank=same hidden1 node21}
{rank=same hidden34 node34}
    {rank=same hidden2 node46};
    //{rank=same hidden2 node561};
    {rank=same hidden3 node561};
    {rank=same hidden4 node67};
     {rank=same hidden5 node6171};
     {rank=same hidden34 node34};
     {rank=same hidden35 node35};
    
  edge [arrowhead='none'] 
  node1 -> hidden1
node4 -> hidden2
node5 -> hidden3
node6 -> hidden4
node61 -> hidden5
node3 -> hidden34  [minlen=2]; 
node3 -> hidden35 [minlen=2]; 

  edge [style=solid arrowhead='vee']
  hidden1 -> node2  [minlen=1]; 
  hidden1  -> node21 [minlen=1]; 
  
  hidden2 -> node6 
  hidden2  -> node46 [minlen=1]; 
  
  hidden3 -> node61 
  hidden3  -> node561 [minlen=0]; 

  hidden4 -> node7 
  hidden4  -> node67 [minlen=0]; 
  
  hidden5 -> node71
  hidden5  -> node6171 [minlen=0]; 
  
   
  hidden34 -> node4
  hidden34  -> node34 [minlen=0]; 
  
    hidden35 -> node5
  hidden35  -> node35 [minlen=0]; 
  
  
       {rank=same Enrollment node1};
        {rank=same Allocation node2}; 
                {rank=same followup node6};
  
}
")

