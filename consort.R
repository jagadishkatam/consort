library(tidyCDISC)
library(tidyverse)
library(ggalluvial)
library(DiagrammeR)


data('adae', package='tidyCDISC')
data('adsl', package='tidyCDISC')

# randomized population
pop1 <- adsl %>% rename_all(tolower) %>% filter(saffl=='Y') %>% count() %>% 
  mutate(col1=paste0('Safety Population\n(N=',n,')'))

popt <- adsl %>% rename_all(tolower) %>% filter(saffl=='Y') %>% group_by(trt01a) %>% count() %>% 
  mutate(col1=paste0(trt01a,'\n(N=',n,')'))

popc <- adsl %>% rename_all(tolower) %>% filter(saffl=='Y' & is.na(disconfl)) %>% group_by(trt01a) %>% count() %>% 
  mutate(col1=paste0('Completed','\n(N=',n,')'))

popcf <- adsl %>% rename_all(tolower) %>% filter(saffl=='Y' & is.na(disconfl) &  (comp8fl=='Y'|comp16fl=='Y'|comp24fl=='Y')) %>% select(trt01a, starts_with('comp')) %>% 
  mutate(across(starts_with('comp'), ~ifelse(.x=='Y',1,0), .names = '{.col}n'))# %>% 
  # mutate(across(ends_with('fl'), ~ifelse(.x=='Y',1,0), .names = '{.col}n')) %>% 
  # group_by(trt01a) %>% 
  # dplyr::summarise(across(ends_with('n'), sum, na.rm = TRUE)) %>% 
  # mutate(comp8fl=paste0(labelled::var_label(comp8fl), comp8fl))

popcf1 <- popcf %>% 
  group_by(trt01a) %>% 
  dplyr::summarise(across(ends_with('n'), sum, na.rm = TRUE))

labelled::var_label(popcf1$comp8fln) <- labelled::var_label(popcf$comp8fl)
labelled::var_label(popcf1$comp16fln) <- labelled::var_label(popcf$comp16fl)
labelled::var_label(popcf1$comp24fln) <- labelled::var_label(popcf$comp24fl)

popcf2 <- popcf1 %>% 
  mutate(across(ends_with('n'), ~paste0(labelled::var_label(.x), '\n(N=', .x, ')')))

popd <- adsl %>% rename_all(tolower) %>% filter(saffl=='Y' & disconfl=='Y') %>% group_by(trt01a) %>% count() %>% 
  mutate(col1=paste0('Discontinued','\n(N=',n,')'))

popds <- adsl %>% rename_all(tolower) %>% filter(saffl=='Y' & disconfl=='Y') %>% group_by(trt01a, dcsreas) %>% count() %>% 
  mutate(col1=paste0(dcsreas,' : ',n)) %>% group_by(trt01a) %>% summarize(col1=paste(col1, collapse = '\n'))

DiagrammeR::grViz("
              digraph box  {                
              // title
               compound=true;

               graph [layout=dot, overlap = true, fontsize = 10, labelloc='t',
               label='Disposition and Reasons for Permanent Discontinuation\n  \n',
               fontsize='40']

               node [shape=box, fontname = Helvetica, style=filled, color = blue, fillcolor = aliceblue]

               total_population [label = '@@1']; 
               placebo [label = '@@2'];
               xanomeline_low_dose [label = '@@3'];
               xanomeline_high_dose [label = '@@4'];
               completedp [label = '@@5'];
               discontinuedp [label = '@@6'];
               completedl [label = '@@7'];
               discontinuedl [label = '@@8'];
               completedh [label = '@@9'];
               discontinuedh [label = '@@10'];
               reasdsp [label = '@@11'];
               reasdsl [label = '@@12'];
               reasdsh [label = '@@13'];
               
               comp8flp [label = '@@14'];
               comp16flp [label = '@@15'];
               comp24flp [label = '@@16'];
               
               comp8fl [label = '@@17'];
               comp16fl [label = '@@18'];
               comp24fl [label = '@@19'];
               
               comp8flh [label = '@@20'];
               comp16flh [label = '@@21'];
               comp24flh [label = '@@22'];
               


               
               total_population  -> placebo total_population -> xanomeline_low_dose total_population -> xanomeline_high_dose 
               placebo -> completedp placebo -> discontinuedp xanomeline_low_dose -> completedl xanomeline_low_dose -> discontinuedl
               xanomeline_high_dose -> completedh xanomeline_high_dose -> discontinuedh
               
               discontinuedp -> reasdsp
               discontinuedl -> reasdsl
               discontinuedh -> reasdsh
               
               completedp -> comp8flp -> comp16flp -> comp24flp
               completedl -> comp8fl -> comp16fl -> comp24fl
               completedh -> comp8flh -> comp16flh -> comp24flh
              }
              
              [1]:  pop1$col1 
              [2]:  popt$col1[1]
              [3]:  popt$col1[3]
              [4]:  popt$col1[2]
              [5]:  popc$col1[1]
              [6]:  popd$col1[1]
              [7]:  popc$col1[3]
              [8]:  popd$col1[3]
              [9]:  popc$col1[2]
              [10]: popd$col1[2]
              [11]: popds$col1[1]
              [12]: popds$col1[3]
              [13]: popds$col1[2]
              [14]: popcf2$comp8fln[1]
              [15]: popcf2$comp16fln[1]
              [16]: popcf2$comp24fln[1]
              [17]: popcf2$comp8fln[3]
              [18]: popcf2$comp16fln[3]
              [19]: popcf2$comp24fln[3]
              [20]: popcf2$comp8fln[2]
              [21]: popcf2$comp16fln[2]
              [22]: popcf2$comp24fln[2]
              

                  ")
