class Country {
  final String name;
  final String fullName;
  final String capital;
  final String iso2;
  final String iso3;
  final Covid19? covid19;
  final CurrentPresident? currentPresident;
  final String currency;
  final String phoneCode;
  final String continent;
  final String description;
  final String size;
  final String independenceDate;
  final String population;
  final CountryLinks? href;

  Country({
    required this.name,
    required this.fullName,
    required this.capital,
    required this.iso2,
    required this.iso3,
    this.covid19,
    this.currentPresident,
    required this.currency,
    required this.phoneCode,
    required this.continent,
    required this.description,
    required this.size,
    required this.independenceDate,
    required this.population,
    this.href,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] ?? 'Unknown',
      fullName: json['full_name'] ?? 'Unknown',
      capital: json['capital'] ?? 'Unknown',
      iso2: json['iso2'] ?? '',
      iso3: json['iso3'] ?? '',
      covid19: json['covid19'] != null ? Covid19.fromJson(json['covid19']) : null,
      currentPresident: json['current_president'] != null ? CurrentPresident.fromJson(json['current_president']) : null,
      currency: json['currency'] ?? 'Unknown',
      phoneCode: json['phone_code'] ?? '',
      continent: json['continent'] ?? 'Unknown',
      description: json['description'] ?? '',
      size: json['size'] ?? '',
      independenceDate: json['independence_date'] ?? '',
      population: json['population'] ?? '',
      href: json['href'] != null ? CountryLinks.fromJson(json['href']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'full_name': fullName,
      'capital': capital,
      'iso2': iso2,
      'iso3': iso3,
      'covid19': covid19?.toJson(),
      'current_president': currentPresident?.toJson(),
      'currency': currency,
      'phone_code': phoneCode,
      'continent': continent,
      'description': description,
      'size': size,
      'independence_date': independenceDate,
      'population': population,
      'href': href?.toJson(),
    };
  }
}

class Covid19 {
  final String totalCase;
  final String totalDeaths;
  final String lastUpdated;

  Covid19({
    required this.totalCase,
    required this.totalDeaths,
    required this.lastUpdated,
  });

  factory Covid19.fromJson(Map<String, dynamic> json) {
    return Covid19(
      totalCase: json['total_case'] ?? '0',
      totalDeaths: json['total_deaths'] ?? '0',
      lastUpdated: json['last_updated'] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_case': totalCase,
      'total_deaths': totalDeaths,
      'last_updated': lastUpdated,
    };
  }
}

class CurrentPresident {
  final String name;
  final String gender;
  final String appointmentStartDate;
  final String? appointmentEndDate;
  final PresidentLinks? href;

  CurrentPresident({
    required this.name,
    required this.gender,
    required this.appointmentStartDate,
    this.appointmentEndDate,
    this.href,
  });

  factory CurrentPresident.fromJson(Map<String, dynamic> json) {
    return CurrentPresident(
      name: json['name'] ?? 'Unknown',
      gender: json['gender'] ?? 'Unknown',
      appointmentStartDate: json['appointment_start_date'] ?? '',
      appointmentEndDate: json['appointment_end_date'],
      href: json['href'] != null ? PresidentLinks.fromJson(json['href']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      'appointment_start_date': appointmentStartDate,
      'appointment_end_date': appointmentEndDate,
      'href': href?.toJson(),
    };
  }
}

class PresidentLinks {
  final String self;
  final String country;
  final String picture;

  PresidentLinks({
    required this.self,
    required this.country,
    required this.picture,
  });

  factory PresidentLinks.fromJson(Map<String, dynamic> json) {
    return PresidentLinks(
      self: json['self'] ?? '',
      country: json['country'] ?? '',
      picture: json['picture'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'self': self,
      'country': country,
      'picture': picture,
    };
  }
}

class CountryLinks {
  final String self;
  final String states;
  final String presidents;
  final String flag;

  CountryLinks({
    required this.self,
    required this.states,
    required this.presidents,
    required this.flag,
  });

  factory CountryLinks.fromJson(Map<String, dynamic> json) {
    return CountryLinks(
      self: json['self'] ?? '',
      states: json['states'] ?? '',
      presidents: json['presidents'] ?? '',
      flag: json['flag'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'self': self,
      'states': states,
      'presidents': presidents,
      'flag': flag,
    };
  }
}
