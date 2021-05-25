# E-Tutoring 
### Flutter Application (Argon UI template)

### *Università degli Studi di Torino*

### *Corso: Programmazione per dispositivi mobili*

#### Studenti
    Bortolotti Simone
    De Cenzo Davide
    Marignati Luca

### CONFIG

lib\config

make config.dart
define authority and unecodedPath for comunicate with backend php mysql API
e.g. 
// SERVER IP
const String authority = '192.168.56.1';
// SERVER LOGIN API URL
const String unencodedPath = 'e-tutoring-web/ws/ws/';

### Remember gitignore lib/config/config.dart because it contains configuration parameters that vary from pc to pc.