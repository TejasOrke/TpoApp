import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

// Static class to store student data
class StudentData {
  static Map<String, dynamic>? registeredStudent;
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TPO App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TPO Portal')),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'TPO Portal',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.app_registration),
              title: const Text('Registration'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistrationPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text('View Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.business),
              title: const Text('Company Details'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CompanyDetailsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.school, size: 100, color: Colors.blue),
              SizedBox(height: 20),
              Text(
                'Welcome to TPO Portal',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Training and Placement Office Portal for Students',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                icon: Icon(Icons.app_registration),
                label: Text('Register Now'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistrationPage()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (StudentData.registeredStudent == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Student Profile')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_off, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text('No Profile Found', style: TextStyle(fontSize: 20)),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistrationPage()),
                ),
                child: Text('Register Now'),
              ),
            ],
          ),
        ),
      );
    }

    final student = StudentData.registeredStudent!;
    return Scaffold(
      appBar: AppBar(title: const Text('Student Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildProfileSection('Personal Details', [
            _buildProfileRow('Name', student['name'] ?? ''),
            _buildProfileRow('Email', student['email'] ?? ''),
            _buildProfileRow('Contact', student['contact'] ?? ''),
            _buildProfileRow('Roll No', student['rollNo'] ?? ''),
          ]),
          _buildProfileSection('HSC Details', [
            _buildProfileRow('College', student['hscCollege'] ?? ''),
            _buildProfileRow('Year', student['hscYear'] ?? ''),
            _buildProfileRow('Percentage', '${student['hscPercentage']}%'),
          ]),
          _buildProfileSection('SSC Details', [
            _buildProfileRow('School', student['sscSchool'] ?? ''),
            _buildProfileRow('Year', student['sscYear'] ?? ''),
            _buildProfileRow('Percentage', '${student['sscPercentage']}%'),
          ]),
          _buildProfileSection('Semester Performance', [
            _buildProfileRow('Semester 1', 'CGPA: ${student['sem1'] ?? ''}'),
            _buildProfileRow('Semester 2', 'CGPA: ${student['sem2'] ?? ''}'),
            _buildProfileRow('Semester 3', 'CGPA: ${student['sem3'] ?? ''}'),
            _buildProfileRow('Semester 4', 'CGPA: ${student['sem4'] ?? ''}'),
            _buildProfileRow('Semester 5', 'CGPA: ${student['sem5'] ?? ''}'),
          ]),
          if (student['additionalCourses']?.isNotEmpty ?? false)
            _buildProfileSection('Additional Courses', [
              Text(student['additionalCourses'] ?? ''),
            ]),
        ],
      ),
    );
  }

  Widget _buildProfileSection(String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text(value)],
      ),
    );
  }
}

class CompanyDetailsPage extends StatelessWidget {
  const CompanyDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Company Details')),
      body: ListView.builder(
        itemCount: dummyCompanies.length,
        itemBuilder: (context, index) {
          final company = dummyCompanies[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ExpansionTile(
              leading: Icon(Icons.business),
              title: Text(company['name']!),
              subtitle: Text(company['location']!),
              children: [
                ListTile(
                  title: Text('Salary Range'),
                  subtitle: Text(company['salary']!),
                ),
                ListTile(
                  title: Text('Company Profile'),
                  subtitle: Text(company['profile']!),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
// Dummy data for companies
final List<Map<String, String>> dummyCompanies = [
  {
    'name': 'TCS',
    'location': 'Mumbai, Maharashtra',
    'salary': '3.5 - 7.5 LPA',
    'profile': 'IT Services and Consulting'
  },
  {
    'name': 'Infosys',
    'location': 'Bangalore, Karnataka',
    'salary': '3.6 - 8.0 LPA',
    'profile': 'Technology and Consulting Services'
  },
  {
    'name': 'Wipro',
    'location': 'Bangalore, Karnataka',
    'salary': '3.5 - 7.0 LPA',
    'profile': 'IT, Consulting and Business Process Services'
  },
];

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Registration'),
      ),
      body: const RegistrationForm(),
    );
  }
}
class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  String? resumePath;
  String hscPercentage = "";
  String sscPercentage = "";

  // Controllers for form fields
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();
  final rollNoController = TextEditingController();
  final hscCollegeController = TextEditingController();
  final hscYearController = TextEditingController();
  final hscMarksController = TextEditingController();
  final hscOutOfController = TextEditingController();
  final sscCollegeController = TextEditingController();
  final sscYearController = TextEditingController();
  final sscMarksController = TextEditingController();
  final sscOutOfController = TextEditingController();
  final sem1Controller = TextEditingController();
  final sem2Controller = TextEditingController();
  final sem3Controller = TextEditingController();
  final sem4Controller = TextEditingController();
  final sem5Controller = TextEditingController();
  final cgpaController = TextEditingController();
  final additionalCoursesController = TextEditingController();

  @override
  void dispose() {
    // Dispose all controllers
    nameController.dispose();
    emailController.dispose();
    contactController.dispose();
    rollNoController.dispose();
    hscCollegeController.dispose();
    hscYearController.dispose();
    hscMarksController.dispose();
    hscOutOfController.dispose();
    sscCollegeController.dispose();
    sscYearController.dispose();
    sscMarksController.dispose();
    sscOutOfController.dispose();
    sem1Controller.dispose();
    sem2Controller.dispose();
    sem3Controller.dispose();
    sem4Controller.dispose();
    sem5Controller.dispose();
    cgpaController.dispose();
    additionalCoursesController.dispose();
    super.dispose();
  }

  void calculatePercentage() {
    if (hscMarksController.text.isNotEmpty && hscOutOfController.text.isNotEmpty) {
      double marks = double.parse(hscMarksController.text);
      double outOf = double.parse(hscOutOfController.text);
      setState(() {
        hscPercentage = ((marks / outOf) * 100).toStringAsFixed(2);
      });
    }
    if (sscMarksController.text.isNotEmpty && sscOutOfController.text.isNotEmpty) {
      double marks = double.parse(sscMarksController.text);
      double outOf = double.parse(sscOutOfController.text);
      setState(() {
        sscPercentage = ((marks / outOf) * 100).toStringAsFixed(2);
      });
    }
  }

Future<void> uploadResume() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'doc', 'docx'],
  );

  if (result != null && result.files.single.path != null) {  // Added null check
    setState(() {
      resumePath = result.files.single.path;
    });
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Resume uploaded successfully')),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            // Personal Details Section
            Text("Personal Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Full Name *"),
              validator: (value) => value!.isEmpty ? "Name is required" : null,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email ID *"),
              validator: (value) => value!.isEmpty ? "Email is required" : null,
            ),
            TextFormField(
              controller: contactController,
              decoration: InputDecoration(labelText: "Contact Number *"),
              validator: (value) => value!.isEmpty ? "Contact number is required" : null,
              keyboardType: TextInputType.phone,
            ),
            TextFormField(
              controller: rollNoController,
              decoration: InputDecoration(labelText: "Roll Number *"),
              validator: (value) => value!.isEmpty ? "Roll number is required" : null,
            ),

            SizedBox(height: 20),
            // HSC Details Section
            Text("HSC Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextFormField(
              controller: hscCollegeController,
              decoration: InputDecoration(labelText: "College Name *"),
              validator: (value) => value!.isEmpty ? "College name is required" : null,
            ),
            TextFormField(
              controller: hscYearController,
              decoration: InputDecoration(labelText: "Year of Passing *"),
              validator: (value) => value!.isEmpty ? "Year is required" : null,
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: hscMarksController,
                    decoration: InputDecoration(labelText: "Marks *"),
                    keyboardType: TextInputType.number,
                    onChanged: (_) => calculatePercentage(),
                    validator: (value) => value!.isEmpty ? "Required" : null,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: hscOutOfController,
                    decoration: InputDecoration(labelText: "Out of *"),
                    keyboardType: TextInputType.number,
                    onChanged: (_) => calculatePercentage(),
                    validator: (value) => value!.isEmpty ? "Required" : null,
                  ),
                ),
              ],
            ),
            Text("Percentage: $hscPercentage%"),

            SizedBox(height: 20),
            // SSC Details Section
            Text("SSC Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextFormField(
              controller: sscCollegeController,
              decoration: InputDecoration(labelText: "School Name *"),
              validator: (value) => value!.isEmpty ? "School name is required" : null,
            ),
            TextFormField(
              controller: sscYearController,
              decoration: InputDecoration(labelText: "Year of Passing *"),
              validator: (value) => value!.isEmpty ? "Year is required" : null,
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: sscMarksController,
                    decoration: InputDecoration(labelText: "Marks *"),
                    keyboardType: TextInputType.number,
                    onChanged: (_) => calculatePercentage(),
                    validator: (value) => value!.isEmpty ? "Required" : null,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: sscOutOfController,
                    decoration: InputDecoration(labelText: "Out of *"),
                    keyboardType: TextInputType.number,
                    onChanged: (_) => calculatePercentage(),
                    validator: (value) => value!.isEmpty ? "Required" : null,
                  ),
                ),
              ],
            ),
            Text("Percentage: $sscPercentage%"),

            SizedBox(height: 20),
            // Semester Details Section
            Text("Semester Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextFormField(
              controller: sem1Controller,
              decoration: InputDecoration(labelText: "Semester 1 CGPA *"),
              validator: (value) => value!.isEmpty ? "Required" : null,
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: sem2Controller,
              decoration: InputDecoration(labelText: "Semester 2 CGPA *"),
              validator: (value) => value!.isEmpty ? "Required" : null,
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: sem3Controller,
              decoration: InputDecoration(labelText: "Semester 3 CGPA *"),
              validator: (value) => value!.isEmpty ? "Required" : null,
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: sem4Controller,
              decoration: InputDecoration(labelText: "Semester 4 CGPA *"),
              validator: (value) => value!.isEmpty ? "Required" : null,
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: sem5Controller,
              decoration: InputDecoration(labelText: "Semester 5 CGPA *"),
              validator: (value) => value!.isEmpty ? "Required" : null,
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 20),
            // Additional Details Section
            Text("Additional Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextFormField(
              controller: additionalCoursesController,
              decoration: InputDecoration(
                labelText: "Additional Courses/Certifications",
                hintText: "Enter any additional courses or certifications",
              ),
              maxLines: 3,
            ),

            SizedBox(height: 20),
            // Resume Upload Section
            ElevatedButton.icon(
              onPressed: uploadResume,
              icon: Icon(Icons.upload_file),
              label: Text(resumePath != null ? "Resume Uploaded" : "Upload Resume *"),
            ),
            if (resumePath != null)
              Text("File: ${resumePath!.split('/').last}", style: TextStyle(color: Colors.green)),

            SizedBox(height: 30),
            // Replace the existing ElevatedButton with this one
ElevatedButton(
 // In _RegistrationFormState class, update the ElevatedButton onPressed:
onPressed: () {
  if (_formKey.currentState!.validate()) {
    // Store registration data
    StudentData.registeredStudent = {
      'name': nameController.text,
      'email': emailController.text,
      'rollNo': rollNoController.text,
      'contact': contactController.text,
      'hscCollege': hscCollegeController.text,
      'hscYear': hscYearController.text,
      'hscPercentage': hscPercentage,
      'sscSchool': sscCollegeController.text,
      'sscYear': sscYearController.text,
      'sscPercentage': sscPercentage,
      'sem1': sem1Controller.text,
      'sem2': sem2Controller.text,
      'sem3': sem3Controller.text,
      'sem4': sem4Controller.text,
      'sem5': sem5Controller.text,
      'additionalCourses': additionalCoursesController.text,
    };

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registration Successful')),
    );
    
    setState(() {
      _formKey.currentState!.reset();
      resumePath = null;
      hscPercentage = "";
      sscPercentage = "";
    });
  }
},
  child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: Text('Submit Registration'),
  ),
),            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

