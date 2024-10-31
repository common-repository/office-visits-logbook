<?php
    if(isset($_COOKIE['dragon_visit_submitform_Result']) && $_COOKIE['dragon_visit_submitform_Result'] !== null && $_COOKIE['dragon_visit_submitform_Result'] !== 'success') {
        $dragon_visit_submitform_Result = sanitize_text_field($_COOKIE['dragon_visit_submitform_Result']);
        setcookie('dragon_visit_submitform_Result', '', time() - 42000, '/', '', true, true);
        unset($_COOKIE['dragon_visit_submitform_Result']);
    }
    $activeconstants = dragonvisitzyx987_getAllSettings(true);
    $settings = [];
    $settings["USE_BOOTSTRAP_JS"] = '1';
    $settings["USE_BOOTSTRAP_CSS"] = '1';
    foreach ($activeconstants as $constant) { 
        if($constant->name === 'USE_BOOTSTRAP_JS') {
            $settings["USE_BOOTSTRAP_JS"] = $constant->value;
        }elseif($constant->name === 'USE_BOOTSTRAP_CSS') {
            $settings["USE_BOOTSTRAP_CSS"] = $constant->value;
        }
    }
    wp_enqueue_script('jquery');
    wp_enqueue_script('jquery-ui');
    wp_enqueue_script('jquery-ui-dialog'); 
    wp_enqueue_style('wp-jquery-ui-dialog');
    wp_enqueue_script('jquery-ui-core2', includes_url() . 'js/jquery/ui/core.min.js');
    wp_enqueue_script('jquery-ui-widget2', includes_url() . 'js/jquery/ui/widget.min.js');
    wp_enqueue_script('jquery-ui-mouse2', includes_url() . 'js/jquery/ui/mouse.min.js');
    wp_enqueue_script('jquery-ui-slider2', includes_url() . 'js/jquery/ui/slider.min.js');
    wp_enqueue_script('jquery-ui-sortable2', includes_url() . 'js/jquery/ui/sortable.min.js');
    wp_enqueue_script('jquery-ui-draggable2', includes_url() . 'js/jquery/ui/draggable.min.js');
    wp_enqueue_script('jquery-ui-droppable2', includes_url() . 'js/jquery/ui/droppable.min.js');
    wp_enqueue_script('jquery-ui-datepicker2', includes_url() . 'js/jquery/ui/datepicker.min.js');
    wp_enqueue_script('jquery-ui-datetimepicker2', plugins_url('js/jquery.datetimepicker.full.min.js', __FILE__ ));
    if($settings["USE_BOOTSTRAP_JS"] === '1') {
        wp_enqueue_script('custom-script-bootstrap', plugins_url('bootstrap/js/bootstrap.min.js', __FILE__ ));
    }
    wp_enqueue_script('custom-script-visit', plugins_url('js/visit.js', __FILE__ ));
    function high_priority_style2($mysettings) {
        if($mysettings["USE_BOOTSTRAP_CSS"] === '1') {
            wp_enqueue_style('bootstrap', plugins_url('bootstrap/css/bootstrap.min.css', __FILE__ ));
            wp_enqueue_style('bootstrap-icons', plugins_url('bootstrap/css/bootstrap-icons.css', __FILE__ ));
        }
        wp_enqueue_style('jquery-ui2', plugins_url('css/jquery-ui.css', __FILE__ ));
        wp_enqueue_style('jquery-datetimepicker2', plugins_url('css/jquery.datetimepicker.min.css', __FILE__ ));
        wp_enqueue_style('dragonvisit', plugins_url('css/dragonvisit.css?v=' . date('Ymd'), __FILE__ ));
    }
    add_action('wp_enqueue_scripts', function() use ($settings) {high_priority_style2( $settings );}, 999);
    get_header(); ?>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="csrf-token" content="">
<script>
var mytemp = "<?php echo dragonvisitzyx987_getConstants('LANGUAGE'); ?>", mylang = "en", mytrans = {};
if(mytemp === "bp") {
    mylang = "pt";
} else if(mytemp === "zhs" || mytemp === "zht") {
    mylang = "ch";
} else if(mytemp === "") {
    mylang = "en";
    mytemp = "en";
}
var master_totalpagenumber;

if(mytemp === "en") {
    mytrans.Myweek = {"Mon":"Mon","Tue":"Tue","Wed":"Wed","Thu":"Thu","Fri":"Fri","Sat":"Sat","Sun":"Sun"};
    mytrans.Week = "Week";
    mytrans.Submit = "Submit";
    mytrans.Cancel = "Cancel";
    mytrans.Submitting = "Submitting";
    mytrans.From = "From";
    mytrans.To = "To";
    mytrans.from = "from";
    mytrans.to = "to";
    mytrans.Up = "Up";
    mytrans.Down = "Down";
    mytrans.Remove = "Remove";
    mytrans.VisitsavedPostedtoallwebhooks = "Visit saved. Posted to all webhooks.";
    mytrans.VisitsavedPostedtosomeofthewebhooks = "Visit saved. Posted to some of the webhooks.";
    mytrans.VisitsavedNowebhooksavailable = "Visit saved. No webhooks available.";
    mytrans.YoualreadysavedsometimeperioddataintodatabaseDuplicatedPleasecreateagain = "You already saved some time period data into database. Duplicated. Please create again.";
    mytrans.NotallthedatacanbesavedintodatabasePleasecreateagain = "Not all the data can be saved into database. Please create again.";
    mytrans.Thisrecordisnotyours = "This record is not yours.";
    mytrans.ErrorPleasecreateagain = "Error. Please create again.";
    mytrans.ErrorPleasetryagain = "Error. Please try again.";
    mytrans.Requestfailed = "Request failed";
    mytrans.Pleaserefreshthepageandtryagain = "Please refresh the page and try again.";
    mytrans.Pleaseenterdatetimeinfo = "Please enter date time info.";
    mytrans.PleaseenterMondaySundayorSaturday = "Please enter Monday, Sunday or Saturday.";
    mytrans.Timeisnotcontinuousatdate = "Time is not continuous at date";
    mytrans.StartTimeEmpty = "Start time is empty";
    mytrans.EndTimeEmpty = "End time is empty";
    mytrans.EndTimeEarlierThanStartTime = "End time is earlier than start time.";
    mytrans.StartTimeWrongDateFormat = "Start time has a wrong date format.";
    mytrans.EndTimeWrongDateFormat = "End time has a wrong date format.";    
    mytrans.Pleasefillallthedatefirst = "Please fill all the date first!";
    mytrans.Areyousureyouwanttodeletethis = "Are you sure you want to delete this ";
    mytrans.DeleteTarget = {"visit":"visit","typecategory":"type category","type":"type","user":"user","role":"role","division":"division"};
    mytrans.Areyousureyouwanttoimpersonateasthisuser = "Are you sure you want to impersonate as this user?";
    mytrans.Chooseoneuser = "Choose one user";
    mytrans.Chooseonetype = "Choose one type";
    mytrans.Onlyshowoneusersworkhourschart = "Only show one user's work/hours chart";
    mytrans.Onlyshowonetypesuserhourschart = "Only show one type's user/hours chart";
    mytrans.showchart = "show chart";
    mytrans.removeallchart = "remove all chart";
    mytrans.Fromdate = "From date";
    mytrans.Todate = "To date";
    mytrans.nodata = "no data";
    mytrans.Hours = "Hours";
    mytrans.UserName = "User Name";
    mytrans.Name = "Name";
    mytrans.Desc = "Desc";
    mytrans.Approved = "Approved";
    mytrans.Approvedby = "Approved by";
    mytrans.ApprovedTime = "Approved Time";
    mytrans.ReviewNotes = "Review Notes";
    mytrans.Status = "Status";
    mytrans.Created = "Created";
    mytrans.ID = "ID";
    mytrans.Review = "Review";
    mytrans.Youdidnotchangeanything = "You did not change anything.";
    mytrans.Youdidnotenteranything = "You did not enter anything.";
    mytrans.Youmustchooseatarget = "You must choose a target.";
    mytrans.duplicate = "duplicate";
    mytrans.Pleasedraganddroptypesfromtherightside = "Please drag and drop types from the right side.";
    mytrans.Pleasedraganddropusersfromtherightside = "Please drag and drop users from the right side.";
    mytrans.Pleaseentertypecategoryandorname = "Please enter type category and/or name.";
} else if(mytemp === "bp") {
    mytrans.Myweek = {"Mon":"Seg","Tue":"Ter","Wed":"Qua","Thu":"Qui","Fri":"Sex","Sat":"Sab","Sun":"Dom"};
    mytrans.Week = "Semana";
    mytrans.Submit = "Enviar";
    mytrans.Cancel = "Cancelar";
    mytrans.Submitting = "Enviando";
    mytrans.From = "de";
    mytrans.To = "para";
    mytrans.from = "de";
    mytrans.to = "para";
    mytrans.Up = "Acima";
    mytrans.Down = "Baixa";
    mytrans.Remove = "Retirar";
    mytrans.VisitsavedPostedtoallwebhooks = "Quadro de horários salvo. Publicado em todos os webhooks.";
    mytrans.VisitsavedPostedtosomeofthewebhooks = "Quadro de horários salvo. Publicado em alguns dos webhooks.";
    mytrans.VisitsavedNowebhooksavailable = "Quadro de horários salvo. Não há webhooks disponíveis.";
    mytrans.YoualreadysavedsometimeperioddataintodatabaseDuplicatedPleasecreateagain = "Você já salvou alguns dados do período no banco de dados. Duplicado. Por favor, crie novamente.";
    mytrans.NotallthedatacanbesavedintodatabasePleasecreateagain = "Nem todos os dados podem ser salvos no banco de dados. Por favor, crie novamente.";
    mytrans.Thisrecordisnotyours = "Este registro não é seu.";
    mytrans.ErrorPleasecreateagain = "Erro. Por favor, crie novamente.";
    mytrans.ErrorPleasetryagain = "Erro. Por favor, tente novamente.";
    mytrans.Requestfailed = "Falha no pedido";
    mytrans.Pleaserefreshthepageandtryagain = "Atualize a página e tente novamente.";
    mytrans.Pleaseenterdatetimeinfo = "Digite as informações de data e hora.";
    mytrans.PleaseenterMondaySundayorSaturday = "Por favor, insira segunda, domingo ou sábado.";
    mytrans.Timeisnotcontinuousatdate = "O tempo não é contínuo na data";
    mytrans.StartTimeEmpty = "A hora de início está vazia";
    mytrans.EndTimeEmpty = "O horário de término está vazio";
    mytrans.EndTimeEarlierThanStartTime = "O horário de término é anterior ao horário de início.";
    mytrans.StartTimeWrongDateFormat = "A hora de início tem um formato de data errado.";
    mytrans.EndTimeWrongDateFormat = "A hora de término tem um formato de data errado.";    
    mytrans.Pleasefillallthedatefirst = "Por favor preencha toda a data primeiro!";
    mytrans.Areyousureyouwanttodeletethis = "Tem certeza de que deseja excluir esta ";
    mytrans.DeleteTarget = {"visit":"planilha de horário","typecategory":"categorias","type":"tipo","user":"usuário","role":"função","division":"divisão"};
    mytrans.Areyousureyouwanttoimpersonateasthisuser = "Tem certeza de que deseja se passar por esse usuário?";
    mytrans.Chooseoneuser = "Escolha um usuário";
    mytrans.Chooseonetype = "Olha um tipo";
    mytrans.Onlyshowoneusersworkhourschart = "Mostrar apenas o gráfico de horas/trabalho de um usuário";
    mytrans.Onlyshowonetypesuserhourschart = "Mostrar apenas o gráfico de horas/usuário de um tipo";
    mytrans.showchart = "mostrar gráfico";
    mytrans.removeallchart = "remover todo o gráfico";
    mytrans.Fromdate = "Do dia";
    mytrans.Todate = "Até dia";
    mytrans.nodata = "sem dados";
    mytrans.Hours = "Horas";        
    mytrans.UserName = "Nome de Usuário";
    mytrans.Name = "Nome";
    mytrans.Desc = "Descrição";
    mytrans.Approved = "Aprovado";
    mytrans.Approvedby = "Aprovado por";
    mytrans.ApprovedTime = "Data Aprovação";
    mytrans.ReviewNotes = "Notas de Revisão";
    mytrans.Status = "Status";
    mytrans.Created = "Criado";
    mytrans.ID = "ID";
    mytrans.Review = "Revisão";
    mytrans.Youdidnotchangeanything = "Você não mudou nada.";
    mytrans.Youdidnotenteranything = "Você não inseriu nada.";
    mytrans.Youmustchooseatarget = "Você deve escolher um alvo.";
    mytrans.duplicate = "duplicada";
    mytrans.Pleasedraganddroptypesfromtherightside = "Arraste e solte tipos do lado direito.";
    mytrans.Pleasedraganddropusersfromtherightside = "Arraste e solte os usuários do lado direito.";
    mytrans.Pleaseentertypecategoryandorname = "Digite a categoria e / ou nome do tipo.";
} else if(mytemp === "zhs") {
    mytrans.Myweek = {"Mon":"周一","Tue":"周二","Wed":"周三","Thu":"周四","Fri":"周五","Sat":"周六","Sun":"周日"};
    mytrans.Week = "周";
    mytrans.Submit = "提交";
    mytrans.Cancel = "取消";
    mytrans.Submitting = "正在提交";
    mytrans.From = "从";
    mytrans.To = "到";
    mytrans.from = "从";
    mytrans.to = "到";
    mytrans.Up = "上移";
    mytrans.Down = "下移";
    mytrans.Remove = "删除";
    mytrans.VisitsavedPostedtoallwebhooks = "时间表保存。自动发送了数据到所有的另外的网站。";
    mytrans.VisitsavedPostedtosomeofthewebhooks = "时间表已保存。自动发送了数据到部分的另外的网站。";
    mytrans.VisitsavedNowebhooksavailable = "时间表已保存。没有另外的网站用来发送数据。";
    mytrans.YoualreadysavedsometimeperioddataintodatabaseDuplicatedPleasecreateagain = "你以前已经存了某些时间段的数据。数据重复。请重新创建。";
    mytrans.NotallthedatacanbesavedintodatabasePleasecreateagain = "不是所有数据能存入数据库。请重新创建。";
    mytrans.Thisrecordisnotyours = "这记录不是您的。";
    mytrans.ErrorPleasecreateagain = "错误。请重新创建。";
    mytrans.ErrorPleasetryagain = "错误。请重试。";
    mytrans.Requestfailed = "请求失败";
    mytrans.Pleaserefreshthepageandtryagain = "请刷新网页重试。";
    mytrans.Pleaseenterdatetimeinfo = "请输入日期时间信息。";
    mytrans.PleaseenterMondaySundayorSaturday = "请输入周一，周日，或者周六。";
    mytrans.Timeisnotcontinuousatdate = "在这个日期时间不连续";
    mytrans.StartTimeEmpty = "起始时间为空";
    mytrans.EndTimeEmpty = "终止时间为空";
    mytrans.EndTimeEarlierThanStartTime = "终止时间比起始时间早。";
    mytrans.StartTimeWrongDateFormat = "错误的起始时间。";
    mytrans.EndTimeWrongDateFormat = "错误的终止时间。";    
    mytrans.Pleasefillallthedatefirst = "请先填写所有日期!";
    mytrans.Areyousureyouwanttodeletethis = "你确定你想删除这个";
    mytrans.DeleteTarget = {"visit":"时间表","typecategory":"类别","type":"具体类型","user":"用户","role":"角色","division":"部门"};
    mytrans.Areyousureyouwanttoimpersonateasthisuser = "你确定你想用这个用户登录？";
    mytrans.Chooseoneuser = "选一个用户";
    mytrans.Chooseonetype = "选择一个具体类型";
    mytrans.Onlyshowoneusersworkhourschart = "只显示一个用户的图表";
    mytrans.Onlyshowonetypesuserhourschart = "只显示一个具体类型的图表";
    mytrans.showchart = "显示图表";
    mytrans.removeallchart = "删除所有图表";
    mytrans.Fromdate = "起始日期";
    mytrans.Todate = "终止日期";
    mytrans.nodata = "没有数据";
    mytrans.Hours = "小时";
    mytrans.UserName = "用户名";
    mytrans.Name = "名字";
    mytrans.Desc = "描述";
    mytrans.Approved = "通过";
    mytrans.Approvedby = "审阅人";
    mytrans.ApprovedTime = "审阅时间";
    mytrans.ReviewNotes = "审阅意见";
    mytrans.Status = "状态";
    mytrans.Created = "建立";
    mytrans.ID = "ID";
    mytrans.Review = "审阅";
    mytrans.Youdidnotchangeanything = "您什么都没改。";
    mytrans.Youdidnotenteranything = "您什么都没输入。";
    mytrans.Youmustchooseatarget = "您必须选择一个。";
    mytrans.duplicate = "重复";
    mytrans.Pleasedraganddroptypesfromtherightside = "请从右侧拖放具体类型到左侧。";
    mytrans.Pleasedraganddropusersfromtherightside = "请从右侧拖放用户到左侧。";
    mytrans.Pleaseentertypecategoryandorname = "请输入类别和/或名称。";
} else if(mytemp === "zht") {
    mytrans.Myweek = {"Mon":"週一","Tue":"週二","Wed":"週三","Thu":"週四","Fri":"週五","Sat":"週六","Sun":"週日"};
    mytrans.Week = "週";
    mytrans.Submit = "提交";
    mytrans.Cancel = "取消";
    mytrans.Submitting = "正在提交";
    mytrans.From = "從";
    mytrans.To = "到";
    mytrans.from = "從";
    mytrans.to = "到";
    mytrans.Up = "上移";
    mytrans.Down = "下移";
    mytrans.Remove = "刪除";
    mytrans.VisitsavedPostedtoallwebhooks = "時間表保存。自動發送了數據到所有的另外的網站。";
    mytrans.VisitsavedPostedtosomeofthewebhooks = "時間表已保存。自動發送了數據到部分的另外的網站。";
    mytrans.VisitsavedNowebhooksavailable = "時間表已保存。沒有另外的網站用來發送數據。";
    mytrans.YoualreadysavedsometimeperioddataintodatabaseDuplicatedPleasecreateagain = "你以前已經存了某些時間段的數據。數據重複。請重新創建。";
    mytrans.NotallthedatacanbesavedintodatabasePleasecreateagain = "不是所有數據能存入數據庫。請重新創建。";
    mytrans.Thisrecordisnotyours = "這記錄不是您的。";
    mytrans.ErrorPleasecreateagain = "錯誤。請重新創建。";
    mytrans.ErrorPleasetryagain = "錯誤。請重試。";
    mytrans.Requestfailed = "請求失敗";
    mytrans.Pleaserefreshthepageandtryagain = "請刷新網頁重試。";
    mytrans.Pleaseenterdatetimeinfo = "請輸入日期時間信息。";
    mytrans.PleaseenterMondaySundayorSaturday = "請輸入週一，週日，或者週六。";
    mytrans.Timeisnotcontinuousatdate = "在這個日期時間不連續";
    mytrans.StartTimeEmpty = "起始時間為空";
    mytrans.EndTimeEmpty = "終止時間為空";
    mytrans.EndTimeEarlierThanStartTime = "終止時間比起始時間早。";
    mytrans.StartTimeWrongDateFormat = "錯誤的起始時間。";
    mytrans.EndTimeWrongDateFormat = "錯誤的終止時間。";
    mytrans.Pleasefillallthedatefirst = "請先填寫所有日期!";
    mytrans.Areyousureyouwanttodeletethis = "你確定你想刪除這個";
    mytrans.DeleteTarget = {"visit":"時間表","typecategory":"類別","type":"具體類型","user":"用戶","role":"角色","division":"部門"};
    mytrans.Areyousureyouwanttoimpersonateasthisuser = "你確定你想用這個用戶登錄？";
    mytrans.Chooseoneuser = "選一個用戶";
    mytrans.Chooseonetype = "選擇一個具體類型";
    mytrans.Onlyshowoneusersworkhourschart = "只顯示一個用戶的圖表";
    mytrans.Onlyshowonetypesuserhourschart = "只顯示一個具體類型的圖表";
    mytrans.showchart = "顯示圖表";
    mytrans.removeallchart = "刪除所有圖表";
    mytrans.Fromdate = "起始日期";
    mytrans.Todate = "終止日期";
    mytrans.nodata = "沒有數據";
    mytrans.Hours = "小時";
    mytrans.UserName = "用戶名";
    mytrans.Name = "名字";
    mytrans.Desc = "描述";
    mytrans.Approved = "通過";
    mytrans.Approvedby = "審閱人";
    mytrans.ApprovedTime = "審閱時間";
    mytrans.ReviewNotes = "審閱意見";
    mytrans.Status = "狀態";
    mytrans.Created = "建立";
    mytrans.ID = "ID";
    mytrans.Review = "審閱";
    mytrans.Youdidnotchangeanything = "您什麼都沒改。";
    mytrans.Youdidnotenteranything = "您什麼都沒輸入。";
    mytrans.Youmustchooseatarget = "您必須選擇一個。";
    mytrans.duplicate = "重複";
    mytrans.Pleasedraganddroptypesfromtherightside = "請從右側拖放具體類型到左側。";
    mytrans.Pleasedraganddropusersfromtherightside = "請從右側拖放用戶到左側。";
    mytrans.Pleaseentertypecategoryandorname = "請輸入類別和/或名稱。";
}

jQuery(document).ready(function(){
    jQuery('input.datepicker').datepicker({dateFormat:"yy-mm-dd"});
    jQuery('input.datetimepicker').each(function(){
        jQuery(this).datetimepicker({
            scrollMonth: false,
            scrollInput: false,
            format:'Y-m-d H:i'
        });
    });
    var myurl = window.location.href, result;
    if(myurl.indexOf("://") !== -1) {
        myurl = myurl.split("://", 2)[1];
    }

    if(myurl.indexOf("/index.php") !== -1) {
        result = myurl.split("/index.php").slice(-1)[0];
    } else {
        result = myurl.split("/", 2)[1];
    }
    result = result.replace("/", "");

    if(result.indexOf('/') !== -1) {
        result = result.split("/")[0];
    } else if(result.indexOf('?') !== -1) {
        result = result.split("?")[0];
    }

    jQuery('div#navbarCollapse li').removeClass('active');
    jQuery('div#homeicon').removeClass('active');

    if(result === '') {
        jQuery('div#homeicon').addClass('active');
    } else {
        if(result !== 'access' && result !== 'user' && result !== 'role' && result !== 'division'){
            jQuery('li#' + result).addClass('active');
        } else {
            jQuery('li#setting').addClass('active');
            jQuery('li#' + result).addClass('active');
        }
    }

    if(jQuery('div.master_pwrapper').length > 0) {
        jQuery('div.master_pwrapper').on( 'click', 'div.master_mypagination > ul.pagination > li:not(.noborder):not(.disabled)', function () {
            var topagenumber = isNaN(parseInt(jQuery(this).text())) ? 0 : parseInt(jQuery(this).text());
            var currentpage;
            if(jQuery(this).hasClass('prev')){
                currentpage = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination > ul.pagination > li.active > a').first().text());
                topagenumber = Math.max(1, (currentpage-1));
            } else if (jQuery(this).hasClass('next')){ 
                currentpage = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination > ul.pagination > li.active > a').first().text());
                topagenumber = Math.min(master_totalpagenumber, (currentpage+1));
            }
            master_showResultOnReloadedPage('', topagenumber);
        });
    }

    if(jQuery('div#master_show_result').length > 0) {
        jQuery('div#master_show_result').on( 'click', 'table th i', function () {
            var class0 = 'fa fa-sort';
            var mysortby = jQuery(this).parent().attr('class');
            var myorder = '';
            if(jQuery(this).hasClass('fa-sort')){
                myorder = 'asc';
            } else if(jQuery(this).hasClass('fa-sort-asc')){
                myorder = 'desc';
            } else if(jQuery(this).hasClass('fa-sort-desc')){
                myorder = 'asc';
            }
            master_showResultOnReloadedPage('', 1, mysortby, myorder);
        });
    }

    jQuery("ul.navbar-right > li.dropdown > ul.dropdown-menu > li > select#master_lang").click(function(event){
        // Avoid following the href location when clicking
        event.preventDefault(); 
        // Avoid having the menu to close when clicking
        event.stopPropagation(); 
        jQuery('ul.navbar-right > li.dropdown > ul.dropdown-menu').show();
    });

    jQuery("ul.navbar-right > li.dropdown > ul.dropdown-menu > li > select#master_lang").keyup(function(event){
        // Avoid following the href location when clicking
        event.preventDefault(); 
        // Avoid having the menu to close when clicking
        event.stopPropagation(); 
        jQuery('ul.navbar-right > li.dropdown > ul.dropdown-menu').show();
    });

});

//a - amount per page; o - order (asc, desc); pg - page number; st - sortby; n - search visitor name; r - search visit reason; status - visit status
//f - from date; t - to date;
function master_createPagination(totalpagenumber, topagenumber) {
    if(totalpagenumber !== parseInt(totalpagenumber, 10) || topagenumber !== parseInt(topagenumber, 10) || totalpagenumber <= 1) {jQuery('div.master_pwrapper > div.master_mypagination').html('');return;}
    var temp = '<ul class="pagination">',i;
    if(topagenumber > totalpagenumber) {topagenumber = totalpagenumber;}
    if(totalpagenumber < 7) {
        temp += '<li class="' + (topagenumber===1 ? 'disabled' : 'prev') + '"><a>&lt;</a></li>';
        for(i=1;i<=totalpagenumber;i++) {
            temp += '<li' + (topagenumber===i ? ' class="active" ' : '') + '><a>' + i + '</a></li>';
        }
        temp += '<li class="' + (topagenumber===totalpagenumber ? 'disabled' : 'next') + '"><a>&gt;</a></li>';
    } else if(topagenumber < 4) {
        temp += '<li class="' + (topagenumber===1 ? 'disabled' : 'prev') + '"><a>&lt;</a></li>';
        for(i=1;i<=5;i++) {
            temp += '<li' + (topagenumber===i ? ' class="active" ' : '') + '><a>' + i + '</a></li>';
        }
        temp += ((totalpagenumber - topagenumber) > 3) ? '<li class="noborder"><a>...</a></li>' : '';
        temp += '<li' + (topagenumber===totalpagenumber ? ' class="active" ' : '') + '><a>' + totalpagenumber + '</a></li><li class="' + (topagenumber===totalpagenumber ? 'disabled' : 'next') + '"><a>&gt;</a></li>';
    } else if(topagenumber < (totalpagenumber - 2)) {
        temp += '<li class="' + (topagenumber===1 ? 'disabled' : 'prev') + '"><a>&lt;</a></li><li' + (topagenumber===1 ? ' class="active" ' : '') + '><a>1</a></li>';
        temp += (topagenumber > 4) ? '<li class="noborder"><a>...</a></li>' : '';
        for(i=(topagenumber-2);i<=((topagenumber+2)>(totalpagenumber-1) ? (totalpagenumber-1) : (topagenumber+2));i++) {
            temp += '<li' + (topagenumber===i ? ' class="active" ' : '') + '><a>' + i + '</a></li>';
        }
        temp += ((totalpagenumber - topagenumber) > 3) ? '<li class="noborder"><a>...</a></li>' : '';
        temp += '<li' + (topagenumber===totalpagenumber ? ' class="active" ' : '') + '><a>' + totalpagenumber + '</a></li><li class="' + (topagenumber===totalpagenumber ? 'disabled' : 'next') + '"><a>&gt;</a></li>';
    } else if(topagenumber >= (totalpagenumber - 2)) {
        temp += '<li class="' + (topagenumber===1 ? 'disabled' : 'prev') + '"><a>&lt;</a></li>';
        temp += '<li' + (topagenumber===1 ? ' class="active" ' : '') + '><a>1</a></li>';
        temp += ((topagenumber - 1) > 3) ? '<li class="noborder"><a>...</a></li>' : '';
        for(i=(totalpagenumber-4);i<=totalpagenumber;i++) {
            temp += '<li' + (topagenumber===i ? ' class="active" ' : '') + '><a>' + i + '</a></li>';
        }
        temp += '<li class="' + (topagenumber===totalpagenumber ? 'disabled' : 'next') + '"><a>&gt;</a></li>';
    }
    temp += '</ul>';
    if(jQuery('div.master_pwrapper > div.master_mypagination').length > 0) {
        jQuery('div.master_pwrapper > div.master_mypagination').html(temp);
    }
}

function master_showResultOnReloadedPage(type, pagenumber, mysortby, myorder) {
    var mydata = {}, temp1 = '';
    mydata['p'] = pagenumber ? pagenumber : 1;
    mydata['s'] = (mysortby === undefined) ? '' : mysortby;
    mydata['o'] = (myorder === undefined) ? '' : myorder;
    mydata['a'] = jQuery('select#master_amountperpage').find(":selected").val();

    if (mysortby === undefined && myorder === undefined) {
        jQuery('div#master_show_result table th i').each(function () {
            if(jQuery(this).hasClass('fa-sort-asc')){
                mydata['o'] = 'asc';
                mydata['s'] = jQuery(this).parent().attr('class');
            } else if(jQuery(this).hasClass('fa-sort-desc')){
                mydata['o'] = 'desc';
                mydata['s'] = jQuery(this).parent().attr('class');
            }
        });
    }
    var str = jQuery.param(mydata);
    //console.log('at 453, str: ' + str);
    var mytemp = window.location.href.split('?');
    window.location.href = mytemp[0] + '?' + str;
}

function master_switchLang() {
    var mylang = jQuery('select#master_lang').find(":selected").val(), myurl = window.location.href, result, myurl2, myheader2 = "", result2;
    if(myurl.indexOf("://") !== -1) {
        myurl = myurl.split("://", 2)[1];
    }

    if(myurl.indexOf("/index.php") !== -1) {
        result = myurl.split("/index.php").slice(-1)[0];
    } else {
        result = myurl.split("/", 2)[1];
    }
    result = result.replace("/", "");

    if(result.indexOf('/') !== -1) {
        result = result.split("/")[0];
    } else if(result.indexOf('?') !== -1) {
        result = result.split("?")[0];
    }

    jQuery('div#navbarCollapse li').removeClass('active');
    jQuery('div#homeicon').removeClass('active');

    if(result === '') {
        result = 'visit';
    }

    myurl2 = window.location.href;

    if(myurl2.indexOf("://") !== -1) {
        myheader2 = myurl2.split("://", 2)[0] + "://";
        myurl2 = myurl2.split("://", 2)[1];
    } else {
        myheader2 = "http://";
    }

    if(myurl2.indexOf("/index.php") !== -1) {
        result2 = myurl2.split("/index.php", 2)[0] + "/index.php";
    } else {
        result2 = myurl2.split("/", 2)[0];
    }

    jQuery('form#form_switchlang').attr('action', myheader2 + result2 + '/visit/switchLang?lang=' + mylang);
    jQuery('form#form_switchlang').submit();
}

function obj2string(obj) {
    var temp = '{', temp0 = '';
    for(var v in obj) {
        if (obj.hasOwnProperty(v)) {
            if(obj[v] !== null && typeof obj[v] !== 'string') {
                temp0 += '"' + v + '":' + obj2string(obj[v]) + ',';
            } else {
                temp0 += '"' + v + '":"' + obj[v] + '",';
            }
        }
    }
    temp0 = temp0.substring(0, temp0.length - 1);
    temp += temp0 + '}';
    return temp;
}

function obj2stringFull(obj) {
    var temp = '{', temp0 = '';
    for(var v in obj) {
        if (obj.hasOwnProperty(v)) {
            if(obj[v] !== null && typeof obj[v] === 'object') {
                temp0 += '"' + v + '":' + obj2string(obj[v]) + ',';
            } else {
                temp0 += '"' + v + '":"' + obj[v] + '",';
            }
        }
    }
    temp0 = temp0.substring(0, temp0.length - 1);
    temp += temp0 + '}';
    return temp;
}

function master_delete(element, id, name, mypluginurl, myajaxurl, my_dragonvisitzyx987_deleteVisit_nonce) {
    var mytempname = typeof mytrans.DeleteTarget[name] === "undefined" ? "" : (mytrans.DeleteTarget[name] === null ? "" : mytrans.DeleteTarget[name]);
    if(confirm(mytrans.Areyousureyouwanttodeletethis + mytempname + "?")) {
        var finaldata = {};
        finaldata["id"] = id;
        finaldata['action'] = "dragonvisitzyx987_deleteVisit"; 
        finaldata['dragonvisitzyx987_hidden_security_deletevisit'] = my_dragonvisitzyx987_deleteVisit_nonce || '';
        finaldata['dragonvisitzyx987_hidden'] = "Y";
        //console.log('at 543, finaldata: ' + JSON.stringify(finaldata));
        jQuery.ajax({
            method: "POST",
            url: myajaxurl,
            data: finaldata
        })
        .done(function( msg ) {
            //console.log("at 550, msg: " + msg );
            if(msg === 'Success') {
                window.location.href = mypluginurl;
            } else {
                alert(msg);
            }
        })
        .fail(function( jqXHR, textStatus ) {
            alert( mytrans.Requestfailed + ": " + textStatus + ". " + mytrans.Pleaserefreshthepageandtryagain);
        });
    }
}

function master_impersonate(element, id, name) {
    if(confirm(mytrans.Areyousureyouwanttoimpersonateasthisuser)) {
        var mytemp = window.location.href.replace(/\/create/,'');
        var mytemp2 = mytemp.replace(/\/edit\/.*$/,'');
        window.location.href = mytemp2 + '/impersonate/' + id; 
    }
}

function enableDoubleClickDrop(sourceElement, targetElement) {
    jQuery(sourceElement).dblclick(function(){
        var temp = jQuery(this).attr('id').split("_");
        var category = (temp.length == 2) ? temp[0] : '';
        var id = (temp.length == 2) ? temp[1] : '';
        var temp2 = '<div class="inline scrolloverflow">' + mytrans.From + ': <input type="text" class="timepicker starttime" value="" />';
        temp2 += '  ' + mytrans.To + ': <input type="text" class="timepicker endtime" value="" /></div>';
        temp2 += '<span class="bold left-name ' + 'cat_' + category + '_' + id + '">' + jQuery(this).text() + '</span>';
        temp2 += '<a class="up-left-item" href="javascript:void(0);" onclick="upParent(this);"><i class="fa fa-arrow-up font24px" aria-hidden="true" title="' + mytrans.Up + '"></i></a>';
        temp2 += '<a class="down-left-item" href="javascript:void(0);" onclick="downParent(this);"><i class="fa fa-arrow-down font24px" aria-hidden="true" title="' + mytrans.Down + '"></i></a>';                        
        temp2 += '<a class="remove-left-item" href="javascript:void(0);" onclick="removeParent(this);"><i class="fa fa-trash-o font24px" aria-hidden="true" title="' + mytrans.Remove + '"></i></a>';
        var newDiv = '<div class="left-item ' + category + ' ' + ((temp.length == 2) ? jQuery(this).attr('id') : '') +'">' + temp2 + '</div>';
        jQuery(targetElement).append(newDiv);
        jQuery('input.timepicker').each(function(){
            jQuery(this).datetimepicker({
                format:'H:i',
                datepicker:false,
            });
        });
    }); 
}

function upParent(element) {
    jQuery(element).parent().insertBefore(jQuery(element).parent().prev());
}

function downParent(element) {
    jQuery(element).parent().insertAfter(jQuery(element).parent().next());
}

function removeParent(element) {
    jQuery(element).parent().remove();
}
</script>
<style>
.table-hover > tbody > tr:hover {
    background-color: #fff8d6;
}

.table-hover > tbody > tr > td.active:hover,
.table-hover > tbody > tr > th.active:hover,
.table-hover > tbody > tr.active:hover > td,
.table-hover > tbody > tr:hover > .active,
.table-hover > tbody > tr.active:hover > th {
    background-color: #fff8d6;
}
</style>
<noscript><style>div.container {display:none}</style>
    <font face=arial>JavaScript must be enabled in order for you to use this website. However, it seems JavaScript is either disabled or not supported by your browser. To use this website, enable JavaScript by changing your browser options, then <a href="">try again</a>.</font>
    <font face=arial>O JavaScript deve estar ativado para que você possa usar este site. No entanto, parece que o JavaScript está desativado ou não é suportado pelo seu navegador. Para usar este site, ative o JavaScript alterando as opções do navegador e, em seguida, <a href="">tente novamente</a>.</font>
    <font face=arial>必须启用JavaScript才能使用此网站。但是，您的浏览器似乎禁用了JavaScript或不支持JavaScript。要使用此网站，请通过更改浏览器选项来启用JavaScript，然后 <a href="">重试</a>.</font>
    <font face=arial>必須啟用JavaScript才能使用此網站。但是，您的瀏覽器似乎禁用了JavaScript或不支持JavaScript。要使用此網站，請通過更改瀏覽器選項來啟用JavaScript，然後 <a href="">重試</a>.</font>
</noscript>
<div class="contentcontainer">