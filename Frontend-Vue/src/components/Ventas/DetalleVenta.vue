<template>
    <v-layout align-start>
        <v-flex>

            <v-toolbar flat color="dark">
                <v-toolbar-title>Consulta 'Ventas'</v-toolbar-title>
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
                                <v-text-field v-model="idVenta" label="Id Venta"></v-text-field>
                            </v-flex>
                            <v-flex xs12 sm12 md12>
                                <v-text-field v-model="idProducto" label="Id Producto"></v-text-field>
                            </v-flex>
                            <v-flex xs12 sm12 md12>
                                <v-text-field v-model="cantidad" label="Cantidad"></v-text-field>
                            </v-flex>
                            <v-flex xs12 sm12 md12>
                                <v-text-field v-model="descuento" label="Descuento"></v-text-field>
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
                            <v-btn dark color="red darken-1" flat @click.native="cerrar">Cancelar</v-btn>
                            <v-btn dark color="blue darken-1" flat @click.native="guardar">Guardar</v-btn>
                        </v-card-actions>
                    </v-card>
                </v-dialog>

                <v-dialog v-model="adModal" max-width="500px"></v-dialog>


            </v-toolbar>

            <v-data-table
                :headers="headers"
                :items="detalle_ventas"
                :search="search"
                class="elevation-1"
            >
                    <template slot="items" slot-scope="props">
                            <!--td>{{ props.item.idDetalle }}</td-->
                            <td>{{ props.item.idVenta }}</td>
                            <td>{{ props.item.idProducto }}</td>
                            <td>{{ props.item.cantidad }}</td>
                            <td>{{ props.item.descuento }}</td>
                            <td class="justify-center layout px-0"></td>
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
                detalle_ventas:[],
                dialog: false,
                loader: null,
                loading: false,
                headers: [
                  { text: 'Id Detalle', value: 'idDetalle' },
                  { text: 'IdVenta', value: 'idVenta', sortable: false},
                  { text: 'Id Producto', value: 'idProducto' },
                  { text: 'Cantidad', value: 'cantidad' },
                  { text: 'Descuento', value: 'descuento'},
                  { text: 'Opciones', value: 'opciones', sortable: false}
                ],
                search: '',

                editedIndex: -1,

                idDetalle: '',
                idVenta: '',
                idProducto: '',
                cantidad: '',
                descuento: '',
                valida: 0,
                validaMensaje:[],
                //adModal: 0,
                //adAction: 0,
                //adnombre_categoria: '',
                //adidcategoria: 0
            }
        },

        computed: {
            formTitle () {
                 return this.editedIndex === -1 ? 'Nueva Detalle' : 'Actualizando Detalle'
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
                axios.get('api/DetalleVentas/Listar').then(function(response){
                  //  console.log(response);
                  me.detalle_ventas=response.data;
                }).catch(function(error){
                    console.log(error);
                });

            },

            initialize () {
            this.listar();

            },

            editItem (item) {
                this.idDetalle=item.idDetalle;
                this.idVenta=item.idVenta;
                this.idProducto=item.idProducto;
                this.cantidad=item.cantidad;
                this.descuento=item.descuento;
                this.editedIndex=1;
                this.dialog = true
            },

            cerrar () {
                this.dialog = false;
                this.limpiar();
            },

            limpiar(){
                this.idDetalle="";
                this.idVenta="";
                this.idProducto="";
                this.cantidad="";
                this.descuento="";
                this.editedIndex=-1;
            },

            guardar () {

                if(this.validar()){
                    return;
                }
                if (this.editedIndex > -1) {
                    //código para editar

                    let me=this;
                    axios.put('api/DetalleVentas/Actualizar',{
                        'idVenta': me.idVenta,
                        'idProducto': me.idProducto,
                        'cantidad' : me.cantidad,
                        'descuento' : me.descuento,
                        'idDetalle': me.idDetalle,
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
                    axios.post('api/DetalleVentas/Crear',{
                        'idDetalle': me.idDetalle,
                        'idVenta': me.idVenta,
                        'idProducto': me.idProducto,
                        'cantidad' : me.cantidad,
                        'descuento' : me.descuento,
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
               if(this.cantidad.length < 0){
                   this.validaMensaje.push("Incluya la cantidad de productos comprados");
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
