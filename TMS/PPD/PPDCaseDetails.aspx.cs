using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PPD_PPDCaseDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MultiView1.SetActiveView(viewAttachment);
            btnAttachmanet.CssClass = "btn btn-warning p-3";
            lnkPreauthorization.CssClass = "nav-link active nav-attach";
        }
    }

    protected void btnPastHistory_Click(object sender, EventArgs e)
    {
        MultiView1.SetActiveView(viewPastHistory);
        btnPastHistory.CssClass = "btn btn-warning p-3";
        btnPreauth.CssClass = "btn btn-primary p-3";
        btnAttachmanet.CssClass = "btn btn-primary p-3";
        btnTreatmentDischarge.CssClass = "btn btn-primary p-3";
    }

    protected void btnPreauth_Click(object sender, EventArgs e)
    {
        MultiView1.SetActiveView(viewPreauth);
        btnPreauth.CssClass = "btn btn-warning p-3";
        btnPastHistory.CssClass = "btn btn-primary p-3";
        btnAttachmanet.CssClass = "btn btn-primary p-3";
        btnTreatmentDischarge.CssClass = "btn btn-primary p-3";
    }

    protected void btnTreatmentDischarge_Click(object sender, EventArgs e)
    {
        MultiView1.SetActiveView(viewTreatmentDischarge);
        btnPreauth.CssClass = "btn btn-primary p-3";
        btnPastHistory.CssClass = "btn btn-primary p-3";
        btnAttachmanet.CssClass = "btn btn-primary p-3";
        btnTreatmentDischarge.CssClass = "btn btn-warning p-3";
    }

    protected void btnAttachmanet_Click(object sender, EventArgs e)
    {
        MultiView1.SetActiveView(viewAttachment);
        MultiView2.SetActiveView(viewPreauthorization);
        btnAttachmanet.CssClass = "btn btn-warning p-3";
        btnPreauth.CssClass = "btn btn-primary p-3";
        btnPastHistory.CssClass = "btn btn-primary p-3";
        btnTreatmentDischarge.CssClass = "btn btn-primary p-3";
        lnkPreauthorization.CssClass = "nav-link active nav-attach";
        lnkDischarge.CssClass = "nav-link nav-attach";
        lnkDeath.CssClass = "nav-link nav-attach";
        lnkClaim.CssClass = "nav-link nav-attach";
        lnkGeneralInvestigation.CssClass = "nav-link nav-attach";
        lnkSpecialInvestigation.CssClass = "nav-link nav-attach";
        lnkFraudDocuments.CssClass = "nav-link nav-attach";
        lnkAuditDocuments.CssClass = "nav-link nav-attach";
    }

    protected void lnkPreauthorization_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewPreauthorization);
        btnAttachmanet.CssClass = "btn btn-warning p-3";
        lnkPreauthorization.CssClass = "nav-link active nav-attach";
        lnkDischarge.CssClass = "nav-link nav-attach";
        lnkDeath.CssClass = "nav-link nav-attach";
        lnkClaim.CssClass = "nav-link nav-attach";
        lnkGeneralInvestigation.CssClass = "nav-link nav-attach";
        lnkSpecialInvestigation.CssClass = "nav-link nav-attach";
        lnkFraudDocuments.CssClass = "nav-link nav-attach";
        lnkAuditDocuments.CssClass = "nav-link nav-attach";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "hidePopOver", "hidePopOver();", true);
    }

    protected void lnkDischarge_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewDischarge);
        btnAttachmanet.CssClass = "btn btn-warning p-3";
        lnkDischarge.CssClass = "nav-link active nav-attach";
        lnkPreauthorization.CssClass = "nav-link nav-attach";
        lnkDeath.CssClass = "nav-link nav-attach";
        lnkClaim.CssClass = "nav-link nav-attach";
        lnkGeneralInvestigation.CssClass = "nav-link nav-attach";
        lnkSpecialInvestigation.CssClass = "nav-link nav-attach";
        lnkFraudDocuments.CssClass = "nav-link nav-attach";
        lnkAuditDocuments.CssClass = "nav-link nav-attach";
    }

    protected void lnkDeath_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewDeath);
        btnAttachmanet.CssClass = "btn btn-warning p-3";
        lnkDeath.CssClass = "nav-link active nav-attach";
        lnkDischarge.CssClass = "nav-link nav-attach";
        lnkPreauthorization.CssClass = "nav-link nav-attach";
        lnkClaim.CssClass = "nav-link nav-attach";
        lnkGeneralInvestigation.CssClass = "nav-link nav-attach";
        lnkSpecialInvestigation.CssClass = "nav-link nav-attach";
        lnkFraudDocuments.CssClass = "nav-link nav-attach";
        lnkAuditDocuments.CssClass = "nav-link nav-attach";
    }

    protected void lnkClaim_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewClaims);
        btnAttachmanet.CssClass = "btn btn-warning p-3";
        lnkClaim.CssClass = "nav-link active nav-attach";
        lnkDeath.CssClass = "nav-link nav-attach";
        lnkDischarge.CssClass = "nav-link nav-attach";
        lnkPreauthorization.CssClass = "nav-link nav-attach";
        lnkGeneralInvestigation.CssClass = "nav-link nav-attach";
        lnkSpecialInvestigation.CssClass = "nav-link nav-attach";
        lnkFraudDocuments.CssClass = "nav-link nav-attach";
        lnkAuditDocuments.CssClass = "nav-link nav-attach";
    }

    protected void lnkGeneralInvestigation_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewGeneralInvestigation);
        btnAttachmanet.CssClass = "btn btn-warning p-3";
        lnkGeneralInvestigation.CssClass = "nav-link active nav-attach";
        lnkClaim.CssClass = "nav-link nav-attach";
        lnkDeath.CssClass = "nav-link nav-attach";
        lnkDischarge.CssClass = "nav-link nav-attach";
        lnkPreauthorization.CssClass = "nav-link nav-attach";
        lnkSpecialInvestigation.CssClass = "nav-link nav-attach";
        lnkFraudDocuments.CssClass = "nav-link nav-attach";
        lnkAuditDocuments.CssClass = "nav-link nav-attach";
    }

    protected void lnkSpecialInvestigation_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewSpecialInvestigation);
        btnAttachmanet.CssClass = "btn btn-warning p-3";
        lnkSpecialInvestigation.CssClass = "nav-link active nav-attach";
        lnkGeneralInvestigation.CssClass = "nav-link nav-attach";
        lnkClaim.CssClass = "nav-link nav-attach";
        lnkDeath.CssClass = "nav-link nav-attach";
        lnkDischarge.CssClass = "nav-link nav-attach";
        lnkPreauthorization.CssClass = "nav-link nav-attach";
        lnkFraudDocuments.CssClass = "nav-link nav-attach";
        lnkAuditDocuments.CssClass = "nav-link nav-attach";
    }

    protected void lnkFraudDocuments_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewFraudDocuments);
        btnAttachmanet.CssClass = "btn btn-warning p-3";
        lnkFraudDocuments.CssClass = "nav-link active nav-attach";
        lnkSpecialInvestigation.CssClass = "nav-link nav-attach";
        lnkGeneralInvestigation.CssClass = "nav-link nav-attach";
        lnkClaim.CssClass = "nav-link nav-attach";
        lnkDeath.CssClass = "nav-link nav-attach";
        lnkDischarge.CssClass = "nav-link nav-attach";
        lnkPreauthorization.CssClass = "nav-link nav-attach";
        lnkAuditDocuments.CssClass = "nav-link nav-attach";
    }

    protected void lnkAuditDocuments_Click(object sender, EventArgs e)
    {
        MultiView2.SetActiveView(viewAuditDocuments);
        btnAttachmanet.CssClass = "btn btn-warning p-3";
        lnkAuditDocuments.CssClass = "nav-link active nav-attach";
        lnkFraudDocuments.CssClass = "nav-link nav-attach";
        lnkSpecialInvestigation.CssClass = "nav-link nav-attach";
        lnkGeneralInvestigation.CssClass = "nav-link nav-attach";
        lnkClaim.CssClass = "nav-link nav-attach";
        lnkDeath.CssClass = "nav-link nav-attach";
        lnkDischarge.CssClass = "nav-link nav-attach";
        lnkPreauthorization.CssClass = "nav-link nav-attach";
    }

    protected void btnTransactionDataReferences_Click(object sender, EventArgs e)
    {
        lbTitle.Text = "Transaction Data References";
        MultiView3.SetActiveView(viewEnhancement);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
    }

    protected void lnkPhoto_Click(object sender, EventArgs e)
    {
        lbTitle.Text = "Patient Photo";
        MultiView3.SetActiveView(viewPhoto);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
    }

    protected void lnkDocument_Click(object sender, EventArgs e)
    {
        lbTitle.Text = "Enhancement Justification";
        MultiView3.SetActiveView(viewJustification);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
    }

    protected void lnkChildPhoto_Click(object sender, EventArgs e)
    {
        lbTitle.Text = "Child Photo";
        MultiView3.SetActiveView(viewPhoto);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
    }

    protected void lnkBirthRationDocument_Click(object sender, EventArgs e)
    {
        lbTitle.Text = "Birth Certificate/ Ration Card";
        MultiView3.SetActiveView(viewJustification);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
    }

    protected void btnViewAudit_Click(object sender, EventArgs e)
    {
        lbTitle.Text = "Raise Query Audit";
        MultiView3.SetActiveView(viewAudit);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
    }
}