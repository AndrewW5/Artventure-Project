// Resource Manager Class
import java.util.HashMap;
class ResourceLoader {
  private HashMap<String, PImage> m_images;
  public ResourceLoader() {
    m_images = new HashMap<String, PImage>();
  }
  public PImage getImage(String filename) {
    if ( false == m_images.containsKey(filename)) {
      PImage img = loadImage(filename);
      m_images.put(filename, img); 
      return img;
    } else {
      return m_images.get(filename);
    }
  }
}
