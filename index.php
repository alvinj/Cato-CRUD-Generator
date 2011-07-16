<?php

# TODO after lots of refactoring, i'm just handing things over to the MainController
require_once 'MainController.php';

# get root_path, smarty_dir, template_dir
require_once 'app.cfg';

# TODO probably don't need to create $smarty here after recent refactoring
require($smarty_dir . '/Smarty.class.php');
$smarty = new Smarty();

$ctrl = new MainController();
$ctrl->display_form($template_dir, $smarty);

?>

