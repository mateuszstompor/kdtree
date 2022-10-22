# KDTree &middot; [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![Build Status](https://www.travis-ci.org/mateuszstompor/kdtree.svg?branch=master)](https://www.travis-ci.org/mateuszstompor/kdtree)


### About the project
Repository contains Ruby implementation of space partitioning tree data structure. 
It is a form of binary tree meant to provide a efficient way of objects retrieval.
Detailed description can be found [here](https://en.wikipedia.org/wiki/K-d_tree)

# Usage
```ruby
    # Import the library to your project
    require 'kd_tree_ms'

    # Create an empty tree of dimension 2
    tree = Kd::Tree.new 2

    # Insert value to the tree
    # Provide coordinates
    # As an example let's take [0, 1] where 0 is x and 1 is y coordinate
    tree.insert [0, 1], 'some_value'

    # You can delete a value which you have inserted before
    tree.delete 'some_value'

    # You can check if the tree is empty
    tree.empty?

    # Check if it includes a value which you are looking for
    tree.include? 'some_value'

    # Append
    tree << [2, 3, 'some_value']

    # Clear an existing tree
    tree.clear

    # Retrieve data from a tree
    # Supply amount of ranges equivalent to the dimension of a tree
    tree.retrieve [0..2, -1..2]

    # Retrieve minimal value for the dimension which a user has passed
    tree.minimum 0

    # Check the dimension of a tree
    tree.dimension

    # It is possible to check its size as well
    tree.size
```

# Approach
The Tree was implemented in TDD approach. 
There are many simple, easy to read tests, written with help of MiniTest gem

# Installation
* Download or clone repository
* Navigate to the root folder of the project
* Build gem with command:
```bash
    $ gem build kd_tree.gemspec
```
* Install gem on your machine
```bash
    $ sudo gem install kd_tree_ms-1.0.0.gem
```
