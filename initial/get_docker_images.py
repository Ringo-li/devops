import requests
import json
def get_docker_images(registry_ip_port):
    cata_url = 'http://'+registry_ip_port+'/v2/_catalog'
    cata_res = requests.get(cata_url).text
#     print(cata_res)
    cata_res = json.loads(cata_res)
#     print(cata_res['repositories'])
    for i in cata_res['repositories']:
        tag_url = 'http://'+registry_ip_port+'/v2/'+ i + '/tags/list'
        tag_res = requests.get(tag_url).text
        docker_pull(tag_res)
        
def docker_pull(tag_res):
    res =  json.loads(tag_res)
    pull = 'docker pull '+registry_ip_port+'/'+res["name"]+':'+str(res['tags'][0])
    print(pull)
#     print(res["name"]+str(res['tags']))
if __name__ == "__main__":
    registry_ip_port = '192.168.33.10:5000'
    get_docker_images(registry_ip_port)