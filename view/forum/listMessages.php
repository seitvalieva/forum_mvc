<?php
    $messages = $result["data"]['messages']; 
?>

<h1>Liste des messages</h1>

<?php
foreach($messages as $message ){ ?>
    <p><a href="#"><?= $message ?></a> par <?= $message->getUser() ?></p>
<?php }