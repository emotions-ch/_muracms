 <!--- This file is part of Mura CMS.

Mura CMS is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, Version 2 of the License.

Mura CMS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Mura CMS. If not, see <http://www.gnu.org/licenses/>.

Linking Mura CMS statically or dynamically with other modules constitutes the preparation of a derivative work based on
Mura CMS. Thus, the terms and conditions of the GNU General Public License version 2 ("GPL") cover the entire combined work.

However, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with programs
or libraries that are released under the GNU Lesser General Public License version 2.1.

In addition, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with
independent software modules (plugins, themes and bundles), and to distribute these plugins, themes and bundles without
Mura CMS under the license of your choice, provided that you follow these specific guidelines:

Your custom code

• Must not alter any default objects in the Mura CMS database and
• May not alter the default display of the Mura CMS logo within Mura CMS and
• Must not alter any files in the following directories.

	/admin/
	/core/
	/Application.cfc
	/index.cfm

You may copy and distribute Mura CMS with a plug-in, theme or bundle that meets the above guidelines as a combined work
under the terms of GPL for Mura CMS, provided that you include the source code of that other code when and as the GNU GPL
requires distribution of source code.

For clarity, if you create a modified version of Mura CMS, you are not obligated to grant this special exception for your
modified version; it is your choice whether to do so, or to make such modified version available under the GNU General Public License
version 2 without this exception.  You may, if you choose, apply this exception to your own modified versions of Mura CMS.
--->
 <!--- license goes here --->
 <cfoutput>
  <script>
function submitBundle(){
	if(jQuery("##saveFileDir").val() != ''){
		var message="Create and Save Bundle to Server?";
	} else {
		var message="Create and Download Bundle File?";
	}
	jQuery("##alertDialogMessage").html(message);
	jQuery("##alertDialog").dialog({
			resizable: false,
			modal: true,
			buttons: {
				'No': function() {
					jQuery(this).dialog('close');
				},
        Yes:
          {click: function() {
            jQuery(this).dialog('close');
            //jQuery(".form-actions").hide();
            //jQuery("##actionIndicator").show();
            document.pluginSelectFrm.submit();
            }
          , text: 'Yes'
          , class: 'mura-primary'
        } // /Yes
			}
		});

	return false;
}

checked=false;
function checkAll (form) {

    if (checked == false) {
        checked = true
    }
    else {
        checked = false
    }

    jQuery('input[name="moduleID"]').attr("checked",checked);

}
</script>

<div class="mura-header">
  <h1>Create Site Bundle</h1>
  <div class="nav-module-specific btn-group">
      <a class="btn" href="./?muraAction=cSettings.editSite&siteID=#esapiEncode('url',rc.siteID)#"><i class="mi-arrow-circle-left"></i> Back to Site Settings</a>
  </div>
</div> <!--- /.mura-header --->

<div class="block block-constrain">


  <form id="pluginSelectFrm" name="pluginSelectFrm" action="./index.cfm">


    <div class="block block-bordered">
    <div class="block-content">


    <div class="mura-control-group">
      <label>Include in Site Bundle:</label>

  <div class="help-block">A Bundle includes a Site's architecture &amp; content, all rendering files (display objects, themes, javascript, etc.) and any of the items you select below. </div>

      <label class="checkbox"><input type="checkbox" checked name="includeStructuredAssets" value="true">Files Associated with Content</label>
      
      <label class="checkbox"><input type="checkbox" name="includeTrash" value="true">Items in Trash Bin</label>

      <label class="checkbox"><input type="checkbox" name="includeVersionHistory" value="true">Content Version Histories</label>

      <label class="checkbox"><input type="checkbox" name="includeMetaData" value="true">Content Comments and Ratings</label>

      <cfif application.settingsManager.getSite(session.siteid).getemailbroadcaster()>
        <label class="checkbox"><input type="checkbox" name="includeMailingListMembers" value="true">Mailing List Members</label>
      </cfif>

      <label class="checkbox"><input type="checkbox" name="includeFormData" value="true">Form Response Data</label>
      <cfset siteBean=application.settingsManager.getSite(session.siteID)>
      <cfif siteBean.getPublicUserPoolID() eq siteBean.getSiteID() and siteBean.getPrivateUserPoolID() eq siteBean.getSiteID()>
        <label class="checkbox"><input type="checkbox" name="includeUsers" value="true">
          Site Members &amp; Administrative Users</label>
      </cfif>
  </div>

    <div class="mura-control-group">
      <label>Also include selected Plugins:</label>
      <div class="mura-control justify">
      <cfif rc.rsplugins.recordcount gt 1>
          <a class="btn" href="##" onclick="checkAll('pluginSelectFrm'); return false;"><i class="mi-check"></i> Select All</a>
      </cfif>
        <cfif rc.rsplugins.recordcount>
          <cfloop query="rc.rsplugins">
              <label class="checkbox">
                <input type="checkbox" name="moduleID" value="#rc.rsplugins.moduleID#">
                #esapiEncode('html',rc.rsplugins.name)#</label>
          </cfloop>
          <cfelse>
              <div class="help-block-empty">This site currently has no plugins assigned to it.</p>
        </cfif>
        </div>
    </div>

    <div class="mura-control-group">
      <label>
        Server Directory <span>(Optional)</span></label>
      <div class="mura-control justify">
        <p class="help-block">
          Set the complete server path to the directory where the bundle .zip file is created.
          <br>If left blank, the bundle file will immediately download in the browser after creation.
        <br><br>
        Current Working Directory: #replace(application.configBean.getWebRoot(),"\","/","all")##application.configBean.getAdminDir()#/temp</p>
      </div>
      <div class="mura-control justify">
        <div class="mura-input-set">
          <input type="button" class="btn" onclick="jQuery('##saveFileDir').val('#esapiEncode('javascript','#replace(application.configBean.getWebRoot(),"\","/","all")##application.configBean.getAdminDir()#/temp')#');" value="Select Working Directory">
          <input class="text" type="text" name="saveFileDir" id="saveFileDir">
        </div>
      </div>
    </div>

        </div> <!--- /.block-content --->

      <div class="mura-actions">
        <div class="clearfix form-actions">
        <button class="btn mura-primary" onClick="return submitBundle();"><i class="mi-check-circle"></i>Create Bundle</button>
        <input type="hidden" name="muraAction" value="cSettings.createBundle">
        <input type="hidden" name="siteID" value="#esapiEncode('html_attr',rc.siteID)#">
        </div>
      </div>

      </div> <!--- /.block.block-bordered --->

  </form>

</div>

</cfoutput>