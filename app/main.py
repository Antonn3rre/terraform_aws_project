from fastapi import FastAPI

def defineApp():
    app = FastAPI()

    @app.get("/health")
    def index():
        return {"status": "Up"}
    
    return app;

if __name__ == "__main__":
    import uvicorn
    app = defineApp();
    uvicorn.run(app, host="0.0.0.0", port=8000)


