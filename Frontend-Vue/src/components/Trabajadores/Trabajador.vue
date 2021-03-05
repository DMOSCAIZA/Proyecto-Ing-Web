<template>
    <v-layout align-start>
        <v-flex>
            <v-toolbar flat color="dark">
                <v-toolbar-title>Usuarios</v-toolbar-title>
                <v-divider
                class="mx-2"
                inset
                vertical
                ></v-divider>
                <v-spacer></v-spacer>
                <v-text-field class="text-xs-center" v-model="search" append-icon="search" label="Búsqueda" single-line hide-details></v-text-field>
                <v-spacer></v-spacer>
                <v-dialog v-model="dialog" max-width="500px">

                <template v-slot:activator="{ on, attrs }">
              <v-btn class="mx-2" fab dark large color="purple" v-bind="attrs" v-on="on">
                <v-icon dark>
                  mdi-plus
                </v-icon>
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
                                <v-text-field v-model="idRol" label="Id Rol"></v-text-field>
                            </v-flex>
                            <v-flex xs12 sm12 md12>
                                <v-text-field v-model="dni" label="DNI"></v-text-field>
                            </v-flex>
                            <v-flex xs12 sm12 md12>
                                <v-text-field v-model="email" label="Email"></v-text-field>
                            </v-flex>

                            <v-flex xs12 sm12 md12 v-show="valida">
                                <div class="red--text" v-for="v in validaMensaje" :key="v" v-text="v">
                                </div>
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

                <v-dialog v-model="adModal" max-width="290px">
                    <v-card>
                        <v-card-title class="headline"  v-if="adAccion==1">¿Activar item?</v-card-title>
                        <v-card-title class="headline"  v-if="adAccion==2">¿Desactivar item?</v-card-title>
                        <v-card-text>
                            Estás a punto de
                            <span v-if="adAccion==1">Activar </span>
                            <span v-if="adAccion==2">Desactivar </span>
                            el Usuario {{ adidUsuario  }}
                        </v-card-text>
                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn color="red darken-1" flat="flat" @click="activarDesactivarCerrar">
                                Cancelar
                            </v-btn>
                            <v-btn v-if="adAccion==1" color="blue darken-1" flat="flat" @click="activar">
                                Activar
                            </v-btn>
                            <v-btn v-if="adAccion==2" color="blue darken-1" flat="flat" @click="desactivar">
                                Desactivar
                            </v-btn>
                        </v-card-actions>
                    </v-card>
                </v-dialog>

            </v-toolbar>

            <v-data-table
                :headers="headers"
                :items="usuarios"
                :search="search"
                class="elevation-1"
            >
                <template slot="items" slot-scope="props">
                        <td>{{ props.item.idUsuario }}</td>
                        <td>{{ props.item.idRol }}</td>
                        <td>{{ props.item.dni }}</td>
                        <td>{{ props.item.email }}</td>
                        <td>
                            <div v-if="props.item.condicion_usuario">
                                <span class="green -- text">Activo</span>
                            </div>
                            <div v-else>
                                <span class="red -- text">Inactivo</span>
                            </div>
                        </td>

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

                            <template v-if="item.condicion_usuario">
                                <v-icon
                                    small
                                    @click="activarDesactivarMostrar(2,item)"
                                >
                                    block
                                </v-icon>
                            </template>

                       <template v-else>
                            <v-icon
                                small
                                @click="activarDesactivarMostrar(1,item)"
                            >
                            check_box
                            </v-icon>
                        </template>
                </template>

        <template slot="no-data" class="mx-5">
          <v-spacer class="ma-5"></v-spacer>
            <span>
              NO SE HAN ENCONTRADO DATOS, INTENTE RECARGAR
            </span>
          <v-spacer class="ma-2"></v-spacer>
            <v-btn
              :loading="loading"
              :disabled="loading"
              color=#000000
              class="ma-2 white--text"
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
                usuarios:[],
                dialog: false,
                loader: null,
                loading: false,
                headers: [

                { text: 'Id Usuario', value: 'idUsuario' },
                { text: 'Id Rol', value: 'idRol', sortable: false},
                { text: 'DNI', value: 'dni', sortable: false},
                { text: 'Email', value: 'email', sortable: false},
                { text: 'Condicion', value: 'condicion_usuario'},
                { text: 'Opciones', value: 'opciones', sortable: false}

                ],

                search: '',

                editedIndex: -1,

                idUsuario: '',
                idRol: '',
                dni: '',
                email: '',
                condicion_usuario: '',
                valida: 0,
                validaMensaje:[],
                adModal: 0,
                adAction: 0,
                adidUsuario: ''
            }
        },
        computed: {
            formTitle () {
                 return this.editedIndex === -1 ? 'Nuevo Usuario' : 'Actualizando Usuario'
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
                axios.get('api/Usuarios/Listar').then(function(response){
                  //  console.log(response);
                  me.usuarios=response.data;
                }).catch(function(error){
                    console.log(error);
                });

            },

            initialize () {
            this.listar();

            },

            editItem (item) {
                this.idUsuario=item.idUsuario;
                this.idRol=item.idRol;
                this.dni=item.dni;
                this.email=item.email;
                this.editedIndex=1;
                this.dialog = true
            },


            cerrar () {
                this.dialog = false;
                this.limpiar();

            },

            limpiar(){
                this.idUsuario="";
                this.idRol="";
                this.dni="";
                this.email="";
                this.editedIndex=-1;
            },

            guardar () {

                if(this.validar()){
                    return;
                }
                if (this.editedIndex > -1) {
                    //código para editar

                    let me=this;
                    axios.put('api/Usuarios/Actualizar',{
                        'idRol': me.idRol,
                        'dni':me.dni,
                        'email': me.email,
                        'idUsuario': me.idUsuario,
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
                    axios.post('api/Usuarios/Crear',{
                        'idRol': me.idRol,
                        'dni':me.dni,
                        'email': me.email,
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
               if(this.email.length > 25){
                   this.validaMensaje.push("El email no debe ser mayor a 25 caracteres");
               }
               if(this.validaMensaje.length){
                   this.valida=1;
               }
               return this.valida;
           },

           activarDesactivarMostrar(accion,item){
               this.adModal=1;
               this.adidUsuario=item.idUsuario;
               if (accion==1){
                    this.adAccion=1;
               }
               else if(accion==2){
                  this.adAccion=2;
               }
               else{
                   this.adModal=0;
               }
           },

            activarDesactivarCerrar(){
                this.adModal=0;

            },

           activar(){
               //usamos axios
                    let me=this;
                    axios.put('api/Usuarios/Activar/'+this.adidUsuario,{}).then(function(response){
                        me.adModal=0;
                        me.adAccion=0;
                        me.adidUsuario="";
                        me.listar();
                    }).catch(function(error){
                        console.log(error);
                    });
           },

           desactivar(){
                    let me=this;
                    axios.put('api/Usuarios/Desactivar/'+this.adidUsuario,{}).then(function(response){
                        me.adModal=0;
                        me.adAccion=0;
                        me.adidUsuario="";
                        me.listar();
                    }).catch(function(error){
                        console.log(error);
                    });
            }
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

