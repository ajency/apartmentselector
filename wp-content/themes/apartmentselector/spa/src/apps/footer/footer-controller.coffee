define [ 'extm', 'src/apps/footer/footer-view' ], ( Extm, FooterView )->

    class FooterController extends Extm.RegionController

        initialize : ->
            @show new FooterView()

        # onComplete : ->
        #     @show new FooterView

    msgbus.registerController 'footer', FooterController