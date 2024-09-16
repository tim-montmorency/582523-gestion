# Scénario interactif

La scénarisation de l'expérience interactive est une étape fondamentale dans la conception multimédias. Elle vise à définir le parcours utilisateur en anticipant ses besoins, ses attentes et ses interactions avec l'objet. Cette démarche permet de créer une expérience personnalisée et engageante.

## Shématisation

La schématisation dans le contexte de la scénarisation interactive est le processus de représentation visuelle des différents éléments, étapes, et interactions d'une expérience interactive ou d'un scénario. Elle permet de structurer et d'organiser les idées de manière claire et compréhensible, facilitant ainsi la planification, le développement, et la communication du projet.

Des outils de création de diagram tel que le language [Mermaid](../../90_outils/80_mermaid/) ou le logiciel [Draw.io](../../90_outils/81_drawio/) peuvent aider à schématiser un scénario interactif.

## Exemples

### Applications Mobiles

```mermaid
graph TD;
    A[Écran d'accueil] --> B[Connexion];
    A -->|Utilisateur connecté| C[Accéder au tableau de bord];
    
    B -->|Succès| C[Tableau de bord];
    B -->|Échec| D[Erreur de connexion];

    C --> E{Que faire ?};
    E -->|Consulter profil| F[Profil utilisateur];
    E -->|Voir notifications| G[Notifications];
    E -->|Accéder aux paramètres| H[Paramètres];
    E -->|Utiliser fonctionnalité principale| I[Fonctionnalité principale];

    F --> E;
    G --> E;
    H --> E;

    I --> J{Interaction ?};
    J -->|Oui| K[Action effectuée];
    J -->|Non| I;

    K --> E;

    H --> L[Déconnexion];
    L --> A[Retour à l'écran d'accueil];

```
Attentions particulière à une navigation intuitive, des interactions tactiles fluides et pertinentes.

### Sites Web Interactifs 

```mermaid
graph TD;
    A[Page d'accueil] --> B[Naviguer vers une section];
    A -->|Connexion utilisateur| C[Tableau de bord];
    
    B --> D{Choisir une section};
    D -->|Produits| E[Page Produits];
    D -->|À propos| F[Page À propos];
    D -->|Contact| G[Page Contact];

    C --> H{Que faire ?};
    H -->|Voir profil| I[Profil utilisateur];
    H -->|Gérer compte| J[Paramètres de compte];
    H -->|Se déconnecter| K[Déconnexion];
    H -->|Utiliser services| L[Services interactifs];

    I --> H;
    J --> H;
    K --> A;

    E -->|Voir détails produit| M[Détails produit];
    M -->|Ajouter au panier| N[Panier];
    N --> H;

    L --> O{Choisir service};
    O -->|Service 1| P[Utiliser Service 1];
    O -->|Service 2| Q[Utiliser Service 2];
    P --> H;
    Q --> H;

```

Offrant du contenu dynamique, des fonctionnalités complexes ou des expériences personnalisées.



### Jeux Vidéo


```mermaid
graph TD;
    A[Écran de démarrage] --> B[Menu principal];
    B -->|Nouvelle partie| C[Choisir personnage];
    B -->|Charger partie| D[Reprendre partie];

    C --> E[Début du jeu];
    D --> E;

    E --> F{Joueur interagit ?};
    F -->|Oui| G[Effectuer action];
    F -->|Non| E;

    G --> H{Résultat de l'action};
    H -->|Succès| I[Progresser dans le jeu];
    H -->|Échec| J[Réessayer];

    I --> F;
    J --> F;

    I --> K[Terminer le niveau];
    K --> L{Fin du jeu ?};
    L -->|Oui| M[Écran de fin];
    L -->|Non| F;

```

Développer une narration interactive et un arbre de décisions pour l'utilisateur influençant le déroulement.

### Plateformes d'E-learning

```mermaid
graph TD;
    A[Page d'accueil] --> B[Connexion];
    A -->|Visiteur| C[Parcourir cours];

    B --> D{Utilisateur connecté ?};
    D -->|Oui| E[Tableau de bord];
    D -->|Non| B;

    E --> F{Que faire ?};
    F -->|Voir mes cours| G[Liste des cours];
    F -->|Parcourir cours| H[Catalogue des cours];
    F -->|Voir profil| I[Profil utilisateur];
    F -->|Gérer paramètres| J[Paramètres de compte];
    F -->|Se déconnecter| K[Déconnexion];

    G --> L{Sélectionner un cours};
    L -->|Commencer/continuer cours| M[Accès au contenu];
    M --> N{Suivre le cours ?};
    N -->|Oui| O[Lecture de la leçon];
    N -->|Non| G;

    O --> P{Leçon terminée ?};
    P -->|Oui| Q[Marquer comme terminé];
    P -->|Non| O;

    Q --> G;

    H --> L;

    I --> F;
    J --> F;
    K --> A;
```

Proposer des contenus éducatifs interactifs qui s'adaptent aux actions de l'utilisateur.

### Experience multimédia

```mermaid
graph TD;
    A[Page d'accueil] --> B[Naviguer dans les sections];
    B --> C{Type de contenu ?};

    C -->|Vidéo| D[Visionner une vidéo];
    C -->|Audio| E[Écouter de l'audio];
    C -->|Image| F[Voir une galerie d'images];
    C -->|Texte| G[Lire du texte interactif];
    C -->|3D| H[Interagir avec un objet 3D];

    D --> I{Vidéo terminée ?};
    I -->|Oui| B;
    I -->|Non| D;

    E --> J{Audio terminé ?};
    J -->|Oui| B;
    J -->|Non| E;

    F --> K{Exploration terminée ?};
    K -->|Oui| B;
    K -->|Non| F;

    G --> L{Texte terminé ?};
    L -->|Oui| B;
    L -->|Non| G;

    H --> M{Interaction 3D terminée ?};
    M -->|Oui| B;
    M -->|Non| H;

    B --> N[Quitter l'expérience];
 ```   

### Installations Multimédias


```mermaid
graph TD;

    C{Interaction ?};
    C -->|Audio| D[Sons activés];
    C -->|Vidéo| E[Vidéo lancée];
    C -->|Lumière| F[Effets lumineux];
    C -->|Multimédia| G[Combinaison de médias];

    D --> H{Interaction terminée ?};
    E --> H;
    F --> H;
    G --> H;

    H -->|Oui| I[Retour à veille];
    H -->|Non| C;

Installation interactive présenté dans un musées, une exposition ou des événement.

```

### Réalité Virtuelle (VR) 

```mermaid
graph TD;
    A[Chargement expérience VR] --> B[Écran d'accueil];
    B -->|Commencer| C[Plongée dans l'environnement virtuel];

    C --> D{Détection d'interaction ?};
    D -->|Oui| E[Action de l'utilisateur];
    D -->|Non| C;

    E --> F{Type d'action};
    F -->|Mouvement| G[Mouvement dans l'espace];
    F -->|Manipulation| H[Interaction avec objets];
    F -->|Dialogue| I[Conversation virtuelle];
    F -->|Choix| J[Décision ou chemin];

    G --> K{Succès ?};
    H --> K;
    I --> K;
    J --> K;

    K -->|Oui| L[Continuer expérience];
    K -->|Non| M[Réessayer];

    L --> C;
    M --> E;

Une expérience de réalité virtuelle avec des choix et des embranchements.

```

### Réalité Augmentée (AR)

```mermaid
graph TD;
    A[Application AR lancée] --> B[Scan environnement];
    B -->|Objet détecté| C[Superposition AR];
    

    C --> D{Interaction avec AR ?};
    D -->|Oui| E[Interagir avec éléments];
    D -->|Non| F[Observer éléments];

    E --> G{Action spécifique ?};
    G -->|Oui| H[Exécution de action];
    G -->|Non| C;

    H --> F;

    F --> I{Continuer expérience ?};
    I -->|Oui| C;
    I -->|Non| J[Quitter application];

```

Une expérience de réalité augmentée créant des environnements via une interactivité temps réelle.

### Publicités Interactives

```mermaid
graph TD;
    A[Publicité affichée] --> B{Utilisateur interagit ?};
    B -->|Oui| C[Accéder au contenu interactif];
    B -->|Non| D[Publicité continue];

    C --> E{Type d'interaction ?};
    E -->|Vidéo| F[Lecture de vidéo];
    E -->|Formulaire| G[Remplir formulaire];
    E -->|Jeu| H[Participer à un jeu];

    F --> I{Action terminée ?};
    G --> I;
    H --> I;

    I -->|Oui| J[Redirection vers site ou produit];
    I -->|Non| C;

    D --> K[Publicité terminée] --> L[Redirection ou fermeture];
    J --> L;

```

Permet à l'utilisateur d'interagir pour découvrir davantage un produit ou un service.

### Livres numériques interactifs 

```mermaid
graph TD;
    A[Page d'accueil du livre] --> B[Choisir chapitre];
    B --> C{Chapitre interactif ?};
    
    C -->|Oui| D[Contenu interactif chargé];
    C -->|Non| E[Lecture normale];

    D --> F{Type d'interaction ?};
    F -->|Vidéo| G[Lecture de vidéo intégrée];
    F -->|Audio| H[Lecture d'audio];
    F -->|Quizz| I[Participer à un quiz];
    F -->|Animation| J[Voir une animation];

    G --> K{Fin du contenu ?};
    H --> K;
    I --> K;
    J --> K;

    K -->|Oui| L[Retour à la lecture];
    K -->|Non| D;

    E --> L;

    L --> M{Continuer ?};
    M -->|Oui| B;
    M -->|Non| N[Quitter le livre];

```

 Expérience littéraire enrichis de médias et d'interactions pour une lecture plus engageante.











