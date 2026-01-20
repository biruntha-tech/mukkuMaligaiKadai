import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  final String role;
  const SignUpScreen({super.key, this.role = 'customer'});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // common/customer controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _locationController = TextEditingController();

  // shopkeeper specific controllers
  final _shopNameController = TextEditingController();
  final _shopAddressController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _openingTimeController = TextEditingController(text: '6 AM');
  final _closingTimeController = TextEditingController(text: '9 PM');

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  static const Color brandColor = Colors.white;
  static const Color bgColor = Color(0xFFCDB7A6);
  static const Color cardColor = Color(0x99FFFFFF); // Colors.white.withAlpha(153)

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.role == 'shopkeeper' ? 'Shop' : 'Account'} created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.role == 'shopkeeper') {
      return _buildShopkeeperUI();
    } else if (widget.role == 'manager') {
      return _buildManagerUI();
    }
    return _buildCustomerUI();
  }

  Widget _buildManagerUI() {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(8),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'MANAGER PROFILE',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF6B584F),
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      _buildManagerInputField(
                        label: 'Full Name',
                        placeholder: 'JOSE MILTON',
                        controller: _nameController,
                      ),
                      const SizedBox(height: 25),
                      _buildManagerInputField(
                        label: 'Email Address',
                        placeholder: 'josemilton@gmail.com',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 25),
                      _buildManagerInputField(
                        label: 'Phone Number',
                        placeholder: '+91 9876543210',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 25),
                      _buildManagerInputField(
                        label: 'Location',
                        placeholder: 'TUTICORIN, TAMIL NADU',
                        controller: _locationController,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFEBEE),
                  foregroundColor: Colors.red[800],
                  minimumSize: const Size(200, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black26,
                ),
                child: Text(
                  'Log out',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildManagerInputField({
    required String label,
    required String placeholder,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF6B584F).withAlpha(180),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: GoogleFonts.outfit(
              color: Colors.black26,
              fontSize: 16,
            ),
            filled: true,
            fillColor: Colors.white.withAlpha(120),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerUI() {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  'CREATE ACCOUNT',
                  style: GoogleFonts.outfit(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  'Join us to start shopping',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 40),
                
                _buildInputField(
                  label: 'Full Name',
                  placeholder: 'Enter your full name',
                  controller: _nameController,
                  icon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter your name';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                
                _buildInputField(
                  label: 'Email',
                  placeholder: 'Enter your email address',
                  controller: _emailController,
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter your email';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                
                _buildInputField(
                  label: 'Mobile Number',
                  placeholder: 'Enter your mobile number',
                  controller: _phoneController,
                  icon: Icons.phone_android_outlined,
                  keyboardType: TextInputType.phone,
                  prefixText: '+91 ',
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter mobile number';
                    if (value.length != 10) return 'Enter a valid 10-digit number';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                
                _buildInputField(
                  label: 'Password',
                  placeholder: 'Create a password',
                  controller: _passwordController,
                  icon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white70,
                    ),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please create a password';
                    if (value.length < 6) return 'Password must be at least 6 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                
                _buildInputField(
                  label: 'Confirm Password',
                  placeholder: 'Re-enter your password',
                  controller: _confirmPasswordController,
                  icon: Icons.lock_clock_outlined,
                  obscureText: _obscureConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white70,
                    ),
                    onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please confirm your password';
                    if (value != _passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                
                _buildInputField(
                  label: 'Location',
                  placeholder: 'Enter your city / location',
                  controller: _locationController,
                  icon: Icons.location_on_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter your location';
                    return null;
                  },
                ),
                
                const SizedBox(height: 50),
                
                ElevatedButton(
                  onPressed: _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brandColor,
                    foregroundColor: const Color(0xFF6B584F),
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 8,
                    shadowColor: Colors.black26,
                  ),
                  child: Text(
                    'SIGN UP',
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: GoogleFonts.outfit(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShopkeeperUI() {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'ACCOUNT',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(13),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SHOP DETAILS',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF6B584F),
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 25),
                    _buildShopInputField(
                      label: 'Shop Name',
                      placeholder: 'Enter shop name',
                      controller: _shopNameController,
                    ),
                    const SizedBox(height: 20),
                    _buildShopInputField(
                      label: 'Shop Address',
                      placeholder: 'Enter full shop address',
                      controller: _shopAddressController,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                    _buildShopInputField(
                      label: 'Owner Name',
                      placeholder: 'Enter owner name',
                      controller: _ownerNameController,
                    ),
                    const SizedBox(height: 20),
                    _buildShopInputField(
                      label: 'Phone Number',
                      placeholder: 'Enter mobile number',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildShopInputField(
                            label: 'Opening Time',
                            placeholder: '6 AM',
                            controller: _openingTimeController,
                            labelColor: Colors.green[700],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildShopInputField(
                            label: 'Closing Time',
                            placeholder: '9 PM',
                            controller: _closingTimeController,
                            labelColor: Colors.red[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFEBEE),
                foregroundColor: Colors.red[800],
                minimumSize: const Size(200, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
                shadowColor: Colors.black26,
              ),
              child: Text(
                'Log out',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String placeholder,
    required TextEditingController controller,
    required IconData icon,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    String? prefixText,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 8),
          child: Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: GoogleFonts.outfit(fontSize: 16, color: Colors.black87),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: GoogleFonts.outfit(color: Colors.black38, fontSize: 14),
            prefixIcon: Icon(icon, color: Colors.black54, size: 22),
            prefixText: prefixText,
            prefixStyle: GoogleFonts.outfit(color: Colors.black87, fontWeight: FontWeight.bold),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            errorStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.white, width: 1),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildShopInputField({
    required String label,
    required String placeholder,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType? keyboardType,
    Color? labelColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: labelColor ?? const Color(0xFF6B584F),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: GoogleFonts.outfit(fontSize: 15),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: GoogleFonts.outfit(color: Colors.black26, fontSize: 14),
            filled: true,
            fillColor: Colors.white.withAlpha(120),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
