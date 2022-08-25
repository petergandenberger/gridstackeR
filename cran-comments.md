## R CMD check results
There were no ERRORs, WARNINGs or NOTEs. 

## 0.1.0 Resubmission

### Review 1 - 2022-08-24

> Please always write package names, software names and API (application
programming interface) names in single quotes in title and description.
e.g: --> 'gridstack.js'
Please note that package names are case sensitive.

Added single quotes around 'gridstack.js' in title and description.

> The Description field is intended to be a (one paragraph) description
of what the package does and why it may be useful.
Please add more details about the package functionality and implemented
methods in your Description text.

Added more details to the description

> Please provide a link to the used webservices (gridstack.js) to the
description field
of your DESCRIPTION file in the form
<http:...> or <https:...>
with angle brackets for auto-linking and no space after 'http:' and
'https:'.

Added link to the gridstack.js github page

> We do not need "| file LICENSE" and the file as these are part of R.
This is only needed in case of attribution requirements or other
possible restrictions.
Hence please omit it.

Removed "| file LICENSE" and the file itself

> Please add \value to .Rd files regarding exported methods and explain
the functions results in the documentation. Please write about the
structure of the output (class) and also what the output means.
(If a function does not return a value, please document that too, e.g.
\value{No return value, called for side effects} or similar)
Missing Rd-tags:
      grid_stack.Rd: \value
      grid_stack_item.Rd: \value
      gridstackeR_demo.Rd: \value
      
Added @return annotations to all three functions

> Please add small executable examples in your Rd-files to illustrate the
use of the exported function but also enable automatic testing. If this
is not
possible due to the function of your package please try to write
additional test.

Added code examples and additional tests
