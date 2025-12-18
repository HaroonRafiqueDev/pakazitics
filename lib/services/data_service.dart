import '../models/city.dart';
import '../models/tourist_spot.dart';

class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  List<City>? _cachedCities;

  List<City> getAllCities() {
    if (_cachedCities != null) return _cachedCities!;

    _cachedCities = [
      _getKarachi(),
      _getLahore(),
      _getIslamabad(),
      _getPeshawar(),
      _getMultan(),
      _getFaisalabad(),
      _getQuetta(),
      _getGilgit(),
    ];
    return _cachedCities!;
  }

  City? getCityById(String id) {
    try {
      return getAllCities().firstWhere((city) => city.id == id);
    } catch (e) {
      return null;
    }
  }

  TouristSpot? getSpotById(String spotId) {
    for (var city in getAllCities()) {
      try {
        return city.touristSpots.firstWhere((spot) => spot.id == spotId);
      } catch (e) {
        continue;
      }
    }
    return null;
  }

  List<TouristSpot> getAllSpots() {
    List<TouristSpot> allSpots = [];
    for (var city in getAllCities()) {
      allSpots.addAll(city.touristSpots);
    }
    return allSpots;
  }

  // Karachi
  City _getKarachi() {
    return City(
      id: 'karachi',
      name: 'Karachi',
      description:
          'The vibrant port city and economic hub of Pakistan, known for its beaches and diverse culture.',
      imagePath: 'assets/images/cities/karachi.jpg',
      rating: 4.2,
      latitude: 24.8607,
      longitude: 67.0011,
      touristSpots: [
        TouristSpot(
          id: 'karachi_1',
          name: 'Clifton Beach',
          description:
              'One of the most popular beaches in Karachi, perfect for evening strolls and camel rides.',
          imagePath: 'assets/images/spots/clifton_beach.jpg',
          bestTimeToVisit: 'October to March',
          entryFee: 'Free',
          latitude: 24.8138,
          longitude: 67.0260,
          category: 'Natural',
        ),
        TouristSpot(
          id: 'karachi_2',
          name: 'Mohatta Palace',
          description:
              'A stunning heritage building showcasing beautiful architecture and art exhibitions.',
          imagePath: 'assets/images/spots/mohatta_palace.jpg',
          bestTimeToVisit: 'Year Round',
          entryFee: 'PKR 50',
          latitude: 24.8138,
          longitude: 67.0297,
          category: 'Historical',
        ),
        TouristSpot(
          id: 'karachi_3',
          name: 'Quaid-e-Azam Mausoleum',
          description:
              'The final resting place of Pakistan\'s founder, a magnificent white marble structure.',
          imagePath: 'assets/images/spots/quaid_mausoleum.jpg',
          bestTimeToVisit: 'Year Round',
          entryFee: 'Free',
          latitude: 24.8752,
          longitude: 67.0408,
          category: 'Historical',
        ),
        TouristSpot(
          id: 'karachi_4',
          name: 'Frere Hall',
          description:
              'A historic building surrounded by beautiful gardens, now housing a library.',
          imagePath: 'assets/images/spots/frere_hall.jpg',
          bestTimeToVisit: 'October to March',
          entryFee: 'Free',
          latitude: 24.8459,
          longitude: 67.0289,
          category: 'Historical',
        ),
        TouristSpot(
          id: 'karachi_5',
          name: 'Pakistan Maritime Museum',
          description:
              'A fascinating museum showcasing Pakistan\'s naval history with submarines and aircraft.',
          imagePath: 'assets/images/spots/maritime_museum.jpg',
          bestTimeToVisit: 'Year Round',
          entryFee: 'PKR 100',
          latitude: 24.8138,
          longitude: 67.0260,
          category: 'Cultural',
        ),
      ],
    );
  }

  // Lahore
  City _getLahore() {
    return City(
      id: 'lahore',
      name: 'Lahore',
      description:
          'The cultural heart of Pakistan, famous for its Mughal architecture and vibrant food scene.',
      imagePath: 'assets/images/cities/lahore.jpg',
      rating: 4.8,
      latitude: 31.5497,
      longitude: 74.3436,
      touristSpots: [
        TouristSpot(
          id: 'lahore_1',
          name: 'Badshahi Mosque',
          description:
              'One of the largest mosques in the world, a masterpiece of Mughal architecture.',
          imagePath: 'assets/images/spots/badshahi_mosque.jpg',
          bestTimeToVisit: 'October to March',
          entryFee: 'Free',
          latitude: 31.5881,
          longitude: 74.3097,
          category: 'Historical',
        ),
        TouristSpot(
          id: 'lahore_2',
          name: 'Lahore Fort',
          description:
              'A UNESCO World Heritage Site with stunning palaces and gardens from the Mughal era.',
          imagePath: 'assets/images/spots/lahore_fort.jpg',
          bestTimeToVisit: 'October to March',
          entryFee: 'PKR 500',
          latitude: 31.5880,
          longitude: 74.3154,
          category: 'Historical',
        ),
        TouristSpot(
          id: 'lahore_3',
          name: 'Shalimar Gardens',
          description:
              'Beautiful Mughal gardens with terraced lawns, fountains, and pavilions.',
          imagePath: 'assets/images/spots/shalimar_gardens.jpg',
          bestTimeToVisit: 'February to April',
          entryFee: 'PKR 50',
          latitude: 31.5861,
          longitude: 74.3747,
          category: 'Natural',
        ),
        TouristSpot(
          id: 'lahore_4',
          name: 'Minar-e-Pakistan',
          description:
              'A national monument commemorating the Lahore Resolution of 1940.',
          imagePath: 'assets/images/spots/minar_pakistan.jpg',
          bestTimeToVisit: 'Year Round',
          entryFee: 'PKR 50',
          latitude: 31.5925,
          longitude: 74.3095,
          category: 'Historical',
        ),
        TouristSpot(
          id: 'lahore_5',
          name: 'Lahore Museum',
          description:
              'Pakistan\'s largest museum with extensive collections of art and artifacts.',
          imagePath: 'assets/images/spots/lahore_museum.jpg',
          bestTimeToVisit: 'Year Round',
          entryFee: 'PKR 200',
          latitude: 31.5656,
          longitude: 74.3242,
          category: 'Cultural',
        ),
        TouristSpot(
          id: 'lahore_6',
          name: 'Wazir Khan Mosque',
          description:
              'A stunning mosque known for its intricate tile work and frescoes.',
          imagePath: 'assets/images/spots/wazir_khan.jpg',
          bestTimeToVisit: 'October to March',
          entryFee: 'Free',
          latitude: 31.5820,
          longitude: 74.3191,
          category: 'Historical',
        ),
        TouristSpot(
          id: 'lahore_7',
          name: 'Anarkali Bazaar',
          description:
              'One of the oldest markets in South Asia, perfect for shopping and food.',
          imagePath: 'assets/images/spots/anarkali_bazaar.jpg',
          bestTimeToVisit: 'Year Round',
          entryFee: 'Free',
          latitude: 31.5580,
          longitude: 74.3153,
          category: 'Cultural',
        ),
      ],
    );
  }

  // Islamabad
  City _getIslamabad() {
    return City(
      id: 'islamabad',
      name: 'Islamabad',
      description:
          'Pakistan\'s modern capital city, known for its scenic beauty and well-planned infrastructure.',
      imagePath: 'assets/images/cities/islamabad.jpg',
      rating: 4.6,
      latitude: 33.6844,
      longitude: 73.0479,
      touristSpots: [
        TouristSpot(
          id: 'islamabad_1',
          name: 'Faisal Mosque',
          description:
              'The largest mosque in Pakistan with stunning contemporary architecture.',
          imagePath: 'assets/images/spots/faisal_mosque.jpg',
          bestTimeToVisit: 'Year Round',
          entryFee: 'Free',
          latitude: 33.7295,
          longitude: 73.0372,
          category: 'Historical',
        ),
        TouristSpot(
          id: 'islamabad_2',
          name: 'Daman-e-Koh',
          description:
              'A viewpoint in the Margalla Hills offering panoramic views of Islamabad.',
          imagePath: 'assets/images/spots/daman_e_koh.jpg',
          bestTimeToVisit: 'March to May',
          entryFee: 'Free',
          latitude: 33.7318,
          longitude: 73.0551,
          category: 'Natural',
        ),
        TouristSpot(
          id: 'islamabad_3',
          name: 'Pakistan Monument',
          description:
              'A national monument representing the four provinces and three territories.',
          imagePath: 'assets/images/spots/pakistan_monument.jpg',
          bestTimeToVisit: 'Year Round',
          entryFee: 'PKR 50',
          latitude: 33.6929,
          longitude: 73.0681,
          category: 'Historical',
        ),
        TouristSpot(
          id: 'islamabad_4',
          name: 'Lok Virsa Museum',
          description:
              'A heritage museum showcasing Pakistan\'s diverse cultural traditions.',
          imagePath: 'assets/images/spots/lok_virsa.jpg',
          bestTimeToVisit: 'Year Round',
          entryFee: 'PKR 20',
          latitude: 33.6518,
          longitude: 73.0835,
          category: 'Cultural',
        ),
        TouristSpot(
          id: 'islamabad_5',
          name: 'Rawal Lake',
          description:
              'A beautiful artificial reservoir perfect for boating and picnics.',
          imagePath: 'assets/images/spots/rawal_lake.jpg',
          bestTimeToVisit: 'September to April',
          entryFee: 'Free',
          latitude: 33.6989,
          longitude: 73.1285,
          category: 'Natural',
        ),
      ],
    );
  }

  // Peshawar
  City _getPeshawar() {
    return City(
      id: 'peshawar',
      name: 'Peshawar',
      description:
          'One of the oldest cities in South Asia, rich in history and Pashtun culture.',
      imagePath: 'assets/images/cities/peshawar.jpg',
      rating: 4.3,
      latitude: 34.0151,
      longitude: 71.5249,
      touristSpots: [
        TouristSpot(
          id: 'peshawar_1',
          name: 'Qissa Khwani Bazaar',
          description:
              'The legendary "Street of Storytellers", a historic marketplace.',
          imagePath: 'assets/images/spots/qissa_khwani.jpg',
          bestTimeToVisit: 'October to March',
          entryFee: 'Free',
          latitude: 34.0089,
          longitude: 71.5784,
          category: 'Cultural',
        ),
        TouristSpot(
          id: 'peshawar_2',
          name: 'Peshawar Museum',
          description:
              'Home to one of the finest collections of Gandhara art in the world.',
          imagePath: 'assets/images/spots/peshawar_museum.jpg',
          bestTimeToVisit: 'Year Round',
          entryFee: 'PKR 100',
          latitude: 34.0089,
          longitude: 71.5601,
          category: 'Cultural',
        ),
        TouristSpot(
          id: 'peshawar_3',
          name: 'Bala Hisar Fort',
          description:
              'An ancient fort with a rich history dating back to the Mughal era.',
          imagePath: 'assets/images/spots/bala_hisar.jpg',
          bestTimeToVisit: 'October to March',
          entryFee: 'PKR 50',
          latitude: 34.0089,
          longitude: 71.5784,
          category: 'Historical',
        ),
        TouristSpot(
          id: 'peshawar_4',
          name: 'Mahabat Khan Mosque',
          description:
              'A beautiful 17th-century mosque with stunning Mughal architecture.',
          imagePath: 'assets/images/spots/mahabat_khan.jpg',
          bestTimeToVisit: 'Year Round',
          entryFee: 'Free',
          latitude: 34.0089,
          longitude: 71.5784,
          category: 'Historical',
        ),
        TouristSpot(
          id: 'peshawar_5',
          name: 'Khyber Pass',
          description:
              'Historic mountain pass connecting Pakistan and Afghanistan.',
          imagePath: 'assets/images/spots/khyber_pass.jpg',
          bestTimeToVisit: 'October to March',
          entryFee: 'Permit Required',
          latitude: 34.0989,
          longitude: 71.0784,
          category: 'Natural',
        ),
      ],
    );
  }

  // Multan
  City _getMultan() {
    return City(
      id: 'multan',
      name: 'Multan',
      description:
          'The City of Saints, known for its Sufi shrines and ancient heritage.',
      imagePath: 'assets/images/cities/multan.jpg',
      rating: 4.1,
      latitude: 30.1575,
      longitude: 71.5249,
      touristSpots: [
        TouristSpot(
          id: 'multan_1',
          name: 'Shrine of Bahauddin Zakariya',
          description:
              'A magnificent shrine of the great Sufi saint with beautiful architecture.',
          imagePath: 'assets/images/spots/bahauddin_shrine.jpg',
          bestTimeToVisit: 'October to March',
          entryFee: 'Free',
          latitude: 30.1975,
          longitude: 71.4653,
          category: 'Historical',
        ),
        TouristSpot(
          id: 'multan_2',
          name: 'Multan Fort',
          description:
              'An ancient fort with a history spanning over 2000 years.',
          imagePath: 'assets/images/spots/multan_fort.jpg',
          bestTimeToVisit: 'October to March',
          entryFee: 'PKR 50',
          latitude: 30.1975,
          longitude: 71.4653,
          category: 'Historical',
        ),
        TouristSpot(
          id: 'multan_3',
          name: 'Shah Rukn-e-Alam',
          description:
              'A stunning mausoleum and one of the finest examples of pre-Mughal architecture.',
          imagePath: 'assets/images/spots/shah_rukn.jpg',
          bestTimeToVisit: 'Year Round',
          entryFee: 'Free',
          latitude: 30.1975,
          longitude: 71.4653,
          category: 'Historical',
        ),
        TouristSpot(
          id: 'multan_4',
          name: 'Hussain Agahi Bazaar',
          description:
              'A vibrant traditional market famous for handicrafts and pottery.',
          imagePath: 'assets/images/spots/hussain_agahi.jpg',
          bestTimeToVisit: 'Year Round',
          entryFee: 'Free',
          latitude: 30.1975,
          longitude: 71.4653,
          category: 'Cultural',
        ),
        TouristSpot(
          id: 'multan_5',
          name: 'Tomb of Shah Shams Tabrez',
          description:
              'A beautiful shrine with intricate tile work and peaceful atmosphere.',
          imagePath: 'assets/images/spots/shah_shams.jpg',
          bestTimeToVisit: 'October to March',
          entryFee: 'Free',
          latitude: 30.1975,
          longitude: 71.4653,
          category: 'Historical',
        ),
      ],
    );
  }

  // Faisalabad
  City _getFaisalabad() {
    return City(
      id: 'faisalabad',
      name: 'Faisalabad',
      description:
          'Pakistan\'s textile hub, known for its industrial heritage and vibrant markets.',
      imagePath: 'assets/images/cities/faisalabad.jpg',
      rating: 3.9,
      latitude: 31.4504,
      longitude: 73.1350,
      touristSpots: [
        TouristSpot(
          id: 'faisalabad_1',
          name: 'Clock Tower',
          description:
              'The iconic Ghanta Ghar, the heart of Faisalabad\'s eight bazaars.',
          imagePath: 'assets/images/spots/clock_tower.jpg',
          bestTimeToVisit: 'Year Round',
          entryFee: 'Free',
          latitude: 31.4180,
          longitude: 73.0790,
          category: 'Historical',
        ),
        TouristSpot(
          id: 'faisalabad_2',
          name: 'Jinnah Garden',
          description:
              'A beautiful public park perfect for family outings and relaxation.',
          imagePath: 'assets/images/spots/jinnah_garden.jpg',
          bestTimeToVisit: 'October to March',
          entryFee: 'PKR 20',
          latitude: 31.4180,
          longitude: 73.0790,
          category: 'Natural',
        ),
        TouristSpot(
          id: 'faisalabad_3',
          name: 'Lyallpur Museum',
          description:
              'A museum showcasing the history and culture of Faisalabad.',
          imagePath: 'assets/images/spots/lyallpur_museum.jpg',
          bestTimeToVisit: 'Year Round',
          entryFee: 'PKR 50',
          latitude: 31.4180,
          longitude: 73.0790,
          category: 'Cultural',
        ),
        TouristSpot(
          id: 'faisalabad_4',
          name: 'Gatwala Wildlife Park',
          description: 'A wildlife park and zoo with diverse animal species.',
          imagePath: 'assets/images/spots/gatwala_park.jpg',
          bestTimeToVisit: 'October to March',
          entryFee: 'PKR 100',
          latitude: 31.4180,
          longitude: 73.0790,
          category: 'Natural',
        ),
        TouristSpot(
          id: 'faisalabad_5',
          name: 'Chenab Club',
          description:
              'A historic club with beautiful architecture and recreational facilities.',
          imagePath: 'assets/images/spots/chenab_club.jpg',
          bestTimeToVisit: 'Year Round',
          entryFee: 'Members Only',
          latitude: 31.4180,
          longitude: 73.0790,
          category: 'Cultural',
        ),
      ],
    );
  }

  // Quetta
  City _getQuetta() {
    return City(
      id: 'quetta',
      name: 'Quetta',
      description:
          'The fruit garden of Pakistan, surrounded by mountains and natural beauty.',
      imagePath: 'assets/images/cities/quetta.jpg',
      rating: 4.4,
      latitude: 30.1798,
      longitude: 66.9750,
      touristSpots: [
        TouristSpot(
          id: 'quetta_1',
          name: 'Hanna Lake',
          description:
              'A picturesque lake surrounded by mountains, perfect for picnics.',
          imagePath: 'assets/images/spots/hanna_lake.jpg',
          bestTimeToVisit: 'March to October',
          entryFee: 'PKR 50',
          latitude: 30.2798,
          longitude: 66.9750,
          category: 'Natural',
        ),
        TouristSpot(
          id: 'quetta_2',
          name: 'Quetta Geological Museum',
          description:
              'A unique museum displaying geological specimens and fossils.',
          imagePath: 'assets/images/spots/geological_museum.jpg',
          bestTimeToVisit: 'Year Round',
          entryFee: 'PKR 20',
          latitude: 30.1798,
          longitude: 66.9750,
          category: 'Cultural',
        ),
        TouristSpot(
          id: 'quetta_3',
          name: 'Ziarat',
          description:
              'A hill station famous for juniper forests and Quaid\'s Residency.',
          imagePath: 'assets/images/spots/ziarat.jpg',
          bestTimeToVisit: 'May to September',
          entryFee: 'Free',
          latitude: 30.3820,
          longitude: 67.7257,
          category: 'Natural',
        ),
        TouristSpot(
          id: 'quetta_4',
          name: 'Hazarganji Chiltan National Park',
          description:
              'A national park home to rare wildlife including the Chiltan markhor.',
          imagePath: 'assets/images/spots/hazarganji.jpg',
          bestTimeToVisit: 'March to October',
          entryFee: 'PKR 100',
          latitude: 30.1798,
          longitude: 66.9750,
          category: 'Natural',
        ),
        TouristSpot(
          id: 'quetta_5',
          name: 'Urak Valley',
          description:
              'A beautiful valley with lush greenery and fruit orchards.',
          imagePath: 'assets/images/spots/urak_valley.jpg',
          bestTimeToVisit: 'April to September',
          entryFee: 'Free',
          latitude: 30.1798,
          longitude: 66.9750,
          category: 'Natural',
        ),
      ],
    );
  }

  // Gilgit
  City _getGilgit() {
    return City(
      id: 'gilgit',
      name: 'Gilgit',
      description:
          'Gateway to the northern areas, offering breathtaking mountain scenery.',
      imagePath: 'assets/images/cities/gilgit.jpg',
      rating: 4.9,
      latitude: 35.9208,
      longitude: 74.3080,
      touristSpots: [
        TouristSpot(
          id: 'gilgit_1',
          name: 'Hunza Valley',
          description:
              'A stunning valley with snow-capped peaks, ancient forts, and friendly people.',
          imagePath: 'assets/images/spots/hunza_valley.jpg',
          bestTimeToVisit: 'April to October',
          entryFee: 'Free',
          latitude: 36.3167,
          longitude: 74.6500,
          category: 'Natural',
        ),
        TouristSpot(
          id: 'gilgit_2',
          name: 'Naltar Valley',
          description:
              'Famous for its colorful lakes and skiing opportunities.',
          imagePath: 'assets/images/spots/naltar_valley.jpg',
          bestTimeToVisit: 'June to September',
          entryFee: 'Free',
          latitude: 36.1667,
          longitude: 74.1833,
          category: 'Natural',
        ),
        TouristSpot(
          id: 'gilgit_3',
          name: 'Fairy Meadows',
          description:
              'A magical alpine meadow with stunning views of Nanga Parbat.',
          imagePath: 'assets/images/spots/fairy_meadows.jpg',
          bestTimeToVisit: 'May to September',
          entryFee: 'PKR 200',
          latitude: 35.4167,
          longitude: 74.5833,
          category: 'Natural',
        ),
        TouristSpot(
          id: 'gilgit_4',
          name: 'Skardu',
          description:
              'A beautiful town surrounded by mountains, lakes, and ancient forts.',
          imagePath: 'assets/images/spots/skardu.jpg',
          bestTimeToVisit: 'April to October',
          entryFee: 'Free',
          latitude: 35.2972,
          longitude: 75.6333,
          category: 'Natural',
        ),
        TouristSpot(
          id: 'gilgit_5',
          name: 'Attabad Lake',
          description:
              'A stunning turquoise lake formed by a landslide in 2010.',
          imagePath: 'assets/images/spots/attabad_lake.jpg',
          bestTimeToVisit: 'April to October',
          entryFee: 'Free',
          latitude: 36.3333,
          longitude: 74.8667,
          category: 'Natural',
        ),
        TouristSpot(
          id: 'gilgit_6',
          name: 'Karakoram Highway',
          description:
              'The highest paved international road in the world with breathtaking views.',
          imagePath: 'assets/images/spots/kkh.jpg',
          bestTimeToVisit: 'May to October',
          entryFee: 'Free',
          latitude: 35.9208,
          longitude: 74.3080,
          category: 'Natural',
        ),
        TouristSpot(
          id: 'gilgit_7',
          name: 'Deosai National Park',
          description:
              'The second highest plateau in the world, home to Himalayan brown bears.',
          imagePath: 'assets/images/spots/deosai.jpg',
          bestTimeToVisit: 'June to September',
          entryFee: 'PKR 300',
          latitude: 35.0167,
          longitude: 75.3667,
          category: 'Natural',
        ),
      ],
    );
  }
}
