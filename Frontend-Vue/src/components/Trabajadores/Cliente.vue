<template>
  <v-layout align-start>
    <v-flex>
      <v-toolbar flat color="dark">
        <v-toolbar-title>Clientes</v-toolbar-title>
          <v-divider class="mx-2" inset vertical></v-divider>
            <v-spacer></v-spacer>
          <v-text-field class="text-xs-center" v-model="search" append-icon="search" label="Búsqueda" single-line hide-details></v-text-field>
            <v-spacer></v-spacer>
          <v-dialog v-model="dialog" max-width="500px">
            <template v-slot:activator="{ on, attrs }">
              <v-btn class="mx-2" fab dark large color="purple" v-bind="attrs" v-on="on">
                <v-icon dark>mdi-plus</v-icon>
              </v-btn>
            </template>
            <v-card>
                <v-card-title>
                  <span class="headline">{{ formTitle }}</span>
                </v-card-title>
                <v-card-text>
                  <v-container grid-list-md>
                    <v-layout wrap>
                      <!-- Campos de la ventana modal-->
                      <v-flex xs12 sm12 md12>
                        <v-text-field v-model="dni" label="DNI *"></v-text-field>
                      </v-flex>
                      <v-flex xs12 sm12 md12 v-show="valida">
                        <div class="red--text" v-for="v in validaMensaje" :key="v" v-text="v"></div>
                      </v-flex>
                    </v-layout>
                  </v-container>
                </v-card-text>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <!-- Botones de la ventana modal-->
                  <v-btn color="red darken-1" flat @click.native="cerrar">Cancelar</v-btn>
                  <v-btn color="blue darken-1" flat @click.native="guardar">Guardar</v-btn>
                </v-card-actions>
            </v-card>
          </v-dialog>
        <v-dialog v-model="adModal" max-width="500px"></v-dialog>
      </v-toolbar>

      <v-data-table
        :headers="headers"
        :items="clientes"
        :search="search"
        class="elevation-1"
      >
        <template slot="items" slot-scope="props">
          <td>{{ props.item.idCliente }}</td>
          <td>{{ props.item.dni }}</td>
          <td class="justify-center layout px-0"></td>
        </template>
        <!--template v-slot:item.opciones="{ item }"-->
        <template v-slot:[`item.opciones`]="{ item }">
            <v-icon
                small
                class="mr-2"
                @click="editItem(item)"
            >
                create
            </v-icon>
        </template>
        <template slot="no-data" class="mx-5">
          <v-spacer class="ma-5"></v-spacer>
            <span>
              NO SE HAN ENCONTRADO DATOS, INTENTE RECARGAR
            </span>
          <v-spacer class="ma-2"></v-spacer>
            <v-btn
              :loading="loading" :disabled="loading"
              color=#000000 class="ma-2 white--text"
              @click="listar, loader = 'loading'"
              :to="{name:'productos'}"
            >
              <v-icon left>
                  mdi-reload
              </v-icon>
                Recargar
            </v-btn>
          <v-spacer class="ma-5"></v-spacer>
        </template>
      </v-data-table>
    </v-flex>
  </v-layout>
</template>


<script>
    import axios from 'axios'
    export default {
        data () {
            return {
                clientes:[],
                dialog: false,
                loader: null,
                loading: false,
                headers: [

                { text: 'Id', value: 'idCliente' },
                { text: 'DNI', value: 'dni', sortable: false},
                { text: 'Opciones', value: 'opciones', sortable: false}

                ],
                search: '',

                editedIndex: -1,
                idCliente: '',
                dni: '',
                valida: 0,
                validaMensaje:[],

            }
        },
        computed: {
            formTitle () {
                 return this.editedIndex === -1 ? 'Nuevo Cliente' : 'Actualizando Cliente'
            }
        },

        watch: {
            dialog (val) {
            val || this.cerrar()
            },
          loader () {
            const l = this.loader
            this[l] = !this[l]
            setTimeout(() => (this[l] = false), 3000)
            this.loader = null
          },
        },

        created () {
            //this.initialize()
            this.listar()
        },
        methods:{
            listar(){
                let me =this;
                axios.get('api/Clientes/Listar').then(function(response){
                  me.clientes=response.data;
                }).catch(function(error){
                    console.log(error);

                });

            },

            initialize () {
            this.listar();

            },

            editItem (item) {
                this.idCliente=item.idCliente;
                this.dni=item.dni;
                this.editedIndex=1;
                this.dialog = true
            },

            cerrar () {
                this.dialog = false;
                this.limpiar();

            },

            limpiar(){
                this.idCliente="";
                this.dni="";
                this.editedIndex=-1;

            },
            guardar () {

                if(this.validar()){
                    return;
                }
                if (this.editedIndex > -1) {
                    //código para editar

                    let me=this;
                    axios.put('api/Clientes/Actualizar',{
                        'idCliente': me.idCliente,
                        'dni':me.dni,
                    }).then(function(response){
                        me.cerrar();
                        me.listar();
                        me.limpiar();

                    }).catch(function(error){
                        console.log(error);
                    });
                } else {
                    // código para guardar
                    let me=this;
                    axios.post('api/Clientes/Crear',{
                        'dni': me.dni,
                    }).then(function(response){
                        me.cerrar();
                        me.listar();
                        me.limpiar();

                    }).catch(function(error){
                        console.log(error);
                    });
                }

            },


           validar(){
               this.valida=0;
               this.validaMensaje=[];
               if(this.dni.length > 8 || this.dni.length < 8){
                   this.validaMensaje.push("El DNI solo consta de 8 caracteres");
               }
               if(this.validaMensaje.length){
                   this.valida=1;
               }
               return this.valida;
           },
        }
    }
</script>

<style>
  .custom-loader {
    animation: loader 1s infinite;
    display: flex;
  }
  @keyframes loader {
    from {
      transform: rotate(0);
    }
    to {
      transform: rotate(360deg);
    }
  }
</style>
