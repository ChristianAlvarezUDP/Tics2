let dataTable;
let dataTableIsInitialized = false;

const dataTableOptions = {
    autoWidth: true,
    scrollX: true,

    serverSide: true,
    ajax: {
        url: '/admin_data_ajax',
        type: 'POST'
    },
    
    lengthMenu: [5, 10, 15, 20, 100, 200, 500],
    columnDefs: [
        { className: "centered", targets: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12] },
        { orderable: false, targets: [0] },
        { searchable: true, targets: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12] }
    ],
    columns: [
        {
            title: "", 
            "name": "Info",
            "mRender": function(data, type, full) {
                return '<a href="/admin/pets/' + full['id'] + '" class="exam-button"><span class="material-symbols-outlined">list</span></a>';
            },
            data: null,
            width: "70px"
        },
        {title: "Mascota", "name": "Mascota", data: 'name'},
        {title: "ID", "name": "ID", data: 'id'},
        {title: "Codigo admivet", "name": "Codigo admivet", data: 'admivet_code'},
        {title: "Especie-Raza", "name": "Especie-Raza", data: null,
            "render": function(data, type, full) {
                return full['species'] + " - " + full['breed'];
            },
        },
        {title: "Sexo", "name": "Sexo", data: null,
            "render": function(data, type, full) {
                
                switch(full['sex']){
                    case 0:
                        return "Macho";
                    case 1:
                        return "Hembra";
                    case 2:
                        return "Indeterminado";
                    default:
                        return "";
                };
            },
        },
        {title: "Color", "name": "Color", data: 'color'},
        {title: "Chip", "name": "Chip", data: 'chip'},
        {title: "ID-legal", "name": "ID-legal", data: null,
            "render": function(data, type, full) {
                return full['id_type'] + " - " + full['legal_id'];
            },
        },
        {title: "Dueño", data: 'clientName'},
        {title: "Numero 1", "name": "Numero 1", data: 'number_1'},
        {title: "Numero 2", "name": "Numero 2", data: 'number_2'},
        {title: "Edad", "name": "Edad", data: 'age'},
    ],
    pageLength: 30,
    destroy: true,
    dom: 'frtip',
    language: {
        lengthMenu: "Mostrar _MENU_ registros por página",
        zeroRecords: "Ningún registro encontrado",
        info: "Mostrando de _START_ a _END_ de un total de _TOTAL_ registros",
        infoEmpty: "Ningún registro encontrado",
        infoFiltered: "(filtrados desde _MAX_ registros totales)",
        search: "Buscar:",
        loadingRecords: "Cargando...",
        paginate: {
            first: "Primero",
            last: "Último",
            next: "Siguiente",
            previous: "Anterior"
        }
    },
    initComplete: function () {
        this.api().columns().every(function () {
            var column = this;
            var select = $('<select><option value=""></option></select>')
                .appendTo($(column.footer()).empty())
                .on('change', function () {
                    var val = $.fn.dataTable.util.escapeRegex(
                        $(this).val()
                    );
                    column
                        .search(val ? '^' + val + '$' : '', true, false)
                        .draw();
                });
            column.data().unique().sort().each(function (d, j) {
                select.append('<option value="' + d + '">' + d + '</option>')
            });
        });
    }
};

$(document).ready(function () {
    dataTable = $("#datatable_pets").DataTable(dataTableOptions);
    dataTableIsInitialized = true;
    document.getElementById("datatable_pets").style.display = "table"
});