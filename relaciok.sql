USE nwind;

--
-- Alter table "alkalmazottak"
--
ALTER TABLE alkalmazottak
  ADD PRIMARY KEY (Alkalmazottkód);
--
-- Alter table "fuvarozók"
--
ALTER TABLE fuvarozók
  ADD PRIMARY KEY (Fuvarozókód);
--
-- Alter table "kategóriák"
--
ALTER TABLE kategóriák
  ADD PRIMARY KEY (Kategóriakód);
--
-- Alter table "`rendelés részletei`"
--
ALTER TABLE `rendelés részletei`
  ADD PRIMARY KEY (Rendeléskód, Termékkód);
  
--
-- Alter table "vevők"
--
ALTER TABLE vevők
  ADD PRIMARY KEY (Vevőkód);
--
-- Alter table "rendelések"
--
ALTER TABLE rendelések
  ADD PRIMARY KEY (Rendeléskód);
  
--
-- Alter table "szállítók"
--
ALTER TABLE szállítók
  ADD PRIMARY KEY (Szállítókód);
--
-- Alter table "termékek"
--
ALTER TABLE termékek
  ADD PRIMARY KEY (Termékkód);

-- Másodlagos kulcsok

--
-- Alter table "rendelések"
--
ALTER TABLE rendelések
  ADD CONSTRAINT FK_rendelések_vevők_Vevőkód FOREIGN KEY (Vevőkód)
    REFERENCES vevők(Vevőkód) ON DELETE RESTRICT ON UPDATE RESTRICT;
--
-- Alter table "rendelések"
--
ALTER TABLE rendelések
  ADD CONSTRAINT FK_rendelések_alkalmazottak_Alkalmazottkód FOREIGN KEY (Alkalmazottkód)
    REFERENCES alkalmazottak(Alkalmazottkód) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Alter table "rendelések"
--
ALTER TABLE rendelések
  ADD CONSTRAINT FK_rendelések_fuvarozók_Fuvarozókód FOREIGN KEY (Fuvarozó)
    REFERENCES fuvarozók(Fuvarozókód) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Alter table "`rendelés részletei`"
--
ALTER TABLE `rendelés részletei`
  ADD CONSTRAINT `FK_rendelés részletei_rendelések_Rendeléskód` FOREIGN KEY (Rendeléskód)
    REFERENCES rendelések(Rendeléskód) ON DELETE RESTRICT ON UPDATE RESTRICT;
--
-- Alter table "`rendelés részletei`"
--
ALTER TABLE `rendelés részletei`
  ADD CONSTRAINT `FK_rendelés részletei_termékek_Termékkód` FOREIGN KEY (Termékkód)
    REFERENCES termékek(Termékkód) ON DELETE RESTRICT ON UPDATE RESTRICT;
--
-- Alter table "termékek"
--
ALTER TABLE termékek
  ADD CONSTRAINT FK_termékek_szállítók_Szállítókód FOREIGN KEY (Szállítókód)
    REFERENCES szállítók(Szállítókód) ON DELETE RESTRICT ON UPDATE RESTRICT;
--
-- Alter table "termékek" 
--
ALTER TABLE termékek
  ADD CONSTRAINT FK_termékek_kategóriák_Kategóriakód FOREIGN KEY (Kategóriakód)
    REFERENCES kategóriák(Kategóriakód) ON DELETE RESTRICT ON UPDATE RESTRICT;


/* Mivel a feladat átgondolatlan és bizonyos kérdéseknél nincs köze az adatbázishoz, ezért létre kell hozni 
  egy mezőt az alkalmazottak táblában fizetések néven jutalék százalékokkal feltöltve
  (a feltöltés a feltölt sql-ben van) */

ALTER TABLE alkalmazottak
  ADD COLUMN Fizetések float;