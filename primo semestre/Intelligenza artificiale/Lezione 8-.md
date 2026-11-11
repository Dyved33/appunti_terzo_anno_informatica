What is Machine Learning? “Learning is any process by which a system improves performance from experience.” - Herbert Simon 

Definition by Tom Mitchell (1998): Machine Learning is the study of algorithms that 
- improve their performance P 
- at some task T 
- with experience E. A well-defined learning task is given by <P,T,E>

![[Pasted image 20261111161705.png]]

When Do We Use Machine Learning? ML is used when: 
- Human expertise does not exist (navigating on Mars) 
- Humans can’t explain their expertise (speech recognition) 
- Models must be customized (personalized medicine) 
- Models are based on huge amounts of data (genomics)

Learning isn’t always useful: There is no need to “learn” to calculate payroll

> [!example] A classic example of a task that requires machine learning: It is very hard to say what makes a 2
> ![[Pasted image 20261111161817.png|500]]

Some more examples of tasks that are best solved by using a learning algorithm 
- Recognizing patterns: 
	- Facial identities or facial expressions 
	- Handwritten or spoken words 
	- Medical images 
- Generating patterns: 
	- Generating images or motion sequences 
- Recognizing anomalies: 
	- Unusual credit card transactions 
	- Unusual patterns of sensor readings in a nuclear power plant 
- Prediction: 
	- Future stock prices or currency exchange rates

Sample Applications 
- Web search 
- Computational biology 
- Finance 
- E-commerce 
- Space exploration 
- Robotics 
- Information extraction 
- Social networks 
- Debugging software 

Defining the Learning Task Improve on task T, with respect to performance metric P, based on experience E T: Playing checkers P: Percentage of games won against an arbitrary opponent E: Playing practice games against itself T: Recognizing hand-written words P: Percentage of words correctly classified E: Database of human-labeled images of handwritten words T: Driving on four-lane highways using vision sensors P: Average distance traveled before a human-judged error E: A sequence of images and steering commands recorded while observing a human driver. T: Categorize email messages as spam or legitimate. P: Percentage of email messages correctly classified. E: Database of emails, some with human-given labels

> [!example] Autonomous cars
> Sensors:
> 
> ![[Pasted image 20261111162428.png|500]]
> 
> Technology:
> 
> ![[Pasted image 20261111162523.png|500]]

> [!example] Deep Learning in the Headlines
> ![[Pasted image 20261111162553.png|500]]

> [!example] Deep Belief Net on Face Images
> ![[Pasted image 20261111162621.png|500]]

> [!example] Learning of Object Parts
> ![[Pasted image 20261111162655.png|500]]

> [!example] Training on Multiple Objects
> ![[Pasted image 20261111162726.png|500]]

> [!example] Scene Labeling via Deep Learning
> ![[Pasted image 20261111162755.png|500]]

> [!example] Inference from Deep Learned Models
> ![[Pasted image 20261111162823.png|500]]

> [!example] Machine Learning in Automatic Speech Recognition
> ![[Pasted image 20261111162851.png|500]]

Types of learning
- Supervised (inductive) learning 
	- Given: training data + desired outputs (labels) 
- Unsupervised learning 
	- Given: training data (without desired outputs) 
- Semi-supervised learning 
	- Given: training data + a few desired outputs 
- Reinforcement learning 
	- Rewards from sequence of actions

Supervised Learning: Regression 
- Given (x 1, y 1), (x 2, y 2), ..., (xn, yn) 
- Learn a function f(x) to predict y given x (y is real-valued == regression)

![[Pasted image 20261111162320.png]]

//Aggiungere spiegazione su over e under fitting e rispetto a cosa//

Supervised Learning: Classification • Given (x 1, y 1), (x 2, y 2), ..., (xn, yn) • Learn a function f(x) to predict y given x – y is categorical == classification

![[Pasted image 20261111163807.png]]

Supervised Learning
x can be multi-dimensional – Each dimension corresponds to an attribute
- Clump Thickness 
- Uniformity of Cell Size 
- Uniformity of Cell Shape

![[Pasted image 20261111165617.png]]

Unsupervised Learning • Given x 1, x 2, ..., xn (without labels) • Output hidden structure behind the x’s – E.g., clustering

![[Pasted image 20261111165632.png]]

Esempi
Genomics application: group individuals by genetic similarity

![[Pasted image 20261111165654.png]]

Independent component analysis – separate a combined signal into its original sources

![[Pasted image 20261111165741.png]]

Reinforcement Learning • Given a sequence of states and actions with (delayed) rewards, output a policy – Policy is a mapping from states -> actions that tells you what to do in a given state • Examples: – Credit assignment problem – Game playing – Robot in a maze – Balance a pole on your hand

The Agent-Environment Interface
![[Pasted image 20261111165851.png]]

Designing a Learning System • Choose the training experience • Choose exactly what is to be learned – i.e. the target function • Choose how to represent the target function • Choose a learning algorithm to infer the target function from the experience

![[Pasted image 20261111173652.png]]

//fino alla slide 45 inclusa//

Classification:  Definition ● Given  a  collection  of  records  (training  set  ) – Each  record  is  by  characterized  by  a  tuple   (x,y),  where  x is  the  attribute  set  and  y is  the   class  label u x:  attribute,  predictor,  independent  variable,  input u y:  class,  response,  dependent  variable,  output ● Task: – Learn  a  model  that  maps  each  attribute  set  x into  one  of  the  predefined  class  labels  y

> [!example] Examples  of  Classification  Task
> ![[Pasted image 20261111173800.png]]

General  Approach  for  Building   Classification  Model
![[Pasted image 20261111173943.png]]

Classification  Techniques 
● Base  Classifiers – Decision  Tree  based  Methods – Rule-­based  Methods – Nearest-­neighbor – Neural  Networks – Deep  Learning – Naïve  Bayes  and  Bayesian  Belief  Networks – Support  Vector  Machines ● Ensemble  Classifiers – Boosting,  Bagging,  Random  Forests

> [!example] Example  of  a  Decision  Tree
> ![[Pasted image 20261111174024.png]]
> ![[Pasted image 20261111174354.png]]

Decision  Tree  Classification  Task
![[Pasted image 20261111174416.png]]

Decision  Tree  Induction
Many  Algorithms: – Hunt’s  Algorithm  (one  of  the  earliest) – CART – ID 3,  C 4.5 – SLIQ,SPRINT

General  Structure  of  Hunt’s  Algorithm
Let  Dt be  the  set  of  training   records  that  reach  a  node  t ● General  Procedure: – If  Dt contains  records  that   belong  the  same  class  yt,   then  t  is  a  leaf  node   labeled  as  yt – If  Dt contains  records  that   belong  to  more  than  one   class,  use  an  attribute  test   to  split  the  data  into  smaller   subsets.  Recursively  apply   the  procedure  to  each   subset.

![[Pasted image 20261111180634.png]]

Hunt’s  Algorithm

![[Pasted image 20261111180700.png]]

Design  Issues  of  Decision  Tree  Induction ● How  should  training  records  be  split? – Method  for  specifying  test  condition   u depending  on  attribute  types – Measure  for  evaluating  the  goodness  of  a  test   condition ● How  should  the  splitting  procedure  stop? – Stop  splitting  if  all  the  records  belong  to  the   same  class  or  have  identical  attribute  values – Early  termination   2/14/18 Introduction  to  Data  Mining,  2 nd Edition 21 Methods  for  Expressing  Test  Conditions ● Depends  on  attribute  types – Binary – Nominal – Ordinal – Continuous ● Depends  on  number  of  ways  to  split – 2-­way  split – Multi-­way  split

Test  Condition  for  Nominal  Attributes
![[Pasted image 20261111180822.png]]
Test  Condition  for  Ordinal  Attributes
![[Pasted image 20261111180833.png]]

Test  Condition  for  Continuous  Attributes
![[Pasted image 20261111180846.png]]

Splitting  Based  on  Continuous  Attributes ● Different  ways  of  handling – Discretization to  form  an  ordinal  categorical   attribute Ranges  can  be  found  by  equal  interval  bucketing,   equal  frequency  bucketing  (percentiles),  or   clustering. u Static  – discretize  once  at  the  beginning u Dynamic  – repeat  at  each  node – Binary  Decision:  (A  <  v)  or  (A  ≥ v) u consider  all  possible  splits  and  finds  the  best  cut u can  be  more  compute  intensive

How  to  determine  the  Best  Split
![[Pasted image 20261111180948.png]]

Greedy  approach:   – Nodes  with  purer class  distribution  are   preferred ● Need  a  measure  of  node  impurity:

![[Pasted image 20261111181013.png]]

Comparison  among  Impurity  Measures
![[Pasted image 20261111182043.png]]