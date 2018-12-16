from pprint import pprint
"""
Feel free to use any language to write this program in.


 Baby Names
 ===========
 
 Build a baby names search engine.
 
 We collected baby names from various published lists and
 put them into a JSON object as follows:
 
 key: source list name 
 (e.g. "2015-us-official-boys", "2015-baby-center-girls")
 
 value: a list of names in the order of popularity 
 (e.g. [ "Sophia", "Emma", "Olivia", ... ])
 
 Write a function that given a name, returns an ascending rank
 sorted list of names of all lists where the given name appears.
 
 For example, given "sophia", function returns:
 
  [
    {list: "2016-baby-center-girls", rank: 1},
    {list: "2015-baby-center-girls", rank: 1},
    {list: "2015-us-official-girls", rank: 3}
  ]
 
 
 Examples:
 
 Input: "sophia" Output:
 
 [
   { list: '2016-baby-center-girls', rank: 1 },
   { list: '2015-baby-center-girls', rank: 1 },
   { list: '2015-us-official-girls', rank: 3 }
 ]
 
 Input: "nicholas" Output:
 
 [
   { list: '2015-baby-center-boys', rank: 36 },
   { list: '2016-baby-center-boys', rank: 39 }
 ]

"""

baby_names = {
  "2016-baby-center-girls": [ 
      "Sophia", "Emma", "Olivia", "Ava", "Mia", "Isabella", "Riley", "Aria",
      "Zoe", "Charlotte", "Lily", "Layla", "Amelia", "Emily", "Madelyn",
      "Aubrey", "Adalyn", "Madison", "Chloe", "Harper", "Abigail", "Aaliyah",
      "Avery", "Evelyn", "Kaylee", "Ella", "Ellie", "Scarlett", "Arianna",
      "Hailey", "Nora", "Addison", "Brooklyn", "Hannah", "Mila", "Leah",
      "Elizabeth", "Sarah", "Eliana", "Mackenzie", "Peyton", "Maria", "Grace",
      "Adeline", "Elena", "Anna", "Victoria", "Camilla", "Lillian", "Natalie"
  ],
  "2016-baby-center-boys": [ 
      "Jackson", "Aiden", "Lucas", "Liam", "Noah", "Ethan", "Mason", "Caden",
      "Oliver", "Elijah", "Grayson", "Jacob", "Michael", "Benjamin", "Carter",
      "James", "Jayden", "Logan", "Alexander", "Caleb", "Ryan", "Luke",
      "Daniel", "Jack", "William", "Owen", "Gabriel", "Matthew", "Connor",
      "Jayce", "Isaac", "Sebastian", "Henry", "Muhammad", "Cameron", "Wyatt",
      "Dylan", "Nathan", "Nicholas", "Julian", "Eli", "Levi", "Isaiah",
      "Landon", "David", "Christian", "Andrew", "Brayden", "John", "Lincoln"
  ],
  "2015-baby-center-girls": [
      "Sophia", "Emma", "Olivia", "Ava", "Mia", "Isabella", "Zoe", "Lily",
      "Emily", "Madison", "Amelia", "Riley", "Madelyn", "Charlotte", "Chloe",
      "Aubrey", "Aria", "Layla", "Avery", "Abigail", "Harper", "Kaylee",
      "Aaliyah", "Evelyn", "Adalyn", "Ella", "Arianna", "Hailey", "Ellie",
      "Nora", "Hannah", "Addison", "Mackenzie", "Brooklyn", "Scarlett", "Anna",
      "Mila", "Audrey", "Isabelle", "Elizabeth", "Leah", "Sarah", "Lillian",
      "Grace", "Natalie", "Kylie", "Lucy", "Makayla", "Maya", "Kaitlyn" 
  ],
  "2015-baby-center-boys": [
      "Jackson", "Aiden", "Liam", "Lucas", "Noah", "Mason", "Ethan", "Caden",
      "Logan", "Jacob", "Jayden", "Oliver", "Elijah", "Alexander", "Michael",
      "Carter", "James", "Caleb", "Benjamin", "Jack", "Luke", "Grayson",
      "William", "Ryan", "Connor", "Daniel", "Gabriel", "Owen", "Henry",
      "Matthew", "Isaac", "Wyatt", "Jayce", "Cameron", "Landon", "Nicholas",
      "Dylan", "Nathan", "Muhammad", "Sebastian", "Eli", "David", "Brayden",
      "Andrew", "Joshua", "Samuel", "Hunter", "Anthony", "Julian", "Dominic" 
  ],
  "2015-us-official-girls": [
    "Emma", "Olivia", "Sophia", "Ava", "Isabella", "Mia", "Abigail",
    "Emily","Charlotte", "Harper" 
  ],
  "2015-us-official-boys": [
    "Noah", "Liam", "Mason", "Jacob", "William", "Ethan",
    "James", "Alexander", "Michael", "Benjamin" 
   ]
}


def baby_search_engine(name):
    """
    Takes in a name and we search the dictionary of baby_names for every list that appears in and rank list in 
    order of name ranking
    
    """
    
    name_ranking = []
    
    for publication_name, name_list in baby_names.items():
        publication = {}
        if name.capitalize() in name_list:
            publication['list'] = publication_name
            publication['rank'] = name_list.index(name.capitalize()) + 1
            name_ranking.append(publication)

    
    return sorted(name_ranking, key=lambda k: k['rank'])

pprint(baby_search_engine("sophia"))
pprint(baby_search_engine("Nicholas"))
pprint(baby_search_engine("Shade"))
pprint(baby_search_engine("SOPHIA"))