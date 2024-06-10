# Mini-framework MVC Elan
Pour visualiser cette documentation sur VSCode 
```
CTRL + SHIFT + V
```

## 📖 Table des matières
- [Mini-framework MVC Elan](#mini-framework-mvc-elan)
  - [📖 Table des matières](#-table-des-matières)
  - [✍️ Rappel des notions](#️-rappel-des-notions)
    - [✅ Design pattern (patron de conception)](#-design-pattern-patron-de-conception)
    - [✅ Modèle Vue Contrôleur (MVC)](#-modèle-vue-contrôleur-mvc)
    - [✅ Programmation orientée objet (POO)](#-programmation-orientée-objet-poo)
  - [✍️ Structure du framework et responsabilité de chaque couche de l'application](#️-structure-du-framework-et-responsabilité-de-chaque-couche-de-lapplication)
    - [✅ index.php](#-indexphp)
    - [✅ public](#-public)
    - [✅ App](#-app)
    - [✅ Controller](#-controller)
    - [✅ Model](#-model)
      - [⭐ Entities](#-entities)
      - [⭐ Managers](#-managers)
    - [✅ View](#-view)


## ✍️ Rappel des notions
### ✅ Design pattern (patron de conception)
A design pattern is a reusable solution to a common software design problem, providing a proven framework for solving similar problems. It provides a standardized way to describe good design practices, facilitating communication between developers. Design patterns promote the maintainability, flexibility, and scalability of software systems by providing proven design patterns.

### ✅ Modèle Vue Contrôleur (MVC)
The MVC (Model-View-Controller) design pattern is a *software architecture* that divides an application into three main components: the Model, which represents the data and business logic, the View, which displays the user interface, and the Controller, which acts as an intermediary between the Model and the View by handling user interactions and updating the Model accordingly. This pattern promotes separation of concerns, allowing for better organization of code, increased reusability and easier maintenance of applications.

### ✅ Programmation orientée objet (POO)
1. **Namespace / Use** :A *namespace* in PHP is a way to group classes, interfaces, functions and constants into a logical namespace to avoid name conflicts. Using the namespace keyword allows you to define a namespace, while the *use* keyword allows you to import a namespace into a file so you can use its elements without specifying the full path each time.

``` php
namespace Model\Entities;
use App\Entity;
```

2. **Classe Abstraite** et **Héritage** : An abstract class is a *class that cannot be instantiated* directly but can contain abstract methods and concrete methods.
Abstract methods are methods declared but not implemented in the abstract class, which means that child classes must implement them.
Inheritance is a concept in object-oriented programming that allows a class (called a child class or subclass) to inherit the properties and methods of another class (called a parent class or superclass). This allows code reuse and the creation of class hierarchies.

``` php
/* app/AbstractController.php */
namespace App;

abstract class AbstractController
```
``` php
/* controller/HomeController.php */
namespace Controller;
use App\AbstractController;

class HomeController extends AbstractController
```

3. **Interface** : An interface in PHP is a *contract defining a set of methods* that the classes that implement it must provide. 
Unlike abstract classes, interfaces do not contain method implementations, only their signatures. A class can implement multiple interfaces.

```php	
/* app/ControllerInterface.php */
namespace App;

interface ControllerInterface{

    public function index();
}
```

``` php
/* controller/HomeController.php */
namespace Controller;

use App\AbstractController;
use App\ControllerInterface;
use Model\Managers\UserManager;

class HomeController extends AbstractController implements ControllerInterface
```

4. **Classe Finale** : A final class is a class that cannot be extended. This means that no other class can inherit from this final class. We generally use this concept when we want to prevent a class from being modified or extended.

``` php
/* model/entities/Category.php */
namespace Model\Entities;

use App\Entity;

final class Category extends Entity
```

5. **Autoloader** : The autoloader is a mechanism in PHP that allows classes to be automatically loaded when they are used, without needing to manually include the files that define them. This simplifies the class loading process and avoids manual inclusion errors.
6. **Hydratation** : hydration is a process where data is used to initialize an object. In PHP, this generally means taking data from an external source (like a database) and using it to populate an object's properties.

``` php
/* app/Entity.php */
namespace App;

abstract class Entity {
    protected function hydrate($data){ /* code */ }
}
```

## ✍️ Structure du framework et responsabilité de chaque couche de l'application

### ✅ index.php
The index.php file at the root of our framework will allow us to define all the constants necessary for our initial configuration, session management, support for HTTP requests from the client as well as the exit delay to load our views the right way.

Each HTTP request in our browser will have the following form:

```
http://serveur/projet/index.php?ctrl=home&action=index&id=x
```

- the argument **"ctrl"** designates the controller to call (without "Controller", in our example "home" for "HomeController"): otherwise it will be HomeController which will be called if no argument is passed
- the argument **"action"** designates the controller method to call (pay attention to case!). In our example, we call the "index" method of "HomeController". If the action is not specified, the "index" method will be invoked.
- the argument **"id"** designates the desired identifier if the method requires passing an argument of this type.

<u>Exemple</u> : afficher la liste des topics d'une catégorie :
```
http://serveur/projet/index.php?ctrl=forum&action=listTopicsByCategory&id=3
```
renverra la liste des topics de la catégorie 3 (la méthode "listTopicsByCategory" sera ici implémentée dans "ForumController").

### ✅ public
Le dossier public contiendra tous les assets nécessaires à notre projet
- fichiers CSS
- fichiers JavaScript
- images
- ...

### ✅ App
The "app" folder contains all the classes necessary for the proper functioning of the framework and thus provide generic classes and methods to avoid having to repeat portions of code.
- **AbstractController.php**: provides 2 methods for role restriction and a method facilitating redirection <br>
So we can implement this:
 
``` php
// Donner accès à la méthode "users" uniquement aux utilisateurs qui ont le rôle ROLE_USER
public function users(){
    $this->restrictTo("ROLE_USER");
}
```
ou
``` php
// Rediriger vers la méthode login du controller "SecurityController"
$this->redirectTo("security", "login");
```

- **Autoloader.php**: allows autoloading of project classes (called in index.php)
- **ControllerInterface.php**: allows you to impose the "index" method on the controllers that implement it
- **DAO.php**: provides all generic methods that interact with the database: connection, SELECT, INSERT, UPDATE, DELETE
- **Entity.php**: provides the method for hydrating the project's class instances (transforming an associative array into an object or collection of objects as would an ORM like Doctrine in Symfony)
- **Manager.php**: provides methods for returning the results of the Manager to the corresponding Controller
- **Session.php**: provides methods relating to the session (flash messages and user management) <br>
The following method allows you to verify that a user is logged in:

``` php
public static function getUser(){
    return (isset($_SESSION['user'])) ? $_SESSION['user'] : false;
}
```
Et ainsi vérifier ceci directement dans un controller : 
``` php
/* controller */
if(\App\Session::getUser())
```
ou directement dans une vue du projet :
``` php
/* view */
($topic->getUser()->getId() == App\Session::getUser()->getId())
```

### ✅ Controller
Les controllers permettent d'intercepter / prendre en charge la requête HTTP émise par le client (à travers index.php).
Chaque controller (namespace Controller) doit hériter d'AbstractController et implémenter ControllerInterface

``` php
/* controller/HomeController.php */
class HomeController extends AbstractController implements ControllerInterface
```

Chaque controller va implémenter "ControllerInterface" et devra donc posséder toutes les méthodes de celle-ci (en l'occurence dans notre cas, la méthode "index").
Nous remarquerons que le controller fait bien le lien avec la vue correspondante à travers le 1er argument du tableau retourné "view"

``` php
/* controller/HomeController.php */
public function index(){
    return [
        "view" => VIEW_DIR."home.php",
        "meta_description" => "Page d'accueil du forum"
    ];
}
```

Dans cet exemple plus complet, nous implémentons la méthode <u>**listTopicsByCategory($id)**</u>.
- Nous instancions les managers nécessaires (ici TopicManager et CategoryManager)
- Nous récupérons les objets fournis par la méthode du manager correspondant (voir la partie [Managers](#managers) de la documentation)
- Nous transmettons les informations à la vue "listTopics.php" 

``` php
/* controller/ForumController.php */
public function listTopicsByCategory($id) {

    $topicManager = new TopicManager();
    $categoryManager = new CategoryManager();
    $category = $categoryManager->findOneById($id);
    $topics = $topicManager->findTopicsByCategory($id);

    return [
        "view" => VIEW_DIR."forum/listTopics.php",
        "meta_description" => "Liste des topics par catégorie : ".$category,
        "data" => [
            "category" => $category,
            "topics" => $topics
        ]
    ];
}
```

### ✅ Model
#### ⭐ Entities
Chaque table de la base de données doit avoir son équivalent sous forme de classe (namespace Model\Entities). Chaque entité doit hériter de la classe Entity (App). Chaque entité a le même constructeur qui hydrate les objets de la classe concernée (la méthode hydrate appartient à la classe parent "Entity" et peut être donc utilisée par héritage). On génère les getters et les setters pour toutes les propriétés de la classe et on ajoute un __toString() pour faciliter nos affichages

``` php
/* model/entities/Category.php */
namespace Model\Entities;

use App\Entity;

final class Category extends Entity{

    private $id;
    private $name;

    // chaque entité aura le même constructeur grâce à la méthode hydrate (issue de App\Entity)
    public function __construct($data){         
        $this->hydrate($data);        
    }

    public function getId()
    {
        return $this->id;
    }

    public function setId($id)
    {
        $this->id = $id;

        return $this;
    }
```

#### ⭐ Managers
Les managers sont responsables de l'interaction avec la base de données.
Comme tous les managers héritent de la classe abstraite "App\Manager", nul besoin de définir les méthodes classiques suivantes dans chaque manager : 
- **findAll(array $order)** : retourne une collection d'objets de la classe spécifiée dans le Manager. Possibilité de trier selon un ou plusieurs critères
- **findOneById(int $id)** : retourne un objet de la classe spécifiée dans le Manager (dont l'identifiant est passé en paramètre)
- **add(array $data)** : ajoute un enregistrement en base de données
- **delete(int $id)** : supprime un enregistrement en base de données (dont l'identifiant est passé en paramètre)
- ...

``` php
/* model/managers/CategoryManager.php */
namespace Model\Managers;

use App\Manager;
use App\DAO;

class CategoryManager extends Manager{

    // on indique la classe POO et la table correspondante en BDD pour le manager concerné
    protected $className = "Model\Entities\Category";
    protected $tableName = "category";

    public function __construct(){
        parent::connect();
    }
}
```

En revanche, si l'on a besoin d'exécuter des requêtes SQL spécifiques, nous pouvons implémenter nos propres méthodes dans le Manager de son choix. <br>

- Si la requête renvoie <u>**plusieurs enregistrements**</u>, par exemple la liste des topics par catégorie, on utilise la méthode getMultipleResults()

``` php
/* model/managers/TopicManager.php */
public function findTopicsByCategory($id) {

    $sql = "SELECT * 
            FROM ".$this->tableName." t 
            WHERE t.category_id = :id";
    
    return  $this->getMultipleResults(
        DAO::select($sql, ['id' => $id]), 
        $this->className
    );
}
```

- Si la requête renvoie <u>**un seul enregistrement**</u>, nous utiliserons la méthode getOneOrNullResult :

``` php
public function findOneElement($id) {

    $sql = "";
    
    return  $this->getOneOrNullResult(
        DAO::select($sql, ['id' => $id]), 
        $this->className
    );
}
```

### ✅ View
Le dossier "view" contiendra l'ensemble des vues du projet
- Nativement, un fichier "home.php" a été crée pour une base de page d'accueil

``` html 
<h1>BIENVENUE SUR LE FORUM</h1>

<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Sit ut nemo quia voluptas numquam, itaque ipsa soluta ratione eum temporibus aliquid, facere rerum in laborum debitis labore aliquam ullam cumque.</p>

<p>
    <a href="index.php?ctrl=security&action=login">Se connecter</a>
    <a href="index.php?ctrl=security&action=register">S'inscrire</a>
</p>
```

- le fichier "layout.php" permet d'implémenter la structure commune à l'ensemble des vues du projet : DOCTYPE, liens externes / internes (notamment librairies CSS et/ou Javascript), "meta" tags, navigation (avec les conditions potentielles concernant le rôle de l'utilisateur connecté par exemple), footer, gestion des messages de succès / d'erreur, etc.
- Toutes les vues héritent donc de "layout.php" concernant le squelette globale de la page et sont donc réduites au strict nécessaire : 

``` php
/* controller/ForumController.php */
$categories = $categoryManager->findAll(["name", "DESC"]);

// le controller communique avec la vue "listCategories" (view) pour lui envoyer la liste des catégories (data)
return [
    "view" => VIEW_DIR."forum/listCategories.php",
    "meta_description" => "Liste des catégories du forum",
    "data" => [
        "categories" => $categories
    ]
];
```

``` php
/* exemple pour lister toutes les catégories du forum */

// on initialise une variable permettant de récupérer ce que nous renvoie le controller à l'index "categories" du tableau de "data"
$categories = $result["data"]['categories']; 
<h1>Liste des catégories</h1>

foreach($categories as $category ){ ?>
    <p><a href="index.php?ctrl=forum&action=listTopicsByCategory&id=<?= $category->getId() ?>"><?= $category->getName() ?></a></p>
}
```


A vous de jouer ! 🚀