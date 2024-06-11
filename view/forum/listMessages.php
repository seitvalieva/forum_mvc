<?php
    $topic = $result["data"]['topic']; 
    $messages = $result["data"]['messages']; 
?>

<h1>Liste des messages</h1>

<?php
    foreach($messages as $message ) { ?>
       
        <?= $topic->getUser() ?>
        <?= date('d-m-Y H:i:s', strtotime($message->getPostDate())) ?><br>
        <?= $message->getTextMessage() ?><br><br>
        <?php }