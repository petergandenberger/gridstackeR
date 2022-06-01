var grid;

/*
* initializes the grid and adds the hooks for the height and width changes
*/
function initGridstackeR(opts, ncols, nrows, dynamic_full_window_height, height_margin) {
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
    if(dynamic_full_window_height) {
      grid.cellHeight((window.innerHeight-height_margin)/nrows);
    }
  }

  var resize_delayed;
  $(window).on('resize', function(){
      clearTimeout(resize_delayed);
    resize_delayed = setTimeout(resizedw, 100);
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
  if(!isJSONArray(layout)) {
    console.log("The given layout is not a json array");
    return;
  }
  if(typeof str == 'string') {
    layout = JSON.parse(layout);
  } else {
    layout = layout[0]
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

function isJSONArray(str) {
  console.log(str);
  if (typeof str !== 'string' && typeof str !== 'object') return false;
  try {
    if(typeof str == 'string') {
      obj = JSON.parse(str);
    } else {
      obj = str;
    }
    const type = Object.prototype.toString.call(obj);
    return type === '[object Array]';
  } catch (err) {
      return false;
  }
}


function saveLayout() {
  layout = grid.save(saveContent = false);
  Shiny.setInputValue('saved_layout', JSON.stringify(layout), {priority: 'event'});
}

function loadLayoutSimple(layout) {
  grid.removeAll({detachNode:false})
  grid.load(layout[0]);
}


/**
 * add elements
**/

function addElement(element) {
  el = JSON.parse(element);
  grid.addWidget(el);
}
