<?php
$app['satis.filename'] = __DIR__.'/../satis.json';
$app['satis.file_formatting'] = JSON_PRETTY_PRINT;
$app['satis.auditlog'] = __DIR__.'/data';
$app['satis.class'] = 'Playbloom\\Satisfy\\Model\\Configuration';
$app['composer.repository.type_default'] = 'git';
$app['composer.repository.url_default'] = '';
$app['repository.pattern'] = '.*';
$app['auth.use_login_form'] = false;

// Default credentials are: admin / foo.
// $app['auth.users'] = array(
//     'admin' => '0beec7b5ea3f0fdbc95d0dd47f3c5bc275da8a33',
//     'john' => 'd6b4e84ee7f31d88617a6b60421451272ebf1a3a',
// );
// $app['auth'] = $app->share(function() {
//     return function($username) {
//         return (bool) preg_match('/@domain\.tld$/', $username);
//     };
// });
