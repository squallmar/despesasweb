// app/javascript/application.js

// Importe Turbo e Stimulus primeiro
import "@hotwired/turbo-rails"
import "controllers"

// Configure Bootstrap
import { Tooltip, Popover, Dropdown, Offcanvas } from "bootstrap"

// Disponibilize os componentes globalmente
window.bootstrap = { Tooltip, Popover, Dropdown, Offcanvas }

// Função para inicializar componentes
const initializeBootstrap = () => {
  // Tooltips
  document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(el => {
    new bootstrap.Tooltip(el)
  })
  
  // Popovers
  document.querySelectorAll('[data-bs-toggle="popover"]').forEach(el => {
    new bootstrap.Popover(el)
  })
}

// Inicialize quando o DOM estiver pronto
document.addEventListener("DOMContentLoaded", initializeBootstrap)

// Reinicialize após cada navegação Turbo
document.addEventListener("turbo:load", initializeBootstrap)