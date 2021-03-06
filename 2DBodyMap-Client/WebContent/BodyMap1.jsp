<!doctype html>
<html lang="en">
    <head>
        <title>Body Map</title>
        <meta charset="utf-8">
        
        <style>
            body {
                margin: 0px;
                overflow: hidden;
            }

            #container{
              width: 800px;
              margin-left: auto;
              margin-right: auto;
              text-align: center;
            }

            #controls{
              width: 400px;
              height: 700px;
              float: left;
              clear:none;
            }

            #obj{
                background-color: #fff;
                color: #fff;
                width: 400px;
                height: 700px;
                float: left;
                clear: none;
            }

            ul, li {
                list-style-type: none;
                padding: 0;
                margin: 0;
            }

            button{
              width: 100px;
            }

        </style>
        <title>Three.js .obj Viewer and Controls</title>
    </head>

    <body>
        <script src="Three.js"></script>
        <script src="OBJLoader.js"></script>

        <div id='container'>

            <h2>BodyMap</h2>

            <div id='controls'>

               <h4>Controls</h4>

               <ul>
                  <li><button id='in' onclick='zoomIn();'>Zoom In</button> | <button id='out' onclick='zoomOut();'>Zoom Out</button></li>
                  <li><button id='rOn' onclick='rotateOn();'>Rotate On</button> | <button id='rOff' onclick='rotateOff();'>Rotate Off</button></li>
                  <li><button id='wOn' onclick='wireframeOn();'>Wireframe On</button> | <button id='wOff' onclick='wireframeOff();'>Wireframe Off</button></li>
                  <li><button id='front' onclick='front();'>Front</button> | <button id='back' onclick='back();'>Back</button></li>
                  <li><button id='left' onclick='left();'>Left</button> | <button id='right' onclick='right();'>Right</button></li>

               </ul>

            </div>
         

     <div id='obj'>

            </div> 

        </div>

        <script>

            var container, stats;

            var camera, scene, renderer, model, particleMaterial, zoom, rotate;

            var mouseX = 0, mouseY = 0;

            var width = 600;
            var height = 700;

            var windowHalfX = width / 2;
            var windowHalfY = height / 2;


            init();
            animate();


            function init() {

                container = document.getElementById('obj');

                scene = new THREE.Scene();

                addCamera(10, 11, 11);


          zoom = camera.fov; 
          var texture  = new THREE.ImageUtils.loadTexture('texture.png');
         /*  var texture1  = new THREE.ImageUtils.loadTexture('jeans_texture.png'); */
          /* var jsonLoader = new THREE.JSONLoader();

          jsonLoader.load('models/schuh.js', addModelToScene);   */
          
          
                var ambient = new THREE.AmbientLight(  0x111111 );
                scene.add( ambient );

                  var directionalLight = new THREE.DirectionalLight( 0xffffff, 0.75 );
                directionalLight.position.set( 0, 0, 1 );
                scene.add( directionalLight ); 

               var pointLight = new THREE.PointLight( 0xffffff, 5, 29 );
      		    pointLight.position.set( 0, -25, 10 ); 
				        scene.add( pointLight );  

                var loader = new THREE.OBJLoader();
                loader.load( "Male.obj", function ( object ) {
                  object.children[0].geometry.computeFaceNormals();
                  var  geometry = object.children[0].geometry;
				          console.log(geometry);
                  THREE.GeometryUtils.center(geometry);
                  geometry.dynamic = true;
                  var material = new THREE.MeshBasicMaterial({map: texture});
                 /*  var material = new THREE.MeshLambertMaterial({color: 0xffffff, shading: THREE.FlatShading, vertexColors: THREE.VertexColors }); */
                  mesh = new THREE.Mesh(geometry, material);
                 /*  mesh.scale.set(10,10,10);  */
                  scene.add( mesh );
                } );

                renderer = new THREE.WebGLRenderer();
                renderer.setSize( width, height );
                container.appendChild( renderer.domElement );
            }

            function animate() {
                requestAnimationFrame( animate );
                render();
            } 

            function render() {
	                if(rotate) 
             mesh.rotation.z += 2;  
	                camera.position.z = 70;   
                camera.lookAt( scene.position );
                renderer.render( scene, camera ); 
            }

            function addCamera(x, y, z){
                camera = new THREE.PerspectiveCamera( 17, width / height, 1, 4000 );
                camera.position.x = x;
                camera.position.y = y;
                camera.position.z = z;
                scene.add( camera );
            } 

            function zoomIn(){
              camera.fov -= 1;
              camera.updateProjectionMatrix();
              zoom = camera.fov;
            }

            function zoomOut(){
              camera.fov += 1;
              camera.updateProjectionMatrix();
              zoom = camera.fov;
            }

            function rotateOn(){
              rotate = true;
            }

            function rotateOff(){
              rotate = false;
            }

            function wireframeOn(){
              mesh.material.wireframe = true;
              mesh.material.color = new THREE.Color( 0x6893DE  );
            }

            function wireframeOff(){
              mesh.material.wireframe = false;
              mesh.material.color = new THREE.Color(0xffffff);
            }

            function front(){
              scene.remove(camera);
              addCamera(0, -6, 1);
              mesh.rotation.z = 0;
              camera.fov = zoom;
              camera.updateProjectionMatrix();
            }

            function back(){
              front();
              mesh.rotation.z = 3.2;
            }

            function left(){
              front();
              mesh.rotation.z = 4.8;
            }

            function right(){
              front();
              mesh.rotation.z = 1.6;
            }

        </script>

    </body>
</html>

