import dbServices.DatabaseConnectionService;
import dbServices.InsertBrick;
import dbServices.InsertSet;
import dbServices.InsertSetData;
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
		DatabaseConnectionService dcs = new DatabaseConnectionService("legoinventorytracker.c2oxnp5y0vck.us-east-2.rds.amazonaws.com", "LegoInventoryTracker");
		try{
			dcs.connect("lego_application", "V32Wz54^CaKbx-rZ");
		} catch(ClassNotFoundException e){

		}

		insertBricks(dcs);
		insertSets(dcs);
		insertSetData(dcs);

		dcs.closeConnection();
	}

	private static void insertBricks(DatabaseConnectionService dcs)
	{
		InsertBrick insertBrick = new InsertBrick(dcs);
		NodeList nodeList = null;

		try
		{
			File file = new File("../scrapedData/DemoData/Bricks/2021-02-18-LegoBrickData.xml");
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
	}

	private static void insertSets(DatabaseConnectionService dcs)
	{
		InsertSet insertSet = new InsertSet(dcs);
		Document doc = null;

		try
		{
			File folder = new File("../scrapedData/DemoData/Sets");
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			for(File file : folder.listFiles())
			{
				doc = db.parse(file);
				doc.getDocumentElement().normalize();
				NodeList nodeList = doc.getElementsByTagName("set");
				for (int i = 0; i < nodeList.getLength(); i++) {
					Node node = nodeList.item(i);
					if (node.getNodeType() == Node.ELEMENT_NODE) {
						Element element = (Element) node;
						String id = element.getAttribute("ID");
						String imageURL = element.getAttribute("imageURL");
						String name = element.getAttribute("name");
//						System.out.println("ID: " + id + " imageURL: " + imageURL + " name: " + name + " color: ");
						insertSet.addSet(id, imageURL, name);
					}
				}
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	private static void insertSetData(DatabaseConnectionService dcs)
	{
		InsertSetData insertSetData = new InsertSetData(dcs);
		Document doc = null;

		try
		{
			File folder = new File("../scrapedData/DemoData/SetContains");
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			for(File file : folder.listFiles())
			{
				String setID = file.getName().split("-")[4];
				doc = db.parse(file);
				doc.getDocumentElement().normalize();
				Element brickCountElement = (Element) doc.getElementsByTagName("brickCount").item(0);
				int acquired = Integer.parseInt(brickCountElement.getAttribute("acquired"));
				int totalInSet = Integer.parseInt(brickCountElement.getAttribute("totalInSet"));
				if(acquired == 0)
				{
					continue;
				}
				else if(totalInSet < 50 && (float)acquired / totalInSet < .7)
				{
					continue;
				}
				else if((float)acquired / totalInSet < .8)
				{
					continue;
				}
//				System.out.println("percentComplete:" + (float)acquired / totalInSet);
				NodeList nodeList = doc.getElementsByTagName("brick");
				for (int i = 0; i < nodeList.getLength(); i++) {
					Node node = nodeList.item(i);
					if (node.getNodeType() == Node.ELEMENT_NODE) {
						Element element = (Element) node;
						String legoBrick = element.getAttribute("elementID") + '/' + element.getAttribute("designID");
						int quantity = Integer.parseInt(element.getAttribute("quantity"));
						System.out.println("setID: " + setID + " legoBrick: " + legoBrick + " quantity: " + quantity);
						insertSetData.addBrick(setID, legoBrick, quantity);
					}
				}
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
}
