<template>
  <v-app id="inspire">
    <!--
      COLOCAR EN CUANDO SE CONCRETE LOS LOGUEOS:
        En v-navigation-drawer -> v-if="logueado"
        En los grupos de listas -> v-if="esAdministrador || esAlmacenero || esVendedor"
    -->
    <!--BARRA LATERAL -->
    <v-navigation-drawer
      app
      dark
      absolute
      permanent
      v-model="drawer"
      :mini-variant.sync="mini"
      :clipped="$vuetify.breakpoint.lgAndUp"
    >

      <!--LISTA DE BARRA LATERAL-->
      <!--Ver lista de iconos en 'material.io/tools/icons'-->

      <v-list shaped>

        <!--BOTÓN INICIO -->
        <v-list-item :to="{name:'Home'}">
          <v-list-item-action>
            <v-icon>mdi-home</v-icon>
          </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>
                Inicio
              </v-list-item-title>
            </v-list-item-content>
        </v-list-item>

          <!--LISTA DE -->
          <v-list-group class="px-0">
            <v-list-item slot="activator" class="px-0">
              <v-list-item-action>
                <v-icon>mdi-ice-cream</v-icon>
              </v-list-item-action>
              <v-list-item-content>
                <v-list-item-title>
                  Producto
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
              <v-list-item :to="{name:'categorias'}" class="px-8">
                <v-list-item-action>
                  <v-icon>mdi-layers-triple</v-icon>
                </v-list-item-action>
                <v-list-item-content>
                  <v-list-item-title>
                    Categorías
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
              <v-list-item :to="{ name: 'productos'}" class="px-8">
                <v-list-item-action>
                  <v-icon>mdi-fridge-top</v-icon>
                </v-list-item-action>
                <v-list-item-content>
                  <v-list-item-title>
                      Productos
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
          </v-list-group>


          <!--LISTA DE -->
          <!--v-list-group class="px-0">
            <v-list-item slot="activator" class="px-0">
              <v-list-item-action>
                <v-icon>table_chart</v-icon>
              </v-list-item-action>
              <v-list-item-content>
                <v-list-item-title>
                  Registro
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>

              <v-list-item :to="{ name: 'personas'}" class="px-8">
                <v-list-item-action>
                  <v-icon>table_chart</v-icon>
                </v-list-item-action>
                <v-list-item-content>
                  <v-list-item-title>
                    Personas
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
          </v-list-group-->

          <!--LISTA DE -->
          <v-list-group class="px-0">
            <v-list-item slot="activator" class="px-0">
              <v-list-item-action>
                <v-icon>mdi-point-of-sale</v-icon>
              </v-list-item-action>
              <v-list-item-content>
                <v-list-item-title>
                  Venta
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>

              <v-list-item :to="{ name: 'ventas'}" class="px-8">
                <v-list-item-action>
                  <v-icon>mdi-sale</v-icon>
                </v-list-item-action>
                <v-list-item-content>
                  <v-list-item-title>
                    Ventas
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
              <v-list-item :to="{ name: 'clientes'}" class="px-8">
                <v-list-item-action>
                  <v-icon>mdi-account-supervisor-circle</v-icon>
                </v-list-item-action>
                <v-list-item-content>
                  <v-list-item-title>
                    Clientes
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
          </v-list-group>


          <!--LISTA DE -->
          <v-list-group class="px-0">
            <v-list-item slot="activator" class="px-0">
              <v-list-item-action>
                <v-icon>mdi-account-group</v-icon>
              </v-list-item-action>
              <v-list-item-content>
                <v-list-item-title>
                  Accesos
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>

              <v-list-item :to="{ name: 'roles'}" class="px-8">
                <v-list-item-action>
                  <v-icon>mdi-microsoft-xbox-controller-menu</v-icon>
                </v-list-item-action>
                <v-list-item-content>
                  <v-list-item-title>
                    Roles
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
              <v-list-item :to="{ name: 'trabajadores'}" class="px-8">
                <v-list-item-action>
                  <v-icon>mdi-account-details</v-icon>
                </v-list-item-action>
                <v-list-item-content>
                  <v-list-item-title>
                    Trabajadores
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
          </v-list-group>

          <!--LISTA DE -->
          <!--v-list-group class="px-0">
            <v-list-item slot="activator" class="px-0">
              <v-list-item-action>
                <v-icon>table_chart</v-icon>
              </v-list-item-action>
              <v-list-item-content>
                <v-list-item-title>
                  Consultas
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>

                  <v-list-item :to="{ name: 'consulta ventas'}" class="px-8">
                    <v-list-item-action>
                      <v-icon>table_chart</v-icon>
                    </v-list-item-action>
                    <v-list-item-content>
                      <v-list-item-title>
                        Consulta ventas
                      </v-list-item-title>
                    </v-list-item-content>
                  </v-list-item>
                  <v-list-item :to="{ name: 'comprobantes'}" class="px-8">
                    <v-list-item-action>
                      <v-icon>table_chart</v-icon>
                    </v-list-item-action>
                    <v-list-item-content>
                      <v-list-item-title>
                        Comprobantes
                      </v-list-item-title>
                    </v-list-item-content>
                  </v-list-item>
          </v-list-group-->

      </v-list>
    </v-navigation-drawer>

      <!--BARRA SUPERIOR-->

      <v-app-bar
        :clipped-left="$vuetify.breakpoint.lgAndUp"
        app
        color="red lighten-1"
        dark
      >
      <v-app-bar-nav-icon
        @click="drawer = !drawer"
        @click.stop="mini = !mini"
        >
      </v-app-bar-nav-icon>

      <v-toolbar-title
        style="width: 400px"
        class="ml-0 pl-4"
      >
        <span class="hidden-sm-and-down">Single Page Application (Venta Helados)</span>
        <!--Single Page Application (Venta Helados)-->
      </v-toolbar-title>
        <v-spacer></v-spacer>
      <v-btn icon>
        <v-icon>apps</v-icon>
      </v-btn>
    </v-app-bar>

    <!--CONTENIDO-->
    <v-main>
      <v-container class="fill-height">
        <v-slide-y-transition mode="out-in">
            <router-view/>
        </v-slide-y-transition>
      </v-container>
    </v-main>
  </v-app>
</template>
<script>
  export default {
    name: 'App',
    data: () => ({
      drawer: true,
      mini: true,
      selectedItem: 0,
    }),
    computed: {
      logueado(){
        return this.$store.state.usuario;
      },
      esAdministrador(){
        return this.$store.state.usuario && this.$store.state.usuario.rol =='Administrador';
      },
      esAlmacenero(){
        return this.$store.state.usuario && this.$store.state.usuario.rol =='Almacenero';
      },
      esVendedor(){
        return this.$store.state.usuario && this.$store.state.usuario.rol =='Vendedor';
      }
    },
    created(){
      this.$store.dispatch("autoLogin");
    },
    methods:{
      salir(){
        this.$store.dispatch("salir");
      }
    }
  }
</script>
