-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 20, 2021 alle 09:51
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
-- Struttura della tabella `user`
--

CREATE TABLE `user` (
  `id` int(20) NOT NULL,
  `username` varchar(70) NOT NULL,
  `password` varchar(40) NOT NULL,
  `email` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `email`, `created_at`, `updated_at`) VALUES
(1, 'luca.marignati', '098f6bcd4621d373cade4e832627b4f6', 'luca.marignati@edu.unito.it', '2021-05-07 09:15:35', '2021-05-07 09:15:35'),
(2, 'simone.bortolotti', '098f6bcd4621d373cade4e832627b4f6', 'simone.bortolotti@edu.unito.it', '2021-05-07 09:15:35', '2021-05-07 09:15:35'),
(3, 'davide.decenzo', '098f6bcd4621d373cade4e832627b4f6', 'davide.decenzo@edu.unito.it', '2021-05-07 09:15:35', '2021-05-07 09:15:35');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `user`
--
ALTER TABLE `user`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;
