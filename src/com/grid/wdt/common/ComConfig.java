package com.grid.wdt.common;


import com.grid.wdt.application.attachment.Attachment;
import com.grid.wdt.application.attachment.AttachmentController;
import com.grid.wdt.application.common.CommonController;
import com.grid.wdt.application.contract.Contract;
import com.grid.wdt.application.contract.ContractController;
import com.grid.wdt.application.dept.Dept;
import com.grid.wdt.application.dept.DeptController;
import com.grid.wdt.application.excel.ExcelController;
import com.grid.wdt.application.file.FileController;
import com.grid.wdt.application.index.IndexController;
import com.grid.wdt.application.login.LoginController;
import com.grid.wdt.application.menu.Menu;
import com.grid.wdt.application.menu.MenuController;
import com.grid.wdt.application.role.Role;
import com.grid.wdt.application.role.RoleController;
import com.grid.wdt.application.user.User;
import com.grid.wdt.application.user.UserController;
import com.grid.wdt.application.vacate.Vacate;
import com.grid.wdt.application.vacate.VacateController;
import com.grid.wdt.handler.ContextPathHandler;
import com.grid.wdt.interceptor.LoginInterceptor;
import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.core.JFinal;
import com.jfinal.ext.plugin.quartz.QuartzPlugin;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.dialect.AnsiSqlDialect;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.render.ViewType;

/**
 * API引导式配置
 */
public class ComConfig extends JFinalConfig {

	/**
	 * 配置常量
	 */
	public void configConstant(Constants me) {
		loadPropertyFile("jdbc.properties"); // 加载少量必要配置，随后可用getProperty(...)获取值
		me.setEncoding("utf-8");
		me.setDevMode(getPropertyToBoolean("devMode", false)); // 配置为开发者模式
		me.setBaseViewPath("/jsp"); // 配置基础jsp页面路径
		me.setViewType(ViewType.JSP); // 设置视图类型为Jsp，否则默认为FreeMarker
		
		//出错页面设置
		me.setError404View("/jsp/common/404.html");
		me.setError500View("/jsp/common/500.html");
	}

	/**
	 * 配置路由
	 */
	public void configRoute(Routes me) {
		//========================系统管理配置=================================
		me.add("/user", UserController.class);
		me.add("/menu",MenuController.class);
		me.add("/file",FileController.class);
		me.add("/common",CommonController.class);
		me.add("/dept", DeptController.class);
		me.add("/role", RoleController.class);
		me.add("/vacate", VacateController.class);
		me.add("/contract", ContractController.class);
		me.add("/attachment", AttachmentController.class);  //附件演示上传
		me.add("/excel", ExcelController.class);  //excel导入数据演示
		
		//-----------------------人力资源路由-------------------------------
		
		//========================系统配置结束=================================
		
		me.add("/index", IndexController.class); // 第三个参数省略时默认与第一个参数值相同，在此即为
		me.add("/login", LoginController.class); // 第三个参数省略时默认与第一个参数值相同，在此即为
		me.add("/", IndexController.class, "/index"); //
		// 第三个参数为该Controller的视图存放路径
		// me.add("/blog", BlogController.class); // 第三个参数省略时默认与第一个参数值相同，在此即为
		// "/blog"
		// me.add("/author", AuthorController.class); //
		// 第三个参数省略时默认与第一个参数值相同，在此即为 "/blog"
		//
		//
		// //============================测试配置信息================================
		// me.add("/icbc", IcbcController.class);
		//
	}

	/**
	 * 配置插件
	 */
	public void configPlugin(Plugins me) {
		// ============配置C3p0数据库连接池插件====================
		C3p0Plugin c3p0Plugin = new C3p0Plugin(getProperty("jdbcUrl"),
				getProperty("user"), getProperty("password").trim(),
				getProperty("driver"));
		me.add(c3p0Plugin);

		// 配置ActiveRecord插件
		ActiveRecordPlugin arp = new ActiveRecordPlugin(c3p0Plugin);
		arp.setShowSql(true);// 这句话就是ShowSql
		me.add(arp);
		arp.setDialect(new AnsiSqlDialect()); // 此处是重点，不然会出错

		// ======================配置druid数据库连接池插件============================
		// String driver = getProperty("driverClass");
		// DruidPlugin druidPlugin = new DruidPlugin(getProperty("jdbcUrl"),
		// getProperty("user"), getProperty("password"), driver);
		//
		// //集成druid的插件
		// druidPlugin.addFilter(new StatFilter());
		// druidPlugin.setInitialSize(3).setMaxActive(10);
		// WallFilter wall = new WallFilter();
		// wall.setDbType("mysql");
		// druidPlugin.addFilter(wall);
		// me.add(druidPlugin);
		//
		// // 配置ActiveRecord插件
		// ActiveRecordPlugin arp = new ActiveRecordPlugin(druidPlugin);
		// //显示执行的sql语句
		// arp.setShowSql(true);
		// me.add(arp);

		// =======================Quartz定时任务插件===============================
		QuartzPlugin quartzPlugin = new QuartzPlugin("job.properties");
		me.add(quartzPlugin);

		// ======================系统路由映射======================================
		arp.addMapping("jf_user", User.class);    // 映射jf_user表到User模型
		arp.addMapping("jf_menu", Menu.class);    //映射jf_menu表到Menu模型
		arp.addMapping("jf_dept", Dept.class);    //映射jf_menu表到Menu模型
		arp.addMapping("jf_role", Role.class);    //映射jf_menu表到Menu模型
		arp.addMapping("jf_vacate", Vacate.class);    //映射jf_vacate表到Vacate模型
		arp.addMapping("jf_contract", Contract.class);    //映射jf_contract表到Contract模型
		arp.addMapping("jf_attachment", Attachment.class);    //映射jf_contract表到Contract模型

		

	}

	/**
	 * 配置全局拦截器
	 */
	public void configInterceptor(Interceptors me) {
		me.add(new LoginInterceptor());
	}

	/**
	 * 配置处理器
	 */
	public void configHandler(Handlers me) {
		me.add(new ContextPathHandler());
	}

	/**
	 * 建议使用 JFinal 手册推荐的方式启动项目 运行此 main
	 * 方法可以启动项目，此main方法可以放置在任意的Class类定义中，不一定要放于此
	 */
	public static void main(String[] args) {
		JFinal.start("WebRoot", 8080, "/", 5);
	}
}
