import 'package:flutter/material.dart';
//import 'student_page.dart'; // Importa a página do aluno

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingPagePresenter(pages: [
        OnboardingPageModel(
          title: 'Auto Notas',
          description:
              'O Auto Notas é um software criado para revolucionar o processo de atribuição de notas',
          image: 'assets/images/logo.png',
          bgColor: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 89, 52, 176),
              Color.fromARGB(255, 118, 110, 231)
            ],
          ),
        ),
        OnboardingPageModel(
          title: 'Aluno',
          description:
              'Seja você um aluno dedicado aos estudos em busca de informações detalhadas sobre suas notas e com o feedback.',
          image: 'assets/images/Nerd-bro.png',
          bgColor: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 223, 103, 129),
              Color(0xFFFAA47D),
            ],
          ),
        ),
        OnboardingPageModel(
          title: 'Notas',
          description:
              'Você, como aluno, consegue visualizar suas notas com apenas um clique.',
          image: 'assets/images/Grades-bro.png',
          bgColor: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF7095),
              Color(0xFF1D78FF),
            ],
          ),
        ),
        OnboardingPageModel(
          title: 'Feedbacks',
          description:
              'Você, como aluno, consegue ter um melhor discernimento com os feedbacks de seus professores.',
          image: 'assets/images/Feedback-amico.png',
          bgColor: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF7B65E3),
              Color(0xFF2CABE3),
            ],
          ),
        ),
      ]),
    );
  }
}

class OnboardingPagePresenter extends StatefulWidget {
  final List<OnboardingPageModel> pages;
  final VoidCallback? onSkip;
  final VoidCallback? onFinish;

  const OnboardingPagePresenter(
      {Key? key, required this.pages, this.onSkip, this.onFinish})
      : super(key: key);

  @override
  State<OnboardingPagePresenter> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPagePresenter> {
  // Store the currently visible page
  int _currentPage = 0;
  // Define a controller for the pageview
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          gradient: widget.pages[_currentPage].bgColor,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                // Pageview to render each page
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.pages.length,
                  onPageChanged: (idx) {
                    // Change current page when pageview changes
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final item = widget.pages[idx];
                    return Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Image.asset(
                              item.image,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                item.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                            Container(
                              constraints:
                                  const BoxConstraints(maxWidth: 280),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                                vertical: 8.0,
                              ),
                              child: Text(
                                item.description,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            )
                          ]),
                        )
                      ],
                    );
                  },
                ),
              ),

              // Current page indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.pages
                    .map(
                      (item) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: _currentPage == widget.pages.indexOf(item)
                            ? 30
                            : 8,
                        height: 8,
                        margin: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    )
                    .toList(),
              ),

              // Bottom buttons
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.comfortable,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        widget.onSkip?.call();
                      },
                      child: const Text(""),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.comfortable,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        if (_currentPage == widget.pages.length - 1) {
                          widget.onFinish?.call();
                          // Navega para a tela de login
                          Navigator.pushNamed(context, '/login');
                        } else {
                          _pageController.animateToPage(
                            _currentPage + 1,
                            curve: Curves.easeInOutCubic,
                            duration: const Duration(milliseconds: 250),
                          );
                        }
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            _currentPage == widget.pages.length - 1
                                ? "Login"
                                : "Next",
                          ),
                          const SizedBox(width: 8),
                            Icon(
                              _currentPage == widget.pages.length - 1
                                  ? Icons.done
                                  : Icons.arrow_forward,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingPageModel {
  final String title;
  final String description;
  final String image;
  final LinearGradient bgColor;

  OnboardingPageModel({
    required this.title,
    required this.description,
    required this.image,
    required this.bgColor,
  });
}