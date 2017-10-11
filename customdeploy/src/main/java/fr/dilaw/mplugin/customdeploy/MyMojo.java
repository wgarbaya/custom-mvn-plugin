package fr.dilaw.mplugin.customdeploy;


import java.io.File;

import org.apache.maven.plugin.AbstractMojo;
import org.apache.maven.plugin.MojoExecutionException;
import org.apache.maven.plugins.annotations.Execute;
import org.apache.maven.plugins.annotations.LifecyclePhase;
import org.apache.maven.plugins.annotations.Mojo;
import org.apache.maven.plugins.annotations.Parameter;


@Mojo(name = "pack")
@Execute(goal="pack", phase =LifecyclePhase.INSTALL)
public class MyMojo extends AbstractMojo {
	@Parameter(property = "msg",defaultValue = "from maven")
	private String msg;

	@Parameter( defaultValue = "${project.basedir}", readonly = true )
	private File basedir;

	public void execute() throws MojoExecutionException {
		getLog().info("Hello " + msg + " " + "baseid : " +  basedir);
	}
	public File getBasedir() {
		return basedir;
	}

	public void setBasedir(File basedir) {
		this.basedir = basedir;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

}