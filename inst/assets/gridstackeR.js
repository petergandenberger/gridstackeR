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
* function for adding and deleting gridstack items
*/
function addGridStackItem(grid_stack_item) {
  grid.addWidget({w: 2, content: grid_stack_item})
}

function deleteGridStackItem(item) {
  grid.removeWidget(item.closest(".grid-stack-item"))
}

/*
* function for loading and saving the grid
*/
function loadGrid(serializedGrid) {
  if(serializedGrid == null) {
    serializedGrid = serializedData;
  } else {
    serializedGrid = JSON.parse(String(serializedGrid).replace(/'/g, ''));
  }
  grid.load(serializedGrid, true);
}

function loadLayout(layout) {
  layout = JSON.parse(layout);

  for(i in layout) {
    item_layout = layout[i];
    grid.update(document.getElementById(item_layout["id"]).closest(".grid-stack-item"), item_layout["options"]);
  }
}

function changeGridStackItem(item) {
  grid.update(document.getElementById("c_line").closest(".grid-stack-item"), (1, 1));
}

function saveGrid() {
  serializedData = grid.save();
  //TODO return does not work, this has to be done using the shiny callbacks
  return JSON.stringify(serializedData, null, '  ');
}
