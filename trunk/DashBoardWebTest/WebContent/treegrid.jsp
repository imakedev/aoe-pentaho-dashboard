<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>
            TreeGrid Example
        </title>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/chartLib/js/resources/css/ext-all.css">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/chartLib/js/shared/example.css">
        <script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/ext.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/treegrid.js"></script>
        <style type="text/css">
            .task {
                background-image: url(<%=request.getContextPath()%>/chartLib/js/shared/icons/fam/cog.gif) !important;
            }
            .task-folder {
                background-image: url(<%=request.getContextPath()%>/chartLib/js/shared/icons/fam/folder_go.gif) !important;
            }
        </style>
        <script>
        /*

        This file is part of Ext JS 4

        Copyright (c) 2011 Sencha Inc

        Contact:  http://www.sencha.com/contact

        GNU General Public License Usage
        This file may be used under the terms of the GNU General Public License version 3.0 as published by the Free Software Foundation and appearing in the file LICENSE included in the packaging of this file.  Please review the following information to ensure the GNU General Public License version 3.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.

        If you are unsure which license is appropriate for your use, please contact the sales department at http://www.sencha.com/contact.

        */
        Ext.require([
            'Ext.data.*',
            'Ext.grid.*',
            'Ext.tree.*'
        ]);

        Ext.onReady(function() {
            //we want to setup a model and store instead of using dataUrl
        alert("test")
            Ext.define('Task', {
                extend: 'Ext.data.Model',
                fields: [
                    {name: 'task',     type: 'string'},
                    {name: 'user',     type: 'string'},
                    {name: 'duration', type: 'string'}
                ]
            });

            var store = Ext.create('Ext.data.TreeStore', {
                model: 'Task',
                proxy: {
                    type: 'ajax',
                    //the store will get the content from the .json file
                    url: '<%=request.getContextPath()%>/chartLib/js/treegrid.json'
                },
                folderSort: true
            });

            //Ext.ux.tree.TreeGrid is no longer a Ux. You can simply use a tree.TreePanel
            var tree = Ext.create('Ext.tree.Panel', {
                title: 'Core Team Projects',
                width: 500,
                height: 300,
                renderTo: Ext.getBody(),
                collapsible: true,
                useArrows: true,
                rootVisible: false,
                store: store,
                multiSelect: true,
                singleExpand: true,
                //the 'columns' property is now 'headers'
                columns: [{
                    xtype: 'treecolumn', //this is so we know which column will show the tree
                    text: 'Task',
                    flex: 2,
                    sortable: true,
                    dataIndex: 'task'
                },{
                    //we must use the templateheader component so we can use a custom tpl
                    xtype: 'templatecolumn',
                    text: 'Duration',
                    flex: 1,
                    sortable: true,
                    dataIndex: 'duration',
                    align: 'center',
                    //add in the custom tpl for the rows
                    tpl: Ext.create('Ext.XTemplate', '{duration:this.formatHours}', {
                        formatHours: function(v) {
                            if (v < 1) {
                                return Math.round(v * 60) + ' mins';
                            } else if (Math.floor(v) !== v) {
                                var min = v - Math.floor(v);
                                return Math.floor(v) + 'h ' + Math.round(min * 60) + 'm';
                            } else {
                                return v + ' hour' + (v === 1 ? '' : 's');
                            }
                        }
                    })
                },{
                    text: 'Assigned To',
                    flex: 1,
                    dataIndex: 'user',
                    sortable: true
                }]
            });
        });

        </script>
    </head>
    <body>
        <h1>
            TreeGrid Example
        </h1>
        <p>
            This example is an advanced tree example. It illustrates:
        </p>
        <ul class="feature-list">
            <li>Multiple headers
            </li>
            <li>Preloading of nodes with a single AJAX request
            </li>
            <li>Header hiding, showing, reordering and resizing
            </li>
            <li>useArrows configuration
            </li>
            <li>Keyboard Navigation
            </li>
            <li>Discontinguous selection by holding the CTRL key
            </li>
            <li>Using custom iconCls
            </li>
            <li>singleExpand has been set to true
            </li>
        </ul>
      
        <div id="tree-example"></div>
    </body>
</html>
