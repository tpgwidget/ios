$(document).ready(function() {
    document.addEventListener("deviceready", onDeviceReady, false);
});

function onDeviceReady() {
    Keyboard.shrinkView(true);
    Keyboard.hideFormAccessoryBar(true);
}

var f7 = new Framework7();

var $$ = Dom7;

var mainView = f7.addView('.view-main', {
    dynamicNavbar: true
});

f7.onPageInit('install', function () {
    $('.install').click('click', function (){
        window.open("https://tpg.nicolapps.ch/"+$(this).attr("data-stop")+"/", '_system');
    });
})

var welcomescreen_slides = [
  {
    id: 'slide0',
    picture: '<img src="img/slides/1.png">',
    text: 'Bienvenue ! Ce court tutoriel vous expliquera comment fonctionne TPGwidget.'
  },
  {
    id: 'slide1',
    picture: '<img src="img/slides/2.png">',
    text: "TPGwidget permet de créer sur votre écran d'accueil un raccourci pour votre arrêt de bus ou de tram."
  },
  {
    id: 'slide2',
    picture: '<img src="img/slides/3.png">',
    text: "Vous pouvez utiliser n'importe quel arrêt : domicile, travail, école... Et vous pouvez créer autant de raccourcis que vous voulez !"
  },
  {
    id: 'slide3',
    picture: '<img src="img/slides/4.png">',
    text: 'Vous pouvez maintenant choisir quel arrêt vous voulez utiliser :<br><br><a class="close-welcomescreen" href="#">COMMENCER</a>'
  }
];

var options = {
  'bgcolor': '#f60',
  'fontcolor': '#fff',
  'closeButtonText': 'PASSER'
}

$$(document).on('ajaxStart', function (e) {
    f7.showIndicator();
});

$$(document).on('ajaxComplete', function () {
    f7.hideIndicator();
});

$$('.right').on('click', function (e) {
    var welcomescreen = f7.welcomescreen(welcomescreen_slides, options);
});

if(navigator.onLine){
    var welcomescreen = f7.welcomescreen(welcomescreen_slides, options);

    $.ajax({
      url: 'https://tpg.nicolapps.ch/app/stops.php',
      success: function(data){
        $$(".layout-dark").removeClass("layout-dark");
        $$(".graym").remove();
        $$("#contenu, section.fav").show();


        var arr = [];
        $.each(data, function (val, key) {
            arr.push({
                stopCode: key,
                stopName: val
            });
        });

        var template = '<li>'+
         '<a href="http://tpg.nicolapps.ch/app/install.php?id={{stopName}}" class="item-link">'+
            '<div class="item-content">'+
               '<div class="item-inner">'+
                  '<div class="item-title">{{stopCode}}</div>'+
               '</div>'+
            '</div>'+
         '</a>'+
      '</li>';

        var myList = f7.virtualList('.list-block.virtual-list', {items: arr,
            template: template,
            searchAll: function (query, items) {
                var foundItems = [];
                for (var i = 0; i < items.length; i++) {
                    if(items[i].stopCode.toLowerCase().indexOf(query.toLowerCase().trim()) >= 0 || items[i].stopName.toLowerCase().indexOf(query.toLowerCase().trim()) >= 0) {
                        foundItems.push(i);
                    }
                }
                return foundItems;
            }
        });
      },
      error: function(){
        welcomescreen.close();
        $$(".right").remove();
        $$(".searchbar").remove();
        $$(".searchbar-overlay").remove();
        $$(".graym").html("<h1>😕</h1><h2>Connection au serveur impossible</h2><small>TPGwidget n'a pas réussi à se connecter au serveur. Veuillez réessayer plus tard.</small>");
      }
    });

} else {
    $$(".right").remove();
    $$(".searchbar").remove();
    $$(".searchbar-overlay").remove();
    $$(".graym").html("<h1>😕</h1><h2>Pas de connection à internet</h2><small>TPGwidget a besoin d'une connection à internet pour fonctionner. Pour continuer, connectez vous à internet.</small>");
}
