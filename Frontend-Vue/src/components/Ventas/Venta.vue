<template>
    <v-layout align-start>
        <v-flex>
            <v-toolbar flat color="dark">
                <v-toolbar-title>Ventas</v-toolbar-title>
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
                                <v-text-field v-model="idCliente" label="Id Cliente"></v-text-field>
                            </v-flex>
                            <v-flex xs12 sm12 md12>
                                <v-text-field v-model="idUsuario" label="Id Usuario"></v-text-field>
                            </v-flex>
                            <v-flex xs12 sm12 md12>
                                <v-text-field v-model="idComprobante" label="Id Comprobante"></v-text-field>
                            </v-flex>
                            <v-flex xs12 sm12 md12>
                                <v-text-field v-model="fecha_hora" label="Fecha & Hora"></v-text-field>
                            </v-flex>
                            <v-flex xs12 sm12 md12>
                                <v-text-field v-model="impuesto" label="Impuesto"></v-text-field>
                            </v-flex>
                            <v-flex xs12 sm12 md12>
                                <v-text-field v-model="ganancia" label="Ganancia"></v-text-field>
                            </v-flex>
                            <v-flex xs12 sm12 md12>
                                <v-text-field v-model="estado" label="Estado"></v-text-field>
                            </v-flex>

                            <v-flex xs12 sm12 md12 v-show="valida">
                                <div dark class="red--text" v-for="v in validaMensaje" :key="v" v-text="v">
                                </div>
                            </v-flex>

                            </v-layout>
                        </v-container>
                    </v-card-text>

                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <!-- Botones de la ventana modal-->
                            <v-btn dark color="red darken-1" flat @click.native="cerrar">Cancelar</v-btn>
                            <v-btn dark color="blue darken-1" flat @click.native="guardar">Guardar</v-btn>
                        </v-card-actions>
                    </v-card>
                </v-dialog>

                <v-dialog v-model="adModal" max-width="500px"></v-dialog>

                <v-dialog v-model="adModal" max-width="290px">
                    <v-card>
                        <v-card-title class="headline"  v-if="adAccion==1">¿Activar item?</v-card-title>
                        <v-card-title class="headline"  v-if="adAccion==2">¿Desactivar item?</v-card-title>
                    </v-card>
                </v-dialog>

            </v-toolbar>

            <v-data-table
                :headers="headers"
                :items="ventas"
                :search="search"
                class="elevation-1"
            >
                <template slot="items" slot-scope="props">
                        <td>{{ props.item.idVenta }}</td>
                        <td>{{ props.item.idCliente }}</td>
                        <td>{{ props.item.idUsuario }}</td>
                        <td>{{ props.item.idComprobante }}</td>
                        <td>{{ props.item.fecha_hora }}</td>
                        <td>{{ props.item.impuesto }}</td>
                        <td>{{ props.item.ganancia }}</td>
                        <td>{{ props.item.estado }}</td>
                </template>

                <!--template v-slot:item.opciones="{ item }"-->
                <template v-slot:[`item.opciones`]="{ item }">
                        <v-btn
                            class="mx-2"
                            fab
                            dark
                            x-small
                            color="secondary"
                            >
                                <v-icon
                                    class="mx-2"
                                    fab
                                    dark
                                    x-small
                                    @click="editItem(item)"
                                >mdi-border-color
                        </v-icon>
                    </v-btn>
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
                ventas:[],
                dialog: false,
                loader: null,
                loading: false,
                headers: [

                { text: 'Id Venta', value: 'idVenta' },
                { text: 'Id Cliente', value: 'idCliente' },
                { text: 'Id Usuario', value: 'idUsuario', sortable: false},
                { text: 'Id Comprobante', value: 'idComprobante', sortable: false},
                { text: 'Fecha & Hora', value: 'fecha_hora'},
                { text: 'Impuesto', value: 'impuesto', sortable: false},
                { text: 'Ganancia', value: 'ganancia', sortable: false},
                { text: 'Estado', value: 'estado'},
                { text: 'Opciones', value: 'opciones', sortable: false}

                ],
                search: '',

                editedIndex: -1,
                idVenta: '',
                idCliente: '',
                idUsuario: '',
                idComprobante: '',
                fecha_hora: '',
                impuesto: '',
                ganancia: '',
                estado: '',
                valida: 0,
                validaMensaje:[],
                adModal: 0,
                adAction: 0,
            }

        },
        computed: {
            formTitle () {
                 return this.editedIndex === -1 ? 'Nuevo Producto' : 'Actualizando Producto'
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
                axios.get('api/Ventas/Listar').then(function(response){
                  //  console.log(response);
                  me.ventas=response.data;
                }).catch(function(error){
                    console.log(error);

                });

            },

            initialize () {
            this.listar();

            },

            editItem (item) {
                this.idVenta=item.idVenta;
                this.idCliente=item.idCliente;
                this.idUsuario=item.idUsuario;
                this.idComprobante=item.idComprobante;
                this.fecha_hora=item.fecha_hora;
                this.impuesto=item.impuesto;
                this.ganancia=item.ganancia;
                this.estado=item.estado;
                this.editedIndex=1;
                this.dialog = true
            },

            cerrar () {
                this.dialog = false;
                this.limpiar();

            },

            limpiar(){
                this.idVenta="";
                this.idCliente="";
                this.idUsuario="";
                this.idComprobante="";
                this.fecha_hora="";
                this.impuesto="";
                this.ganancia="";
                this.estado="";
                this.editedIndex=-1;
            },

            guardar () {

                if(this.validar()){
                    return;
                }
                if (this.editedIndex > -1) {
                    //código para editar

                    let me=this;
                    axios.put('api/Ventas/Actualizar',{
                        'idVenta': me.idVenta,
                        'idCliente': me.idCliente,
                        'idUsuario': me.idUsuario,
                        'idComprobante': me.idComprobante,
                        'fecha_hora': me.fecha_hora,
                        'impuesto': me.impuesto,
                        'ganancia':me.ganancia,
                        'estado': me.estado,

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
                    axios.post('api/Ventas/Crear',{
                        'idCliente': me.idCliente,
                        'idUsuario': me.idUsuario,
                        'idComprobante': me.idComprobante,
                        'fecha_hora': me.fecha_hora,
                        'impuesto': me.impuesto,
                        'ganancia':me.ganancia,
                        'estado': me.estado
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
               if(this.estado.length > 20){
                   this.validaMensaje.push("El estado solo contiene 20 caracteres");
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
