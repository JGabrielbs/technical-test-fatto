<%@ page import="com.example.listtasksactivity.model.Task" %>
<%@ page import="com.example.listtasksactivity.model.ErrorMessage" %>

<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script><%@include file = "../common/script.js"%></script>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap-responsive.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
<script src="https://kit.fontawesome.com/14aa1ab862.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="../common/style.css">
<script>
    $(document).ready(function(){
        $('.datepicker').datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true,
            startDate: '0d',
            locale: 'pt-br'
        });
    });

</script>
<html>
<head>
  <meta name="viewport">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
  <title>Gerenciador de Tarefas Fatto</title>
  <meta charset="UTF-8">
</head>
<body>
<c:if test="${not empty param.message}">
    <div class="alert alert-danger">
        <span id="errorMessage">${param.message}</span>
    </div>
    <c:set var="message" value="${null}" />
</c:if>
<div class="container table-responsive py-5">
    <form:form action="/" method="get">
    <div class="row" style="margin-left: auto;">
        <button type="submit" class="btn btn-primary btn-lg">Página Inicial</button>
    </div>
    <br>
    <div class="row" style="margin-left: auto;">
        <i style="margin-right: 5px; color: #ff6347;" class="fa-sharp fa-solid fa-circle"></i>
        Linhas em vermelho representam tarefas com custo maior que R$1.0000.
    </div>
    </form:form>
    <br>
    <table class="table">
      <thead class="">
        <tr>
          <th scope="col" style="text-align: center;">Código da Tarefa</th>
          <th scope="col" style="text-align: center;">Nome da Tarefa</th>
          <th scope="col" style="text-align: center;">Custo</th>
          <th scope="col" style="text-align: center;">Data Limite</th>
          <th scope="col" colspan="3"></th>
        </tr>
      </thead>
      <tbody>
      <c:choose>
          <c:when test="${tasks.size() > 0}">
              <c:forEach items="${tasks}" var="task" varStatus="loop">
                  <tr>
                      <c:choose>
                          <c:when test="${task.taskCost >= 1000}">
                              <td style=" text-align: center; background-color:  #ff6347;">${task.id}</td>
                              <td style="background-color:  #ff6347;">${task.taskName}</td>
                              <td style="text-align: center; background-color:  #ff6347;"><fmt:formatNumber value="${task.taskCost}" type="currency" currencySymbol="R$"/></td>
                              <td style="text-align: center; background-color:  #ff6347;"><fmt:formatDate value="${task.targetDate}" pattern="dd/MM/yyyy"/></td>
                              <td style="text-align: center; background-color:  #ff6347; cursor: pointer;" title="Editar">
                                  <button type="button" class="btn btn-success" onclick="fillEditModal('${task.id}')" data-toggle="modal" data-target="#editModal">
                                      <i class="fa-solid fa-pencil"></i>
                                  </button>
                              </td>
                              <td style="text-align: center; background-color:  #ff6347; cursor: pointer;" title="Excluir">
                                  <button type="button" class="btn btn-danger" onclick="fillModal('${task.taskName}', '${task.id}')" data-toggle="modal" data-target="#deleteModal">
                                      <i class="fa-solid fa-trash-can"></i>
                                  </button>
                              </td>
                              <td style="text-align: center; background-color:  #ff6347; cursor: pointer;">
                                  <c:choose>
                                      <c:when test="${loop.first}">
                                          <i class="fa-solid fa-chevron-up" style="opacity: 0.5; pointer-events: none;"></i>
                                      </c:when>
                                      <c:otherwise>
                                          <i class="fa-solid fa-chevron-up" onclick="orderTask('${task.id}', 'up')" title="Subir Tarefa"></i>
                                      </c:otherwise>
                                  </c:choose>
                                  <c:choose>
                                      <c:when test="${loop.last}">
                                          <i class="fa-solid fa-chevron-down" style="opacity: 0.5; pointer-events: none;"></i>
                                      </c:when>
                                      <c:otherwise>
                                          <i class="fa-solid fa-chevron-down" onclick="orderTask('${task.id}', 'down')" title="Descer Tarefa"></i>
                                      </c:otherwise>
                                  </c:choose>
                              </td>
                          </c:when>
                          <c:otherwise>
                              <td style="text-align: center;">${task.id}</td>
                              <td>${task.taskName}</td>
                              <td style="text-align: center;"><fmt:formatNumber value="${task.taskCost}" type="currency" currencySymbol="R$"/></td>
                              <td style="text-align: center;"><fmt:formatDate value="${task.targetDate}" pattern="dd/MM/yyyy"/></td>
                              <td style="text-align: center; cursor: pointer;" title="Editar">
                                  <button type="button" class="btn btn-success" onclick="fillEditModal('${task.id}')" data-toggle="modal" data-target="#editModal">
                                      <i class="fa-solid fa-pencil"></i>
                                  </button>
                              </td>
                              <td style="text-align: center; cursor: pointer;" title="Excluir">
                                  <button type="button" class="btn btn-danger" onclick="fillModal('${task.taskName}', '${task.id}')" data-toggle="modal" data-target="#deleteModal">
                                      <i class="fa-solid fa-trash-can"></i>
                                  </button>
                              </td>
                              <td style="text-align: center; cursor: pointer;">
                                  <c:choose>
                                      <c:when test="${loop.first}">
                                          <i class="fa-solid fa-chevron-up" style="opacity: 0.5; pointer-events: none;"></i>
                                      </c:when>
                                      <c:otherwise>
                                          <i class="fa-solid fa-chevron-up" onclick="orderTask('${task.id}', 'up')" title="Subir Tarefa"></i>
                                      </c:otherwise>
                                  </c:choose>
                                  <c:choose>
                                      <c:when test="${loop.last}">
                                          <i class="fa-solid fa-chevron-down" style="opacity: 0.5; pointer-events: none;"></i>
                                      </c:when>
                                      <c:otherwise>
                                            <i class="fa-solid fa-chevron-down" onclick="orderTask('${task.id}', 'down')" title="Descer Tarefa"></i>
                                      </c:otherwise>
                                  </c:choose>
                              </td>
                          </c:otherwise>
                      </c:choose>
                  </tr>
              </c:forEach>
          </c:when>
          <c:otherwise>
              <tr>
                  <td colspan="6" style="text-align: center;"><b>Oops. Parece que você não tem nenhuma tarefa no momento.</b></td>
              </tr>
          </c:otherwise>
      </c:choose>
      </tbody>
    </table>
    <div class="row" style="margin-left: auto;">
      <button data-toggle="modal" data-target="#exampleModal" class="btn btn-primary btn-lg">Registrar Nova Tarefa</button>
    </div>
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Registrar nova tarefa.</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
              <form:form action="/add-task" method="post" modelAttribute="newTask">
              <form:hidden path="id" />
              <div class="modal-body">
                  <div class="form-group">
                      <form:label path="taskName">Título da Tarefa:</form:label>
                      <form:errors path="taskName" cssClass="text-warning" type="text" class="form-control" required="required" />
                      <fmt:formatNumber var="taskName" value='${newTask.taskCost}' type='both'/>
                      <form:input path="taskName" type="text" class="form-control"/>
                  </div>
                  <div class="form-group">
                      <form:label path="taskCost"><b>R$</b>Custo:</form:label>
                      <form:input path="taskCost" value="" id="taskCost" onkeypress="return(formatMoney(this,'.',',',event))" type="text" class="form-control" required="required"/>
                      <form:errors path="taskCost" cssClass="text-warning" />
                  </div>
                  <div class="form-group">
                      <form:label path="targetDate">Data Limite:</form:label>
                      <form:input path="targetDate" type="text" class="form-control datepicker" required="required" />
                      <form:errors path="targetDate" cssClass="text-warning" />
                  </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-success" onclick="submitForm()">Criar Tarefa</button>
              </div>
            </form:form>
        </div>
      </div>
    </div>
    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModallLabel">Editar Tarefa.</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div style="padding: 10px 10px 10px 10px;">
                    <input type="hidden" id="editTask-taskId" name="editTask-taskId" value="">
                    <input type="hidden" id="editTask-ordenationPosition" name="editTask-ordenationPosition" value="">

                    <div class="form-group">
                        <label for="editTask-taskName" class="col-form-label">Título da Tarefa:</label>
                        <input type="text" class="form-control" id="editTask-taskName"  value="" required>
                    </div>
                    <div class="form-group">
                        <label for="editTask-taskCost" class="col-form-label"><b>R$</b> Custo:</label>
                        <input class="form-control" id="editTask-taskCost" value="" onkeypress="return(formatMoney(this,'.',',',event))" type="text"  required>
                    </div>
                    <div class="form-group">
                        <label for="editTask-dataTarget" class="col-form-label">Data Limite:</label>
                        <input type="date" class="form-control" id="editTask-dataTarget"  value="" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-success" onclick="editTask()">Editar Tarefa</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Exclusão de tarefa</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <span id="pText"></span>
                </div>
                    <input name="idToDelete" id="idToDelete" type="hidden" value="">
                    <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Não</button>
                    <a class="btn btn-danger" href="#" id="deleteLink">Sim</a>
                </div>
            </div>
        </div>
    </div>
    </div>
</body>
</html>