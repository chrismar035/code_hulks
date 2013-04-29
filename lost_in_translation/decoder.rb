require './substitution_cypher'

encoded_seed = 'encoded_ref.txt'
decoded_seed = 'decoded_ref.txt'

s = SubstitutionCypher.new(encoded_seed, decoded_seed)
s.decode_message 'encoded_message.txt'
