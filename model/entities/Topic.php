<?php
namespace Model\Entities;

use App\Entity;

/*
    En programmation orientée objet, une classe finale (final class) est une classe que vous ne pouvez pas étendre, c'est-à-dire qu'aucune autre classe ne peut hériter de cette classe. En d'autres termes, une classe finale ne peut pas être utilisée comme classe parente.
*/

final class Topic extends Entity{

    private $id;
    private $titleTopic;
    // private $category;
    private $publicationDate;
    private $user;              // cle etrangere  user_id
    // private $closed;

    public function __construct($data){         
        $this->hydrate($data);        
    }

    /**
     * Get the value of id
     */ 
    public function getId(){
        return $this->id;
    }

    /**
     * Set the value of id
     *
     * @return  self
     */ 
    public function setId($id){
        $this->id = $id;
        return $this;
    }

    /**
     * Get the value of titleTopic
     */ 
    public function getTitleTopic()
    {
        return $this->titleTopic;
    }

    /**
     * Set the value of titleTopic
     *
     * @return  self
     */ 
    public function setTitleTopic($titleTopic)
    {
        $this->titleTopic = $titleTopic;

        return $this;
    }
    /**
     * Get the value of publicationDate
     */ 
    public function getPublicationDate()
    {
        return $this->publicationDate;
    }

    /**
     * Set the value of publicationDate
     *
     * @return  self
     */ 
    public function setPublicationDate($publicationDate)
    {
        $this->publicationDate = $publicationDate;

        return $this;
    }
    /**
     * Get the value of user
     */ 
    public function getUser(){
        return $this->user;
    }

    /**
     * Set the value of user
     *
     * @return  self
     */ 
    public function setUser($user){
        $this->user = $user;
        return $this;
    }
    
    public function __toString(){
        return $this->titleTopic;
    }


}