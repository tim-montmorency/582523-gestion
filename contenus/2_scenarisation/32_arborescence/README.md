# Arborescence

Une arborescence des fichiers bien structurée et une nomenclature cohérente sont des éléments essentiels dans la gestion d’un projet multimédia, surtout dans le cadre d’installations interactives où plusieurs types de médias sont utilisés. Ces pratiques facilitent non seulement la gestion des ressources, mais permettent aussi de collaborer plus efficacement et d'assurer la maintenance du projet.

## Définir l'arborescence des fichiers

L’arborescence des fichiers correspond à la structure hiérarchique des dossiers dans lesquels les fichiers multimédia sont organisés. Une bonne arborescence doit être claire, intuitive, et adaptée aux besoins du projet, en tenant compte des types de médias (vidéos, sons, images, etc.), des séquences du scénario, et des interactions prévues.

### Exemple d'arborescence utilisée dans l'industrie multimédia

Une structure d’arborescence type pourrait ressembler à ceci :

```
/projet_multimedia
    /assets
        /videos
        /sons
        /images
        /3D
    /scenario
    /scenarimage
    /export
        /final
        /versions
    /references
```

Cette structure permet :
- **/assets** : de regrouper tous les fichiers sources par catégorie de média.
- **/scenario et /scenarimage** : de séparer les éléments narratifs et de préproduction.
- **/export** : d’organiser les fichiers finaux ou les rendus intermédiaires pour éviter les confusions entre les différentes versions d’un fichier.
- **/references** : d'ajouter des éléments de références visuelles ou sonores.

Dans une installation interactive, des sous-dossiers supplémentaires peuvent être créés pour distinguer les éléments interactifs ou ceux qui nécessitent des déclenchements spécifiques par l’utilisateur.

### Arborescence pour une installation interactive

Voici un exemple relativement générique qui pourrait s'appliquer à une installation interactive :

```
/installation_interactive
    /medias
        /videos
            /intro
            /transitions
            /boucles
        /sons
            /effets
            /ambiances
        /images
            /textures
            /backgrounds
    /interactions
        /capteurs
        /cameras
    /scripts
        /declencheurs
        /animations
        /standby
```

Cette structure permet de :
- **/medias** : organiser les différents types de contenus utilisés dans l’installation.
- **/interactions** : regrouper les fichiers liés aux dispositifs interactifs.
- **/scripts** : centraliser les scripts et les déclencheurs de l’installation.
