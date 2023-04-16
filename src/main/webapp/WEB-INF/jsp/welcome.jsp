<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>

<head>

  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

  <title>Gerenciador de Tarefas Fatto</title>
  <meta charset="UTF-8">
</head>

<body class="d-flex flex-column h-100">

  <main role="main" class="flex-shrink-0">
    <div class="container">
      <h1 class="mt-5">Olá ${name}, bem vindo ao gerenciador de tarefas da Fatto.</h1>
      <p class="lead"><a href="/list-tasks">Clique aqui</a> para começar a gerenciar suas tarefas.</p>
    </div>
  </main>
  <div style="font-size: 1000px; text-align: center;">
    <img src="https://blush.design/api/download?shareUri=ewlktq1jla9wIdDz&c=Bottom_0%7E89c5cc-0.1%7E393f82-0.2%7E393f82_Hair_0%7E181658-0.1%7Ee8e1e1-0.2%7E2c1b18_Skin_0%7Edcae92-0.1%7E57331f-0.2%7E57331f_Top_0%7Eff4133-0.1%7Ef2f2f2-0.2%7Ef2f2f2&w=800&h=800&fm=png" />
  </div>
  <footer class="footer mt-auto py-3">
    <div class="container">
      <hr>
      <p>Você pode encontrar o repositório público deste projeto em meu<a href="https://github.com/Joaobds/technical-test-fatto"> GitHub.</a></p>
    </div>
  </footer>
  <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>

</html>