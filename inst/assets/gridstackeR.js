var grids = [];

/*
* initializes the grid and adds the hooks for the height and width changes
*/
function initGridstackeR(opts, id, ncols, nrows, dynamic_full_window_height, height_margin) {
  /**
   * create the grid
   **/
  var grid = GridStack.init(opts, elOrString = '#'+id);
  grid.column(ncols);
  grids.push(grid);

  /*
  * create callbacks to shiny when a grid-stack-item's size has changed
  */
  grid.on('resizestop', function(event, el) {
    $(window).trigger('resize');
    id = el.firstElementChild.getAttribute('id');
    notify_shiny_inputs_changed(el, id);
  });

  grid.on('change', function(event, items) {
    $(window).trigger('resize');
    setTimeout(function (){
      for(i in items) {
        id = items[i]["id"];
        el = document.getElementById(id);
        notify_shiny_inputs_changed(el, id);
      }
    }, 500);
  });

  /*
  * resize the grid-stack after the browser window resized
  */
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
    notify_shiny_inputs_changed(this, id);
  });
});

function notify_shiny_inputs_changed (e, id) {
  if(id != null & e != null) {
    Shiny.onInputChange(id + '_height', e.offsetHeight);
    Shiny.onInputChange(id + '_width', e.offsetWidth);
    if(e.parentElement) {
      Shiny.onInputChange(id + '_x', e.parentElement.getAttribute('gs-x'));
      Shiny.onInputChange(id + '_y', e.parentElement.getAttribute('gs-y'));
      Shiny.onInputChange(id + '_w', e.parentElement.getAttribute('gs-w'));
      Shiny.onInputChange(id + '_h', e.parentElement.getAttribute('gs-h'));
    }
  }
}

/*
* function for loading a specific layout.
* The given layout has to be a JSON array with each element containing the information about one
* grid-stack-item.
* - the id of the grid-stack-item
* - the desired options (i.e. height, width, x-, y-Values)
*/
function load_grid_layout(grid_id, layout) {
  var grid = helper_find_grid_by_id(grid_id);
  if(grid == null) {
    console.log("Couldn't find grid with id " + grid_id);
    return(null);
  }
  try {
    console.log(layout);
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

/*
* similar to the saveLayout function but gives the option to give an ns prefix
*/
function save_grid_layout(grid_id, ns) {
  var grid = helper_find_grid_by_id(grid_id);
  if(grid == null) {
    console.log("Couldn't find grid with id " + grid_id);
    Shiny.setInputValue(ns + grid_id + '_saved_layout', null, {priority: 'event'});
  } else {
    layout = grid.save(saveContent = false);
    layout.forEach(function(el) {
      if (el.hasOwnProperty('subGrid')) {
          el.subGrid = true;
      }
    });
    Shiny.setInputValue(ns + grid_id + '_saved_layout', JSON.stringify(layout), {priority: 'event'});
  }
}

/*
* loads the given grid.
*/
function load_grid(grid_id, new_grid) {
  var grid = helper_find_grid_by_id(grid_id);
  if(grid == null) {
    console.log("Couldn't find grid with id " + grid_id);
  } else {
    grid.removeAll({detachNode:false})
    grid.load(new_grid[0]);
  }
}

/**
 * add elements
**/
function add_grid_element(grid_id, element) {
  var grid = helper_find_grid_by_id(grid_id);
  if(grid == null) {
    console.log("Couldn't find grid with id " + grid_id);
  } else {
    el = JSON.parse(element);
    grid.addWidget(el);
  }
}

/**
 * add elements
**/
function remove_grid_element(grid_id, element_id) {
  var grid = helper_find_grid_by_id(grid_id);
  var el = $('[gs-id="' + element_id + '"]')
  if(grid == null) {
    console.log("Couldn't find grid with id " + grid_id);
  } else if(el == null | el.length != 1) {
    console.log("Couldn't find element with id " + element_id);
  } else {
    grid.removeWidget(el[0]);
  }
}

/**
 * add elements
**/
function remove_all_grid_elements(grid_id, element) {
  var grid = helper_find_grid_by_id(grid_id);
  if(grid == null) {
    console.log("Couldn't find grid with id " + grid_id);
  } else {
    grid.removeAll();
  }
}

/**
 * remove grid
**/
function remove_grid(grid_id) {
  var grid = helper_find_grid_by_id(grid_id);
  if(grid == null) {
    console.log("Couldn't find grid with id " + grid_id);
  } else {
    const index = grids.indexOf(grid);
    if (index > -1) {
      grids.splice(index, 1);
    }
  }
}

/**
 * find the grid with the given grid_id
**/
function helper_find_grid_by_id(grid_id) {
  var grid = null;
  grids.forEach(function (element) {
    if(element.el.id==grid_id) {
      grid = element;
    }
  })
  return(grid)
}
