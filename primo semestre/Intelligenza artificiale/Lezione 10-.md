Classification Errors  Training errors (apparent errors) – Errors committed on the training set  Test errors – Errors committed on the test set  Generalization errors – Expected error of a model over random selection of records from same distribution 

> [!example] Example Data Set
> Two class problem: + : 5200 instances • 5000 instances generated from a Gaussian centered at (10,10) • 200 noisy instances add
> ed o : 5200 instances • Generated from a uniform distribution 10 % of the data used for training and 90% of the data used for testing
> ![[Pasted image 20261118162900.png|500]]

Increasing number of nodes in Decision Trees 
![[Pasted image 20261118162944.png]]

Decision Tree with 4 nodes
![[Pasted image 20261118163002.png]]

Decision Tree with 50 nodes
![[Pasted image 20261118163020.png]]

Which tree is better?
![[Pasted image 20261118163039.png]]

Model Overfitting
Underfitting: when model is too simple, both training and test errors are large 
Overfitting: when model is too complex, training error is small but test error is large 

 If training data is under-representative, testing errors increase and training errors decrease on increasing number of nodes • Increasing the size of training data reduces the difference between training and testing errors at a given number of nodes

![[Pasted image 20261118163217.png]]

Reasons for Model Overfitting  Limited Training Size  High Model Complexity – Multiple Comparison Procedure

Effect of Multiple Comparison Procedure  Consider the task of predicting whether stock market will rise/fall in the next 10 trading days  Random guessing: P(correct) = 0.5  Make 10 random guesses in a row:

//aggiungi tabella e formula presenti in questa slide//

Effect of Multiple Comparison Procedure  Approach: – Get 50 analysts – Each analyst makes 10 random guesses – Choose the analyst that makes the most number of correct predictions  Probability that at least one analyst makes at least 8 correct predictions

//aggiungi la formula che manca//

Effect of Multiple Comparison Procedure  Many algorithms employ the following greedy strategy: – Initial model: M – Alternative model: M’ = M  , where  is a component to be added to the model (e.g., a test condition of a decision tree) – Keep M’ if improvement, (M,M’) >   Often times,  is chosen from a set of alternative components,  = {1 , 2 , …, k }  If many alternatives are available, one may inadvertently add irrelevant components to the model, resulting in model overfitting 

Effect of Multiple Comparison - Example Use additional 100 noisy variables generated from a uniform distribution along with X and Y as attributes. Use 30% of the data for training and 70% of the data for testing

![[Pasted image 20261118163355.png]]

![[Pasted image 20261118163406.png]]

//queste 2 immagini cerca di metterle affiancate come nella slide con un blocco html possibilmente//

Notes on Overfitting  Overfitting results in decision trees that are more complex than necessary  Training error does not provide a good estimate of how well the tree will perform on previously unseen records  Need ways for estimating generalization errors 

Model Selection  Performed during model building  Purpose is to ensure that model is not overly complex (to avoid overfitting)  Need to estimate generalization error – Using Validation Set – Incorporating Model Complexity – Estimating Statistical Bounds

Using Validation Set  Divide training data into two parts: – Training set:  use for model building – Validation set:  use for estimating generalization error  Note: validation set is not the same as test set  Drawback: – Less data available for training 

Incorporating Model Complexity  Rationale: Occam’s Razor – Given two models of similar generalization errors, one should prefer the simpler model over the more complex model – A complex model has a greater chance of being fitted accidentally by errors in data – Therefore, one should include model complexity when evaluating a model Gen. Error(Model) = Train. Error(Model, Train. Data) + alpha x Complexity(Model)

Estimating the Complexity of Decision Trees  Pessimistic Error Estimate of decision tree T with k leaf nodes: – err(T): error rate on all training records – : trade-off hyper-parameter (similar to ) Relative cost of adding a leaf node – k: number of leaf nodes – Ntrain : total number of training records 

//aggiungi la formula che manca//

![[Pasted image 20261118163531.png]]

Resubstitution Estimate: – Using training error as an optimistic estimate of generalization error – Referred to as optimistic error estimate

Minimum Description Length (MDL)  Cost(Model,Data) = Cost(Data|Model) + x Cost(Model) – Cost is the number of bits needed for encoding. – Search for the least costly model.  Cost(Data|Model) encodes the misclassification errors.  Cost(Model) uses node encoding (number of children) plus splitting condition encoding.

![[Pasted image 20261118163624.png]]

Estimating Statistical Bounds
![[Pasted image 20261118163653.png]]

//scrivi la formula mancante e tutto il resto della slide mettilo a fianco del'immagine//

Model Selection for Decision Trees  Pre-Pruning (Early Stopping Rule) – Stop the algorithm before it becomes a fully-grown tree – Typical stopping conditions for a node:  Stop if all instances belong to the same class  Stop if all the attribute values are the same – More restrictive conditions:  Stop if number of instances is less than some user-specified threshold  Stop if class distribution of instances are independent of the available features (e.g., using  2 test)  Stop if expanding the current node does not improve impurity measures (e.g., Gini or information gain).  Stop if estimated generalization error falls below certain threshold

Post-pruning – Grow decision tree to its entirety – Subtree replacement  Trim the nodes of the decision tree in a bottom-up fashion  If generalization error improves after trimming, replace sub-tree by a leaf node  Class label of leaf node is determined from majority class of instances in the sub-tree – Subtree raising  Replace subtree with most frequently used branch 

> [!example] Example of post-pruning
> Training Error (Before splitting) = 10/30 Pessimistic error = (10 + 0.5)/30 = 10.5/30 Training Error (After splitting) = 9/30 Pessimistic error (After splitting) = (9 + 4  0.5)/30 = 11/30
> //aggiungi la tabella//
> ![[Pasted image 20261118163845.png]]

> [!example]
> ![[Pasted image 20261118163904.png]]

Model Evaluation  Purpose: – To estimate performance of classifier on previously unseen data (test set)  Holdout – Reserve k% for training and (100-k)% for testing – Random subsampling: repeated holdout  Cross validation – Partition data into k disjoint subsets – k-fold: train on k-1 partitions, test on the remaining one – Leave-one-out: k=n

> [!example] Cross-validation Example  
> 3-fold cross-validation
> ![[Pasted image 20261118163945.png]]

Class Imbalance Problem  Lots of classification problems where the classes are skewed (more records from one class than another) – Credit card fraud – Intrusion detection – Defective products in manufacturing assembly line – COVID-19 test results on a random sample  Key Challenge: – Evaluation measures such as accuracy are not wellsuited for imbalanced class

Confusion matrix
REDICTED CLASS ACTUAL CLASS Class=Yes Class=No Class=Yes a b Class=No c d a: TP (true positive) b: FN (false negative) c: FP (false positive) d: TN (true negative)

//sistema la tabella//

Accuracy
PREDICTED CLASS ACTUAL CLASS Class=Yes Class=No Class=Yes a (TP) b (FN) Class=No c (FP) d (TN)
Most widely-used metric:
//aggiungi formula//

//inserisci il contenuto di tutte le slide che non ho inserito io. Con ciò intendo la tabella completa e il contenuto e possibilmente una buona spiegazione//

ROC (Receiver Operating Characteristic)  A graphical approach for displaying trade-off between detection rate and false alarm rate  Developed in 1950 s for signal detection theory to analyze noisy signals  ROC curve plots TPR against FPR – Performance of a model represented as a point in an ROC curve

ROC Curve (TPR,FPR):  (0,0): declare everything to be negative class  (1,1): declare everything to be positive class  (1,0): ideal  Diagonal line: – Random guessing – Below diagonal line:  prediction is opposite of the true class

![[Pasted image 20261118165511.png]]

//cosa significa threshold in questo contesto?//

ROC (Receiver Operating Characteristic)  To draw ROC curve, classifier must produce continuous-valued output – Outputs are used to rank test records, from the most likely positive class record to the least likely positive class record – By using different thresholds on this value, we can create different variations of the classifier with TPR/FPR tradeoffs  Many classifiers produce only discrete outputs (i.e., predicted class) – How to get continuous-valued outputs?  Decision trees, rule-based classifiers, neural networks, Bayesian classifiers, k-nearest neighbors, SVM

> [!example] decision trees
> ![[Pasted image 20261118170617.png]]

> [!example] roc curve 
> ![[Pasted image 20261118170645.png]]
> 
> ![[Pasted image 20261118170714.png]]

How to Construct an ROC curve Instance Score True Class 1 0.95 + 2 0.93 + 3 0.87 - 4 0.85 - 5 0.85 - 6 0.85 + 7 0.76 - 8 0.53 + 9 0.43 - 10 0.25 + • Use a classifier that produces a continuous-valued score for each instance • The more likely it is for the instance to be in the + class, the higher the score • Sort the instances in decreasing order according to the score • Apply a threshold at each unique value of the score • Count the number of TP, FP, TN, FN at each threshold • TPR = TP/(TP+FN) • FPR = FP/(FP + TN)

//sistema la tabella//

How to construct an ROC curve
//spiega come//
![[Pasted image 20261118170803.png]]

Using ROC for Model Comparison  No model consistently outperforms the other  M 1 is better for small FPR  M 2 is better for large FPR  Area Under the ROC curve (AUC)  Ideal:  Area = 1  Random guess:  Area = 0.5

![[Pasted image 20261118170822.png]]

Dealing with Imbalanced Classes - Summary  Many measures exists, but none of them may be ideal in all situations – Random classifiers can have high value for many of these measures – TPR/FPR provides important information but may not be sufficient by itself in many practical scenarios – Given two classifiers, sometimes you can tell that one of them is strictly better than the other C 1 is strictly better than C 2 if C 1 has strictly better TPR and FPR relative to C 2 (or same TPR and better FPR, and vice versa) – Even if C 1 is strictly better than C 2, C 1’s F-value can be worse than C 2’s if they are evaluated on data sets with different imbalances – Classifier C 1 can be better or worse than C 2 depending on the scenario at hand (class imbalance, importance of TP vs FP, cost/time tradeoffs)

//inserisci il contenuto delle slide che ho saltato nella forma di tabelle, scritte che sono a lato e spiegazione di cosa mostrano//

Building Classifiers with Imbalanced Training Set  Modify the distribution of training data so that rare class is well-represented in training set – Undersample the majority class – Oversample the rare class
