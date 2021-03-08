import Vue from 'vue'
import VueRouter from 'vue-router'

//Login//
import Login from '../components/Login.vue'

//Home//
import Home from '../views/Home.vue'

//Producto//
import Categoria from '../components/Ventas/Categoria.vue'
import Producto from '../components/Ventas/Producto.vue'

//Registro//
import Persona from '../components/Trabajadores/Persona.vue'

//Ventas//
import Cliente from '../components/Trabajadores/Cliente.vue'
import Venta from '../components/Ventas/Venta.vue'

//Accesos//
import Rol from '../components/Trabajadores/Rol.vue'
import Trabajador from '../components/Trabajadores/Trabajador.vue'

//Consultas//
import Comprobante from '../components/Ventas/Comprobante.vue'
import DetalleVenta from '../components/Ventas/DetalleVenta.vue'

Vue.use(VueRouter)

  const routes = [

    //Login//
    {
      path: '/',
      name: 'Login',
      component: Login
    },

    //Inicio//
    {
      path: '/inicio',
      name: 'Home',
      component: Home
    },

    //Producto//
    {
      path: '/categorias',
      name: 'categorias',
      component: Categoria
    },
    {
      path: '/productos',
      name: 'productos',
      component: Producto
    },

    //Registro//
    {
      path: '/personas',
      name: 'personas',
      component: Persona
    },

    //Ventas//
    {
      path: '/clientes',
      name: 'clientes',
      component: Cliente
    },
    {
      path: '/ventas',
      name: 'ventas',
      component: Venta
    },

    //Accesos (Trabajadores)//
    {
      path: '/roles',
      name: 'roles',
      component: Rol
    },
    {
      path: '/trabajadores',
      name: 'trabajadores',
      component: Trabajador
    },

    //Consultas//
    {
      path: '/comprobantes',
      name: 'comprobantes',
      component: Comprobante
    },
    {
      path: '/consulta ventas',
      name: 'consulta ventas',
      component: DetalleVenta
    },

]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
