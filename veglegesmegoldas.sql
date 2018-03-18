USE nwind;
-- 
--
-- ***********************************************************************************************************************************
--
--
-- Feladványok 1

-- 1.1 Mely rendelések nincsenek kiszállítva? 

  SELECT r.`Rendeléskód` FROM rendelések r
  WHERE r.`Szállítás dátuma` IS NULL;

-- 1.2 Határidő után kiszállított rendelések?

SELECT r.Rendeléskód FROM rendelések r
  WHERE r.`Szállítás dátuma` > r.Határidő;

-- 1.3 Listázza ki az 1000 Ft-nál olcsóbb italokat!

SELECT
  Terméknév, Egységár
FROM termékek
  INNER JOIN kategóriák
    ON termékek.Kategóriakód = kategóriák.Kategóriakód
  WHERE kategóriák.Kategóriakód=1 AND Egységár<1000;

-- 1.4 Paraméterben megadott év rendelései?
SELECT r.Rendeléskód FROM rendelések r
  WHERE YEAR(r.`Rendelés dátuma`)=1994;

-- 1.5 A Vevő (Cégnév) 3. vagy negyedik betűje „R”-betű.

SELECT v.Cégnév FROM vevők v
 WHERE v.Cégnév LIKE '__R%' OR v.Cégnév LIKE '___R%';

-- 1.6 Határozzuk meg a kategóriánkénti kifutott termékek számát és átlagos egységárát!

SELECT
  kategóriák.Kategórianév,
  AVG(termékek.Egységár) AS Átlag
FROM termékek
  INNER JOIN kategóriák
    ON termékek.Kategóriakód = kategóriák.Kategóriakód
WHERE termékek.Kifutott = 1
GROUP BY kategóriák.Kategóriakód;

-- 1.7 Határozza meg országonként és városonként a vevők számát!

SELECT
  vevők.Ország,
  vevők.Város,
  COUNT(vevők.Város) AS Összesen
FROM vevők
GROUP BY vevők.Ország,
         vevők.Város;

-- 1.8 Listázza ki csökkenő sorrendben azt a 10 vevőt, akik a legtöbb pénzt hagyták a kasszában?

SELECT
  vevők.Cégnév, SUM( termékek.Egységár* Mennyiség+ `Szállítási költség`) AS bevétel
FROM rendelések
  INNER JOIN vevők
    ON rendelések.Vevőkód = vevők.Vevőkód
  INNER JOIN `rendelés részletei`
    ON `rendelés részletei`.Rendeléskód = rendelések.Rendeléskód
  INNER JOIN termékek
    ON `rendelés részletei`.Termékkód = termékek.Termékkód
  GROUP BY rendelések.Vevőkód 
  ORDER BY bevétel DESC LIMIT 10;

-- 1.9 Határozza meg az évenkénti rendelések számát!

SELECT YEAR( r.`Rendelés dátuma`), COUNT( r.Rendeléskód) AS Db FROM rendelések r
  GROUP BY YEAR( r.`Rendelés dátuma`);

-- 1.10 Határozza meg az évenként eladott termékek számát!

  
  SELECT YEAR( `Rendelés dátuma`), COUNT(termékek.Termékkód) AS `Össz. eladott termék`
  
FROM `rendelés részletei`
  INNER JOIN termékek
    ON `rendelés részletei`.Termékkód = termékek.Termékkód
  INNER JOIN rendelések
    ON `rendelés részletei`.Rendeléskód = rendelések.Rendeléskód 
    GROUP BY YEAR( `Rendelés dátuma`);

-- 1.11. Üzletkötőnként határozza meg az össze engedmény értékét!

SELECT Vezetéknév, Keresztnév, Beosztás, SUM( Egységár* Mennyiség * Engedmény) AS `Engedmény össz`
    
FROM `rendelés részletei`
  INNER JOIN rendelések
    ON `rendelés részletei`.Rendeléskód = rendelések.Rendeléskód
  INNER JOIN alkalmazottak
    ON rendelések.Alkalmazottkód = alkalmazottak.Alkalmazottkód
  WHERE Beosztás='üzletkötő'
  GROUP BY alkalmazottak.Alkalmazottkód;

-- 1.12. Az üzletkötők hányszor adtak engedményt?

SELECT COUNT( Engedmény) AS `Engedmény db`
  
FROM `rendelés részletei`
  INNER JOIN rendelések
    ON `rendelés részletei`.Rendeléskód = rendelések.Rendeléskód
  INNER JOIN alkalmazottak
    ON rendelések.Alkalmazottkód = alkalmazottak.Alkalmazottkód
  WHERE Beosztás = 'Üzletkötő';

-- 1.13. Tíznél több terméket tartalmazó kategóriákban hány termék szerepel.

SELECT Kategórianév, COUNT( Termékkód) AS Össz
  
FROM termékek
  INNER JOIN kategóriák
    ON termékek.Kategóriakód = kategóriák.Kategóriakód
 
  GROUP BY kategóriák.Kategóriakód
  HAVING Össz >10;
  
-- 1.14. A Fizetés mezőben azon üzletkötők jövedelme, akiké meghaladja
--  az "Igazgató" vagy "Alelnök" címmel rendelkező minden alkalmazottét.

SELECT
  alkalmazottak.Beosztás,
  alkalmazottak.Vezetéknév,
  alkalmazottak.Keresztnév,
  SUM(FLOOR(`rendelés részletei`.Egységár * `rendelés részletei`.Mennyiség * `rendelés részletei`.Engedmény * alkalmazottak.Fizetések)) AS Fizetés
FROM rendelések
  INNER JOIN alkalmazottak
    ON rendelések.Alkalmazottkód = alkalmazottak.Alkalmazottkód
  INNER JOIN `rendelés részletei`
    ON `rendelés részletei`.Rendeléskód = rendelések.Rendeléskód
  INNER JOIN termékek
    ON `rendelés részletei`.Termékkód = termékek.Termékkód
GROUP BY alkalmazottak.Alkalmazottkód
HAVING Beosztás = 'Üzletkötő' AND
  (SUM(FLOOR(`rendelés részletei`.Egységár * `rendelés részletei`.Mennyiség *
  `rendelés részletei`.Engedmény * alkalmazottak.Fizetések)) > (SELECT
    FLOOR(SUM(`rendelés részletei`.Egységár * `rendelés részletei`.Mennyiség * `rendelés részletei`.Engedmény * alkalmazottak.Fizetések)) AS expr1
  FROM rendelések
    INNER JOIN alkalmazottak
      ON rendelések.Alkalmazottkód = alkalmazottak.Alkalmazottkód
    INNER JOIN `rendelés részletei`
      ON `rendelés részletei`.Rendeléskód = rendelések.Rendeléskód
  WHERE alkalmazottak.Beosztás LIKE '%alelnök%') OR
  SUM(FLOOR(`rendelés részletei`.Egységár * `rendelés részletei`.Mennyiség *
  `rendelés részletei`.Engedmény * alkalmazottak.Fizetések)) > (SELECT
    FLOOR(SUM(`rendelés részletei`.Egységár * `rendelés részletei`.Mennyiség * `rendelés részletei`.Engedmény * alkalmazottak.Fizetések)) AS expr1
  FROM rendelések
    INNER JOIN alkalmazottak
      ON rendelések.Alkalmazottkód = alkalmazottak.Alkalmazottkód
    INNER JOIN `rendelés részletei`
      ON `rendelés részletei`.Rendeléskód = rendelések.Rendeléskód
  WHERE alkalmazottak.Beosztás LIKE '%igazgató%'));
  

-- 1.15. A Rendelésösszeg: [Egységár] * [Mennyiség] számított mezőben az átlagos rendelésértéknél nagyobb összegű rendelések.

SELECT
  rendelések.Rendeléskód,
  SUM(`rendelés részletei`.Egységár * `rendelés részletei`.Mennyiség) AS érték
FROM (SELECT
         SUM(`rendelés részletei`.Egységár * `rendelés részletei`.Mennyiség) AS átlag
       FROM `rendelés részletei`
       GROUP BY `rendelés részletei`.Rendeléskód) SubQuery,
     `rendelés részletei`
       INNER JOIN rendelések
         ON `rendelés részletei`.Rendeléskód = rendelések.Rendeléskód
GROUP BY rendelések.Rendeléskód
HAVING AVG(SubQuery.átlag) < SUM(`rendelés részletei`.Egységár * `rendelés részletei`.Mennyiség);

-- 1.16. Az Egységár mező azon termékei, amelyek egységára megegyezik az ánizsmagszörpével.

SELECT t.Termékkód, t.Terméknév
  FROM termékek t
  WHERE t.Egységár=(SELECT t.Egységár
  FROM termékek t
  WHERE t.Terméknév ='Aniseed Syrup');

-- 1.17. Kik azok az üzletkötők, akik az igazgatóknál és az alelnököknél is idősebbek?

SELECT a.Alkalmazottkód, a.Vezetéknév, a.Keresztnév
  FROM alkalmazottak a
  WHERE CURDATE()- a.`Születési dátum`> (SELECT CURDATE()- a1.`Születési dátum`
  FROM alkalmazottak a1
  WHERE a1.Beosztás LIKE '%alelnök%') AND 
    CURDATE() - a.`Születési dátum`> (SELECT CURDATE() - a1.`Születési dátum`
    FROM alkalmazottak a1
    WHERE a1.Beosztás LIKE '%igazgató%');

-- 2.1. Add meg a kifutott termékek nevét és szállítóját!
SELECT Terméknév, Cégnév
  
FROM termékek
  INNER JOIN szállítók
    ON termékek.Szállítókód = szállítók.Szállítókód
  WHERE Kifutott = 1;
-- 2.2. Töröld az Alkalmazottak táblából a Gyakornok Beosztású rekordokat.
DELETE FROM alkalmazottak
  WHERE Beosztás = 'gyakornok';
-- 2.3. Add meg a B és az M betűvel kezdődő városokból szállított termékek nevét és egységárát.
SELECT
  termékek.Terméknév,
  termékek.Egységár
   
FROM termékek
  INNER JOIN szállítók
    ON termékek.Szállítókód = szállítók.Szállítókód
WHERE szállítók.Város LIKE 'b%'
OR szállítók.Város LIKE 'm%';

-- 2.4. Add meg a raktáron lévő termékek átlagos egységárát.
SELECT AVG(t.Egységár)
  FROM termékek t
WHERE t.Raktáron > 0;
-- 2.5. Add meg a minimumkészlet alá csökkent nem kifutott termékek nevét és darabszámát terméknév szerinti sorrendben.

  SELECT t.Terméknév, t.`Mennyiség egységenként`
  FROM termékek t
WHERE t.Kifutott = 1 AND
  t.`Minimum készlet` >= t.Raktáron
ORDER BY t.Terméknév;

-- 2.6. Add meg a 10 legnagyobb raktári összértékkel rendelkező termék nevét, beszállítóját, értékszerinti csökkenő sorrendben.

SELECT t.Terméknév,
  s1.Cégnév,
  t.Egységár * t.Raktáron AS `Raktári érték`
  FROM termékek t
  INNER JOIN szállítók s1 ON t.Szállítókód = s1.Szállítókód
  WHERE t.Raktáron > 0
  ORDER BY `Raktári érték` DESC 
  LIMIT 10;

-- 2.7. Add meg az 1995 első félévében született rendelések megrendelésszámát, megrendelőjét és az alkalmazott nevét, aki a megrendelést bonyolította.

  SELECT
  rendelések.Rendeléskód,
  vevők.Cégnév,
  alkalmazottak.Vezetéknév,
  alkalmazottak.Keresztnév
FROM rendelések
  INNER JOIN vevők
    ON rendelések.Vevőkód = vevők.Vevőkód
  INNER JOIN alkalmazottak
    ON rendelések.Alkalmazottkód = alkalmazottak.Alkalmazottkód
WHERE rendelések.`Rendelés dátuma` BETWEEN '1994.12.31' AND '1995.06.30';

-- 2.8. Add meg annak a 3 alkalmazottnak a nevét, akik 1995-ben a legkevesebb rendeléseket bonyolította.

SELECT
  alkalmazottak.Vezetéknév,
  alkalmazottak.Keresztnév,
  COUNT(rendelések.Rendeléskód) AS Rendelések
FROM rendelések
  INNER JOIN alkalmazottak
    ON rendelések.Alkalmazottkód = alkalmazottak.Alkalmazottkód
WHERE YEAR(rendelések.`Rendelés dátuma`) = 1995
GROUP BY alkalmazottak.Vezetéknév,
         alkalmazottak.Keresztnév
ORDER BY Rendelések LIMIT 3;

-- 2.9. A következő példa minden olyan rekord Felettes mezőjét 5-re állítja, amelynek jelenleg 2 az értéke.

UPDATE alkalmazottak a
  SET a.Felettes = 5
  WHERE a.Felettes = 2;

-- 2.10. A következő példa minden olyan termék egységárát megnöveli 10 százalékkal, amely a 8. számú szállítótól származik, és amelyből van raktáron.

UPDATE termékek t
  SET t.Egységár = t.Egységár*1.1
  WHERE t.Szállítókód = 8 AND t.Raktáron > 0;

-- 2.11. A következő példa minden olyan termék egységárát csökkenti 10 százalékkal, amely
--  a Tokyo Traders nevű szállítótól származik, és amelyből van raktáron.

    UPDATE termékek t
    INNER JOIN szállítók s 
    ON s.Szállítókód = t.Szállítókód
    SET t.Egységár = t.Egységár/1.1 
  WHERE s.Cégnév = 'Tokyo Traders' AND t.Raktáron > 0;

-- 2.12. Add meg a termékek kategóriánkénti átlagos egységárát!

SELECT
  k.Kategórianév, AVG(t.Egységár) AS Átlagár
  FROM termékek t
  INNER JOIN kategóriák k
  ON k.Kategóriakód= t.Kategóriakód
  GROUP BY k.Kategóriakód;