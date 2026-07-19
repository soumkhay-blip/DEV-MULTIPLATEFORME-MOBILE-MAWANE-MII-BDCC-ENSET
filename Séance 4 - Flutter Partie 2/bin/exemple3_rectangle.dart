class Rectangle {
  int longueur;
  int largeur;

  Rectangle(this.longueur, this.largeur);

  // méthode qui calcul la surface du rectangle
  int surface() {
    return this.longueur * this.largeur;
  }

  // méthode qui calcul le périmètre du rectangle
  int perimetre() {
    return 2 * (this.longueur + this.largeur);
  }
}

void main() {
  var R = Rectangle(10, 5);
  print("La surface du rectangle R est : ${R.surface()}  ");
  // Affiche: La surface du rectangle R est : 50
  print("Le périmètre du rectangle R est : ${R.perimetre()}  ");
  // Affiche: Le périmètre du rectangle R est : 30
}
