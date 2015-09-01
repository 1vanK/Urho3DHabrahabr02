Scene@ scene_;

void Start()
{
    scene_ = Scene();
    
    // Загружаем сцену из файла.
    scene_.LoadXML(cache.GetFile("Scenes/Level01.xml"));
    
    // Находим в сцене ноду с камерой.
    Node@ cameraNode = scene_.GetChild("Camera");
    
    // Указываем движку, что мы хотим смотреть через эту камеру.
    Viewport@ viewport = Viewport(scene_, cameraNode.GetComponent("Camera"));
    renderer.viewports[0] = viewport;
    
    // Задаем большой размер теневых карт, чтобы они были более четкие.
    renderer.shadowMapSize = 2048;
    
    // Указываем движку приемник звука, через который мы хотим слушать.
    audio.listener = cameraNode.GetComponent("SoundListener");
}
