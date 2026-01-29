from django.http import JsonResponse


def home(request):
    return JsonResponse({"service": "demo", "endpoints": ["/health"]})
    
def health(request):
    return JsonResponse({"status": "ok"})
