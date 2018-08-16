# MSc_Thesis-Classify-Objects-Using-bigger-NN
At this final experiment we use a similar but different 3rd approach. We train a NN at the curvature data that come from a whole image -or an image-group of the same objects. Thus we need bigger NN. Afterwars we use these NN to classify an image. 

#3
curveFitTrain: Create the NN
curveFitTest: Classify an new image. We first calculate its curvature and then predict it using all the NN. The best one represents the object class.



The code above uses the following Functions:
