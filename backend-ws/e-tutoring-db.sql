-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 30, 2021 alle 14:55
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
-- Struttura della tabella `course`
--

CREATE TABLE `course` (
  `course_id` int(11) NOT NULL,
  `course_name` varchar(99) NOT NULL,
  `course_cfu` int(11) NOT NULL,
  `enrollment_year` varchar(20) DEFAULT NULL COMMENT 'Academic year of enrollment',
  `study_year` int(5) DEFAULT NULL,
  `teaching_type` varchar(30) DEFAULT NULL COMMENT 'Type of teaching',
  `dac` varchar(10) DEFAULT NULL COMMENT 'Code of didactic activity',
  `department` varchar(30) DEFAULT NULL,
  `curriculum` varchar(99) DEFAULT NULL,
  `ssd` varchar(30) DEFAULT NULL COMMENT 'Scientific Disciplinary Sector (SSD)',
  `delivery_mode` varchar(30) DEFAULT NULL,
  `language` varchar(30) DEFAULT NULL COMMENT 'Language of instruction',
  `didactic_period` varchar(30) DEFAULT NULL COMMENT 'Didactic period',
  `component_type` varchar(99) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `course`
--

INSERT INTO `course` (`course_id`, `course_name`, `course_cfu`, `enrollment_year`, `study_year`, `teaching_type`, `dac`, `department`, `curriculum`, `ssd`, `delivery_mode`, `language`, `didactic_period`, `component_type`) VALUES
(1, 'Analisi Matematica', 9, '2021/2022', 1, 'Base', 'MFN0570', 'Informatica', 'percorso generico', 'ANALISI MATEMATICA (MAT/05)', 'Convenzionale', 'Italiano', 'Secondo Semestre', 'Attività formativa monodisciplinare'),
(2, 'Architettura degli Elaboratori', 9, '2021/2022', NULL, 'Base', NULL, 'Informatica', NULL, NULL, 'Convenzionale', 'Italiano', NULL, NULL),
(3, 'Agenti Intelligenti', 6, '2021/2022', NULL, 'Caratterizzante', 'MFN1348', 'Informatica', 'INTELLIGENZA ARTIFICIALE E SISTEMI INFORMATICI \"PIETRO TORASSO\"', 'INFORMATICA (INF/01)', 'Convenzionale', 'Italiano', 'Secondo Semestre', 'Attività formativa monodisciplinare'),
(5, 'Elementi di Astrofisica', 6, '2021/2022', NULL, 'Base', NULL, 'Fisica', NULL, NULL, 'Convenzionale', 'Italiano', NULL, NULL),
(6, 'apprendimento automatico', 9, '2021/2022', 1, 'Caratterizzante', 'INF0095', 'Informatica', 'INTELLIGENZA ARTIFICIALE E SISTEMI INFORMATICI \"PIETRO TORASSO\"', '\r\nINFORMATICA (INF/01)', 'Convenzionale', 'Inglese', 'Secondo Semestre', 'Attività formativa monodisciplinare'),
(7, 'Base di dati multimediali', 9, '2021/2022', 1, 'Caratterizzante', 'MFN0947', 'Informatica', 'INTELLIGENZA ARTIFICIALE E SISTEMI INFORMATICI \"PIETRO TORASSO\"Artificiale', ' INFORMATICA (INF/01)', 'Convenzionale', 'Italiano', ' Secondo Semestre', 'Attività formativa monodisciplinare'),
(8, 'reti neurali e deep learning', 9, '2021/2022', 1, 'Caratterizzante', 'INF0188', 'Informatica', 'INTELLIGENZA ARTIFICIALE E SISTEMI INFORMATICI \"PIETRO TORASSO\"', ' INFORMATICA (INF/01)', 'Convenzionale', 'Italiano', 'Primo Semestre', 'Attività formativa monodisciplinare'),
(9, 'Programmazione per dispositivi mobili', 6, '2021/2022', 1, 'Caratterizzante', 'INF0008', 'Informatica', 'INTELLIGENZA ARTIFICIALE E SISTEMI INFORMATICI \"PIETRO TORASSO\"', 'INFORMATICA (INF/01)', 'Convenzionale', 'Italiano', 'Secondo Semestre', 'Attività formativa monodisciplinare');

-- --------------------------------------------------------

--
-- Struttura della tabella `course_path_degree`
--

CREATE TABLE `course_path_degree` (
  `course_id` int(11) NOT NULL,
  `degree_path_id` int(11) NOT NULL,
  `degree_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `course_path_degree`
--

INSERT INTO `course_path_degree` (`course_id`, `degree_path_id`, `degree_id`) VALUES
(1, 6, 1),
(1, 7, 1),
(1, 8, 1),
(2, 6, 1),
(2, 7, 1),
(2, 8, 1),
(3, 1, 2),
(5, 9, 5),
(6, 1, 2),
(7, 1, 2),
(8, 1, 2),
(9, 1, 2);

-- --------------------------------------------------------

--
-- Struttura della tabella `degree`
--

CREATE TABLE `degree` (
  `degree_id` int(20) NOT NULL,
  `degree_name` varchar(30) NOT NULL,
  `degree_cfu` int(11) DEFAULT NULL,
  `degree_description` text DEFAULT NULL,
  `degree_type_id` int(11) NOT NULL,
  `degree_location` varchar(99) DEFAULT NULL,
  `degree_athenaeum` varchar(99) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `degree`
--

INSERT INTO `degree` (`degree_id`, `degree_name`, `degree_cfu`, `degree_description`, `degree_type_id`, `degree_location`, `degree_athenaeum`) VALUES
(1, 'Informatica', 180, 'Il Corso di Laurea in Informatica (classe L-31, D.M. 270) si articola in tre diversi percorsi con i primi due anni in comune, dedicati allo studio di materie propedeutiche per gli insegnamenti degli anni successivi. Nel primo anno sono presenti insegnamenti di matematica e di introduzione alla struttura dei calcolatori e alla programmazione. Per gli studenti del primo anno, i \"pre-corsi\" di Matematica Discreta ed Analisi Matematica si svolgeranno all’interno dell’orario del singolo insegnamento. Per gli studenti del secondo anno, i \"pre-corsi\" di Fisica si svolgeranno all’interno dell’orario del relativo insegnamento. Tutti i percorsi affiancano alla didattica svolta in aula delle ore di didattica in laboratorio e prevedono la formazione anche in ambiti disciplinari di cultura generale come diritto, lavoro di gruppo e conoscenza della lingua inglese.', 1, 'Torino', 'Unito'),
(2, 'Informatica', 120, 'In questi anni il mondo delle imprese, dei servizi e della Pubblica Amministrazione sta guardando con particolare interesse ai laureati in Informatica e la rapida evoluzione del settore crea nuove opportunità per l\'inserimento degli informatici nel mondo del lavoro.  Il Corso di Laurea in Informatica ha come obiettivo la formazione di una figura professionale dotata di preparazione tecnica rispondente alle esigenze di un rapido inserimento nel mondo del lavoro nel settore delle tecnologie dell\'informazione e della comunicazione. Il laureato in Informatica dovrà essere in grado di utilizzare le conoscenze e le competenze acquisite nella progettazione, sviluppo e gestione di sistemi informatici; dovrà inoltre possedere le capacità necessarie per affrontare ed analizzare problemi in vari contesti applicativi e per sviluppare sistemi informatici per la loro soluzione.  Nel corso degli studi, la comprensione della tecnologia informatica ed il suo utilizzo nella risoluzione di problemi applicativi è integrata con una solida preparazione di base, onde permettere al laureato di seguire la rapida evoluzione tecnologica e di adattarsi in modo flessibile a realtà lavorative molto varie.  Oltre alla preparazione tecnico-professionale, il percorso formativo prevede l\'acquisizione, da parte dello studente, delle competenze necessarie per lavorare in gruppo e per comprendere e produrre documentazione tecnica sia in Italiano che in Inglese.', 2, 'Torino', 'Unito'),
(3, 'Matematica', 180, 'Il Corso di Studi in Matematica dell\'Università di Torino si prefigge di fornire allo studente una solida preparazione matematica di base, utile sia per proseguire gli studi, sia per un immediato inserimento lavorativo. Il percorso formativo, fondato su un\'ampia parte comune per tutti gli studenti, nella fase finale offre percorsi differenziati specializzati su diversi aspetti della Matematica. Tali percorsi sono finalizzati al proseguimento degli studi per il conseguimento di una Laurea Magistrale in Matematica o in altre discipline scientifiche, ma permettono anche la scelta di attività utili per l\'immediato inserimento nel mondo del lavoro con l\'acquisizione di competenze tecniche professionalizzanti.   Gli obiettivi formativi del corso di studi si possono riassumere brevemente nella capacità di comprendere l\'essenza logica di problemi formulati in linguaggio comune, di tradurli in termini matematici e di trarne vantaggio per proporre soluzioni adeguate. Ben lungi quindi dall\'essere uno studio mnemonico o una mera applicazione di regole, lo studio della Matematica porta ad una formazione in cui si integrano rigore logico, ingegno e creatività.  I primi due anni sono dedicati alla formazione di base con corsi che riguardano l\'algebra, l\'analisi matematica, la geometria, l\'analisi numerica, il calcolo delle probabilità e la statistica. Vi sono inoltre corsi di fisica e informatica. Nel secondo anno lo studente può iniziare a differenziare il percorso scegliendo tra l\'orientamento teorico e quello applicativo. Tale scelta potrà comunque venir variata l\'anno successivo se lo studente si convincerà di preferire l\'altro orientamento.', 1, 'Torino', 'Unito'),
(4, 'Matematica', 120, 'Il Corso di Studi in Matematica dell\'Università di Torino si prefigge di fornire allo studente una solida preparazione matematica di base, utile sia per proseguire gli studi, sia per un immediato inserimento lavorativo. Il percorso formativo, fondato su un\'ampia parte comune per tutti gli studenti, nella fase finale offre percorsi differenziati specializzati su diversi aspetti della Matematica. Tali percorsi sono finalizzati al proseguimento degli studi per il conseguimento di una Laurea Magistrale in Matematica o in altre discipline scientifiche, ma permettono anche la scelta di attività utili per l\'immediato inserimento nel mondo del lavoro con l\'acquisizione di competenze tecniche professionalizzanti.   Gli obiettivi formativi del corso di studi si possono riassumere brevemente nella capacità di comprendere l\'essenza logica di problemi formulati in linguaggio comune, di tradurli in termini matematici e di trarne vantaggio per proporre soluzioni adeguate. Ben lungi quindi dall\'essere uno studio mnemonico o una mera applicazione di regole, lo studio della Matematica porta ad una formazione in cui si integrano rigore logico, ingegno e creatività.  I primi due anni sono dedicati alla formazione di base con corsi che riguardano l\'algebra, l\'analisi matematica, la geometria, l\'analisi numerica, il calcolo delle probabilità e la statistica. Vi sono inoltre corsi di fisica e informatica. Nel secondo anno lo studente può iniziare a differenziare il percorso scegliendo tra l\'orientamento teorico e quello applicativo. Tale scelta potrà comunque venir variata l\'anno successivo se lo studente si convincerà di preferire l\'altro orientamento.', 2, 'Torino', 'Unito'),
(5, 'Fisica', 180, 'La Laurea Triennale richiede 3 anni di corso (a tempo pieno), con 180 crediti formativi universitari (cfu) da acquisire. Il Corso di Laurea Triennale in Fisica ha un unico indirizzo generico che prevede un percorso comune per l\'85% dei crediti da acquisire e la possibilita\' di fare alcune scelte sui corsi affini e liberi che meglio riflettano gli specifici interessi dello studente. Il naturale proseguimento del percorso formativo e\' rivolto al completamento degli  studi con una Laurea Magistrale, pur non escludendo la possibilita\' di inserimento diretto nel mondo del lavoro. La laurea triennale in Fisica ha una naturale continuazione nella Laurea Magistrale: 2 anni di corso (a tempo pieno) e 120 cfu da acquisire. A partire dall\'Anno Accademico 2009/2010 sono attivate 2 diverse Lauree Magistrali: Laurea Magistrale in Fisica (vedi: ordinamento, regolamento, scheda di sintesi) Laurea Magistrale Interateneo in Fisica dei Sistemi Complessi (vedi: ordinamentoopen_in_new e regolamentoopen_in_new), in collaborazione con l\'Università del Piemonte Orientale', 1, 'Torino', 'Unito'),
(6, 'Fisica', 120, 'La Laurea Magistrale in Fisica è articolata in tre curricula che offrono percorsi didattici molto vicini a quelli esitenti nelle quattro \"vecchie\" Lauree Specialistiche (Fisica delle Interazioni Fondamentali, Fisica dell\'Ambiente e Biomedica, Fisica delle Tecnologie Avanzate e Astrofisica e Fisica Cosmica). Il passaggio da quattro lauree con denominazioni differenti ad una sola è avvenuto per applicare le nuove norme previste dal DM 270/04. I tre curricula della Laurea Magistrale in Fisica sono: Astrofisica e Fisica Teorica Fisica dell\'Ambiente e delle Tecnologie Avanzate Fisica Nucleare,  Sub-Nucleare e Biomedica I Corsi di Laurea Magistrale permettono di raggiungere una più spiccata specializzazione nei vari settori scientifici ed applicativi.', 2, 'Torino', 'Unito');

-- --------------------------------------------------------

--
-- Struttura della tabella `degree_path`
--

CREATE TABLE `degree_path` (
  `degree_path_id` int(11) NOT NULL,
  `degree_path_name` varchar(99) NOT NULL,
  `degree_path_description` varchar(99) DEFAULT NULL,
  `degree_path_note` text DEFAULT NULL,
  `degree_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `degree_path`
--

INSERT INTO `degree_path` (`degree_path_id`, `degree_path_name`, `degree_path_description`, `degree_path_note`, `degree_id`) VALUES
(1, 'Intelligenza Artificiale e Sistemi Informatici Pietro Torasso', 'Intelligenza Artificiale e Sistemi Informatici Pietro Torasso', 'per studenti iscritti dal 2017/2018', 2),
(2, 'Sistemi per il Trattamento dell\'Informazione', 'Sistemi per il Trattamento dell\'Informazione', 'per studenti iscritti fino al 2016/2017', 2),
(3, 'Reti e Sistemi informatici', 'Reti e Sistemi informatici', NULL, 2),
(4, 'Realtà virtuale e Multimedialità', 'Realtà virtuale e Multimedialità', 'per gli studenti iscritti fino al 2019/2020', 2),
(5, 'Immagini, Visione e Realtà Virtuale', 'Immagini, Visione e Realtà Virtuale', 'per studenti iscritti dal 2020/2021', 2),
(6, 'Informazione e conoscenza', 'Informazione e conoscenza', NULL, 1),
(7, 'Linguaggio e sistemi', 'Linguaggio e sistemi', NULL, 1),
(8, 'Reti e sistemi informatici', 'Reti e sistemi informatici', NULL, 1),
(9, 'Fisica del Sistema Meteoclimatico e delle Tecnologie Avanzate', 'Fisica del Sistema Meteoclimatico e delle Tecnologie Avanzate', 'Fisica del Sistema Meteoclimatico e delle Tecnologie Avanzate', 6),
(10, 'Fisica Nucleare e Subnucleare e Biomedica', 'Fisica Nucleare e Subnucleare e Biomedica', 'Fisica Nucleare e Subnucleare e Biomedica', 6),
(11, 'Fisica dell\'Ambiente e delle Tecnologie Avanzate', 'Fisica dell\'Ambiente e delle Tecnologie Avanzate', 'Fisica dell\'Ambiente e delle Tecnologie Avanzate', 6);

-- --------------------------------------------------------

--
-- Struttura della tabella `degree_type`
--

CREATE TABLE `degree_type` (
  `degree_type_id` int(20) NOT NULL,
  `degree_type_name` varchar(30) NOT NULL,
  `degree_type_note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `degree_type`
--

INSERT INTO `degree_type` (`degree_type_id`, `degree_type_name`, `degree_type_note`) VALUES
(1, 'LT', 'Laurea Triennale'),
(2, 'LM', 'Laurea Magistrale');

-- --------------------------------------------------------

--
-- Struttura della tabella `private_lesson`
--

CREATE TABLE `private_lesson` (
  `private_lesson_id` int(11) NOT NULL,
  `private_lesson_start_hour` varchar(10) NOT NULL,
  `private_lesson_end_hour` varchar(10) NOT NULL,
  `private_lesson_day` varchar(50) NOT NULL,
  `private_lesson_location` varchar(50) NOT NULL,
  `private_lesson_note` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `tutor_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `private_lesson`
--

INSERT INTO `private_lesson` (`private_lesson_id`, `private_lesson_start_hour`, `private_lesson_end_hour`, `private_lesson_day`, `private_lesson_location`, `private_lesson_note`, `user_id`, `course_id`, `tutor_id`) VALUES
(1, '19:00', '21:00', 'Sabato, Domenica', '', 'Richiedo lezione in streaming', 1, 3, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `role`
--

CREATE TABLE `role` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(20) NOT NULL,
  `role_description` varchar(99) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `role`
--

INSERT INTO `role` (`role_id`, `role_name`, `role_description`) VALUES
(1, 'Student', 'Student'),
(2, 'Tutor', 'Tutor'),
(3, 'Tutor/Student', 'Tutor & Student');

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

-- --------------------------------------------------------

--
-- Struttura della tabella `user_attribute`
--

CREATE TABLE `user_attribute` (
  `user_attribute_id` int(11) NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
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

INSERT INTO `user_attribute` (`user_attribute_id`, `firstname`, `lastname`, `badge_number`, `cf`, `birth_date`, `birth_city`, `residence_city`, `address`, `nationality`, `gender`, `phone_number`, `degree_id`, `degree_path_id`, `role_id`, `user_id`) VALUES
(1, 'Luca', 'Marignati', 779038, 'MRGLCU94D02L219F', '1994-04-02', 'Torino', 'Settimo Torinese', 'Via Botticelli 2', 'Italiana', 'M', '3347811074', 2, 1, 1, 1),
(2, 'Simone', 'Bortolotti', 802598, NULL, NULL, NULL, NULL, NULL, 'Italiana', NULL, NULL, 2, 1, 1, 2),
(3, 'Davide', 'De Cenzo', 785552, NULL, NULL, NULL, NULL, NULL, 'Italiana', NULL, NULL, 2, 1, 1, 3);

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`course_id`);

--
-- Indici per le tabelle `course_path_degree`
--
ALTER TABLE `course_path_degree`
  ADD PRIMARY KEY (`course_id`,`degree_path_id`,`degree_id`);

--
-- Indici per le tabelle `degree`
--
ALTER TABLE `degree`
  ADD PRIMARY KEY (`degree_id`);

--
-- Indici per le tabelle `degree_path`
--
ALTER TABLE `degree_path`
  ADD PRIMARY KEY (`degree_path_id`);

--
-- Indici per le tabelle `degree_type`
--
ALTER TABLE `degree_type`
  ADD PRIMARY KEY (`degree_type_id`);

--
-- Indici per le tabelle `private_lesson`
--
ALTER TABLE `private_lesson`
  ADD PRIMARY KEY (`private_lesson_id`);

--
-- Indici per le tabelle `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_id`);

--
-- Indici per le tabelle `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `user_attribute`
--
ALTER TABLE `user_attribute`
  ADD PRIMARY KEY (`user_attribute_id`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `course`
--
ALTER TABLE `course`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT per la tabella `degree`
--
ALTER TABLE `degree`
  MODIFY `degree_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT per la tabella `degree_path`
--
ALTER TABLE `degree_path`
  MODIFY `degree_path_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT per la tabella `degree_type`
--
ALTER TABLE `degree_type`
  MODIFY `degree_type_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `private_lesson`
--
ALTER TABLE `private_lesson`
  MODIFY `private_lesson_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT per la tabella `role`
--
ALTER TABLE `role`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la tabella `user`
--
ALTER TABLE `user`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la tabella `user_attribute`
--
ALTER TABLE `user_attribute`
  MODIFY `user_attribute_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;
