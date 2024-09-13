import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"; // Adjust the path if necessary

// Connects to data-controller="book"
export default class extends Controller {
  static targets = ['judulBuku', 'tahunTerbit', 'penulis', 'helperText'];

  async submitForm(event) {
    event.preventDefault(); // Prevent default form submission

    // Get the values from the input fields
    const judulBuku = this.judulBukuTarget.value;
    const tahunTerbit = this.tahunTerbitTarget.value;
    const penulis = this.penulisTarget.value;

    // Clear previous messages
    this.helperTextTarget.textContent = '';

    // Perform an AJAX request to submit data
    try {
      const response = await fetch('/add_book', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        },
        body: JSON.stringify({
          book: { // Ensure to wrap your data with the correct key
            judul: judulBuku,
            tahun_terbit: tahunTerbit,
            author_id: penulis,
          },
        }),
      });

      if (response.ok) {
        const data = await response.json();
        console.log('Book created successfully:', data);
        this.helperTextTarget.classList.remove("text-red-500");
        this.helperTextTarget.classList.add("text-green-500"); 
        this.helperTextTarget.textContent = "Buku berhasil ditambahkan!";
        this.removeModal();
      } else {
        const errorData = await response.json();
        console.error('Error creating book:', errorData);
        this.helperTextTarget.classList.remove("text-green-500");
        this.helperTextTarget.classList.add("text-red-500");
        this.helperTextTarget.textContent = errorData.errors.join(", ");
      }
    } catch (error) {
      console.error('Error:', error);
      this.helperTextTarget.classList.remove("text-green-500");
      this.helperTextTarget.classList.add("text-red-500"); 
      this.helperTextTarget.textContent = "Terjadi kesalahan saat menambahkan buku."; 
    }
  }

  connect() {
    if (!this.subscription) {
      this.subscribeToBooksChannel();
    }
  }

  subscribeToBooksChannel() {
    this.subscription = consumer.subscriptions.create("BooksChannel", {
      received: (data) => {
        if (data.action === "create") {
          this.addBookRow(data.book);
        }
      },
    });
  }

  addBookRow(book) {
    // Check if the book already exists in the table
    const existingRows = this.tableBodyTarget.querySelectorAll("tr");
    const exists = Array.from(existingRows).some(row => {
      const titleCell = row.querySelector("th");
      return titleCell && titleCell.textContent === book.judul;
    });
  
    if (!exists) {
      const row = document.createElement("tr");
      row.classList.add("odd:bg-white", "odd:dark:bg-gray-900", "even:bg-gray-50", "even:dark:bg-gray-800", "border-b", "dark:border-gray-700");
      row.innerHTML = `
        <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
          ${book.judul}
        </th>
        <td class="px-6 py-4">
          ${book.tahun_terbit}
        </td>
        <td class="px-6 py-4">
          ${book.author.nama}
        </td>
      `;
    
      this.tableBodyTarget.appendChild(row);
    }
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
