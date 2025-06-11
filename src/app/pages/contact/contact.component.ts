import { Component } from '@angular/core';
import emailjs from '@emailjs/browser';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-contact',
  standalone: true,
  imports: [FormsModule, CommonModule],
  templateUrl: './contact.component.html',
  styleUrls: ['./contact.component.css']
})

export class ContactComponent {
  formData = {
    name: '',
    email: '',
    message: ''
  };

  success = false;
  error = false;

  sendEmail(form: any) {
    if (form.invalid) return;

    emailjs.send('service_okwhk9f', 'template_tvdxbwn', this.formData, 'R3dUaUR_-IAvUbpfX')
      .then(() => {
        this.success = true;
        this.error = false;
        form.resetForm();
        setTimeout(() => this.success = false, 5000); 
      }, (error) => {
        this.success = false;
        this.error = true;
        setTimeout(() => this.error = false, 5000); 
      });
  }
}
