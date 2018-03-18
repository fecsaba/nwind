DROP DATABASE IF EXISTS nwind;
CREATE DATABASE nwind
	CHARACTER SET utf8
	COLLATE utf8_hungarian_ci;
USE nwind;
--
-- Tábla szerkezet ehhez a táblához `alkalmazottak`
--
CREATE TABLE `alkalmazottak` (
  `Alkalmazottkód` int(10) DEFAULT NULL,
  `Vezetéknév` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `Keresztnév` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `Beosztás` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `Megszólítás` varchar(25) CHARACTER SET utf8 DEFAULT NULL,
  `Születési dátum` datetime DEFAULT NULL,
  `Belépés dátuma` datetime DEFAULT NULL,
  `Cím` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `Város` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `Körzet` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `Irányítószám` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `Ország` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `Otthoni telefon` varchar(24) CHARACTER SET utf8 DEFAULT NULL,
  `Mellék` varchar(4) CHARACTER SET utf8 DEFAULT NULL,
  `Fénykép` blob,
  `Megjegyzés` text CHARACTER SET utf8,
  `Felettes` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;
--
-- Tábla szerkezet ehhez a táblához `fuvarozók`
--
CREATE TABLE `fuvarozók` (
  `Fuvarozókód` int(10) DEFAULT NULL,
  `Cégnév` varchar(40) CHARACTER SET utf8 DEFAULT NULL,
  `Telefon` varchar(24) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;
--
-- Tábla szerkezet ehhez a táblához `kategóriák`
--
CREATE TABLE `kategóriák` (
  `Kategóriakód` int(10) DEFAULT NULL,
  `Kategórianév` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `Leírás` text CHARACTER SET utf8,
  `Kép` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;
--
-- Tábla szerkezet ehhez a táblához `rendelések`
--
CREATE TABLE `rendelések` (
  `Rendeléskód` int(10) DEFAULT NULL,
  `Vevőkód` varchar(5) CHARACTER SET utf8 DEFAULT NULL,
  `Alkalmazottkód` int(10) DEFAULT NULL,
  `Rendelés dátuma` datetime DEFAULT NULL,
  `Határidő` datetime DEFAULT NULL,
  `Szállítás dátuma` datetime DEFAULT NULL,
  `Fuvarozó` int(10) DEFAULT NULL,
  `Szállítási költség` decimal(30,11) DEFAULT NULL,
  `Címzett` varchar(40) CHARACTER SET utf8 DEFAULT NULL,
  `Cím` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `Város` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `Körzet` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `Irányítószám` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `Ország` varchar(20) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;
--
-- Tábla szerkezet ehhez a táblához `rendelés részletei` 
--

CREATE TABLE `rendelés részletei` (
  `Rendeléskód` int(10) DEFAULT NULL,
  `Termékkód` int(10) DEFAULT NULL,
  `Egységár` decimal(30,11) DEFAULT NULL,
  `Mennyiség` smallint(5) DEFAULT NULL,
  `Engedmény` float(23,16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;
--
-- Tábla szerkezet ehhez a táblához `szállítók`
--

CREATE TABLE `szállítók` (
  `Szállítókód` int(10) DEFAULT NULL,
  `Cégnév` varchar(40) CHARACTER SET utf8 DEFAULT NULL,
  `Ügyintéző` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `Beosztás` varchar(35) CHARACTER SET utf8 DEFAULT NULL,
  `Cím` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `Város` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `Körzet` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `Irányítószám` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `Ország` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `Telefon` varchar(24) CHARACTER SET utf8 DEFAULT NULL,
  `Fax` varchar(24) CHARACTER SET utf8 DEFAULT NULL,
  `Honlap` text CHARACTER SET utf8
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;
--
-- Tábla szerkezet ehhez a táblához `termékek`
--

CREATE TABLE `termékek` (
  `Termékkód` int(10) DEFAULT NULL,
  `Terméknév` varchar(40) CHARACTER SET utf8 DEFAULT NULL,
  `Szállítókód` int(10) DEFAULT NULL,
  `Kategóriakód` int(10) DEFAULT NULL,
  `Mennyiség egységenként` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `Egységár` decimal(30,11) DEFAULT NULL,
  `Raktáron` smallint(5) DEFAULT NULL,
  `Megrendelve` smallint(5) DEFAULT NULL,
  `Minimum készlet` smallint(5) DEFAULT NULL,
  `Kifutott` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;
--
-- Tábla szerkezet ehhez a táblához `vevők`
--

CREATE TABLE `vevők` (
  `Vevőkód` varchar(5) CHARACTER SET utf8 DEFAULT NULL,
  `Cégnév` varchar(40) CHARACTER SET utf8 DEFAULT NULL,
  `Ügyintéző` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `Beosztás` varchar(36) CHARACTER SET utf8 DEFAULT NULL,
  `Cím` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `Város` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `Körzet` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `Irányítószám` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `Ország` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `Telefon` varchar(24) CHARACTER SET utf8 DEFAULT NULL,
  `Fax` varchar(24) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;


