package kha.wpf;

import haxe.io.Bytes;
import haxe.Json;
import kha.Blob;
import kha.FontStyle;
import kha.loader.Asset;
import kha.Starter;
import system.io.File;
import system.windows.FrameworkElement;
import system.windows.input.Cursor;
import system.windows.input.Cursors;
import system.windows.input.Mouse;

class Loader extends kha.Loader {
	public static var path : String = "";
	public static var forceBusyCursor : Bool = false;
	var savedCursor : Cursor;
	var busyCursor : Bool = false;
	
	public function new() {
		super();
		isQuitable = true;
	}
	
	public override function loadProject(call: Void -> Void) {
		enqueue(new kha.loader.Asset(path + "project.kha", path + "project.kha", "blob"));
		loadFiles(call);
	}
	
	private override function parseProject() : Dynamic {
		return Json.parse(getBlob(path + "project.kha").toString());
	}
	
	override function loadMusic(filename: String, done: kha.Music -> Void) : Void {
		done(null);
	}

	override function loadSound(filename: String, done: kha.Sound -> Void) : Void {
		done(new Sound(path + filename + ".wav"));
	}

	override function loadImage(filename: String, done: kha.Image -> Void) : Void {
		done(new Image(path + filename));
	}

	override private function loadBlob(filename: String, done: kha.Blob -> Void): Void {
		done(new Blob(Bytes.ofData(File.ReadAllBytes(filename))));
	}

	override function loadVideo(filename: String, done: kha.Video -> Void) : Void {
		done(new Video(path + filename + ".wmv"));
	}
	
	override public function loadFont(name : String, style : FontStyle, size : Int) : kha.Font {
		var font : kha.Font = new Font(name, style, size);
		return (font != null ? font : new Font("Arial", style, size));
	}

	@:functionBody('
		System.Diagnostics.Process.Start(new System.Uri(url).AbsoluteUri);
	')
	override public function loadURL(url : String) : Void {
		
	}

	override function checkComplete(): Void {
		if (numberOfFiles <= 0) {
			if (forceBusyCursor)
				Starter.frameworkElement.Cursor = Cursors.Wait;
		}
		super.checkComplete();
	}
	
	override function setNormalCursor() {
		savedCursor = Cursors.Arrow;
		if (!busyCursor && !forceBusyCursor) Starter.frameworkElement.Cursor = Cursors.Arrow;
	}
	
	override function setHandCursor() {
		savedCursor = Cursors.Hand;
		if (!busyCursor && !forceBusyCursor) Starter.frameworkElement.Cursor = Cursors.Hand;
	}
	
	override function setCursorBusy(busy : Bool) {
		busyCursor = busy;
		if (busy || forceBusyCursor)
			Starter.frameworkElement.Cursor = Cursors.Wait;
		else
			Starter.frameworkElement.Cursor = savedCursor;
	}
	
	@:functionBody('
		System.Windows.Application.Current.Shutdown();
	')
	override function quit() : Void { }
}