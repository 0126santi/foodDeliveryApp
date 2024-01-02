class UnboardingContent {
  String image;
  String title;
  String description;
  UnboardingContent(
      {required this.description, required this.image, required this.title});
}

List<UnboardingContent> contents = [
  UnboardingContent(
      description: 'Elige tu comida de nuestro menú.',
      image: "assets/screen1.png",
      title: 'Seleccione de Nuestro\n        Mejor Menú'),
  UnboardingContent(
      description:
          'Puedes pagar en efectivo y el pago\n        con tarjeta está disponible. ',
      image: "assets/screen2.png",
      title: 'Pago fácil y en línea'),
  UnboardingContent(
      description: 'Entrega tu comida en tu puerta',
      image: "assets/screen3.png",
      title: 'Entrega rápida en su puerta'),
];
