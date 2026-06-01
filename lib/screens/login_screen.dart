import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true; // للتحكم في رؤية كلمة المرور

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text('خطأ: ${e.message ?? 'حدث خطأ أثناء تسجيل الدخول'}'),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // جلب أبعاد الشاشة لتحديد التجاوب
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F7), // خلفية رمادية فاتحة بأسلوب علي بابا
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Container(
              // تحديد أقصى عرض للبطاقة على اللابتوب لمنع تمدد الواجهة بشكل مزعج
              constraints: BoxConstraints(
                maxWidth: isDesktop ? 450 : double.infinity,
              ),
              padding: isDesktop ? const EdgeInsets.all(40.0) : const EdgeInsets.all(16.0),
              decoration: isDesktop
                  ? BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        )
                      ],
                    )
                  : null, // بدون بطاقة على الهاتف لتوفر المساحة
              child: Form(
                key: _formKey,
                child: Directionality(
                  textDirection: TextDirection.rtl, // دعم كامل للغة العربية
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // شعار المتجر البديل (Alibaba style)
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.shopping_bag_outlined,
                              size: 42,
                              color: Color(0xFFFF6A00), // لون علي بابا البرتقالي
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'متجري',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF181818),
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Center(
                        child: Text(
                          'أهلاً بك مجدداً! قم بتسجيل الدخول للمتابعة.',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // حقل البريد الإلكتروني
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'البريد الإلكتروني أو اسم المستخدم',
                          prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFFFF6A00), width: 1.5),
                          ),
                        ),
                        validator: (val) => val != null && val.isEmpty ? 'الرجاء إدخال البريد الإلكتروني' : null,
                      ),
                      const SizedBox(height: 20),

                      // حقل كلمة المرور
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'كلمة المرور',
                          prefixIcon: const Icon(Icons.lock_open_outlined, color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFFFF6A00), width: 1.5),
                          ),
                        ),
                        validator: (val) => val != null && val.isEmpty ? 'الرجاء إدخال كلمة المرور' : null,
                      ),
                      const SizedBox(height: 12),

                      // زر نسيت كلمة المرور
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'نسيت كلمة المرور؟',
                            style: TextStyle(color: Color(0xFF1A73E8), fontSize: 13),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // زر تسجيل الدخول
                      _isLoading
                          ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF6A00))))
                          : ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF6A00), // برتقالي علي بابا
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 54),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(26), // حواف دائرية عصرية
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'تسجيل الدخول',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                      const SizedBox(height: 24),

                      // خيار إنشاء حساب جديد
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('ليس لديك حساب؟', style: TextStyle(color: Colors.black54)),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupScreen()));
                            },
                            child: const Text(
                              'سجل الآن مجاناً',
                              style: TextStyle(
                                color: Color(0xFFFF6A00),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}