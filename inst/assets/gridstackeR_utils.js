shinyjs.load_grid_layout = function(params){
  var defaultParams = {
    grid_id : null,
    layout : null
  };
  params = shinyjs.getParams(params, defaultParams);
  if(params.grid_id == null | params.layout == null) {
    console.log('function load_grid_layout needs a grid_id and layout');
  } else {
    load_grid_layout(params.grid_id, params.layout);
  }
}

shinyjs.save_grid_layout = function(params){
  var defaultParams = {
    grid_id : null,
    ns : ''
  };
  params = shinyjs.getParams(params, defaultParams);
  if(params.grid_id == null) {
    console.log('function save_grid_layout needs a grid_id');
  } else {
    save_grid_layout(params.grid_id, params.ns);
  }
}

shinyjs.load_grid = function(params){
  var defaultParams = {
    grid_id : null,
    grid_new : null
  };
  params = shinyjs.getParams(params, defaultParams);
  if(params.grid_id == null | params.grid_new == null) {
    console.log('function save_grid_stack_layout needs a grid_id and a grid_new');
  } else {
    load_grid(params.grid_id, params.grid_new);
  }
}

shinyjs.add_grid_element = function(params){
  var defaultParams = {
    grid_id : null,
    element : null
  };
  params = shinyjs.getParams(params, defaultParams);
  if(params.grid_id == null | params.element == null) {
    console.log('function add_grid_element needs a grid_id and a element');
  } else {
    add_grid_element(params.grid_id, params.element);
  }
}

shinyjs.remove_grid_element = function(params){
  var defaultParams = {
    grid_id : null,
    element_id : null
  };
  params = shinyjs.getParams(params, defaultParams);
  if(params.grid_id == null | params.element_id == null) {
    console.log('function remove_grid_element needs a grid_id and a element');
  } else {
    remove_grid_element(params.grid_id, params.element_id);
  }
}

shinyjs.remove_all_grid_elements = function(params){
  var defaultParams = {
    grid_id : null
  };
  params = shinyjs.getParams(params, defaultParams);
  if(params.grid_id == null) {
    console.log('function remove_all_grid_elements needs a grid_id');
  } else {
    remove_all_grid_elements(params.grid_id, params.element);
  }
}


shinyjs.remove_grid = function(params){
  var defaultParams = {
    grid_id : null
  };
  params = shinyjs.getParams(params, defaultParams);
  if(params.grid_id == null) {
    console.log('function remove_grid needs a grid_id');
  } else {
    remove_grid(params.grid_id);
  }
}
