class Cannon : ScriptObject
{
    // Положительное или отрицательное направление вращения пушки.
    int direction = 1;

    // Задержка до следующего выстрела.
    float shootDelay = 0.0f;

    // Функция вызывается каждый кадр.
    void Update(float timeStep)
    {
        // Угол поворота вокруг оси x (node указывает на ноду, к которой прикреплен скрипт).
        float pitch = node.rotation.pitch;

        // Меняем направление вращения, если значение угла выходит за заданные пределы.
        if (pitch >= 70.0f)
            direction = -1;
        else if (pitch <= -10.0f)
            direction = 1;

        pitch += 30.0f * direction * timeStep;
        node.rotation = Quaternion(pitch, 0.0f, 0.0f);

        if (shootDelay > 0.0f)
            shootDelay -= timeStep;

        // Если нажат пробел и прошло достаточно времени с предыдущего выстрела,
        if (input.keyDown[KEY_SPACE] && shootDelay <= 0.0f)
        {
            Shoot();             // то стреляем
            shootDelay = 1.0f;   // и вновь устанавливаем задержку в одну секунду.

            AnimationController@ animCtrl = node.GetComponent("AnimationController");
            animCtrl.SetTime("Models/Shoot.ani", 0.0f);                 // Перематываем анимацию в начало.
            animCtrl.PlayExclusive("Models/Shoot.ani", 0, false, 0.0f); // Запускаем анимацию пушки.

            SoundSource3D@ source = node.CreateComponent("SoundSource3D"); // Создаем источник звука.
            Sound@ sound = cache.GetResource("Sound", "Sounds/Shoot.wav");
            source.autoRemove = true; // Источник звука будет автоматически уничтожен после проигрывания.
            source.Play(sound);
        }
    }

    void Shoot()
    {
        // Определяем позицию кости CannonballPlace у пушки.
        Vector3 position = node.GetChild("CannonballPlace", true).worldPosition;

        // Добавляем в сцену префаб.
        XMLFile@ xml = cache.GetResource("XMLFile", "Objects/Cannonball.xml");
        Node@ newNode = scene.InstantiateXML(xml, position, Quaternion());
        
        // Находим компонент RigidBody.
        RigidBody@ body = newNode.GetComponent("RigidBody");
        
        // Изначально у пушечного ядра уже будет импульс, так как ядро частично пересекается с пушкой
        // и стремится оттолкнуться от него. Но нам нужен импульс побольше.
        body.ApplyImpulse(node.rotation * Vector3(0.0f, 1.0f, 0.0f) * 15.0f);
    }
}
