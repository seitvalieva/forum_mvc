<?php
    $topics = $result["data"]['topics']; 
?>

<h1>Liste des topics</h1>

<?php

foreach($topics as $topic ){ ?>

    <p><a href="index.php?ctrl=forum&action=listMessagesByTopic&id=<?= $topic->getId() ?>">
        <?= $topic ?></a> par <?= $topic->getUser() ?>
        <?= date('d-m-Y H:i:s', strtotime($topic->getPublicationDate())) ?><br></p>
<?php }
