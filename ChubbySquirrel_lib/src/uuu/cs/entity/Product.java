package uuu.cs.entity;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

import uuu.cs.exception.CSDataInvalidException;

public class Product {
	public static final NumberFormat priceFormat = NumberFormat.getCurrencyInstance();
	static {
		priceFormat.setMaximumFractionDigits(2);
		priceFormat.setMaximumFractionDigits(0);
	}
	
	private int id;//PKey, AUTO-INCREMENT,>0, RW
	private String name;//必要, Unique,1~60個字元 RW
	private String category;//必要, RW, 堅果/爆米花/果乾
	private double unitPrice;//必要, RW, >0, 售價即為定價
	private int stock;//必要, RW
	private LocalDate releaseDate;//必要, RW
	private String photoUrl;//非必要, RW
	private String description="";//非必要, RW	
	private int status; //必要
	
	private List<Spec> specList = new ArrayList<>(); 
	
	//集合屬性的getter必須回傳副本
	public List<Spec> getSpecList() {
		return new ArrayList<>(specList); //回傳副本
	}
	
	//集合屬性不可直接提供setter
//	public void setSpecList(List<Spec> specList) {
//		this.specList = specList;
//	}
	public void add(Spec spec) {
		specList.add(spec);
	}

	public Product() {};
	
	public Product(int id, String name, double unitPrice) {
		this.setId(id);
		this.setName(name);
		this.setUnitPrice(unitPrice);
	}
	/**
	 * 
	 * @param id 產品代號
	 * @param name 產品名稱
	 * @param unitPrice 定價
	 * @param stock 庫存
	 */
	public Product(int id, String name, double unitPrice, int stock) {
//		super(); //也要放在第一行
//		this.setId(id);
//		this.setName(name);
//		this.setUnitPrice(unitPrice);
		this(id, name, unitPrice);//建構式第一行可以用this呼叫同類別的其他建構式
		this.setStock(stock);
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		if(id>0) {
			this.id = id;
		}else {
//			System.err.printf("產品編號不得小於1\n");
			String errMsg = String.format("產品編號不得小於1:%s\n", id);
			throw new CSDataInvalidException(errMsg);
		}
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		//檢查參數name是否符合在1-60個字元
		int minLength=1, maxLength=60;
		if(name!=null && (name=name.trim()).length()>=minLength && name.length()<=maxLength) {
			this.name = name;	
		}else{
//			System.err.printf("產品名稱應在1-60個字元之間\n");
			String errMsg = String.format("產品名稱應在1-60個字元之間:%s\n", name);
			throw new CSDataInvalidException(errMsg);
		}
	}
	
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	
	/**
	 * 查詢定價(即為售價)
	 * @return double型態的定/售價
	 */
	public double getUnitPrice() {
		return unitPrice;
	}
	
	/**
	 * 設定定價(即為售價)
	 * @param unitPrice
	 */
	public void setUnitPrice(double unitPrice) {
		if(unitPrice>0) {
			this.unitPrice = unitPrice;
		}else {
//			System.err.printf("定價應>0元\n");
			String errMsg = String.format("產品定價應>0元:%s\n", unitPrice);
			throw new CSDataInvalidException(errMsg);
			
		}
	}
	
	public int getStock() {
		if(specList!=null && specList.size()>0) {
			int sum = 0;
			for (int i=0; i<specList.size(); i++) {
				sum = sum + specList.get(i).getStock();
			}
			return sum;
		}
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	
	public LocalDate getReleaseDate() {
		return releaseDate;
	}
	/**
	 * 上架日期的範圍檢查
	 * @param releaseDate
	 */
	public void setReleaseDate(LocalDate releaseDate) {
		if(releaseDate.isAfter(LocalDate.now())) {
			String errMsg = String.format("上架日期不可大於今日: %s", releaseDate);
			throw new CSDataInvalidException(errMsg);
		}else {
			this.releaseDate = releaseDate;
		}

	}
	
	/**
	 * 將參數releaseDate轉換為LocalDate的物件，
	 * 再呼叫setReleaseDate(theDate)方法做指派
	 * @param releaseDate 產品上架日期，須符合ISO-8601
	 */
	public void setReleaseDate(String releaseDate) {
		try{
			if(releaseDate!=null) releaseDate = releaseDate.replace('/', '-'); //把/換成-再指派給自己
			LocalDate theDate = LocalDate.parse(releaseDate); //releaseDate字串必須符合iso8601
			this.setReleaseDate(theDate);
		}catch(DateTimeParseException e) {
			throw new CSDataInvalidException("上架日期格式錯誤:" + releaseDate);
		}

	}
	
	public String getPhotoUrl() {
		return photoUrl;
	}
	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "\n"+getClass().getName()
				+ " id=" + id + ", 產品名稱=" + name 
				+ ", 產品種類=" + category + ", 圖片網址=" + photoUrl
				+ ", 定價=" + priceFormat.format(unitPrice) + ", 庫存=" + stock 
				+ ", 規格清單=" + specList
				+ ", 產品說明=" + description 
				+ ", 上架日期=" + releaseDate 
				+ ", 狀態=" + status;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Product other = (Product) obj;
		if (id != other.id)
			return false;
		return true;
	}

	public Spec findSpec(String specName) {
			if(specList!=null && specList.size()>0) {
				for(int i = 0; i < specList.size(); i++) {
					Spec spec = specList.get(i);
					if(spec.getSpecName().equals(specName)) {
						return spec;
					}
				}
			}
			return null;
	}
}
