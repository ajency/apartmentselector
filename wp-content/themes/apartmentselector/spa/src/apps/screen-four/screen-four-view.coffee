define [ 'marionette' ], ( Marionette )->

    class ScreenFourView extends Marionette.ItemView

        className : "grid-block-1"

        template : '<a href="#"  class="grid-link"   >
                                            <div class="grid-text-wrap"     >
                                                <span class="grid-main-title">{{name}}</span>
                                                 <span class="grid-sub-title">{{unit_type_name}}</span>
                                                  <span class="grid-sub-title">{{unit_variant_name}}</span>
                                                    <span class="grid-sub-title">{{view_name}}</span>

                                                                </div>
                                         </a>'












