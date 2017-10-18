package fr.dilaw.mplugin.customdeploy;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.Charset;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import org.apache.maven.plugin.AbstractMojo;
import org.apache.maven.plugin.MojoExecutionException;
import org.apache.maven.plugins.annotations.Execute;
import org.apache.maven.plugins.annotations.LifecyclePhase;
import org.apache.maven.plugins.annotations.Mojo;
import org.apache.maven.plugins.annotations.Parameter;
import org.apache.maven.project.MavenProject;

@Mojo(name = "merge-file")
@Execute(goal="merge-file", phase =LifecyclePhase.GENERATE_RESOURCES)
public class MyMojo extends AbstractMojo {
	@Parameter(property = "msg",defaultValue = "")
	private String msg;

	@Parameter(property = "parent_node",defaultValue = "root")
	private String parent_node;

	@Parameter( defaultValue = "${project}", readonly = true )
	private MavenProject project;


	@Parameter( defaultValue = "${project.basedir}/target/generated-resources/XML_Datasources/" )
	private File basedir;

	public void execute() throws MojoExecutionException {
		getLog().info("MyMojo " + msg + " " + "basedir : " + project.getBasedir());
		String pathout = basedir.getAbsolutePath() + "/out/Data.xml";
		File f = new File(pathout);
		f.getParentFile().mkdirs();
		if(!f.exists())
			try {
				f.createNewFile();
				FileOutputStream fileOutputStream = new FileOutputStream(f);
				fileOutputStream.write((getMsg().getBytes(Charset.forName("UTF-8"))));
				fileOutputStream.write((("<"+getParent_node()+">").getBytes(Charset.forName("UTF-8"))));
				fileOutputStream.close();
			} catch (IOException e2) {
				e2.printStackTrace();
			}
		try(OutputStream out = new FileOutputStream(pathout,true)){
			try (DirectoryStream<Path> directoryStream = Files.newDirectoryStream(Paths.get(basedir.getAbsolutePath()))) {
				for (Path path : directoryStream) {
					if (path.toFile().isFile()) {
						getLog().info("MyMojo " + "File to be processed " +path.toFile().getAbsolutePath());
						Files.copy(path, out);
					} 
				}
				out.write((("</"+getParent_node()+">").getBytes(Charset.forName("UTF-8"))));
			} catch (IOException e) {
				throw e;
			};
		} 
		catch (IOException e1) {
			MojoExecutionException me = new MojoExecutionException("File Problem",e1);
			throw me;
		}
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
	public String getParent_node() {
		return parent_node;
	}
	public void setParent_node(String parent_node) {
		this.parent_node = parent_node;
	}

}