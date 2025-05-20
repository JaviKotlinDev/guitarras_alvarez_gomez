import { Component } from '@angular/core';
import emailjs from 'emailjs-com';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-contact',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './contact.component.html',
  styleUrls: ['./contact.component.css']
})

export class ContactComponent {

formData = {
    name: '',
    email: '',
    message: ''
  };

  sendEmail(form: any) {
    if (form.invalid) return;

    emailjs.send('service_okwhk9f', 'template_tvdxbwn', this.formData, 'R3dUaUR_-IAvUbpfX')
      .then(() => {
        alert('Mensaje enviado con éxito');
        form.resetForm();
      }, (error) => {
        console.error('Error al enviar el mensaje:', error);
        alert('Error al enviar el mensaje. Inténtalo más tarde.');
      });
  }

}
