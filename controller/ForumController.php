<?php
namespace Controller;

use App\Session;
use App\AbstractController;
use App\ControllerInterface;
use Model\Managers\TopicManager;
use Model\Managers\PostManager;

class ForumController extends AbstractController implements ControllerInterface{

    public function index() {
        
        // créer une nouvelle instance de CategoryManager
        $topicManager = new TopicManager();
        // récupérer la liste de toutes les catégories grâce à la méthode findAll de Manager.php (triés par nom)
        $topics = $topicManager->findAll(["publicationDate", "DESC"]);

        // le controller communique avec la vue "listCategories" (view) pour lui envoyer la liste des catégories (data)
        return [
            "view" => VIEW_DIR."forum/listTopics.php",
            "meta_description" => "Liste des topics du forum",
            "data" => [
                "topics" => $topics
            ]
        ];
    }

    public function listMessagesByTopic($id) {

        $topicManager = new TopicManager();
        $messageManager = new MessageManager();
        $topic = $topicManager->findOneById($id);
        $messages = $messageManager->findMessagesByTopic($id);

        return [
            "view" => VIEW_DIR."forum/listMessages.php",
            "meta_description" => "Liste des messages par topic : ".$topic,
            "data" => [
                "topic" => $topic,
                "messages" => $messages
            ]
        ];
    }
}