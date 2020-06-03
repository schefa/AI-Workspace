<?php 
$lab            = getenv('HOST_LAB','localhost:8888/lab');
$mlflow         = getenv('HOST_MLFLOW');
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
                <li><a href="http://<?php echo $lab ?>" target="content">Jupyter</a></li>
                <li><a href="http://<?php echo $mlflow ?>" target="content">MLFlow</a></li>
                <li><a href="http://<?php echo $minio ?>" target="content">MinIO</a></li>
                <li><a href="http://<?php echo $tensorboard ?>" target="content">Tensorboard</a></li>
                <li><a href="http://<?php echo $database ?>" target="content">Database</a></li>
                <li><a href="http://<?php echo $airflow ?>" target="content">Airflow</a></li>
            </ul>
        </nav>
    </div>

    <div id="frameContainer">
    <iframe src="http://<?php echo $lab ?>" name="content" id="main_iframe"></iframe>
    </div>
</body>
</html>
