/****  Variables Initiation  ****/
var doc = document;
var docEl = document.documentElement;
var $sidebar = $('.sidebar');
var $mainContent = $('.main-content');
var $sidebarWidth = $(".sidebar").width();
var is_RTL = false;
if($('body').hasClass('rtl'))  is_RTL = true;

/* ==========================================================*/
/* PLUGINS                                                   */
/* ========================================================= */

(function($) {
    $.fn.autogrow = function() {
        return this.each(function() {
            var textarea = this;
            $.fn.autogrow.resize(textarea);
            $(textarea).focus(function() {
                textarea.interval = setInterval(function() {
                    $.fn.autogrow.resize(textarea);
                }, 500);
            }).blur(function() {
                clearInterval(textarea.interval);
            });
        });
    };
    $.fn.autogrow.resize = function(textarea) {
        var lineHeight = parseInt($(textarea).css('line-height'), 10);
        var lines = textarea.value.split('\n');
        var columns = textarea.cols;
        var lineCount = 0;
        $.each(lines, function() {
            lineCount += Math.ceil(this.length / columns) || 1;
        });
        var height = lineHeight * (lineCount + 1);
        $(textarea).css('height', height);
    };
})(jQuery);

/**** Color Picker ****/
function colorPicker(){
    if ($('.color-picker').length && $.fn.spectrum) {
        $('.color-picker').each(function () {
            var current_palette = '';
            if($(this).data('palette')){
                current_palette = $(this).data('palette');
            }
            $(this).spectrum({
                color: $(this).data('min') ? $(this).data('min') : "#D15ADE",
                showInput: $(this).data('show-input') ? $(this).data('show-input') : false,
                showPalette: $(this).data('show-palette') ? $(this).data('show-palette') : false,
                showPaletteOnly: $(this).data('show-palette-only') ? $(this).data('show-palette-only') : false,
                showAlpha: $(this).data('show-alpha') ? $(this).data('show-alpha') : false,
                palette: $(this).data('palette') ? $(this).data('palette') : [[current_palette]]
            });
            $(this).show();
        });
    }
}

// ELEMENTS ANIMATION WHEN APPEAR ON SCREEN
function appearEffect(){
    // Element Animation when Visible
    if ($.fn.appear) {
        setTimeout(function() {
            $('.animated, .countup, progress').appear({
                force_process: true
            });
        }, 300);
        setTimeout(function() {
            $('.circular-bar, .dial').appear({
                force_process: true
            });
        }, 1000);
    }


    $('.animated').on('appear', function(event, $allAppearedElements) {
        var element = $(this),
            animation = element.data('animation'),
            animationDelay = element.data('animation-delay');
        if (animationDelay) {
            setTimeout(function() {
                element.addClass(animation + ' visible');
            }, animationDelay);
        } else {
            element.addClass(animation + ' visible');
        }
    });
}

// PROGRESS BAR & CIRCLE
function handleProgress(){
    // PROGRESS BAR ANIMATION
    $('progress').on('appear', function(event, $allAppearedElements) {
        var progressBar = $(this),
            animationDelay = progressBar.data('animation-delay');
        if (animationDelay) {
            setTimeout(function() {
                progressBar.css('width', progressBar.attr('value') + '%');
                progressBar.parent().find('.progress-value').css('opacity', 1);
            }, animationDelay);
        } else {
            progressBar.css('width', progressBar.attr('value') + '%');
            progressBar.parent().find('.progress-value').css('opacity', 1);
        }
    });
    $('.progress.visible').each(function(){
        var progressBar = $(this).find('progress');
        progressBar.css('width', progressBar.attr('value') + '%');
        progressBar.parent().find('.progress-value').css('opacity', 1);
    });
}

/**** Numeric Stepper ****/
function numericStepper(){
    if ($('.numeric-stepper').length && $.fn.TouchSpin) {
        $('.numeric-stepper').each(function () {
            $(this).TouchSpin({
                min: $(this).data('min') ? $(this).data('min') : 0,
                max: $(this).data('max') ? $(this).data('max') : 100,
                step: $(this).data('step') ? $(this).data('step') : 0.1,
                decimals: $(this).data('decimals') ? $(this).data('decimals') : 0,
                boostat: $(this).data('boostat') ? $(this).data('boostat') : 5,
                maxboostedstep: $(this).data('maxboostedstep') ? $(this).data('maxboostedstep') : 10,
                verticalbuttons: $(this).data('vertical') ? $(this).data('vertical') : false,
                buttondown_class: $(this).data('btn-before') ? 'btn btn-' + $(this).data('btn-before') : 'btn btn-default',
                buttonup_class: $(this).data('btn-after') ? 'btn btn-' + $(this).data('btn-after') : 'btn btn-default',
            });
        });
    }
}

/**** Sortable Portlets ****/
function sortablePortlets(){
    if ($('.portlets').length && $.fn.sortable) {
        $( ".portlets" ).sortable({
            connectWith: ".portlets",
            handle: ".panel-header",
            items:'div.panel',
            placeholder: "panel-placeholder",
            opacity: 0.5,
            dropOnEmpty: true,
            forcePlaceholderSize: true,
            receive: function(event, ui) {
                $("body").trigger("resize");
            }
        });
    }
}

var oldIndex;
if ($('.sortable').length && $.fn.sortable) {
    $(".sortable").sortable({
        handle: ".panel-header, .card-title",
        start: function(event, ui) {
            oldIndex = ui.item.index();
            ui.placeholder.height(ui.item.height() - 20);
        },
        stop: function(event, ui) {
            var newIndex = ui.item.index();

            var movingForward = newIndex > oldIndex;
            var nextIndex = newIndex + (movingForward ? -1 : 1);

            var items = $('.sortable > div');

            // Find the element to move
            var itemToMove = items.get(nextIndex);
            if (itemToMove) {

                // Find the element at the index where we want to move the itemToMove
                var newLocation = $(items.get(oldIndex));

                // Decide if it goes before or after
                if (movingForward) {
                    $(itemToMove).insertBefore(newLocation);
                } else {
                    $(itemToMove).insertAfter(newLocation);
                }
            }
        }
    });
}

/**** Nestable List ****/
function nestable(){
    if ($('.nestable').length && $.fn.nestable) {
        $(".nestable").nestable();
    }
}

 /**** Sortable Table ****/
function sortableTable(){
    if ($('.sortable_table').length && $.fn.sortable) {
        $(".sortable_table").sortable({
            itemPath: '> tbody',
            itemSelector: 'tbody tr',
            placeholder: '<tr class="placeholder"/>'
        });
    }
}

/****  Show Tooltip  ****/
function showTooltip(){
    if ($('[data-rel="tooltip"]').length && $.fn.tooltip) {
        $('[data-rel="tooltip"]').tooltip();
    }
}

 /****  Show Popover  ****/
function popover() {
    if ($('[rel="popover"]').length && $.fn.popover) {
        $('[rel="popover"]').popover({
            trigger: "hover"
        });
        $('[rel="popover_dark"]').popover({
            template: '<div class="popover popover-dark"><div class="arrow"></div><h3 class="popover-title popover-title"></h3><div class="popover-content popover-content"></div></div>',
            trigger: "hover"
        });
    }
}

/****  Table progress bar  ****/
function progressBar(){
    if ($('.progress-bar').length && $.fn.progressbar) {
        $('.progress-bar').progressbar();
    }
}

/**** IOS Switch  ****/
function iosSwitch() {
    if ($('.js-switch').length){
        setTimeout(function(){
            $('.js-switch').each(function () {
            var colorOn = '#18A689';
            var colorOff = '#DFDFDF';
            if($(this).data('color-on')) colorOn = $(this).data('color-on');
            if($(this).data('color-on')) colorOff = $(this).data('color-off');
            if(colorOn == 'blue') colorOn = '#56A2D5';
            if(colorOn == 'red') colorOn = '#C75757';
            if(colorOn == 'yellow') colorOn = '#F3B228';
            if(colorOn == 'green') colorOn = '#18A689';
            if(colorOn == 'purple') colorOn = '#8227f1';
            if(colorOn == 'dark') colorOn = '#292C35';
            if(colorOff == 'blue') colorOff = '#56A2D5';
            if(colorOff == 'red') colorOff = '#C75757';
            if(colorOff == 'yellow') colorOff = '#F3B228';
            if(colorOff == 'green') colorOff = '#18A689';
            if(colorOff == 'purple') colorOff = '#8227f1';
            if(colorOff == 'dark') colorOff = '#292C35';
            var switchery = new Switchery(this,{
                color          : colorOn,
                secondaryColor : colorOff});
            });
        },500);
   }
}

/* Manage Slider */
function sliderIOS(){
    if ($('.slide-ios').length && $.fn.slider) {
        $('.slide-ios').each(function () {
            $(this).sliderIOS();
        });
    }
}

/* Manage Range Slider */
function rangeSlider(){
    if ($('.range-slider').length && $.fn.ionRangeSlider) {
        $('.range-slider').each(function () {
            $(this).ionRangeSlider({
                min: $(this).data('min') ? $(this).data('min') : 0,
                max: $(this).data('max') ? $(this).data('max') : 5000,
                hideMinMax: $(this).data('hideMinMax') ? $(this).data('hideMinMax') : false,
                hideFromTo: $(this).data('hideFromTo') ? $(this).data('hideFromTo') : false,
                to: $(this).data('to') ? $(this).data('to') : '',
                step: $(this).data('step') ? $(this).data('step') : '',
                type: $(this).data('type') ? $(this).data('type') : 'double',
                prefix: $(this).data('prefix') ? $(this).data('prefix') : '',
                postfix: $(this).data('postfix') ? $(this).data('postfix') : '',
                maxPostfix: $(this).data('maxPostfix') ? $(this).data('maxPostfix') : '',
                hasGrid: $(this).data('hasGrid') ? $(this).data('hasGrid') : false,
            });
        });
    }
}

/* Button Loading State */
function buttonLoader(){
    if($('.ladda-button').length){
        Ladda.bind('.ladda-button', {
            timeout: 2000
        });
        // Bind progress buttons and simulate loading progress
        Ladda.bind('.progress-demo button', {
            callback: function (instance) {
                var progress = 0;
                var interval = setInterval(function () {
                    progress = Math.min(progress + Math.random() * 0.1, 1);
                    instance.setProgress(progress);

                    if (progress === 1) {
                        instance.stop();
                        clearInterval(interval);
                    }
                }, 100);
            }
        });
    }
}

var t;
function inputSelect(){

    if ($.fn.select2) {
        setTimeout(function(){
            $('select:not(.select-picker)').each(function() {
            	 if($(this).hasClass('search-select')){
	                 $(this).select2({
	                	 placeholder: $(this).data('placeholder') ? $(this).data('placeholder') : '',
		                 allowClear: $(this).data('allowclear') ? $(this).data('allowclear') : false,
		                 minimumInputLength: $(this).data('minimumInputLength') ? $(this).data('minimumInputLength') : -1,
		                 minimumResultsForSearch: $(this).data('search') ? -1 : 1,
		                 dropdownCssClass: $(this).data('style') ? $(this).data('style') : '',
		                 containerCssClass: $(this).data('container-class') ? $(this).data('container-class') : ''
	                 });
            	 }
            });
        },200);
    }
}

function inputTags(){
    $('.select-tags').each(function(){
        $(this).tagsinput({
            tagClass: 'label label-primary'

        });
    });

}

/****  Tables Responsive  ****/
function tableResponsive(){
    setTimeout(function () {
       $('.table').each(function () {
            window_width = $(window).width();
            table_width = $(this).width();
            content_width = $(this).parent().width();
            if(table_width > content_width) {
                $(this).parent().addClass('force-table-responsive');
            }
            else{
                $(this).parent().removeClass('force-table-responsive');
            }
        });
    }, 200);
}

/****  Tables Dynamic  ****/
function tableDynamic(){
    if ($('.table-dynamic').length && $.fn.dataTable) {
        $('.table-dynamic').each(function () {
            var opt = {};
            opt.oLanguage = {
            	sZeroRecords:"데이터가 없습니다."
            	,sSearch: ""
            	,oPaginate: {sFirst:"처음",sPrevious:"이전" ,sNext:"다음",sLast:"마지막"}
            	,sInfo: "총 _TOTAL_ 개중 _START_ 부터 _END_"
            	,sInfoEmpty: "전체 0 건 / [0 부터 0]"
            	,sInfoFiltered: "(전체 _MAX_ 건에서 필터링)"
            };
            opt.bPaginate = true;
            opt.bStateSave =  true; // 상태 저장
            opt.pagingType = "full_numbers_no_ellipses";
            opt.pageLength= 15;
            opt.ordering = false;
            opt.fnDrawCallback = function(){
            	if($('.icheck-box').length > 0){
	            	$('.icheck-box').iCheck({
	            		checkboxClass: 'icheckbox_minimal'
	            	});
            	}
            }

            // Tools: export to Excel, CSV, PDF & Print
            if ($(this).hasClass('table-tools')) {
                opt.dom = "<'row'<'col-md-6'f><'col-md-6'B>r><'t_line'>t<'row'<'col-md-6'i><'spcol-md-6an6'p>>",
                opt.buttons = [
                        {
                            extend: 'excelHtml5',
                            title: $(this).data('table-name') || "Your custom name",
                            className: 'btn btn-default'
                        },
                        {
                            extend: 'pdfHtml5',
                            title: $(this).data('table-name') || "Your custom name",
                            className: 'btn btn-default'
                        },
                        {
                            extend: 'csvHtml5',
                            title: $(this).data('table-name') || "Your custom name",
                            className: 'btn btn-default'
                        },
                        {
                            extend: 'copyHtml5',
                            className: 'btn btn-default'
                        }
                    ]
            }
            //
            if ($(this).hasClass('table-tools-patch')) {
                opt.dom = "<'row'<'col-md-6'f><'col-md-6'B>r><'t_line'>t<'row p-t-10'<'col-md-5'i><'col-sm-7 pagination2 p-b-10'p>>",
                opt.buttons = [];

                var mainButton = {
                    	text : '<i class="fa fa-plus"></i>패치',
                    	action : function(dt){
                    		uploadModal(dt);
                    	},
                        className: 'btn btn-white'
                }
                opt.buttons.push(mainButton);
            }
            if ($(this).hasClass('table-tools-basic')) {
                opt.dom = "<'row'<'col-md-6'f><'col-md-6'B>r><'t_line'>t<'row p-t-10'<'col-md-12 pagination2'p>>",
                //opt.bPaginate = false;
                opt.buttons = [];
            }
            if ($(this).hasClass('table-tools-normal')) {
                opt.dom = "<'row'<'col-md-6'f><'col-md-6'B>r><'t_line'>t<'row p-t-10'<'col-md-5'i><'col-sm-7 pagination2 p-b-10'p>>",
                opt.buttons = [];
            }
            if ($(this).hasClass('table-tools-add')) {
                opt.dom = "<'row'<'col-md-6'f><'col-md-6'B>r><'t_line'>t<'row p-t-10'<'col-md-5'i><'col-sm-7 pagination2 p-b-10'p>>",
                opt.buttons = [];
                var mainButton = {
                    	text : '<i class="fa fa-plus"></i>추가',
                    	action : function(dt){
                    		regist(dt);
                    	},
                        className: 'btn btn-white'
                }

               if ($(this).hasClass('institution')) {
                    var a = {
                    		text : '<i class="fa fa-plus"></i>추가',
                    		action : function(param){
                    			showInstitution(0);
                    		},
                            className: 'btn btn-white'
                        }
                	opt.buttons.push(a);
                }

                if ($(this).hasClass('interface')) {
                    var toActiveButton = {
                    		text : '<i class="fa fa-play"></i>시작',
                    		action : function(dt){
	                    		if_activate();
	                    	},
                            className: 'btn btn-white'
                        }

                	opt.buttons.push(toActiveButton);

                    var toDeactiveButton = {
                    		text : '<i class="fa fa-pause"></i>중지',
                    		action : function(dt){
	                    		if_deactivate();
	                    	},
                            className: 'btn btn-white'
                        }

                	opt.buttons.push(toDeactiveButton);
                }

                if (!$(this).hasClass('interface') && !$(this).hasClass('institution')) {
                	opt.buttons.push(mainButton);
                }



                if ($(this).hasClass('excel-download')) {
                    var downloadButton = {
                    		text : '<i class="fa fa-download"></i>다운로드',
                    		action : function(param){
                    			excel(param);
                    		},
                            //extend: 'excelHtml5',
                            //title: $(this).data('table-name') || "Your custom name",
                            className: 'btn btn-white excelButton'
                        }

                	opt.buttons.push(downloadButton);
                }

            }
            if ($(this).hasClass('no-header')) {
                opt.bFilter = false;
                opt.bLengthChange = false;
            }
            if ($(this).hasClass('no-footer')) {
                opt.bInfo = false;
                opt.bPaginate = false;
            }
            if ($(this).hasClass('filter-head')) {
                $('.filter-head thead th').each( function () {
                    var title = $('.filter-head thead th').eq($(this).index()).text();
                    $(this).append( '<input type="text" onclick="stopPropagation(event);" class="form-control" placeholder="Filter '+title+'" />' );
                });
                var table = $('.filter-head').DataTable();
                $(".filter-head thead input").on( 'keyup change', function () {
                    table.column( $(this).parent().index()+':visible').search( this.value ).draw();
                });
            }
            if ($(this).hasClass('filter-footer')) {
                $('.filter-footer tfoot th').each( function () {
                    var title = $('.filter-footer thead th').eq($(this).index()).text();
                    $(this).html( '<input type="text" class="form-control" placeholder="Filter '+title+'" />' );
                });
                var table = $('.filter-footer').DataTable();
                $(".filter-footer tfoot input").on( 'keyup change', function () {
                    table.column( $(this).parent().index()+':visible').search( this.value ).draw();
                });
            }


            if ($(this).hasClass('search-icon')) {
                opt.initComplete =  function () {
                	//검색 창 돋보기 아이콘 넣기
					var target = $('.input-sm')
					target.parent().append('<i class="fas fa-search" style="padding-left: 30px;"></i>');
					var p = target.parent().parent().parent();
					p.addClass('prepend-icon');
					target.css('padding-left', '36px');
					if ($(this).hasClass('show-all-checkbox')) {
						var dt = $('#dataListTable').dataTable();
						var dtOpt = dt.fnSettings()
						var size = dtOpt._iDisplayLength;
						var iconClass = 'fa-compress';
						var tooltipText = 'data-rel="tooltip" data-placement="top" data-original-title="페이징 목록 보기"';
						if( size == 15){
							iconClass = 'fa-expand';
							tooltipText = 'data-rel="tooltip" data-placement="top" data-original-title="전체 목록 보기"';
						}

						// 전체보기 아이콘
						var style ="padding: 0px 0px;font-size: 11px;line-height:1.5;border-radius:3px;background-color: #ffffff;border: 1px solid #E0E0E0 !important;width:38px;height:30px;";
						p.append('<div class="filter-left"><a class="dt-button btn btn-white show-all" tabindex="0" href="#" style="'+style+'"><span style="padding-left:4px;"><i class="fas '+iconClass +' toggle-show-icon toggle-show-disable"  '+tooltipText+' style="position:relative;height:0px;font-size:15px;color: #373C40;top:-2px;"></i></span></a>');
						$('.show-all').bind('click', function(param){
							var d = $('#dataListTable').dataTable();
							var opt = d.fnSettings()
							var size = opt._iDisplayLength;
							if( size == 15){
								opt._iDisplayLength = 1000;
								$('.toggle-show-icon').addClass('fa-compress')
								$('.toggle-show-icon').removeClass('fa-expand')
								$('.toggle-show-icon')[0].dataset.originalTitle = '페이징 목록 보기';
							}else{
								opt._iDisplayLength = 15;
								$('.toggle-show-icon').addClass('fa-expand')
								$('.toggle-show-icon').removeClass('fa-compress')
								$('.toggle-show-icon')[0].dataset.originalTitle = '전체 목록 보기';
							}
							d.fnDraw();
						});
						$('.toggle-show-icon').tooltip();
					}
                }
            }

            if ($(this).hasClass('filter-select')) {
                $(this).DataTable( {
                    initComplete: function () {
                        var api = this.api();
                        api.columns().indexes().flatten().each( function ( i ) {
                            var column = api.column( i );
                            var select = $('<select class="form-control" data-placeholder="Select to filter"><option value=""></option></select>')
                                .appendTo( $(column.footer()).empty() )
                                .on( 'change', function () {
                                    var val = $(this).val();

                                    column
                                        .search( val ? '^'+val+'$' : '', true, false )
                                        .draw();
                                } );

                            column.data().unique().sort().each( function ( d, j ) {
                                select.append( '<option value="'+d+'">'+d+'</option>' )
                            } );
                        } );
                    }
                } );
            }
            if (!$(this).hasClass('filter-head') && !$(this).hasClass('filter-footer') && !$(this).hasClass('filter-select'))  {
                var oTable = $(this).dataTable(opt);
                oTable.fnDraw();

               	var value = $(this).attr("init-search-value");
                if($(this).hasClass('init-search')){

                	var ob = $('.form-control.input-sm');

                	ob.val(value);
					var element = ob[0];

					var event;
					if (document.createEvent) {
						event = document.createEvent("HTMLEvents");
						event.initEvent("keyup", true, true);
					} else {
						event = document.createEventObject();
						event.eventType = "keyup";
					}
					event.eventName = "keyup";
					if (document.createEvent) {
						element.dispatchEvent(event);
					} else {
						element.fireEvent("on" + event.eventType, event);
					}

                }

        if($(this).hasClass('interface')){
        	var selectTypeButton = '<div class="btn-group">'
			+'	<button type="button" class="btn btn-white" onclick="regist();"><i class="fa fa-plus"></i>추가</button>'
			+'    <button type="button" class="btn btn-white dropdown-toggle" data-toggle="dropdown" aria-expanded="false" style="padding-left:3px;padding-right:3px;">'
			+'    	<span class="caret"></span>'
			+'    	<span class="sr-only">Toggle Dropdown</span>'
			+'    </button>'
			+'    <span class="dropdown-arrow"></span>'
			+'    	<ul class="dropdown-menu" role="menu" style="min-width: 115px;top: 75%;">'
			+'        	<li><a href="javascript:regist();">신규</a></li>'
			+'        	<li><a href="javascript:copyModal();">복사</a></li>'
			+'        </ul>'
			+'</div>';
    		$('.excelButton').before(selectTypeButton);
        }
            }
        });
    }
    $('.dataTables_info').removeClass();
}

// Handles custom checkboxes & radios using jQuery iCheck plugin
function handleiCheck() {

    if (!$().iCheck)  return;
    $(':checkbox:not(.js-switch, .switch-input, .switch-iphone, .onoffswitch-checkbox, .ios-checkbox, .md-checkbox), :radio:not(.md-radio)').each(function() {

        var checkboxClass = $(this).attr('data-checkbox') ? $(this).attr('data-checkbox') : 'icheckbox_minimal-grey';
        var radioClass = $(this).attr('data-radio') ? $(this).attr('data-radio') : 'iradio_minimal-grey';

        if (checkboxClass.indexOf('_line') > -1 || radioClass.indexOf('_line') > -1) {
            $(this).iCheck({
                checkboxClass: checkboxClass,
                radioClass: radioClass,
                insert: '<div class="icheck_line-icon"></div>' + $(this).attr("data-label")
            });
        } else {
            $(this).iCheck({
                checkboxClass: checkboxClass,
                radioClass: radioClass
            });
        }
    });
}

/* Time picker */
function timepicker(){
    $('.timepicker').each(function () {
        $(this).timepicker({
            isRTL : $('body').hasClass('rtl') ? true : false,
            timeFormat: $(this).attr('data-format', 'am-pm') ? 'hh:mm tt'  : 'HH:mm'
        });
    });
}

 /* Date picker */
function datepicker(){
    $('.date-picker').each(function () {
         $(this).datepicker({
            numberOfMonths: 1,
            isRTL : $('body').hasClass('rtl') ? true : false,
            prevText: '<i class="fa fa-angle-left"></i>',
            nextText: '<i class="fa fa-angle-right"></i>',
            showButtonPanel: false
        });
    });
}

 /* Date picker */
function bDatepicker(){
    $('.b-datepicker').each(function () {
        $(this).bootstrapDatepicker({
            startView: $(this).data('view') ? $(this).data('view') : 0, // 0: month view , 1: year view, 2: multiple year view
            language: $(this).data('lang') ? $(this).data('lang') : "en",
            forceParse: $(this).data('parse') ? $(this).data('parse') : false,
            daysOfWeekDisabled: $(this).data('day-disabled') ? $(this).data('day-disabled') : "", // Disable 1 or various day. For monday and thursday: 1,3
            calendarWeeks: $(this).data('calendar-week') ? $(this).data('calendar-week') : false, // Display week number
            autoclose: $(this).data('autoclose') ? $(this).data('autoclose') : false,
            todayHighlight: $(this).data('today-highlight') ? $(this).data('today-highlight') : true, // Highlight today date
            toggleActive: $(this).data('toggle-active') ? $(this).data('toggle-active') : true, // Close other when open
            multidate: $(this).data('multidate') ? $(this).data('multidate') : false, // Allow to select various days
            orientation: $(this).data('orientation') ? $(this).data('orientation') : "top", // Allow to select various days,
            rtl: $('html').hasClass('rtl') ? true : false
        });
    });
}

function multiDatesPicker(){
    $('.multidatepicker').each(function () {
        $(this).multiDatesPicker({
            dateFormat: 'yy-mm-dd',
            minDate: new Date(),
            maxDate: '+1y',
            firstDay: 1,
            showOtherMonths: true
        });
    });
}

function rating(){
    $('.rateit').each(function(){
        $(this).rateit({
            readonly: $(this).data('readonly') ? $(this).data('readonly') : false, // Not editable, for example to show rating that already exist
            resetable: $(this).data('resetable') ? $(this).data('resetable') : false,
            value: $(this).data('value') ? $(this).data('value') : 0, // Current value of rating
            min: $(this).data('min') ? $(this).data('min') : 1, // Maximum of star
            max: $(this).data('max') ? $(this).data('max') : 5, // Maximum of star
            step:$(this).data('step') ? $(this).data('step') : 0.1
        });
        // Tooltip Option
        if($(this).data('tooltip')) {
            var tooltipvalues = ['bad', 'poor', 'ok', 'good', 'super']; // You can change text here
            $(this).bind('over', function (event, value) { $(this).attr('title', tooltipvalues[value-1]); });
        }
        // Confirmation before voting option
        if($(this).data('confirmation')) {
            $(this).on('beforerated', function (e, value) {
                value = value.toFixed(1);
                if (!confirm('Are you sure you want to rate this item: ' +  value + ' stars?')) {
                    e.preventDefault();
                }
                else{
                    // We disable rating after voting. If you want to keep it enable, remove this part
                    $(this).rateit('readonly', true);
                }
            });
        }
        // Disable vote after rating
        if($(this).data('disable-after')) {
            $(this).bind('rated', function (event, value) {
                $(this).rateit('readonly', true);
            });
        }
        // Display rating value as text below
        if($(this).parent().find('.rating-value')) {
            $(this).bind('rated', function (event, value) {
                if(value) value = value.toFixed(1);
                $(this).parent().find('.rating-value').text('Your rating: ' + value);
            });
        }
        // Display hover value as text below
        if($(this).parent().find('.hover-value')) {
            $(this).bind('over', function (event, value) {
                if(value) value = value.toFixed(1);
                $(this).parent().find('.hover-value').text('Hover rating value: ' + value);
            });
        }

    });
}

/* Date & Time picker */
function datetimepicker(){
    if ($.fn.datetimepicker) {
        $('.datetimepicker').each(function () {
           $(this).datetimepicker({
                prevText: '<i class="fa fa-angle-left"></i>',
                nextText: '<i class="fa fa-angle-right"></i>'
            });
        });

           /* Inline Date & Time picker */
       $('.inline_datetimepicker').datetimepicker({
            altFieldTimeOnly: false,
            isRTL: is_RTL
        });
    }
}

/* Popup Images */
function magnificPopup(){
    if ($('.magnific').length && $.fn.magnificPopup) {
        $('.magnific').magnificPopup({
            type:'image',
            gallery: {
                enabled: true
            },
            removalDelay: 300,
            mainClass: 'mfp-fade'
        });
    }
}

/****  Summernote Editor  ****/
function editorSummernote(){
    if ($('.summernote').length && $.fn.summernote) {
        $('.summernote').each(function () {
            $(this).summernote({
                height: 300,
                airMode : $(this).data('airmode') ? $(this).data('airmode') : false,
                airPopover: [
                    ["style", ["style"]],
                    ['color', ['color']],
                    ['font', ['bold', 'underline', 'clear']],
                    ['para', ['ul', 'paragraph']],
                    ['table', ['table']],
                    ['insert', ['link', 'picture']]
                  ],
                toolbar: [
                    ["style", ["style"]],
                    ["style", ["bold", "italic", "underline", "clear"]],
                    ["fontsize", ["fontsize"]],
                    ["color", ["color"]],
                    ["para", ["ul", "ol", "paragraph"]],
                    ["height", ["height"]],
                    ["table", ["table"]],
                    ['view', ['codeview']],
                ]
            });
        });
    }
}

/****  CKE Editor  ****/
function editorCKE(){
    if ($('#cke-editor').length) {
        $('#cke-editor').each(function () {
            CKEDITOR.replace('cke-editor');
        });
        // Turn off automatic editor creation first.
        CKEDITOR.disableAutoInline = true;
    }
}

function slider(){
    if ($('.slick').length && $.fn.slick) {
        $('.slick').each(function () {
            $(this).slick({
                accessibility: true, // Enables tabbing and arrow key navigation
                adaptiveHeight: false,
                arrows: $(this).data('arrows') ? $(this).data('arrows') : false, // Enable Next/Prev arrows
                asNavFor: null,
                prevArrow: '<button type="button" data-role="none" class="slick-prev">Previous</button>', // prev arrow
                nextArrow: '<button type="button" data-role="none" class="slick-next">Next</button>', // next arrow
                autoplay: $(this).attr('data-autoplay') ? $(this).attr('data-autoplay') : true, // Enables auto play of slides
                autoplaySpeed: $(this).data('timing') ? $(this).data('timing') : 4000, // Auto play change interval
                centerMode: $(this).data('center') ? $(this).data('center') : false, // Enables centered view with partial prev/next slides.
                centerPadding: '50px', // Side padding when in center mode. (px or %)
                cssEase: 'ease', // CSS3 easing
                dots: $(this).attr('data-dots') ? $(this).attr('data-dots') : true, // Current slide indicator dots
                dotsClass: 'slick-dots', // Class for slide indicator dots container
                draggable: true, // Enables desktop dragging
                easing: 'linear', // animate() fallback easing
                fade: $(this).data('fade') ? $(this).data('fade') : false, // Enables fade
                focusOnSelect: false,
                infinite: true, // Infinite looping
                lazyLoad: 'ondemand', // Accepts 'ondemand' or 'progressive' for lazy load technique
                onBeforeChange: null, // Before slide change callback
                onAfterChange: null, // After slide change callback
                onInit: null, // When Slick initializes for the first time callback
                onReInit: null, // Every time Slick (re-)initializes callback
                pauseOnHover: true, // Pauses autoplay on hover
                pauseOnDotsHover: false, // Pauses autoplay when a dot is hovered
                responsive: null, // Breakpoint triggered settings
                rtl: $('body').hasClass('rtl') ? true : false, // Change the slider's direction to become right-to-left
                slide: '.slide', // Slide element query
                slidesToShow: $(this).data('num-slides') ? $(this).data('num-slides') : 1, // # of slides to show at a time
                slidesToScroll:  $(this).data('num-scroll') ? $(this).data('num-scroll') : 1, // # of slides to show at a time,
                speed: 500, // Transition speed
                swipe: true, // Enables touch swipe
                swipeToSlide: false, // Swipe to slide irrespective of slidesToScroll
                touchMove: true, // Enables slide moving with touch
                touchThreshold: 5, // To advance slides, the user must swipe a length of (1/touchThreshold) * the width of the slider.
                useCSS: true, // Enable/Disable CSS Transitions
                variableWidth: $(this).data('variable-width')? true : false, // Disables automatic slide width calculation
                vertical: false, // Vertical slide direction
                waitForAnimate: true // Ignores requests to advance the slide while animating
            });
        });
    }
}

function formWizard(){

    if ($('.wizard').length && $.fn.stepFormWizard) {
        $('.wizard').each(function () {
            $this = $(this);
            $(this).stepFormWizard({
                theme: $(this).data('style') ? $(this).data('style') : "circle",
                showNav: $(this).data('nav') ? $(this).data('nav') : "top",
                height: "auto",
                rtl: $('body').hasClass('rtl') ? true : false,
                onNext: function(i, wizard) {
                    if($this.hasClass('wizard-validation')){
                        return $('form', wizard).parsley().validate('block' + i);
                    }
                },
                onFinish: function(i) {
                    if($this.hasClass('wizard-validation')){
                        return $('form', wizard).parsley().validate();
                    }
                }
            });
        });

        /* Fix issue only with tabs with Validation on error show */
        $('#validation .wizard .sf-btn').on('click', function(){
            setTimeout(function () {
                $(window).resize();
                $(window).trigger('resize');
            }, 50);
        });
    }
}

function formValidation(){
	var formValidation;
    if($('.form-validation').length && $.fn.validate){
        /* We add an addition rule to show you. Example : 4 + 8. You can other rules if you want */
        $.validator.methods.operation = function(value, element, param) {
            return value == param;
        };
        $.validator.methods.customemail = function(value, element) {
            return /^([-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4})+$/.test(value);
        };

    	$.validator.methods.passwordCk = function( value, element ) {
    		return this.optional(element) || /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/.test(value);
    	};

        $('.form-validation').each(function(){
            formValidation = $(this).validate({
                ignore: ":not(:visible)",
                rules: {
                    email: {
                        required:  {
                                depends:function(){
                                    $(this).val($.trim($(this).val()));
                                    return true;
                                }
                            },
                        customemail: true
                    }
            		,loginPassword : {
            			passwordCk : true,
            			required : true,
            			minlength : 9
            		}
            		,loginPasswordConfirm : {
            			required : true,
            			equalTo : '#loginPassword'
            		}
                },
                messages:{
                    email: {
                    	required: '이메일 주소를 입력하세요',
                    	customemail: '올바른 이메일 주소를 입력하세요'
                    },
                    loginPassword:{
                		required : "필수 항목",
                		passwordCk : "영문자, 숫자, 특수문자 조합 필요",
                		minlength : $.validator.format("{0}자 이상 입력해주세요"),
                	}, 
                	loginPasswordConfirm : {
                		required : "필수 항목",
                		minlength : $.validator.format("{0}자 이상 입력해주세요"),
                		equalTo : "입력한 비밀번호와 다릅니다."
                	}
                }
            });
            $(".form-validation .cancel").click(function() {
                formValidation.resetForm();
            });
        });
    }
    return formValidation;
}

/****  Animated Panels  ****/
function liveTile() {

    if ($('.live-tile').length && $.fn.liveTile) {
        $('.live-tile').each(function () {
            $(this).liveTile("destroy", true); /* To get new size if resize event */
            tile_height = $(this).data("height") ? $(this).data("height") : $(this).find('.panel-body').height() + 52;
            $(this).height(tile_height);
            $(this).liveTile({
                speed: $(this).data("speed") ? $(this).data("speed") : 500, // Start after load or not
                mode: $(this).data("animation-easing") ? $(this).data("animation-easing") : 'carousel', // Animation type: carousel, slide, fade, flip, none
                playOnHover: $(this).data("play-hover") ? $(this).data("play-hover") : false, // Play live tile on hover
                repeatCount: $(this).data("repeat-count") ? $(this).data("repeat-count") : -1, // Repeat or not (-1 is infinite
                delay: $(this).data("delay") ? $(this).data("delay") : 0, // Time between two animations
                startNow: $(this).data("start-now") ? $(this).data("start-now") : true, //Start after load or not
            });
        });
    }
}

/**** Bar Charts: CHARTJS ****/
function barCharts() {
    if ($('.bar-stats').length) {
        $('.bar-stats').each(function () {
            var randomScalingFactor = function(){ return Math.round(Math.random()*100)};
            var custom_colors =['#C9625F', '#18A689', '#90ed7d', '#f7a35c', '#8085e9', '#f15c80', '#8085e8', '#91e8e1'];
            var custom_color = custom_colors[Math.floor(Math.random()*custom_colors.length)];
            var barChartData = {
                labels : ["1","2","3","4","5","6","7","8","9","10","11","12"],
                datasets : [ {
                        backgroundColor : custom_color,
                        borderColor : custom_color,
                        pointBackgroundColor : "#394248",
                        pointBorderColor : "#394248",
                        data : [randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor()]
                    }
                ]
            }
            var ctx =  $(this).get(0).getContext("2d");
            window.myBar = new Chart(ctx).Bar(barChartData, {
                responsive : true,
                scaleShowLabels: false,
                showScale: true,
                scaleLineColor: "rgba(0,0,0,.1)",
                scaleShowGridLines : false,
            });
        });
    }
}

function animateNumber(){
    $('.countup').each(function(){
        from     = $(this).data("from") ? $(this).data("from") : 0;
        to       = $(this).data("to") ? $(this).data("to") : 0;
        duration = $(this).data("duration") ? $(this).data("duration") : 2;
        delay    = $(this).data("delay") ? $(this).data("delay") : 1000;
        decimals = $(this).data("decimals") ? $(this).data("decimals") : 0;
        var options = {
          useEasing : true,
          useGrouping : true,
          separator : ',',
          prefix : $(this).data("prefix") ? $(this).data("  prefix") : '',
          suffix : $(this).data("suffix") ? $(this).data("suffix") : ''
        }
        var numAnim = new countUp($(this).get(0),from, to, decimals, duration, options);
        setTimeout(function(){
            numAnim.start();
        },delay);
    });
}

function textareaAutosize(){
    $('textarea.autosize').each(function(){
        $(this).autosize();
    });
}

/****  Initiation of Main Functions  ****/
$(document).ready(function () {
    sortablePortlets();
    sortableTable();
    nestable();
    showTooltip();
    popover();
    colorPicker();
    numericStepper();
    iosSwitch();
    sliderIOS();
    rangeSlider();
    buttonLoader();
    inputSelect();
    inputTags();
    tableResponsive();
    tableDynamic();
    handleiCheck();
    timepicker();
    datepicker();
    bDatepicker();
    multiDatesPicker();
    datetimepicker();
    rating();
    magnificPopup();
    editorSummernote();
    editorCKE();
    slider();
    liveTile();
    formWizard();
    formValidation();
    barCharts();
    animateNumber();
    textareaAutosize();
    appearEffect();
    handleProgress();
    $('.autogrow').autogrow();
});


/****  On Resize Functions  ****/
$(window).bind('resize', function (e) {
    window.resizeEvt;
    $(window).resize(function () {
        clearTimeout(window.resizeEvt);
        window.resizeEvt = setTimeout(function () {
            tableResponsive();
        }, 250);
    });
});



if( $.validator){
	$.validator.addMethod(
	    "regex",
	    function(value, element, regexp) {
	        var re = new RegExp(regexp);
	        return this.optional(element) || re.test(value);
	    },
	    function(regex,element){
	    	if(element.id=='intrfcId'){
	    		return "영문, 숫자, '_', '-' 만 허용";
	    	}else if(element.id=='simpleSecText'){
	    		return "숫자만 허용";
	    	}else if(element.id=='agentId'){
	    		return "영문 대문자만 허용";
	    	}else if(element.id=='agentNo'){
	    		return "숫자(최대3자리)만 허용";
	    	}else if(element.id.toLowerCase().indexOf("port") > -1){
	    		return "숫자(4~5자리)만 허용";
	    	}else if(element.id.toLowerCase().indexOf("ip") > -1 || element.id.toLowerCase().indexOf("host") > -1){
	    		return "IP 주소 형식만 허용";
	    	}else if(element.id.indexOf('dtasrcId')> -1){
	    		return "영문, 숫자, '_', '-' 만 허용";
	    	}else if(element.id=='maxCnncCnt'){
	    		return "숫자(최대2자리)만 허용";
	    	}else if(element.id=='cnncWaitTime' || element.id=='soTimeout' ){
	    		return "숫자(4~5자리)만 허용";
	    	}else if(element.id=='mxmmReconnect'){
	    		return "숫자(최대1자리)만 허용";
	    	}else{
	    		return "형식에 맞지 않습니다.";
	    	}
	    });
}