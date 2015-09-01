class Dying : ScriptObject
{
    float time = 0.0f;

    void Update(float timeStep)
    {
        time += timeStep;
        if (time > 10.0f)
            node.Remove();
    }
}
