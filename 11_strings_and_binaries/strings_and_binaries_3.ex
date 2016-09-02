IO.inspect ['cat' | 'dog']

# This outputs ['cat', 100, 111, 103]
# because the head of the newly created list is actually the list [?c, ?a, ?t]
# This means the overall list consists of a list and three ASCII characters:
# ['cat' | 'dog'] = [[?c, ?a, ?t], ?d, ?o, ?g]
