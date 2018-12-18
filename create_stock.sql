-- 
DROP DATABASE stock;
CREATE DATABASE IF NOT EXISTS stock;
USE stock;

DROP TABLE IF EXISTS `stock`.`article`;
CREATE TABLE `stock`.`article` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `reference` VARCHAR(10) NOT NULL,
  `nom` VARCHAR(255) NOT NULL,
  `marque` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `reference_UNIQUE` (`reference` ASC));

DROP TABLE IF EXISTS `stock`.`entrepot`;  
CREATE TABLE `stock`.`entrepot` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NOT NULL,
  `ville` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`));

DROP TABLE IF EXISTS `stock`.`stock`;
CREATE TABLE `stock`.`stock` (
  `article_id` INT NOT NULL,
  `entrepot_id` INT NOT NULL,
  `qte` INT NULL DEFAULT NULL,
  `seuil_min` INT NULL DEFAULT NULL,
  `seuil_max` INT NULL DEFAULT NULL,
  PRIMARY KEY (`article_id`, `entrepot_id`),
  FOREIGN KEY (article_id)
        REFERENCES article(id),
  FOREIGN KEY (entrepot_id)
        REFERENCES entrepot(id)
  );

    
    
-- FILL VALUES

INSERT INTO `stock`.`entrepot` (`nom`, `ville`) VALUES ('dijon 1', 'dijon');
INSERT INTO `stock`.`entrepot` (`nom`, `ville`) VALUES ('marseille 1', 'marseille');


INSERT INTO `stock`.`article` (`reference`, `nom`, `marque`) VALUES ('BTMTWND001', 'boîtier moyen tour noir', 'wind');
INSERT INTO `stock`.`article` (`reference`, `nom`, `marque`) VALUES ('BTMTWND002', 'boîtier moyen tour blanc', 'wind');
INSERT INTO `stock`.`article` (`reference`, `nom`, `marque`) VALUES ('BTMTSNW001', 'boitier moyen tour noir ', 'snow');
INSERT INTO `stock`.`article` (`reference`, `nom`, `marque`) VALUES ('BTGTSNW001', 'boitier grand tour noir ', 'snow');
INSERT INTO `stock`.`article` (`reference`, `nom`, `marque`) VALUES ('SD12EST001', 'SSD 120Go ', 'eastern');
INSERT INTO `stock`.`article` (`reference`, `nom`, `marque`) VALUES ('SD25EST001', 'SSD 250Go ', 'eastern');
INSERT INTO `stock`.`article` (`reference`, `nom`, `marque`) VALUES ('SD50EST001', 'SSD 500Go ', 'eastern');
INSERT INTO `stock`.`article` (`reference`, `nom`, `marque`) VALUES ('SD25HYP001', 'SSD 250Go ', 'hyper');
INSERT INTO `stock`.`article` (`reference`, `nom`, `marque`) VALUES ('SD12HYP001', 'SSD 120Go ', 'hyper');
INSERT INTO `stock`.`article` (`reference`, `nom`, `marque`) VALUES ('SD50HYP001', 'SSD 500Go ', 'hyper');
INSERT INTO `stock`.`article` (`reference`, `nom`, `marque`) VALUES ('SD14BMM001', 'RAM 4Go ', 'best memory');
INSERT INTO `stock`.`article` (`reference`, `nom`, `marque`) VALUES ('SD18BMM001', 'RAM 8Go ', 'best memory');
INSERT INTO `stock`.`article` (`reference`, `nom`, `marque`) VALUES ('SD24BMM001', 'RAM 2*4Go ', 'best memory');
INSERT INTO `stock`.`article` (`reference`, `nom`, `marque`) VALUES ('SD28BMM001', 'RAM 2*8Go ', 'best memory');
INSERT INTO `stock`.`article` (`reference`, `nom`, `marque`) VALUES ('SD24BNY001', '$inconnue$', 'BNY');
INSERT INTO `stock`.`article` (`reference`, `nom`, `marque`) VALUES ('SD28BNY001', '$inconnue$', 'BNY');
INSERT INTO `stock`.`article` (`reference`, `nom`, `marque`) VALUES ('CPR5BMD001', 'CPU BMD R5', NULL);
INSERT INTO `stock`.`article` (`reference`, `nom`, `marque`) VALUES ('CPR7BMD001', 'CPU BMD R7', 'BMD');
INSERT INTO `stock`.`article` (`reference`, `nom`, `marque`) VALUES ('ABSENT0001', 'article non stocké', 'ABS');
INSERT INTO `stock`.`article` (`reference`, `nom`, `marque`) VALUES ('SEUIL00P10', 'Seuil + 10pct', 'seuil');


-- STOCK entrepot 1

INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('1', '1', '60', '30', '100');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('2', '1', '30', '30', '200');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('3', '1', '35', '30', '200');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('4', '1', '100', '30', '200');

INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('5', '1', '1400', '500', '8000');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('6', '1', '900', '600', '8000');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('7', '1', '200', '500', '8000');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('8', '1', '350', '400', '8000');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('9', '1', '3500', '500', '8000');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('10', '1', '600', '500', '8000');

INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('11', '1', '225', '500', '8000');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('12', '1', '351', '400', '8000');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('13', '1', '12', '500', '8000');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('14', '1', '1604', '500', '8000');

INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('20', '1', '659', '600', '8000');


-- STOCK entrepot 2

INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('2', '2', '21', '30', '200');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('1', '2', '70', '30', '100');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('3', '2', '150', '30', '200');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('4', '2', '105', '30', '200');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('5', '2', '101', '500', '8000');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('6', '2', '904', '600', '8000');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('7', '2', '208', '500', '8000');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('8', '2', '351', '400', '8000');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('9', '2', '3501', '500', '8000');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('10', '2', '605', '500', '8000');

INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('11', '2', '700', '500', '8000');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('12', '2', '389', '400', '8000');
INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('13', '2', '28', '500', '8000');
-- INSERT INTO `stock`.`stock` (`article_id`, `entrepot_id`, `qte`, `seuil_min`, `seuil_max`) VALUES ('14', '2', '1604', '500', '8000');


SELECT 'END SCRIPT';