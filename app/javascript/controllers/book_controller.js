import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="book"
export default class extends Controller {
  
  static targets = ['judulBuku', 'tahunTerbit', 'penulis'];
  
  submitForm(event) {
    event.preventDefault(); // Prevent default form submission

    // Get the values from the input fields
    const judulBuku = this.judulBukuTarget.value;
    const tahunTerbit = this.tahunTerbitTarget.value;
    const penulis = this.penulisTarget.value;

    console.log('Judul Buku:', judulBuku);
    console.log('Tahun Terbit:', tahunTerbit);
    console.log('Penulis:', penulis);

    // Perform an AJAX request or other actions with the form data here
    // You could use fetch() or axios() to submit data
  }

  connect() {
  }

  showModal() {
      let modal_card = document.getElementById('modal-form');
      modal_card.classList.remove('hidden');
  }

  removeModal() {
    let modal_card = document.getElementById('modal-form');
    modal_card.classList.add('hidden');
  }


}
