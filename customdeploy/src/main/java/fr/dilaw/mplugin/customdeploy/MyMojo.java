package fr.dilaw.mplugin.customdeploy;


import java.io.File;
import org.apache.maven.plugin.AbstractMojo;
import org.apache.maven.plugin.MojoExecutionException;
import org.apache.maven.plugins.annotations.Execute;
import org.apache.maven.plugins.annotations.LifecyclePhase;
import org.apache.maven.plugins.annotations.Mojo;
import org.apache.maven.plugins.annotations.Parameter;
import org.apache.maven.project.MavenProject;

@Mojo(name = "pack")
@Execute(goal="pack", phase =LifecyclePhase.INSTALL)
public class MyMojo extends AbstractMojo {
	@Parameter(property = "msg",defaultValue = "from maven")
	private String msg;

	@Parameter( defaultValue = "${project}", readonly = true )
	private MavenProject project;


	@Parameter( defaultValue = "${project.basedir}" )
	private File basedir;

	public void execute() throws MojoExecutionException {
		getLog().info("Hello " + msg + " " + "baseid : " + project.getBasedir());
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