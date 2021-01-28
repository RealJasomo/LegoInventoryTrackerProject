import dbServices.DatabaseConnectionService;
import dbServices.InsertBrick;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.File;

public class Main {

	public static void main(String[] args)
	{
		DatabaseConnectionService dcs = new DatabaseConnectionService("titan.csse.rose-hulman.edu", "LegoInventoryTracker");
		dcs.connect("lego_application", "[FO>i9l7.)XDJ^(6L*:_:Yj,SNh3n");
		InsertBrick insertBrick = new InsertBrick(dcs);

		NodeList nodeList = null;
		
		try
		{
			File file = new File("../scrapedData/2021-01-26-LegoBrickData.xml");
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			Document doc = db.parse(file);
			doc.getDocumentElement().normalize();
			System.out.println("Root element: " + doc.getDocumentElement().getNodeName());
			nodeList = doc.getElementsByTagName("brick");
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}

		if(nodeList != null)
		{
			for (int i = 0; i < nodeList.getLength(); i++) {
				Node node = nodeList.item(i);
				if(node.getNodeType() == Node.ELEMENT_NODE)
				{
					Element element = (Element) node;
					String id = element.getAttribute("elementID") + '/' + element.getAttribute("designID");
					String imageURL = element.getAttribute("imageURL");
					String name = element.getAttribute("name");
					String color = element.getAttribute("color");
					System.out.println("ID: " + id + " imageURL: " + imageURL + " name: " + name + " color: " + color);
					insertBrick.addBrick(id, imageURL, name, color);
				}
			}
		}

		dcs.closeConnection();
	}

}
