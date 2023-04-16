
function formatMoney(a, e, r, t) {
    let n = ""
        , h = j = 0
        , u = tamanho2 = 0
        , l = ajd2 = ""
        , o = window.Event ? t.which : t.keyCode;
    if (13 == o || 8 == o)
        return !0;
    if (n = String.fromCharCode(o),
    -1 == "0123456789".indexOf(n))
        return !1;
    for (u = a.value.length,
             h = 0; h < u && ("0" == a.value.charAt(h) || a.value.charAt(h) == r); h++)
        ;
    for (l = ""; h < u; h++)
        -1 != "0123456789".indexOf(a.value.charAt(h)) && (l += a.value.charAt(h));
    if (l += n,
    0 == (u = l.length) && (a.value = ""),
    1 == u && (a.value = "0" + r + "0" + l),
    2 == u && (a.value = "0" + r + l),
    u > 2) {
        for (ajd2 = "",
                 j = 0,
                 h = u - 3; h >= 0; h--)
            3 == j && (ajd2 += e,
                j = 0),
                ajd2 += l.charAt(h),
                j++;
        for (a.value = "",
                 tamanho2 = ajd2.length,
                 h = tamanho2 - 1; h >= 0; h--)
            a.value += ajd2.charAt(h);
        a.value += r + l.substr(u - 2, u)
    }
    return !1
}

function formatNumber(n) {
    // format number 1000000 to 1,234,567
    return n.replace(/\D/g, "").replace(/\B(?=(\d{3})+(?!\d))/g, ",")
}
function formatCurrency(input, blur) {
    // appends $ to value, validates decimal side
    // and puts cursor back in right position.

    // get input value
    var input_val = input.value;

    // don't validate empty input
    if (input_val === "") { return; }

    // original length
    var original_len = input_val.length;

    // initial caret position
    var caret_pos = input.attr("selectionStart", true);


    // check for decimal
    if (input_val.indexOf(".") >= 0) {

        // get position of first decimal
        // this prevents multiple decimals from
        // being entered
        var decimal_pos = input_val.indexOf(".");

        // split number by decimal point
        var left_side = input_val.substring(0, decimal_pos);
        var right_side = input_val.substring(decimal_pos);

        // add commas to left side of number
        left_side = formatNumber(left_side);

        // validate right side
        right_side = formatNumber(right_side);

        // On blur make sure 2 numbers after decimal
        if (blur === "blur") {
            right_side += "00";
        }

        // Limit decimal to only 2 digits
        right_side = right_side.substring(0, 2);

        // join number by .
        input_val = "$" + left_side + "." + right_side;

    } else {
        // no decimal entered
        // add commas to number
        // remove all non-digits
        input_val = formatNumber(input_val);
        input_val = "$" + input_val;

        // final formatting
        if (blur === "blur") {
            input_val += ".00";
        }
    }

    // send updated string to input
    input.val(input_val);

    // put caret back in the right position
    var updated_len = input_val.length;
    caret_pos = updated_len - original_len + caret_pos;
    input[0].setSelectionRange(caret_pos, caret_pos);
}

function fillModal(taskName, taskId){
    document.getElementById("pText").innerHTML = "Atenção, deseja realmente excluir a tarefa " + "\"" + taskName + "\"" + " ? ";
    var link = document.getElementById("deleteLink");
    link.href = "/delete-task?id=" + taskId;
}
    function fillEditModal(taskId) {
        var serviceURL = '/get-task?id=' + taskId;
        $.ajax({
            type: "GET",
            url: serviceURL,
            data: param = "",
            contentType: "application/json; charset=utf-8",
            success: successFunc,
            error: errorFunc
        });
    }
    function successFunc(data, status) {
        document.getElementById("editTask-taskName").value = data.taskName;
        document.getElementById("editTask-taskCost").value = data.taskCost;
        document.getElementById("editTask-taskId").value = data.id;
        document.getElementById("editTask-ordenationPosition").value = data.ordenationPosition;
        var date = new Date(data.targetDate);
        document.getElementById("editTask-dataTarget").value = FormataStringData(date.toLocaleDateString());
    }
    function errorFunc(xhr, status, error) {
        var response = JSON.parse(xhr.responseText);

        alert(response.message);
    }

    function FormataStringData(data) {
        var dia  = data.split("/")[0];
        var mes  = data.split("/")[1];
        var ano  = data.split("/")[2];

        return ano + '-' + ("0"+mes).slice(-2) + '-' + ("0"+dia).slice(-2);
        // Utilizo o .slice(-2) para garantir o formato com 2 digitos.
    }



    function editTask(){
        var taskName = document.getElementById("editTask-taskName").value;
        var taskCost = document.getElementById("editTask-taskCost").value;
        var ordenationPosition = document.getElementById("editTask-ordenationPosition").value;
        const formattedValue = taskCost.replace(/\./g, '').replace(',', '.');
        taskCost = Number(formattedValue);
        var taskId = document.getElementById("editTask-taskId").value;
        var targetDate = document.getElementById("editTask-dataTarget").value;
        if(taskName.trim().length <= 0 || targetDate.trim().length <= 0){
            alert("Nenhum campo pode estar vazio.");
            return
        }
        if(taskCost <= 0){
            alert("Custo da tarefa inválido.");
            return
        }

        var data = JSON.stringify({
            "id": parseFloat(taskId),
            "taskName": taskName,
            "targetDate": targetDate,
            "ordenationPosition": ordenationPosition,
            "taskCost": parseFloat(taskCost)});
        console.log(data);
        var serviceURL = '/update-task';
        $.ajax({
            type: "POST",
            url: serviceURL,
            data: data,
            contentType: "application/json",
            success: successFuncEdit,
            error: errorFunc
        });

    }

    function successFuncEdit(){
        window.location.reload();
    }

    function orderTask(taskId, operation){
        var serviceURL = '/order-task?id=' + taskId + '&operation=' + operation;
        $.ajax({
            type: "POST",
            url: serviceURL,
            data: param = "",
            contentType: "application/json",
            success: successFuncEdit,
            error: errorFunc
        });
    }

    function submitForm(){
        var value = document.getElementById("taskCost").value;
        const formattedValue = value.replace(/\./g, '').replace(',', '.');
        document.getElementById("taskCost").value = Number(formattedValue);
        var frm = document.forms[1];
        frm.submit();
    }