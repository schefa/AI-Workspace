<?php

$user = getenv('PMA_USERNAME');
$password = getenv('PMA_PASSWORD');
$host = getenv('PMA_HOST');

$cfg['AllowThirdPartyFraming'] = true;

$i = 0;

$i++;

$cfg['Servers'][$i]['auth_type'] = 'config';
$cfg['Servers'][$i]['host'] = $host;
$cfg['Servers'][$i]['user'] = $user;
$cfg['Servers'][$i]['password'] = $password;
$cfg['Servers'][$i]['AllowNoPassword'] = true;
