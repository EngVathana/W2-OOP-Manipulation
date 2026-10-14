
enum Skill { FLUTTER, DART, OTHER }

class Address {
  final String _street;
  final String _city;
  final String _zipCode;

  Address(this._street, this._city, this._zipCode);

  String get street => _street;
  String get city => _city;
  String get zipCode => _zipCode;

  @override
  String toString() {
    return '$_street, $_city, $_zipCode';
  }
}

class Employee {
  final String _name;
  final double _baseSalary;
  final List<Skill> _skills;
  final Address _address;
  final int _yearsOfExperience;

  Employee(
    this._name,
    this._baseSalary,
    List<Skill> skills,
    this._address,
    this._yearsOfExperience,
  ) : _skills = List.unmodifiable(skills);

  Employee.mobileDeveloper(
    String name,
    Address address,
    int yearsOfExperience,
  ) : this(
          name,
          40000,
          [Skill.FLUTTER, Skill.DART],
          address,
          yearsOfExperience,
        );

  String get name => _name;
  double get baseSalary => _baseSalary;
  List<Skill> get skills => _skills;
  Address get address => _address;
  int get yearsOfExperience => _yearsOfExperience;

  double computeSalary() {
    double salary = _baseSalary;
    salary += _yearsOfExperience * 2000;

    for (var skill in _skills) {
      switch (skill) {
        case Skill.FLUTTER:
          salary += 5000;
          break;
        case Skill.DART:
          salary += 3000;
          break;
        case Skill.OTHER:
          salary += 1000;
          break;
      }
    }

    return salary;
  }

  void printDetails() {
    print('Employee: $_name');
    print('Base Salary: \$$_baseSalary');
    print('Skills: ${_skills.map((s) => s.name).join(', ')}');
    print('Address: $_address');
    print('Experience: $_yearsOfExperience years');
    print('Total Salary: \$${computeSalary()}');
    print('--------------------------');
  }
}

void main() {
  Address address1 = Address('Street 1', 'Phnom Penh', '12000');
  Address address2 = Address('Street 2', 'Siem Reap', '17000');

  Employee emp1 = Employee(
    'Sokea',
    40000,
    [Skill.FLUTTER, Skill.DART],
    address1,
    3,
  );

  Employee emp2 = Employee.mobileDeveloper(
    'Ronan',
    address2,
    5,
  );

  emp1.printDetails();
  emp2.printDetails();
}
