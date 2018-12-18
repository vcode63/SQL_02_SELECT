USE stock;
-- ! L'ordre SELECT du langage SQL/DML !--
-- ! Lister le contenu d'une table et le trier !--
-- Tous les articles triés par marque et par nom
SELECT *
FROM article
ORDER BY marque, nom;

-- ! Sélectionner les champs de la table et utiliser une fonction avec agrégation !--
-- Nombre de articles référencés par marque 
SELECT marque, COUNT(*)
FROM article
GROUP BY marque
ORDER BY marque;

-- !  Jointure et renommer les champs  grâce aux alias.!--
-- Liste des articles dans les entrepôts
-- marque, nom de article, référence, ("Entrepôt"), ("Quantité") 
-- trié par référence;
SELECT
    marque, a.nom, reference, e.nom AS 'Entrepot', qte AS 'Quantité'
FROM
    article a,
    entrepot e,
    stock s
WHERE
    s.article_id = a.id
    AND s.entrepot_id = e.id
ORDER BY reference;

-- ! Sélectionner en fonction d'une valeur !--
-- Liste des articles dans un entrepôt
-- marque, nom de article, référence, ("Entrepôt"), ("Quantité") 
-- pour l'entrepôt "dijon 1"
-- trié par référence
SELECT
    marque, reference, a.nom, e.nom AS 'Entrepot', qte AS 'Quantité'
FROM
    article a,
    entrepot e,
    stock s
WHERE
    s.article_id = a.id
    AND e.entrepot_id = e.id
    AND e.nom = 'dijon 1'
ORDER BY reference;

-- ! faites le produit cartésien des entrepots et des articles  !--
-- Card(ExA) = Card(E) x Card(A)
SELECT *
FROM
    entrepot,
    article;

-- ! La clause FROM  !--
-- La clause FROM liste les relations utiles pour la requête,
-- ce n'est pas forcément une table du schéma.
-- tables dérivées.

SELECT a.* , e.*
FROM
    (SELECT nom AS 'article'
    FROM article
   ) AS a,
    (SELECT nom AS 'entrepot'
    FROM entrepot
   ) AS e;


-- ! Faire une somme !--
-- marque, reference, nom, 
-- Somme de 'Quantité' par référence
-- trié par référence.
SELECT
    marque, reference, nom, SUM(qte) AS 'Quantité'
FROM
    article a,
    stock s
WHERE
    s.article_id = a.id
GROUP BY reference
ORDER BY reference;

-- ! Concaténer !--
-- marque + '1 espace' + nom, reference, 
-- Somme de 'Quantité' par référence
-- trié par référence.
SELECT
    CONCAT(marque, ' ', nom) AS article,
    reference,
    SUM(qte) AS 'Quantité'
FROM
    article a,
    stock s
WHERE
    s.article_id = a.id
GROUP BY reference
ORDER BY reference;

-- ! sous-requête et DISTINCT !--
-- référence et nom des articles absent des entrepots
-- marque, nom de article, référence, ("Entrepôt"), ("Quantité")
-- trié par référence;

SELECT reference, nom FROM `article` p
WHERE NOT EXISTS (
    SELECT DISTINCT article_id FROM `stock` s
    WHERE p.id = article_id
    );


-- ! Jointure à gauche !--
-- référence et nom de tous les articles avec quantités stockées dans tous les entrepôts
-- marque, nom de article ("Quantité")
-- trié par référence;

SELECT a.reference, a.nom, SUM(qte) AS "Quantité"
FROM article AS a
    LEFT JOIN stock s ON id = s.article_id
GROUP BY a.reference
ORDER BY a.reference;


-- ! Jointure à gauche et test des valeurs NULL !--
-- référence et nom du article absent des entrepots
-- marque, nom de article, référence, ("Entrepôt"), ("Quantité")
-- trié par référence;

SELECT a.reference, a.nom, qte
FROM article AS a
    LEFT JOIN stock s ON id = s.article_id
WHERE qte is NULL
    OR qte = 0
ORDER BY a.reference;

-- ! Test des éléments présents sur la table de gauche et absent à droite !--
-- référence et nom de tous les articles non référencés dans les entrepôts
-- marque, nom de article ("Quantité")
-- trié par référence
-- en utilisant une jointure
SELECT a.reference, a.nom, SUM(qte) AS "Quantité"
FROM article AS a
    LEFT JOIN stock s ON id = s.article_id
WHERE qte is NULL
GROUP BY a.reference
ORDER BY a.reference;

-- ! Test sur une expression !--
-- référence et nom de tous les articles dont la quantité est < seuil mini + 10% du seuil mini
-- marque, nom de article ("Quantité")
-- trié par référence
-- en utilisant une jointure
-- faire ensuite la requête avec le seuil d'alerte en variable

SELECT a.reference, a.nom, qte AS "Quantité", seuil_min AS "Seuil", seuil_min * 1.1 AS 'Seuil10pct'
FROM article AS a
    LEFT JOIN stock s ON id = s.article_id
WHERE qte < (seuil_min * 1.1)
ORDER BY a.reference;

-- ! Utilisation d'une variable !--
SET @SEUIL_ALERTE = 1.1;
SELECT a.reference, a.nom, qte AS "Quantité", seuil_min AS "Seuil", seuil_min * @SEUIL_ALERTE AS 'Seuil10pct'
FROM article AS a
    LEFT JOIN stock s ON id = s.article_id
WHERE qte < (seuil_min * @SEUIL_ALERTE)
ORDER BY a.reference;

-- ! Création d'une vue !--
-- Creer une vue article stock entrepot
DROP VIEW IF EXISTS v_stock_entrepot;
CREATE VIEW v_stock_entrepot
AS
    SELECT article_id, marque, a.nom AS article_nom, entrepot_id, e.nom AS entrepot_nom, ville, qte, seuil_min, seuil_max
    FROM stock s, article a, entrepot e
    WHERE  a.id = article_id
        AND e.id = entrepot_id;

-- ! Clause IN !--
-- Sélectionner dans la vue v_stock_entrepôt
-- Les articles de la marque wind et snow avec "IN"
SELECT marque, article_nom, qte
FROM v_stock_entrepot
WHERE marque IN ('wind','snow')
ORDER BY marque, article_nom;

-- ! Incrémentation d'un compteur !--
-- Sélectionner dans la vue v_stock_entrepôt
-- le nom du article et le nom de l'entrepôt avec un numéro de ligne en première colonne.
SET @compteur:=0;
SELECT @compteur:=@compteur+1 AS "Rang",article_nom, entrepot_nom 
FROM v_stock_entrepot;

-- ! Clause HAVING !--
-- Lister les articles dont le stock total de l'entreprise est supérieur à 500.
-- trié par quantité stoquée décroissante
SELECT SUM(qte) AS "Quantité", article_nom
FROM v_stock_entrepot
GROUP BY article_id
HAVING SUM(qte) > 500
ORDER BY SUM(qte) DESC;
-- Les opérateurs possibles sont :
--  =, !=, <>, >, <, !<, !>, >=, <=
-- BEETWEEN, NOT BETWEEN
-- LIKE, NOT LIKE
-- IS NULL, IS NOT NULL
-- les opérateurs commençant par ! sont non conformes SQL-92
-- Les conditions négatives ralentissent les requêtes.


-- ===== SOUS REQUETES ===== --

-- ! Clause ANY !--
-- Sélectionner les articles dont le stock est < 104
-- dans au moins un entrepôt
-- Trié par marque et référence

SELECT id, reference, marque, nom
FROM article
WHERE id = ANY (
        SELECT article_id
        FROM stock
        WHERE qte < 104
    )
ORDER BY marque, reference;

-- ! Clause ALL !--
-- Sélectionner les articles dont le stock est < 29
-- dans chaque entrepôt
-- Trié par marque et référence

SELECT id, reference, marque, nom
FROM article a
WHERE 29 >  ALL (
        SELECT qte
        FROM stock
        where article_id = a.id  
    )
ORDER BY marque, reference;

-- ! Clause NOT IN et sous-requête !--
-- Lister les articles présents dans l'entrepôt de 
-- dijon 1 et absent dans l'entrepot de marseille 1
-- 

SELECT article_nom
FROM `v_stock_entrepot`
WHERE entrepot_nom = 'dijon 1'
AND article_id NOT IN
(
    SELECT article_id
    FROM `v_stock_entrepot`
    WHERE entrepot_nom = 'marseille 1'
);

