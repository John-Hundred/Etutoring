-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 25, 2021 alle 17:46
-- Versione del server: 10.4.18-MariaDB
-- Versione PHP: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `e_tutoring`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `user_attribute`
--

CREATE TABLE `user_attribute` (
  `user_attribute_id` int(11) NOT NULL,
  `badge_number` int(11) NOT NULL,
  `cf` varchar(30) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `birth_city` varchar(50) DEFAULT NULL,
  `residence_city` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `gender` varchar(5) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `degree_id` int(11) NOT NULL,
  `degree_path_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `user_attribute`
--

INSERT INTO `user_attribute` (`user_attribute_id`, `badge_number`, `cf`, `birth_date`, `birth_city`, `residence_city`, `address`, `nationality`, `gender`, `phone_number`, `degree_id`, `degree_path_id`, `role_id`, `user_id`) VALUES
(1, 779038, 'MRGLCU94D02L219F', '1994-04-02', 'Torino', 'Settimo Torinese', 'Via Botticelli 2', 'Italiana', 'M', '3347811074', 2, 2, 1, 1);

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `user_attribute`
--
ALTER TABLE `user_attribute`
  ADD PRIMARY KEY (`user_attribute_id`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `user_attribute`
--
ALTER TABLE `user_attribute`
  MODIFY `user_attribute_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;
