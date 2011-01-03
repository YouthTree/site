document.observe("dom:loaded", function() {
  drag_order_index = new DragOrderIndex();
  drag_order_index.initialize();
})

Event.addBehavior({
  '.index#pages': SiteMapBehavior(),  
  '.index': RuledTableBehavior(),
});

var DragOrderIndex = Class.create({
  
  initialize: function() {
    this.sortPages();
  },
  
  sortPages: function() {
    var tree = new SortableTree('parent_pages', {
      draggable: {
        handle: 'handle',
        ghosting: false,
        scroll: window,
        constraint:  false,
        onDrag: function(drag, event) {
          drag.element.addClassName('drag_move');          
        },
        onEnd: function(drag, event) {
          drag.element.removeClassName('drag_move');
        }
      },
      onDrop: function(drag, drop, event){
        this.assignIndentation(drag.element);
        this.assignExpanders(drag.element);
        
        new Ajax.Request('/admin/pages/sort.js', {
          method: 'put',
          parameters: {
            'parent_id': this.getPageID(drag.element.up('.page')),
            'children' : this.buildChildrenString(drag.element.up('.children').immediateDescendants())
          }
        });
      }.bind(this)
    });
    tree.setSortable();
  },
  
  assignExpanders: function(element) {
    element.up('#pages').select('.page').each(function(page) {
      var children = page.down('.children').immediateDescendants();
      
      // If there are children, it's not the home and it doesn't have children_visible
      if (children.length > 0) {
        if (!page.hasClassName('level_0') && page.hasClassName('no_children')) {
          // Toggle Expand Class (we want an expander)
          page.down('.expander').addClassName('visible');
          page.down('.expander').removeClassName('hidden');

          // Toggle Children Identifier Classes (there are children)  
          page.addClassName('children_visible');
          page.removeClassName('no_children');
        }
      }
      // Else if there is not already a class of no children
      else if (!page.hasClassName('no_children')) {
        // Toggle Expand Class
        page.down('.expander').addClassName('hidden');
        page.down('.expander').removeClassName('visible');
        
        // Toggle Children Identifier Classes
        page.addClassName('no_children');
        page.removeClassName('children_visible');
        page.removeClassName('children_hidden');
      }
    });
  },
  
  assignIndentation: function(page) {
    var level = parseInt(page.up('.page').getAttribute('data-level'))
    
    level += 1;    
    page.setAttribute('data-level', level);
    page.addClassName('level_' + level);
    page.down('.attributes').setStyle({ paddingLeft: ((level * 23) + 31) + 'px' });
    
    page.select('.children').each(function(container) {
      level += 1;
      container.select('.page').each(function(page) {
        page.setAttribute('data-level', level);
        page.addClassName('level_' + level);
        page.down('.attributes').setStyle({ paddingLeft: ((level * 23) + 31) + 'px' });
      });
    });
  },
  
  buildChildrenString: function(pages) {
    var drag_order = this;
    
    var children = '';    
    pages.each(function(page) {
      children += drag_order.getPageID(page) + ',';
    })
    children = children.slice(0,-1);
    
    return children;
  },
  
  getPageID: function(page) {
    return page.readAttribute('data-page_id');
  }
})