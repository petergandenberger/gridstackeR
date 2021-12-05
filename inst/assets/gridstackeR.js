var grid;
var serializedData;

/*
* initializes the grid and adds the hooks for the height and width changes
*/
function initGridstackeR(opts, ncols) {
  grid = GridStack.init(opts);
  grid.column(ncols);

  /*
  * fires the height callbacks after resize stopped
  */
  grid.on('resizestop', function(event, el) {
    $(window).trigger('resize');
    id = el.firstElementChild.getAttribute('id');
    if(id != null) {
      Shiny.onInputChange(id + '_height', el.offsetHeight);
      Shiny.onInputChange(id + '_width', el.offsetWidth);
    }
  });

  grid.on('change', (event, items) => {
    $(window).trigger('resize');
    setTimeout(function (){
      for(i in items) {
        id = items[i]["id"];
        el = document.getElementById(id);
        if(id != null & el != null) {
          Shiny.onInputChange(id + '_height', el.offsetHeight);
          Shiny.onInputChange(id + '_width', el.offsetWidth);
        }
      }
    }, 500);
  });

  function resizedw(){
    grid.cellHeight(window.innerHeight/12);
    $(window).trigger('resize');
  }

  var doit;
  $(window).on('resize', function(){
      clearTimeout(doit);
    doit = setTimeout(resizedw, 100);
  });
}

/*
* fires the height callbacks after the shiny session is initialized
*/
$(document).on('shiny:sessioninitialized', function(event) {
  $(".grid-stack-item").each(function() {
    id = this.firstElementChild.getAttribute('id');
    if(id != null) {
      Shiny.onInputChange(id + '_height', this.offsetHeight);
      Shiny.onInputChange(id + '_width', this.offsetWidth);
    }
  });
});

/*
* function for loading a specific layout.
* The given layout has to be a JSON array with each element containing the information about one
* grid-stack-item.
* - the id of the grid-stack-item
* - the desired options (i.e. height, width, x-, y-Values)
*/
function loadLayout(layout) {
  layout = JSON.parse(layout);

  for(i in layout) {
    item_layout = layout[i];
    grid.update(document.getElementById(item_layout["id"]).closest(".grid-stack-item"), item_layout["options"]);
  }
}
