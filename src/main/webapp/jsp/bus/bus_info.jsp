<html lang="en">
<head>
    <title>Jquery - bootstrap Prompt modal using bootbox.js</title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-alpha/css/bootstrap.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.css" rel="stylesheet">
</head>
<body>
<div class="container text-center">
    <h2>Jquery - Sortable table rows example</h2>
    <table class="table table-bordered pagin-table">
        <thead>
        <tr>
            <th width="50px">No</th>
            <th>Name</th>
            <th width="220px">Action</th>
        </tr>
        </thead>
        <tbody>

        <tr>
            <td>1</td>
            <td>Hardik Savani</td>
            <td><a href="" class="btn btn-danger">Delete</a></td>
        </tr>
        <tr>
            <td>2</td>
            <td>Rajesh Savani</td>
            <td><a href="" class="btn btn-danger">Delete</a></td>
        </tr>
        <tr>
            <td>3</td>
            <td>Haresh Patel</td>
            <td><a href="" class="btn btn-danger">Delete</a></td>
        </tr>
        <tr>
            <td>4</td>
            <td>Vimal Patel</td>
            <td><a href="" class="btn btn-danger">Delete</a></td>
        </tr>
        <tr>
            <td>5</td>
            <td>Harshad Pathak</td>
            <td><a href="" class="btn btn-danger">Delete</a></td>
        </tr>
        </tbody>
    </table>
</div>
<script type="text/javascript">
    $('tbody .btn btn-danger').sortable();

    $(function() {
        var obj = document.getElementsByTagName("tr");
        if( obj.length >= 0 ){
            var orderList = "";
            for(var i=1; i< obj.length; i++) {

            }
        }

    });

</script>
</body>
</html>