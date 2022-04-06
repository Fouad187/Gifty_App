class payment
{
  late String image;
  late String name;

  payment({required this.image, required this.name});
}
List<payment> paymentsWay=[
  payment(image: 'assets/images/visa.png' , name: 'Visa'),
  payment(image: 'assets/images/mastercard.png' , name: 'MasterCard'),
  payment(image: 'assets/images/discover.png' , name: 'Discover'),
  payment(image: 'assets/images/paypal.png' , name: 'Pay Pal'),
];