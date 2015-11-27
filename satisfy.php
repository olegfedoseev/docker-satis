<?php
$app = require_once __DIR__ . '/bootstrap.php';
/**
 * Homepage, shows satis index.html file if available
 * and adds a link to satisfy backend.
 */
$app->get('/', function () use ($app) {
    $indexPath = __DIR__ . '/../web/index.html';
    if (file_exists($indexPath)) {
        return file_get_contents($indexPath);
    }
    return <<<HTML404
<html>
    <head>
        <title>Composer Repository currently not available</title>
    </head>
    <body>
        <h1>Composer Repository currently not available.</h1>
        <p><a href="/admin/">Manage Repositories</a></p>
    </body>
</html>
HTML404;
})->bind('home');

$app->get('/build/', function () use ($app) {
    $cmd = '/var/www/satisfy/bin/satis -n build /var/www/satisfy/satis.json /var/www/satisfy/web';
    echo '<pre>';
    system($cmd, $retval);
    echo '</pre>';
    echo '<hr />Exit code:';
    var_dump($retval);
    return '';
})->bind('build');

$app->mount('/admin/', new \Playbloom\Satisfy\Controller\SecurityController());
$app->mount('/admin/', new \Playbloom\Satisfy\Controller\RepositoryController());
return $app;
