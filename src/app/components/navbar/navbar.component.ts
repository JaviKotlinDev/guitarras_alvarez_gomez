import { Component, HostListener  } from '@angular/core';
import { NgIf } from '@angular/common';
import { RouterLink, RouterLinkActive } from '@angular/router';

@Component({
  selector: 'app-navbar',
  imports: [RouterLink, RouterLinkActive, NgIf],
  templateUrl: './navbar.component.html',
  styleUrl: './navbar.component.css'
})

export class NavbarComponent {
  menuOpen = false;
  isMobileView = window.innerWidth < 768; // md breakpoint

  toggleMenu() {
    this.menuOpen = !this.menuOpen;
  }

  @HostListener('window:resize')
  onResize() {
    this.isMobileView = window.innerWidth < 768;
    if (!this.isMobileView) {
      this.menuOpen = false;
    }
  }

  isMobile() {
    return this.isMobileView;
  }
  
}