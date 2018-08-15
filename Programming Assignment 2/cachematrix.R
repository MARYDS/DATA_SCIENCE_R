## This file has 2 functions
## makeCacheMatrix - Stores a matrix and its inverse and provides setter/getter
##                   functions to set/return the matrix details and its inverse.
##
## cacheSolve - Receives a makeCacheMatrix object. Attemps to retrieve an already
##              calculated/stored inverse from the makeCacheMatrix object. If found,
##              returns this value, otherwise retrieves the matrix stored in the 
##              makeCacheMatrix object and calls solve to calculate the inverse now.
##              Stores the inverse on the makeCacheMatrix object and returns the 
##              value to the calling environment.

## ----------------------------------------------------------------------------------
## makeCacheMatrix - Input Parameter: x (a matrix)
##                   Output Parameter: a makeCacheMatrix object
## ----------------------------------------------------------------------------------
## Stores the input matrix in x. Initialises the matrix inverse to NULL.
##
## Sets up functions which can be called on the stored matrix to...
## (1) set/store new matrix details (set)
## (2) get/return the stored matrix (get)
## (3) to set the inverse of the matrix to a passed value (setinverse)
## (4) return the stored inverse of the matrix (getinverse)
##
## Sets up a list to access the variables/functions by x$name

makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  get <- function() x
  setinverse <- function(inverse) inv <<- inverse
  getinverse <- function() inv
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}

## ------------------------------------------------------------------------------------
## cacheSolve - Input Parameter: x (a makeCacheMatrix object)
##              Output Parameter: inv (a matrix) 
## ------------------------------------------------------------------------------------
## Attemts to retrieve an already stored inverse from the passed matrix using the 
## getinverse variable from the makeCacheMatrix function. If found, returns this value.
## Otherwise, retrieves the original matrix using the get variable from the makeCacheMatrix 
## function and calls the solve function to calculate the inverse. Stores this value on
## the makeCacheMatrix matrix by setting the setinverse variable. Returns this value to
## the calling environment.

cacheSolve <- function(x, ...) {
   ## Return a matrix that is the inverse of 'x'
   inv <- x$getinverse()
   if(!is.null(inv)) {
      message("getting cached data")
      return(inv)
   }
   data <- x$get()
   inv <- solve(data, ...)
   x$setinverse(inv)
   inv
}
