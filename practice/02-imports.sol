// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

import {Calculatrice} from "./02-imports-base.sol";

contract Utilisateur {
    Calculatrice public calculatrice;           // Calculatrice est utilisable comme un type

    // fonction creerCalculatrice
    function creerCalculatrice() public {
        calculatrice = new Calculatrice();
    }

    // fonction doublerUnNombre
    function doublerUnNombre(uint256 _n) public view returns (uint256) {

        // On appelle la fonction "doubler" sur l'instance stockée dans "calculatrice"
        uint256 resultat = calculatrice.doubler(_n);

        // On renvoie le résultat obtenu
        return resultat;
    }
}

// ===== mes résultats aux test dans remix =====
// 1. Appelle doublerUnNombre(5) avant creerCalculatrice(). Que se passe-t-il ?
// Avant creerCalculatrice(), la variable calculatrice contient sa valeur par défaut, qui est l’adresse zéro (0x000...). 
// Aucun contrat n’existe à cette adresse, donc il n’y a rien à appeler. 
// la variable contient l’adresse zéro, aucun contrat n’existe, donc l’appel échoue.
//
// 2. Appelle creerCalculatrice(), puis doublerUnNombre(5). Que renvoie-t-elle ?
// j'obtiens 10, 5 a doublé parce qu'après avoir creerCalculatrice, calculatrice contient l'adresse du contrat créé par new 
// et donc doubler s'exécute
//
// une phrase sur la différence entre import {Calculatrice} from "..." et import "...";
// La différence entre import {Calculatrice} from "./imports-base.sol"; et import "./imports-base.sol"; est que :
// import {Calculatrice} from "./imports-base.sol"; importe précisement le contrat Calculatrice depuis imports-base.sol
// import "./imports-base.sol"; importe tout ce que contient ce fichier (s'il y a plusieurs contrats il les importe tous)