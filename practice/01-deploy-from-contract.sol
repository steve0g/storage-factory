// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract Compteur {

    // une variable publique valeur
    uint256 public valeur;

    // une fonction incrementer() qui ajoute 1 à la variable globale "valeur"
    function incrementer() public {
        valeur += 1;
    }
}


contract FabriqueCompteur {

    // un tableau public qui garde chaque Compteur créé
    Compteur[] public listeDesCompteurs;

    // fonction creerCompteur() qui crée un nouveau Compteur à chaque appel et le range dans le tableau
    // Chaque new crée un contrat à part entière avec son adresse, sans lien avec celle de la fabrique
    function creerCompteur() public {
        Compteur nouveauCompteur = new Compteur();
        listeDesCompteurs.push(nouveauCompteur);
    }

    // une fonction nombreDeCompteurs() en lecture seule, qui renvoie le nombre de compteurs créés
    function nombreDeCompteurs() public view returns(uint256) {
        return listeDesCompteurs.length;
    }
}

// ===== Résultats de mes tests dans Remix =====
// 1. Nombre de compteurs : j'ai lu 3 comme valeur nombreDeCompteurs() parce que j'ai appelé 3 fois la fonction creerCompteur
// 2. Adresses : j'ai obtenu 3 adresses différentes parce que chaque nouveau compteur a son adresse, 
//    la fabrique a elle aussi sa propre adresse, différente des compteurs.
// 3. Valeurs : compteur 1 = 2, compteur 2 = 4 (après plusieurs appels de incrementer())
//    Chacun a sa propre valeur parce que chaque compteur (contrat) est un contrat à part entière, ils ne partagent pas les mêmes valeurs