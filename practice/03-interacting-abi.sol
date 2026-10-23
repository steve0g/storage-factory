// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract Jauge {

    // une variable publique niveau
    uint256 public niveau;

    // une fonction augmenter qui ajoute _quantite à niveau
    function augmenter(uint256 _quantite) public {
        niveau += _quantite;
    }
}


contract Superviseur {
    
    // un tableau public qui garde chaque Jauge créée
    Jauge[] public listeDesJauges;

    // fonction creerJauge() qui crée une Jauge et la range dans le tableau
    function creerJauge() public {
        Jauge nouvelleJauge = new Jauge();
        listeDesJauges.push(nouvelleJauge);
    }

    // fonction augmenterJauge qui appelle augmenter sur la jauge à cette position
    function augmenterJauge(uint256 _index, uint256 _quantite) public {
        listeDesJauges[_index].augmenter(_quantite);
    }

    // fonction lireJauge qui prend index en paramètre, en lecture seule et renvoie le niveau de cette jauge
    function lireJauge(uint256 _index) public view returns (uint256) {
        return listeDesJauges[_index].niveau();
    }

    // fonction adresseDeJauge qui prend index en paramètre, en lecture seule : renvoie l’adresse de cette jauge (type address)
    function adresseDeJauge(uint256 _index) public view returns (address) {
        return address(listeDesJauges[_index]);
    }
}


// ===== mes test dans remix =====
// 
// 1. quand je crée les deux jauges qui sont créées avec chacune son adresse avec le niveau 0
// 
// 2. Appelle augmenterJauge(0, 5), puis lireJauge(0) et lireJauge(1). Quelles valeurs ?
//
// chaque Jauge est un contrat avec son propre niveau
// quand j'appelle augmenterJauge(0, 5) une transaction est effectuée
// quand je fais lireJauge(0), j'ai 5 parce que Superviseur a créé Jauge et l'a mise à la position 0 donc lorsque 
// je fais augmenter à l'index 0 puis donner la valeur 5, en lisant c'est la valeur de la jauge à la position 0 qui prends cette valeur
// quand je fais lireJauge(1), j'ai 0 (valeur d'origine) parce qu'à cette position je n'ai pas appeler augmenterJauge
//
// 3. Appelle adresseDeJauge(0). Compare avec ce que renvoie le tableau public pour l’index 0. Que remarques-tu ?
//
// quand j'appelle adresseDeJauge(0) j'ai : 0xFe69a76A29213454597F96Fee900F38687A1cf51
// quand j'appelle listeDesJauges[0] j'ai la même adresse de la jauge à l'index 0
// address(...) donne l’adresse du contrat à cette position, et le tableau public, listeDesJauges, renvoie la même.
// 
// 4. Appelle lireJauge(7). Que se passe-t-il, et pourquoi ?
// 
// Quand je fais lireJauge(7) j'ai revert avec ce message dans remix : The transaction has been reverted to the initial state.
// l’index 7 est hors du tableau, qui n’a que 2 éléments.