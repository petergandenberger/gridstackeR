var grids = [];

/*
* initializes the grid and adds the hooks for the height and width changes
*/
function initGridstackeR(opts, id, ncols, nrows, dynamic_full_window_height, height_margin) {
  let grid = GridStack.init(opts, elOrString = '#'+id);
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
    if(dynamic_full_window_height) {
      grid.cellHeight((window.innerHeight-height_margin)/nrows);
    }
  }

  var resize_delayed;
  $(window).on('resize', function(){
      clearTimeout(resize_delayed);
    resize_delayed = setTimeout(resizedw, 100);
  });

  grids.push(grid);
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
  try {
    layout = JSON.parse(layout);
  } catch (err) {
    console.log("The given layout is not a valid json array");
    return false;
  }

  for(i in layout) {
    item_layout = layout[i];
    if(!item_layout.hasOwnProperty('id')) {
      console.log("Warning in loadLayout: Couldn't find property 'id' for element" + item_layout);
      continue;
    }
    if(!item_layout.hasOwnProperty('options')) {
      console.log("Warning in loadLayout: Couldn't find property 'options' for element" + item_layout);
      continue;
    }

    element = document.getElementById(item_layout["id"])
    if(element != null) {
      gridStackItem = element.closest(".grid-stack-item")
      if(gridStackItem != null) {
        grid.update(gridStackItem, item_layout["options"]);
      } else {
        console.log("Error in loadLayout: Couldn't find grid-stack-item from element with id " + item_layout["id"])
      }
    } else {
      console.log("Error in loadLayout: Couldn't find element with id " + item_layout["id"])
    }
  }
}

function saveLayout(id) {
  layout = grids[id].save(saveContent = false);
  Shiny.setInputValue('saved_layout', JSON.stringify(layout), {priority: 'event'});
}

function saveLayout() {
  saveLayout(0);
}

function saveLayout_ns(ns, id) {
  layout = grids[id].save(saveContent = false);
  Shiny.setInputValue(ns + 'saved_layout', JSON.stringify(layout), {priority: 'event'});
}

function saveLayout_ns(ns) {
  saveLayout_ns(ns, 0);
}

function loadLayoutSimple(layout, id) {
  grids[id].removeAll({detachNode:false})
  grids[id].load(layout[0]);
}

function loadLayoutSimple(layout) {
  loadLayoutSimple(layout, 0);
}


/**
 * add elements
**/

function addElement(element, id) {
  el = JSON.parse(element);
  grids[id].addWidget(el);
}

function addElement(element) {
  addElement(element, 0);
}
