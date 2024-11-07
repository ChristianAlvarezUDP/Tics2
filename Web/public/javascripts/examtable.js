$(document).ready(function() {
    $('#datatable_exams').DataTable( {
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
        lengthMenu: [5, 10, 15, 20, 100, 200, 500],
        autoWidth: false,
        scrollX: true,
        columnDefs: [
            { className: "centered", targets: [0, 1, 2] },
            { orderable: false, targets: [2] },
            //{ searchable: false, targets: [1] }
        ],
        pageLength: 30,
        destroy: true,
        dom: 'frtip'
    });
});
