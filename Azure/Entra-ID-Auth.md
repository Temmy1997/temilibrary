# Microsoft Entra ID 

## 1. What is it?

- Microsoft Entra ID (formerly **Azure Active Directory / Azure AD**, renamed in 2023) is Microsoft's cloud-based **identity and access management (IAM)** service. 
- It's the foundational product in the Microsoft Entra family.

## In plain terms: 
- it's the system that checks who you are (authentication) 
- It decides what you're allowed to do (authorization) across Microsoft 365, Azure, and thousands of third-party apps.

## 2. Core concepts

**Tenant** — A tenant is a dedicated instance of Microsoft Entra ID that represents one organization — it's where all of that organization's users, groups, and app permissions live, isolated from every other company's tenant."

**Users and groups** — individual accounts and collections of accounts. Access to apps and resources is usually granted to a group rather than one-by-one to users.

**App registration** — the process of telling Entra ID an application exists so it can handle sign-in and permissions for it.


**Rule of thumb:**
- **Application object** = the app's identity card, made once by its creator, lives in the home tenant.
- **Service principal** = the app's permission slip, made fresh in every tenant that uses the app, controls what it can actually do there.
- One application object → many service principals (one per tenant using the app).

**Security principal** — the general term for anything (user, group, service principal, managed identity) that can be assigned access. This is what Entra ID authenticates and authorizes.

**Managed identity** — a special type of service principal Azure creates and manages automatically for a resource (like a VM or pipeline) so it can authenticate to other Azure services without you handling credentials manually.

## 3. Authentication vs. authorization

These are two different steps and get mixed up constantly:

- **Authentication** = proving who you are (username/password + MFA).
- **Authorization** = once verified, deciding what you're allowed to do.

Authentication happens first, and MFA is enforced at this stage — before any app-specific token is issued.

## 4. How apps trust Entra ID: the protocols

Entra ID doesn't invent its own login protocol — it implements open industry standards:

**OAuth 2.0** — a protocol for *authorization*. It lets a user grant an app limited access to a resource without handing over their password (e.g., "let this app read my calendar").

**OpenID Connect (OIDC)** — built on top of OAuth 2.0, but adds *authentication*. It's the standard for modern apps — mobile apps, websites, web APIs — to confirm who the user is.

**SAML** — an older XML-based protocol, still common in enterprise apps and federated setups (e.g., linking on-prem Active Directory Federation Services to Entra ID).

Whichever protocol an app uses, Entra ID applies the same security policies (MFA, Conditional Access) before issuing a token — so the user experience is consistent regardless of the underlying plumbing.

**Tokens** — once authenticated, Entra ID issues a signed token the app trusts, so the user doesn't need to log in again for every action or app (this is what powers **SSO**, Single Sign-On).

## 5. Key security features

**Multi-Factor Authentication (MFA)** — requires a second proof of identity beyond a password (e.g., an Authenticator app code).

**Conditional Access** — "if this, then that" access rules. Policies evaluate signals like user location, device compliance, and sign-in risk, then require extra verification, block access, or allow it. Not available on the Free tier.

**Identity Protection** — detects risky sign-ins (e.g., impossible travel, leaked credentials) and can trigger automatic responses.

**Privileged Identity Management (PIM)** — grants admin-level roles *just-in-time* instead of standing 24/7 access, reducing the attack surface of privileged accounts.

**Access Reviews** — periodic checks to confirm people still need the access they have.

**Passkeys / FIDO2** — passwordless sign-in using device-bound security keys or biometrics; Microsoft has been actively expanding support for this through 2026.

## 6. Licensing tiers (as of 2026)

| Tier | Approx. price | Included in | Adds |
|---|---|---|---|
| **Free** | $0 | Every Microsoft 365/Azure/Dynamics 365 tenant | Basic user/group management, directory sync, security defaults, MFA via Authenticator |
| **P1** | ~$6/user/month | Microsoft 365 E3/F1/F3, Business Premium, EM+S E3 | Conditional Access, dynamic groups, self-service password reset (hybrid), advanced reporting, Application Proxy |
| **P2** | ~$9/user/month | Microsoft 365 E5 | Everything in P1 + Identity Protection (risk-based sign-in), PIM, Access Reviews |
| **Entra Suite** | ~$12/user/month (requires P1) | — | Full Identity Governance, Internet Access, Private Access, Verified ID, and more |

Prices and bundles change; check [Microsoft's official licensing page](https://learn.microsoft.com/en-us/entra/fundamentals/licensing) for current numbers.

## 7. Why it matters for DevOps / Azure work

- Pipelines and automation don't log in as a human — they authenticate using a **service principal** or **managed identity**.
- **Service connections** in Azure DevOps are typically backed by a service principal registered in Entra ID.
- Role-Based Access Control (RBAC) in Azure is layered on top of Entra ID identities — a security principal must exist before you can grant it a role on a resource.
- Conditional Access and MFA policies can affect automated logins too, so pipeline authentication often uses certificates or federated credentials instead of passwords.

## 8. Quick glossary

- **Tenant** — your org's isolated Entra ID instance
- **SSO** — log in once, access many apps
- **MFA** — password + a second factor
- **Security principal** — anything that can be granted access (user, group, app, managed identity)
- **Service principal** — an app's identity within a tenant
- **Managed identity** — Azure-managed service principal, no credentials to handle
- **Conditional Access** — context-based access rules
- **PIM** — just-in-time privileged access
- **OAuth 2.0** — authorization protocol
- **OIDC** — authentication protocol built on OAuth 2.0
- **SAML** — older XML-based auth protocol, common in enterprise/federated setups
- **Zero Trust** — "never trust, always verify" security model

## Sources

- [What is Microsoft Entra? — Microsoft Learn](https://learn.microsoft.com/en-us/entra/fundamentals/what-is-entra)
- [Microsoft Entra releases and announcements — Microsoft Learn](https://learn.microsoft.com/en-us/entra/fundamentals/whats-new)
- [What's New in Microsoft Entra: June 2026 — Microsoft Community Hub](https://techcommunity.microsoft.com/blog/microsoft-entra-blog/whats-new-in-microsoft-entra-june-2026/4517885)
- [Microsoft Entra licensing — Microsoft Learn](https://learn.microsoft.com/en-us/entra/fundamentals/licensing)
- [Microsoft Entra ID Licensing: Free, P1, P2, Suite — Ciraltos](https://www.ciraltos.com/microsoft-entra-id-licensing-free-p1-p2-and-the-entra-suite-explained/)
- [Apps & service principals in Microsoft Entra ID — Microsoft Learn](https://learn.microsoft.com/en-us/entra/identity-platform/app-objects-and-service-principals)
- [Register a Microsoft Entra app and create a service principal — Microsoft Learn](https://learn.microsoft.com/en-us/entra/identity-platform/howto-create-service-principal-portal)
- [Authentication vs. authorization — Microsoft Learn](https://learn.microsoft.com/en-us/entra/identity-platform/authentication-vs-authorization)
- [OAuth 2.0 authorization with Microsoft Entra ID — Microsoft Learn](https://learn.microsoft.com/en-us/entra/architecture/auth-oauth2)
- [OpenID Connect authentication with Microsoft Entra ID — Microsoft Learn](https://learn.microsoft.com/en-us/entra/architecture/auth-oidc)
- [Single sign-on SAML protocol — Microsoft Learn](https://learn.microsoft.com/en-us/entra/identity-platform/single-sign-on-saml-protocol)
- [Understand Microsoft's SSO model — Microsoft Learn](https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/understand-microsoft-sso-model)
