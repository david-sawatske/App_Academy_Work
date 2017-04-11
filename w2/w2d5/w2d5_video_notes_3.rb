## Video 7 ##

# Caching #

# LRU - Least Reciently Used is the heuristic (rule of thumb)
# => the LRU gets deleted

# cache built as a hash map the object key and includes timestamp in values
# => operations for hash-map cache
#     -ejection 0(n)   # could have to look at all of the items
#     -insertion 0(n)  # must look at all to determine inclution
#     -reading 0(1)

# cache built as a linked link list
#     -ejection 0(1)
#     -insertion 0(1)
#     -reading 0(n)   # to find key, you must visit every node

# Need to combine hash map and linked list!!!

# LRU cache
# it will use hash map, but it will point at a likned list object, not the object itself
# hash map    linked list
{               ↑↓
  mario: =>   |object|
              |mario |
                ↑↓
  bowser: =>  |object|
              |bowser|
                ↑↓
  goomba: =>  |object|
              |goomba|
}               ↑↓

#     -ejection 0(1)   # to remove goomba, point the node on the link list that boswer
#                        points to to nil then delete the goomba key of the hash map
#     -insertion 0(1)  # append key and object to the top of the linked list and
#                        add a key to the hash map for the object
#     -reading 0(1)    # reading a hash map my finding the key
#
