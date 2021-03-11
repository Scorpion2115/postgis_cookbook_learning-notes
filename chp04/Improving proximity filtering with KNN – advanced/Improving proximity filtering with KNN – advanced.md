# Improving proximity filtering with KNN – advanced
## Use Case
* We want to traverse an entire dataset and test each record for its nearest neighbors?

## Recipe
* Create a function which allows a geometry input and return a float output 
* Use `With` statement to create a temporary table, which returns 5 closest lines to our points. **Because the index uses bounding boxes, we don't know which line is the closest**.
* In summary, what returns with our temporary index_query table is the distance to the nearest five lines. Then we order the results by distance and leave the real nearst one


## Lesson Learnt
* When our KNN approach used only points, our indexing was exact—the bounding box of a point is effectively a point. As bounding boxes are what indexes are built around, our indexing estimates of distance perfectly reflected the actual distances between our points.
* However, when approaching points to lines, the bounding box is an approximation of the lines to which we will be comparing our points. Hence, the nearest neighbor may not be our very nearest neighbor, but is likely our approximate nearest neighbor, or one of our nearest neighbors.
* I have also created a function called `knn_point2point` to find n nearest neighbors of each point in one point dataset.


