import Sortable from 'sortablejs';

const initSortable = () => {
    const list = document.getElementById("letters");
    Sortable.create(list);
};

export { initSortable };