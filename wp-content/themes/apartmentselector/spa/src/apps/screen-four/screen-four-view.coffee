define [ 'marionette' ], ( Marionette )->

    class ScreenFourView extends Marionette.ItemView

        className : "grid-block-1"

        template : '<a href="#"  class="grid-link"   >
                                            <div class="grid-text-wrap"     >
                                                <span class="grid-main-title">Apartment Details</span>: <span class="grid-main-title">{{name}}</span><br/>
                                                 <span class="grid-main-title">Floor</span>: <span class="grid-main-title">{{floor}}</span><br/>
                                                  <span class="grid-main-title">Apartment Type</span>: <span class="grid-sub-title">{{unit_type_name}}</span><br/>
                                                  <span class="grid-main-title">Area</span>:<span class="grid-sub-title">{{unit_variant_name}} (sq. ft.)</span><br/>
                                                    <span class="grid-main-title">Apartment Facing</span>:<span class="grid-sub-title">{{view_name}}</span>

                                                                </div>
                                         </a>'












