<?php 
$lab            = getenv('HOST_LAB','localhost:8888/lab');
$mlflow         = getenv('HOST_MLFLOW');
$theia          = getenv('HOST_THEIA');
$minio          = getenv('HOST_MINIO');
$database       = getenv('HOST_DATABASE');
$tensorboard    = getenv('HOST_TENSORBOARD');
$airflow        = getenv('HOST_AIRFLOW');
?>

<!DOCTYPE html>
<html>
<head>
    <title>AI Workspace</title> 
    <link media="all"  rel="stylesheet" href="style.css" />
</head> 
<body>
 
    <div id="navigation">
        <div id="title">AI Workspace</div>
        <nav>
            <ul>
                <?php if(!empty($lab)) { ?>
                <li><a href="http://<?php echo $lab ?>" target="content">Jupyter</a></li>
                <?php } ?>
                <?php if(!empty($theia)) { ?>
                <li><a href="http://<?php echo $theia ?>" target="content">IDE</a></li>
                <?php } ?>
                <?php if(!empty($mlflow)) { ?>
                <li><a href="http://<?php echo $mlflow ?>" target="content">MLFlow</a></li>
                <?php } ?>
                <?php if(!empty($minio)) { ?>
                <li><a href="http://<?php echo $minio ?>" target="content">MinIO</a></li>
                <?php } ?>
                <?php if(!empty($tensorboard)) { ?>
                <li><a href="http://<?php echo $tensorboard ?>" target="content">Tensorboard</a></li>
                <?php } ?>
                <?php if(!empty($database)) { ?>
                <li><a href="http://<?php echo $database ?>" target="content">Database</a></li>
                <?php } ?>
                <?php if(!empty($airflow)) { ?>
                <li><a href="http://<?php echo $airflow ?>" target="content">Airflow</a></li>
                <?php } ?>
            </ul>
        </nav>
    </div>

    <div id="frameContainer">
    <iframe src="http://<?php echo $lab ?>" name="content" id="main_iframe"></iframe>
    </div>
</body>
</html>
