# KDTree
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Build Status](https://www.travis-ci.org/mateuszstompor/kdtree.svg?branch=master)](https://www.travis-ci.org/mateuszstompor/kdtree)
<br>
Repository contains Ruby implementation of space partitioning tree data structure. It is a form of binary tree and its detailed description can be found [here](https://en.wikipedia.org/wiki/K-d_tree).

# Installation
###### Offline installation
* Download or clone repository
* Navigate to the root folder of the project
* Build gem with command:
```bash
    $ gem build kd_tree.gemspec
```
* Install gem in search paths
```bash
    $ gem install kd_tree_ms-x.x.x.gem
```
Where "x.x.x" is a version number

###### Online installation with ruby gem
It is not available at the moment, you will be able to install gem when it becomes fully stable

# Usage
```ruby
    # First of all you have to import the library to your project
    require 'kd_tree_ms'

    # Create an empty tree of dimension 2
    tree = Kd::Tree.new 2

    # Insert value to the tree
    # Provide coordinates
    # As an example let's take [0, 1] where 0 is x and 1 is y coordinate
    tree.insert [0, 1], 'some_value'

    # You can check if the tree is empty
    puts tree.empty?

    # It is possible to check its size as well
    puts tree.size
```
