<?php
// Provide some variables for properly running behind non http proxy.
$_SERVER['HTTPS'] = 0;
$_SERVER['ssl'] = false;
$_SERVER['SERVER_NAME'] = 'localhost';