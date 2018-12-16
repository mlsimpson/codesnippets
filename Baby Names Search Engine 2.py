from pprint import pprint

"""
Baby Names Search Engine, part 2

Now, we would like to make our service more user friendly. We would 
like to provide a name prefix (e.g. "an") and get all baby names that
start with that prefix (e.g. "anna", "anthony", etc.) along with the
list name and relative ranking for each matching name.

For example, given "an", function returns something like this:

    {
      anna: [
        { list: '2015-baby-center-girls', rank: 36 },
        { list: '2016-baby-center-girls', rank: 46 }
      ],
      andrew: [
        { list: '2015-baby-center-boys', rank: 44 },
        { list: '2016-baby-center-boys', rank: 47 }
      ],
      anthony: [
        { list: '2015-baby-center-boys', rank: 48 }
      ]
    }

Examples
========

Search: "s"
Output:

    {
      sophia:
       [ { list: '2016-baby-center-girls', rank: 1 },
         { list: '2015-baby-center-girls', rank: 1 },
         { list: '2015-us-official-girls', rank: 3 } ],
      scarlett:
       [ { list: '2016-baby-center-girls', rank: 28 },
         { list: '2015-baby-center-girls', rank: 35 } ],
      sarah:
       [ { list: '2016-baby-center-girls', rank: 38 },
         { list: '2015-baby-center-girls', rank: 42 } ],
      samuel: [ { list: '2015-baby-center-boys', rank: 46 } ],
      sebastian:
       [ { list: '2016-baby-center-boys', rank: 32 },
         { list: '2015-baby-center-boys', rank: 40 } ]
    }


Search: "ant"
Output:
    { anthony: [ { list: '2015-baby-center-boys', rank: 48 } ] }


Search: "an"
Output:

    {
      anna: [
        { list: '2015-baby-center-girls', rank: 36 },
        { list: '2016-baby-center-girls', rank: 46 }
      ],
      andrew: [
        { list: '2015-baby-center-boys', rank: 44 },
        { list: '2016-baby-center-boys', rank: 47 }
      ],
      anthony: [
        { list: '2015-baby-center-boys', rank: 48 }
      ]
    }

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


def baby_search_engine(prefix):
    """
    Takes in a name and we search the dictionary of baby_names for every list that appears in and rank list in 
    order of name ranking
    
    """
    
    name_ranking = {}
    
    for publication_name, name_list in baby_names.items():
        for name in name_list:
            if name.startswith(prefix.capitalize()):
                if name not in name_ranking:
                    name_ranking[name] = []
                publication = {}
                publication['list'] = publication_name
                publication['rank'] = name_list.index(name.capitalize()) + 1
                name_ranking[name].append(publication)

    for name,publication_list in name_ranking.items():
        publication_list.sort(key=lambda k: k['rank'])
    
    return name_ranking

pprint(baby_search_engine("ant"))
pprint(baby_search_engine("An"))
pprint(baby_search_engine("s"))
#pprint(baby_search_engine("SOPHIA"))