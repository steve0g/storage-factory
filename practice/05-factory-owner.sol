// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract GestionStockKorbanas {

    address public owner;

    // un constructor qui reçoit en paramètre l’adresse du propriétaire et l’enregistre dans owner
    // le constructor est déclenché par la ligne new GestionStockKorbanas(...), écrite dans la fabrique "FabriqueStock"
    constructor(address _owner) {
        owner = _owner;
    }

    struct Laptop{
        string modele;
        uint256 prix;
        bool disponible;
    }

    // tableau public stock
    Laptop[] public stock;

    // fonction ajouterLaptop réservé uniquement au propriétaire par le mot-clé require
    function ajouterLaptop(string memory _modele, uint256 _prix) public {
        require(owner == msg.sender, "Vous n'etes pas le proprietaire");
        stock.push( Laptop(_modele, _prix, true) );
    }
}


contract FabriqueStock {

    // un tableau public qui garde chaque GestionStockKorbanas créé
    GestionStockKorbanas[] public listeDesGestionStockKorbanas;

    // une fonction creerStock(), ouverte à tout le monde (sans require),
    // qui crée un nouveau GestionStockKorbanas dont le propriétaire est celui qui appelle creerStock(),
    // puis le range dans le tableau
    function creerStock() public {
        // Déploiement du nouveau contrat avec msg.sender comme owner
        GestionStockKorbanas nouveauStock = new GestionStockKorbanas(msg.sender);

        // ajout du contrat dans le tableau
        listeDesGestionStockKorbanas.push(nouveauStock);
    }

    // fonction pour voir le nombre de contrat (GestionDeStockKorbanas) créé
    function nombreDeStocks() public view returns(uint256) {
        return listeDesGestionStockKorbanas.length;
    }

    // fonction pour voir le owner d'un contrat à l'index indiqué
    function proprietaireDuStock(uint256 _index) public view returns(address) {
        return listeDesGestionStockKorbanas[_index].owner();
    }
}



// ===== Résultats de mes tests dans Remix =====
// Comptes (copiés depuis le menu Account de Remix): 
//      A = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2  
//      B = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db 
//
// 3. nombreDeStocks() après creerStock() avec A puis avec B : 2
//    Raison : en créant le stock avec A puis avec B c'est deux stock différents qui ont été créés grace à new
//             chaque appel de creerStock() ajoute un stock au tableau, et que nombreDeStocks() renvoie la taille de ce tableau.
//
// 6. proprietaireDuStock(0) = A (0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2), 
//    proprietaireDuStock(1) = B (0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db),
//    Raison : creerStock() passe msg.sender (celui qui l'appelle) au constructor,
//             qui le range dans owner. A a donc créé le stock 0, B le stock 1.
//
// 7. B appelle ajouterLaptop sur le stock 0 : revert "Vous n'etes pas le proprietaire".
//    Raison : msg.sender = B, owner = A, donc la condition msg.sender == owner est fausse
//             et le require annule la transaction.
//    A appelle ajouterLaptop sur le stock 0 : la transaction réussit.
//    Raison : A a appelé creerStock() pour créer le stock 0. FabriqueStock a créé le stock 0 et a donné
//             l'adresse de A au constructor (_owner), qui l'a rangée dans owner.
//             Quand A appelle ajouterLaptop, msg.sender = A et owner = A,
//             donc la condition est vraie et le require laisse passer.
//
//
// ===== Traçage : B appelle creerStock() =====
// | Ligne qui s'exécute                  | Qui l'a appelée | msg.sender   | owner          |
// | creerStock()                         | B               | B            | n'existe pas   |
// | new GestionStockKorbanas(msg.sender) | B               | B            | n'existe pas   |
// | constructor                          | FabriqueStock   | FabriqueStock| B (via _owner) |