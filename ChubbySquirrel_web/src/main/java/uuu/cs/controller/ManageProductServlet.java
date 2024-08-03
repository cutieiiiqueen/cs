package uuu.cs.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.google.gson.Gson;

import uuu.cs.entity.Product;
import uuu.cs.entity.Spec;
import uuu.cs.entity.SpecialOffer;
import uuu.cs.exception.CSException;
import uuu.cs.service.ManageService;

@WebServlet("/manageProduct.do")
@MultipartConfig
public class ManageProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		ManageService manageService = new ManageService();
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		String id = request.getParameter("id");
		
		
			if ("add".equals(action)) {
				
				try {
	
					String name = request.getParameter("name");
					String category = request.getParameter("category");
					String unitPrice = request.getParameter("unitPrice");
					String stock = request.getParameter("stock");
					String releaseDate = request.getParameter("releaseDate");
					String description = request.getParameter("description");
	
					String photoUrl = null;
	
					Product newProduct = new Product();
					newProduct.setName(name);
					newProduct.setCategory(category);
					newProduct.setUnitPrice(Double.parseDouble(unitPrice));
					newProduct.setStock(Integer.parseInt(stock));
					newProduct.setReleaseDate(releaseDate);
					newProduct.setPhotoUrl(photoUrl);
					newProduct.setDescription(description);
	
					manageService.addProduct(newProduct);
					
					int thisId = manageService.selectProductId(name);
					
					//處理圖片
					Part filePart = request.getPart("postImage");
					if (filePart != null && filePart.getSize() > 0) {
					    // 獲取文件副檔名
					    String fileExtension = getFileExtension(filePart);					    
					    // 設置新的文件名（id + 原始副檔名）
					    String fileName = thisId + fileExtension;
						//產品儲存路徑
					    String uploadPath = System.getProperty("user.home") + File.separator + "Desktop" + File.separator +
		                        "ChubbySquirrel" + File.separator + "ChubbySquirrel_web" + File.separator +
		                        "src" + File.separator + "main" + File.separator + "webapp" + File.separator + 
		                        "images"+ File.separator +"products";
					    // 將檔案寫入指定路徑
					    filePart.write(uploadPath + File.separator + fileName);
						// 設置photoUrl的路徑
						photoUrl = "/cs/images/products/" + fileName;
					}				
					//重新設置圖片
					manageService.UpdatePhotoUrl(photoUrl, thisId);
					
					response.getWriter().write("success");
					
				}catch(CSException e) {
					this.log("後台[新增產品]失敗", e);
				}catch(Exception e) {
					this.log("後台[新增產品]發生非預期錯誤", e);
				}
				
			} else if ("addSpec".equals(action)) {
				
				try{
					String productId = request.getParameter("productId");
					String specName = request.getParameter("specName");
					String listPrice = request.getParameter("listPrice");
					String stock = request.getParameter("stock");
	
					Spec newSpec = new Spec();
					newSpec.setProductId(Integer.parseInt(productId));
					newSpec.setSpecName(specName);
					newSpec.setListPrice(Double.parseDouble(listPrice));
					newSpec.setStock(Integer.parseInt(stock));
	
					String photoUrl = null;
					//處理圖片
					Part filePart = request.getPart("postImage");
					if (filePart != null && filePart.getSize() > 0) {
					    // 獲取文件副檔名
					    String fileExtension = getFileExtension(filePart);					    
					    // 設置新的文件名（id + 原始副檔名）
					    String fileName = id + "-" + specName + fileExtension;
						//產品儲存路徑
					    String uploadPath = System.getProperty("user.home") + File.separator + "Desktop" + File.separator +
		                        "ChubbySquirrel" + File.separator + "ChubbySquirrel_web" + File.separator +
		                        "src" + File.separator + "main" + File.separator + "webapp" + File.separator + 
		                        "images"+ File.separator +"products";
					    // 將檔案寫入指定路徑
					    filePart.write(uploadPath + File.separator + fileName);
						// 設置photoUrl的路徑
						photoUrl = "/cs/images/products/" + fileName;
					}
	
					newSpec.setPhotoUrl(photoUrl);
					
					manageService.addSpec(newSpec);
					response.getWriter().write("success");
					
				}catch(CSException e) {
					this.log("後台[新增產品規格]失敗", e);
				}catch(Exception e) {
					this.log("後台[新增產品規格]發生非預期錯誤", e);
				}
				
			}else if ("update".equals(action)) {
				
				try {
					
					String name = request.getParameter("name");
					String category = request.getParameter("category");
					String unitPrice = request.getParameter("unitPrice");
					String stock = request.getParameter("stock");
					String releaseDate = request.getParameter("releaseDate");
					String photoUrl = request.getParameter("photoUrl");
					String description = request.getParameter("description");
					String discount = request.getParameter("discount");
					
					//處理圖片
					Part filePart = request.getPart("postImage");
					if (filePart != null && filePart.getSize() > 0) {
					    // 獲取文件副檔名
					    String fileExtension = getFileExtension(filePart);					    
					    // 設置新的文件名（id + 原始副檔名）
					    String fileName = id + fileExtension;
					    // 產品儲存路徑
					    String uploadPath = System.getProperty("user.home") + File.separator + "Desktop" + File.separator +
					                        "ChubbySquirrel" + File.separator + "ChubbySquirrel_web" + File.separator +
					                        "src" + File.separator + "main" + File.separator + "webapp" + File.separator + 
					                        "images"+ File.separator +"products";
					    // 將檔案寫入指定路徑
					    filePart.write(uploadPath + File.separator + fileName);
					    // 設置photoUrl的路徑
					    photoUrl = "images/products/" + fileName;
					} else {
					    photoUrl = request.getParameter("photoUrl");
					}
				
					SpecialOffer updatedProduct = new SpecialOffer();
					updatedProduct.setId(Integer.parseInt(id));
					updatedProduct.setName(name);
					updatedProduct.setCategory(category);
					updatedProduct.setUnitPrice(Double.parseDouble(unitPrice));
					updatedProduct.setStock(Integer.parseInt(stock));
					updatedProduct.setReleaseDate(releaseDate);
					updatedProduct.setPhotoUrl(photoUrl);
					updatedProduct.setDescription(description);
					updatedProduct.setDiscount(Integer.parseInt(discount));
	
					manageService.updateProduct(updatedProduct);
					
					response.getWriter().write("success");
					
				}catch(CSException e) {
					this.log("後台[更新產品]失敗", e);
				}catch(Exception e) {
					this.log("後台[更新產品]發生非預期錯誤", e);
				}
				
			} else if ("updateSpec".equals(action)) {
				
				try {
					
					int productId = Integer.parseInt(request.getParameter("productId"));
					String specName = request.getParameter("specName");
					double listPrice = Double.parseDouble(request.getParameter("listPrice"));
					int stock = Integer.parseInt(request.getParameter("stock"));
					String photoUrl = request.getParameter("photoUrl");
	
					//處理圖片
					Part filePart = request.getPart("postImage");
					if (filePart != null && filePart.getSize() > 0) {
					    // 獲取文件副檔名
					    String fileExtension = getFileExtension(filePart);					    
					    // 設置新的文件名（id + 原始副檔名）
					    String fileName = id + "-" + specName + fileExtension;
						//產品儲存路徑
						String uploadPath = System.getProperty("user.home") + File.separator + "Desktop" + File.separator +
								"ChubbySquirrel" + File.separator + "ChubbySquirrel_web" + File.separator +
								"src" + File.separator + "main" + File.separator + "webapp" + File.separator + 
								"images"+ File.separator +"products";
						//將檔案寫入指定路徑
						filePart.write(uploadPath + File.separator + fileName);
						// 設置圖片的 URL 路徑
						photoUrl = "images"+ File.separator + "products"+ File.separator + fileName;
					}
	
					Spec spec = new Spec();
					spec.setProductId(productId);
					spec.setSpecName(specName);
					spec.setListPrice(listPrice);
					spec.setStock(stock);
					spec.setPhotoUrl(photoUrl);
	
					manageService.updateSpec(spec);
					response.getWriter().write("success");
					
				}catch(CSException e) {
					this.log("後台[更新產品規格]失敗", e);
				}catch(Exception e) {
					this.log("後台[更新產品規格]發生非預期錯誤", e);
				}
				
			} else if ("delete".equals(action)) {
				
				try {
					manageService.deleteProduct(Integer.parseInt(id));
					response.getWriter().write("success");
				}catch(CSException e) {
					this.log("後台[刪除產品]失敗", e);
				}catch(Exception e) {
					this.log("後台[刪除產品]發生非預期錯誤", e);
				}
				
			} else if ("updateStatus".equals(action)) {
				
				try {
					String productId = request.getParameter("productId");
					String status = request.getParameter("status");
					
					manageService.updateStatus(productId, status);					
					response.getWriter().write("success");
					
				}catch(CSException e) {
					this.log("後台[更新產品狀態]失敗", e);
				}catch(Exception e) {
					this.log("後台[更新產品狀態]發生非預期錯誤", e);
				}
			}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		ManageService manageService = new ManageService();
		Gson gson = new Gson();
		String action = request.getParameter("action");
		int productId = Integer.parseInt(request.getParameter("productId"));

		try {
			if ("getSpecs".equals(action)) {
				List<Spec> specs = manageService.getSpecs(productId);
				String json = gson.toJson(specs);
				response.setContentType("application/json");
				response.getWriter().write(json);
			}
		}catch(CSException e) {
			this.log("後台[查詢產品規格]失敗", e);
		}catch(Exception e) {
			this.log("後台[查詢產品規格]發生非預期錯誤", e);
		}
	}

	/**
	 * 從 HTTP 請求的檔案部分（Part）中解析出檔案的原始檔案名稱
	 */
	/*private String getFileName(Part part) {
		for (String cd : part.getHeader("content-disposition").split(";")) {
			if (cd.trim().startsWith("filename")) {
				return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
			}
		}
		return null;
	}*/
	
	/**
	 * 從上傳的文件中獲取文件副檔名
	 * @param filePart 上傳的文件部分
	 * @return 文件的副檔名（包括點號），如果沒有副檔名則返回空字符串
	 */
	private String getFileExtension(Part filePart) {
	    String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
	    int lastDotIndex = originalFileName.lastIndexOf(".");
	    if (lastDotIndex > 0) {
	        return originalFileName.substring(lastDotIndex);
	    }
	    return ""; // 如果文件沒有副檔名，返回空字符串
	}
}