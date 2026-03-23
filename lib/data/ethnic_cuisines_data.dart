import '../models/ethnic_cuisine.dart';

const List<EthnicCuisine> ethnicCuisines = [
  EthnicCuisine(
    id: 'akan',
    name: 'Akan',
    group: 'Grand ensemble culturel Akan',
    regions: ['Centre', 'Est', 'Sud-Est'],
    description:
        'Les cuisines akan sont connues pour leurs sauces onctueuses, leurs feculents piles et leurs plats servis lors des grands moments familiaux.',
    historicalOverview:
        'Les peuples akan occupent une place importante dans l histoire du Centre et de l Est ivoiriens. Leur culture culinaire s est construite autour des cultures de base locales, des techniques de pilage et des repas de partage servis lors des rassemblements.',
    culinaryIdentity:
        'On y retrouve souvent des sauces profondes en gout, des accompagnements comme le foutou, des plats de poisson et une cuisine de table familiale.',
    communities: ['Baoule', 'Agni', 'Abron'],
    specialties: [
      'Foutou et sauces',
      'Poisson assaisonne',
      'Desserts et collations de fete',
    ],
    stapleIngredients: [
      'Igname',
      'Banane plantain',
      'Tomate',
      'Piment',
      'Poisson',
    ],
    culturalMoments: [
      'Repas de famille',
      'Ceremonies communautaires',
      'Accueil des invites',
    ],
    recipeIds: ['attieke_poisson', 'claclo', 'gateau_creme'],
  ),
  EthnicCuisine(
    id: 'krou',
    name: 'Krou',
    group: 'Peuples Krou du littoral et du Sud-Ouest',
    regions: ['Littoral', 'Sud-Ouest', 'Bas-Sassandra'],
    description:
        'Les cuisines krou valorisent la mer, les produits fumes, les cuissons directes et les accompagnements simples mais tres parfumes.',
    historicalOverview:
        'Installes sur le littoral et dans les zones forestieres du Sud-Ouest, les peuples krou ont developpe une cuisine fortement reliee a la peche, au commerce local et aux produits frais des zones cotieres.',
    culinaryIdentity:
        'Les plats sont souvent vifs, sales, pimentes et centres sur le poisson, la friture, les sauces rapides et les aliments de rue tres populaires.',
    communities: ['Bete', 'Dida', 'Wobe', 'Kroumen'],
    specialties: [
      'Poissons frits',
      'Accompagnements de rue',
      'Saveurs marines et fumees',
    ],
    stapleIngredients: [
      'Poisson',
      'Attieke',
      'Plantain',
      'Oignon',
      'Piment',
    ],
    culturalMoments: [
      'Marches populaires',
      'Repas cotiers',
      'Cuisine de rue',
    ],
    recipeIds: ['garba', 'alloco', 'attieke_poisson'],
  ),
  EthnicCuisine(
    id: 'mande',
    name: 'Mande',
    group: 'Peuples Mande de l Ouest et du Nord-Ouest',
    regions: ['Ouest', 'Nord-Ouest', 'Zones de savane et de transition'],
    description:
        'Les cuisines mande privilegient les plats consistants, les cuissons lentes, les riz riches et les mets partages en grande quantite.',
    historicalOverview:
        'Les traditions culinaires mande sont liees aux routes commerciales anciennes, aux grands espaces de l Ouest et aux habitudes de repas collectifs. Les plats sont souvent penses pour nourrir de nombreux convives.',
    culinaryIdentity:
        'Le riz, les sauces longues, les viandes et certaines preparations de grande marmite occupent une place centrale dans cette culture alimentaire.',
    communities: ['Malinke', 'Dan', 'Yacouba', 'Gouro'],
    specialties: [
      'Riz sauces',
      'Mijotes de viande',
      'Plats de grande marmite',
    ],
    stapleIngredients: [
      'Riz',
      'Tomate',
      'Viande ou poisson',
      'Legumes',
      'Epices locales',
    ],
    culturalMoments: [
      'Fetes familiales',
      'Repas communautaires',
      'Hospitalite traditionnelle',
    ],
    recipeIds: ['tchep', 'kedjenou', 'macedoine'],
  ),
  EthnicCuisine(
    id: 'gour',
    name: 'Gour',
    group: 'Peuples Gour du Nord et du Nord-Est',
    regions: ['Nord', 'Nord-Est', 'Zones de savane'],
    description:
        'Les cuisines gour mettent en avant les preparations nourrissantes, les cereales, les boissons de convivialite et les recettes adaptees aux grands repas collectifs.',
    historicalOverview:
        'Dans les regions du Nord et du Nord-Est, les peuples gour ont developpe une cuisine ancree dans la vie agricole, les produits de saison et les habitudes de conservation adaptees au climat de savane.',
    culinaryIdentity:
        'Les saveurs y sont franches, les preparations souvent simples dans leur forme mais tres genereuses dans leur fonction nourriciere et sociale.',
    communities: ['Senoufo', 'Lobi', 'Koulango'],
    specialties: [
      'Boissons de partage',
      'Plats nourrissants',
      'Cuisine de saison',
    ],
    stapleIngredients: [
      'Cereales',
      'Tubercules',
      'Feuilles et legumes',
      'Sucre',
      'Fleurs infusees',
    ],
    culturalMoments: [
      'Rencontres communautaires',
      'Jours de marche',
      'Repas de saison',
    ],
    recipeIds: ['bissap', 'dessert_fruits', 'alloco'],
  ),
];
