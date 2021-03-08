<template>
    <v-layout align-start>
        <v-flex>
            <v-toolbar flat color="dark">
                <v-toolbar-title>Productos</v-toolbar-title>
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
                        <v-flex>
                            <v-text-field v-model="idCategoria" label="Nombre Categoria"></v-text-field>
                        </v-flex>
                        <v-flex>
                            <v-text-field v-model="nombre_producto" label="Nombre Producto"></v-text-field>
                        </v-flex>
                        <v-flex>
                            <v-text-field v-model="precio_producto" label="Precio"></v-text-field>
                        </v-flex>
                        <v-flex>
                            <v-text-field v-model="cantidad" label="Stock"></v-text-field>
                        </v-flex>
                        <!--v-flex >
                            <v-text-field v-model="descripcion_producto" label="Descripción"></v-text-field>
                        </v-flex-->

                        <v-flex v-show="valida">
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
                <v-dialog v-model="adModal" max-width="500px">

                </v-dialog>
                <v-dialog v-model="adModal" max-width="290px">
                    <v-card>
                        <v-card-title class="headline"  v-if="adAccion==1">¿Activar item?</v-card-title>
                        <v-card-title class="headline"  v-if="adAccion==2">¿Desactivar item?</v-card-title>
                        <v-card-text>
                            Estás a punto de
                            <span v-if="adAccion==1">Activar </span>
                            <span v-if="adAccion==2">Desactivar </span>
                            el item <p class="font-weight-bold">"{{ adnombre_producto }}"</p>
                        </v-card-text>
                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn dark color="red darken-1" flat="flat" @click="activarDesactivarCerrar">
                                Cancelar
                            </v-btn>
                            <v-btn dark v-if="adAccion==1" color="green darken-1" flat="flat" @click="activar">
                                Activar
                            </v-btn>
                            <v-btn dark v-if="adAccion==2" color="blue darken-1" flat="flat" @click="desactivar">
                                Desactivar
                            </v-btn>
                        </v-card-actions>
                    </v-card>
                </v-dialog>

            </v-toolbar>

            <v-data-table
                :headers="headers"
                :items="productos"
                :search="search"
                class="elevation-1"
            >
                <template slot="items" slot-scope="props">
                        <!--td>{{ props.item.idCategoria }}</td-->
                        <td>{{ props.item.categoria }}</td>
                        <td>{{ props.item.nombre_producto }}</td>
                        <td>{{ props.item.precio_producto }}</td>
                        <td>{{ props.item.cantidad }}</td>
                        <!--td>{{ props.item.descripcion_producto }}</td-->
                        <td>
                            <div v-if="props.item.condicion_producto">
                                <span class="green--text">true</span>
                            </div>
                            <div v-else>
                                <span class="red--text">false</span>
                            </div>
                        </td>
                    </template>

                    <!--template v-slot:item.opciones="{ item }"-->
                    <template v-slot:[`item.opciones`] ="{ item }">
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

                        <template v-if="item.condicion_producto">
                            <v-btn
                                class="mx-2"
                                fab
                                dark
                                x-small
                                color="error"
                                >
                                    <v-icon
                                        fab
                                        dark
                                        x-small
                                        @click="activarDesactivarMostrar(2, item)"
                                    >mdi-block-helper
                                    </v-icon>
                            </v-btn>
                        </template>

                        <template v-else>
                            <v-btn
                                class="mx-2"
                                fab
                                dark
                                x-small
                                color="success"
                                >
                                    <v-icon
                                        fab
                                        dark
                                        x-small
                                        @click="activarDesactivarMostrar(1, item)"
                                    >mdi-check-bold
                                    </v-icon>
                            </v-btn>
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
        data: () => ({
          dialog: false,
          productos:[],
          loader: null,
          loading: false,
            headers: [
                { text: 'Id Producto', value: 'idproducto' },
                //{ text: 'Id Categoria', value: 'idcategoria', sortable: false },
                { text: 'Código', value: 'codigo' },
                { text: 'Nombre Producto', value: 'nombre' },
                //{ text: 'Nombre Categoria', value: 'nombre_cat' },
                { text: 'Precio', value: 'precio_venta' },
                { text: 'Stock', value: 'stock', sortable: false},
                { text: 'Estado', value: 'condicion_prod'},
                { text: 'Opciones', value: 'opciones', sortable: false}
            ],

            search: '',
            editedIndex: -1,
            idproducto: '',
            codigo: '',
            nombre: '',
            idcategoria: '',
            //nombre_cat: '',
            precio_venta: '',
            stock: '',
            condicion_prod: '',
            valida: 0,
            validaMensaje:[],
            adModal: 0,
            adAction: 0,
            adnombre_producto: '',
            adidProducto: ''

        }),

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
            this.listar()
        },
        methods:{
            listar(){
              let me =this;
              axios.get('api/Producto.php').then(function(response){
                //  console.log(response);
                me.productos=response.data;
              }).catch(function(error){
                console.log(error);
              });
            },

            initialize () {
              this.listar();
            },
            editItem (item) {
                this.idProducto=item.idProducto;
                this.nombre_producto=item.nombre_producto;
                this.idCategoria=item.idCategoria;
                this.categoria=item.categoria;
                this.precio_producto=item.precio_producto;
                this.cantidad=item.cantidad;
                this.descripcion_producto=item.descripcion_producto;
                this.editedIndex=1;
                this.dialog = true
            },

            cerrar () {
                this.dialog = false;
                this.limpiar();

            },

            limpiar(){
                this.idProducto='';
                this.idCategoria='';
                this.categoria='';
                this.nombre_producto='';
                this.precio_producto='';
                this.cantidad='';
                this.descripcion_producto='';
                this.editedIndex=-1;


            },
            guardar () {

                if(this.validar()){
                    return;
                }
                if (this.editedIndex > -1) {
                    //código para editar

                    let me=this;
                    axios.put('api/Productos/Actualizar',{
                        'idProducto':me.idProducto,
                        'nombre_producto': me.nombre_producto,
                        'idCategoria': me.idCategoria,
                        'categoria': me.categoria,
                        'precio_producto': me.precio_producto,
                        'cantidad': me.cantidad,
                        'descripcion_producto': me.descripcion_producto,
                        'idProducto':me.idProducto,
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
                    axios.post('api/Productos/Crear',{
                        'idProducto':me.idProducto,
                        'idCategoria': me.idCategoria,
                        'categoria': me.categoria,
                        'nombre_producto': me.nombre_producto,
                        'precio_producto': me.precio_producto,
                        'cantidad': me.cantidad,
                        'descripcion_producto': me.descripcion_producto,
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
               if(this.nombre_producto.length < 3 || this.descripcion_producto.length > 25){
                   this.validaMensaje.push("El nombre debe tener más de 3 caracteres y menos de 50 caracteres");
               }
               if(this.validaMensaje.length){
                   this.valida=1;
               }
               return this.valida;
           },

           activarDesactivarMostrar(accion,item){
               this.adModal=1;
               this.adnombre_producto=item.nombre_producto;
               this.adidProducto=item.idProducto;
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
                    axios.put('api/Productos/Activar/'+this.adidProducto,{}).then(function(response){
                        me.adModal=0;
                        me.adAccion=0;
                        me.adnombre_producto="";
                        me.adidProducto="";
                        me.listar();
                    }).catch(function(error){
                        console.log(error);
                    });
           },

           desactivar(){
                    let me=this;
                    axios.put('api/Productos/Desactivar/'+this.adidProducto,{}).then(function(response){
                        me.adModal=0;
                        me.adAccion=0;
                        me.adnombre_producto="";
                        me.adidProducto="";
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
