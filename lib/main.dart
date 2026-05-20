import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: LoginScreen()));
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedModel = "Corolla";
  String selectedYear = "2015";

  String getVehicleImage() {
    if (selectedModel == "Corolla" && selectedYear == "2002") {
      return "images/corolla_2002.png";
    }
    if (selectedModel == "Corolla" && selectedYear == "2007") {
      return "images/corolla_2007.png";
    }
    if (selectedModel == "Corolla" && selectedYear == "2023") {
      return "images/corolla_2023.png";
    }
    if (selectedModel == "Vitz" && selectedYear == "2007") {
      return "images/Vitz_2007.png";
    }
    if (selectedModel == "Vitz" && selectedYear == "2015") {
      return "images/Vitz_2015.png";
    }
    if (selectedModel == "Vitz" && selectedYear == "2017") {
      return "images/Vitz_2017.png";
    }
    if (selectedModel == "Premio" && selectedYear == "2003") {
      return "images/Premio_2003.png";
    }
    if (selectedModel == "Premio" && selectedYear == "2014") {
      return "images/Premio_2014.png";
    }
    if (selectedModel == "Premio" && selectedYear == "2016") {
      return "images/Premio_2016.png";
    }

    return "images/corolla.png";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "VehiCheck Guide",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 0),
              Text(
                "Vehicle Inspection Dashboard",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              SizedBox(height: 25),
              Text(
                "Select VehiCle Model",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  value: selectedModel,
                  dropdownColor: Colors.black,
                  isExpanded: true,
                  underline: SizedBox(),
                  style: TextStyle(color: Colors.white),
                  items: [
                    DropdownMenuItem(
                      value: "Corolla",
                      child: Text("Toyota Corolla"),
                    ),
                    DropdownMenuItem(value: "Vitz", child: Text("Toyota Vitz")),
                    DropdownMenuItem(
                      value: "Premio",
                      child: Text("Toyota Premio"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedModel = value!;
                    });
                  },
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Select Manufacture Year",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  value: selectedYear,
                  dropdownColor: Colors.black,
                  isExpanded: true,
                  underline: SizedBox(),
                  style: TextStyle(color: Colors.white),
                  items: [
                    DropdownMenuItem(value: "2002", child: Text("2002")),
                    DropdownMenuItem(value: "2003", child: Text("2003")),
                    DropdownMenuItem(value: "2007", child: Text("2007")),
                    DropdownMenuItem(value: "2014", child: Text("2014")),
                    DropdownMenuItem(value: "2015", child: Text("2015")),
                    DropdownMenuItem(value: "2016", child: Text("2016")),
                    DropdownMenuItem(value: "2017", child: Text("2017")),
                    DropdownMenuItem(value: "2023", child: Text("2023")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value!;
                    });
                  },
                ),
              ),
              SizedBox(height: 25),
              Center(child: Image.asset(getVehicleImage(), height: 180)),
              SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(15),
                    ),
                  ),
                  child: Text(
                    "Start Inspection",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurepassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: TextStyle(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter Email",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.email, color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                obscureText: _obscurepassword,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.lock, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurepassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurepassword = !_obscurepassword;
                      });
                    },
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(250, 50),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text(
                "Login",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
