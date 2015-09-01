Scene@ scene_;

void Start()
{
    scene_ = Scene();
    
    // ��������� ����� �� �����.
    scene_.LoadXML(cache.GetFile("Scenes/Level01.xml"));
    
    // ������� � ����� ���� � �������.
    Node@ cameraNode = scene_.GetChild("Camera");
    
    // ��������� ������, ��� �� ����� �������� ����� ��� ������.
    Viewport@ viewport = Viewport(scene_, cameraNode.GetComponent("Camera"));
    renderer.viewports[0] = viewport;
    
    // ������ ������� ������ ������� ����, ����� ��� ���� ����� ������.
    renderer.shadowMapSize = 2048;
    
    // ��������� ������ �������� �����, ����� ������� �� ����� �������.
    audio.listener = cameraNode.GetComponent("SoundListener");
}
