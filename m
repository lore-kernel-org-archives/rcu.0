Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6BD3A8D0;
	Mon, 16 Sep 2024 05:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726463419; cv=fail; b=f/wyI6jMgOhJ39ophKJ73eODUvc26RdRk4pAoDVIM+dGJYIoPzmR/1WK5mlRWx1HF2OF1MyK4U06iX3wticiBmw6vKmfhtfN4jd4IuU2HvIP1fweLFkVTnZJyGRzUo/CSO4mf2QDymDod3t9cFvA/QBdTCaaYFrVVBikDOrN7/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726463419; c=relaxed/simple;
	bh=ZG69J9fb/MH2pDP9DJ9M1WxKGt76RUByqunLIK7tl1w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PyAWoxVpsUJ4A8reyyp9QLLcL2UcGnT8ujWsW4yxmz79PSUGwFcbgcDfUyiFG19mQ44bbHT+O6mu9Pi3fJO9KkVNaVia6e/SA3gOtuZHCL+XfRoSH286dpR4xH7sfeVB6yzZdwoHSYdzTt/4dVLywGnokqbxN6JCfokTWtuBf7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KSONu474; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KSONu474"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeeRSJDjnT5XmAG9cL8MVPPV7tbchLg/mdlApLaJgQeDt7N3nFhh2WiChXLfPfpphlt8slwlPePCCNj0VaQqI2xyP7FMbUhWmxOsGVpiJahi2SOLu5olPNn7U3VLpqxGJZQ3E2sAWipoUwy4/GJrT1+wVBm63ChIdIjuZvxLczE4b2peJo6P8CJG7t1mZ3ag3yCDnJWrbkanozGd/tr/0OKhV66IW6QSeRrImSSIYY4OU6NAWY5X5k5FvjQ58vS5/4rCaDdvSr5QA7Cdc2k9N7lwZpxErd7tK+PldDJ25vXRbQugiPFaNvQe5mX3FGOm8jsvSOoJUTdoRTF+HJVXzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OqzpmHm/kCI17KSwacwKrAFSzbQ0xVh02AwQwCCtsY=;
 b=Jfx1mhbbVogNZQcy+ONM9uWGGeMVFsse6JpJ6MlGfFAxni8uQ5E5w+l2smP6HbzeaHVNq7z8OboCdGfIJ4otApYZwubST24gYsbVKDAyWQCpbyuWa/IUcCkZQANhGByiK9LSX2U2qjFofG/DCQSPJ5gMyZblEZ1o8HAUttcz4GkIHiXNahCcqb+mnuglX58qABkS1L0dPrXpTO2lBWSy0ltcc5yRtNfZEzjXUp+qmnzRQBcdZU7BMOGtsw/aeVkg8PBVLPH5tyQfeo0NVMdinQCLgkn93GQwMPZXWty4oIpUC4vt40E9+87Z27fMAMi/x1hZsiwuNeZFPKV1tn2HZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OqzpmHm/kCI17KSwacwKrAFSzbQ0xVh02AwQwCCtsY=;
 b=KSONu474m2K6uG+4iUQRZWp/WfoysiVFDfw6n4PCiQ8zHzTNYeHxSbBM0B3AMujdPP9V/5uWKKJHZdMlkIC6aM5d/y6lbRJkO+vUO4LME7jvObvigZP+W/bvKc0pW5Z2FXsREnG3pVWUOOMH/qLMbykPujOZcdCw7/GBniS00S0=
Received: from BY3PR10CA0016.namprd10.prod.outlook.com (2603:10b6:a03:255::21)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 05:10:13 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::9d) by BY3PR10CA0016.outlook.office365.com
 (2603:10b6:a03:255::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Mon, 16 Sep 2024 05:10:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 05:10:12 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 00:10:06 -0500
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <john.johansen@canonical.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <linux-security-module@vger.kernel.org>,
	<gautham.shenoy@amd.com>, <Santosh.Shukla@amd.com>, <Ananth.Narayan@amd.com>,
	<Raghavendra.KodsaraThimmappa@amd.com>, <paulmck@kernel.org>,
	<boqun.feng@gmail.com>, <vinicius.gomes@intel.com>, <mjguzik@gmail.com>,
	<dennis@kernel.org>, <tj@kernel.org>, <cl@linux.com>, <linux-mm@kvack.org>,
	<rcu@vger.kernel.org>
Subject: [RFC 5/6] apparmor: Switch labels to percpu refcount in atomic mode
Date: Mon, 16 Sep 2024 10:38:10 +0530
Message-ID: <20240916050811.473556-6-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916050811.473556-1-Neeraj.Upadhyay@amd.com>
References: <20240916050811.473556-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|CH2PR12MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2f42d9-b4c6-481d-6e1e-08dcd60dd834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A21RKebqrsJAiHO0VT5nONbFgCNyttdxI4ojSVcCkz9cBK3PTRaWbtU9qBA5?=
 =?us-ascii?Q?tJqfUdEH5KLtB1VcKIR2k1CiqTxSnxSR45NT3lG7KMm8X2DxbA3Ox817QebB?=
 =?us-ascii?Q?m0/XwyDH71NyLV0cVfKjqhMfKw7wLBZklL3qWY4xhB9UZXJtNKMAD+L9aML/?=
 =?us-ascii?Q?+Vsjss/Yq35CrzTn8xwvkqPo0yygX8bKF4gYOcuOPSG4sMeA13cKnm9FdJmg?=
 =?us-ascii?Q?i/4ZeLohPPXwz8Tqdpi3bfGAgcqw6cCmxxRehfHsDnKBc6Cc76YpU40zHqWg?=
 =?us-ascii?Q?TiH5QnEkq6V5MFO3yZ2kIjncq35t4uOlyjEQ9I+Avp6JSdx1BsOSeyf/9GBF?=
 =?us-ascii?Q?A1TYEzWotTxIZUq/ox5DUy9Rxk/CiNmyfumB7MpR5ryttWVx7HuJSr0YJ7qH?=
 =?us-ascii?Q?k737TUnU/ICLjsrC1iobDlUP4zb0k/E1wCJuBy2mY0+6cg7WvHud1UKL8Kno?=
 =?us-ascii?Q?U0HnP/fpO47CuHZEAJi+IX+joD1ts32rHPPRHpXxDXRpbcxD5uii3LZazPmy?=
 =?us-ascii?Q?rAs6ON15jmqIfNOoVWn9VyfWc8RmVtozN4rR/gSeEVvE9fO/EDFgrjQ4Cyrc?=
 =?us-ascii?Q?2nNw/A/CTOBig1r7CB4M7qkQuF+rM5Dk2fyjPSDdqdxFRrXO5X2cv3x6ubcB?=
 =?us-ascii?Q?ay/SxZt4044tRLNJNqIS6keXwtGwRa+ioBEdqPIpeWymFp3+o5hb/ftvcNcO?=
 =?us-ascii?Q?5C+SPtRyr7xMgoRiKsckPr3GXBWHntEDpnju/k7G7CaMZ4t97xIWzHuqfLU4?=
 =?us-ascii?Q?jDBTzUIFGkeRyUFUsDcyQIErBMOvYO7TAjW5WCzD447FgJPbtTZ8fLCPE9GV?=
 =?us-ascii?Q?35JsRG0VPJ147UWZiImx+EYKHnKoFxYN4rn79/DwD8qC4Z4L6c20h7I5BENJ?=
 =?us-ascii?Q?zh2D5CqPF5yhcsb7ZPdn91LL9rUINq8WqI6Dor20h3+spFNvVWctpl8RFeXk?=
 =?us-ascii?Q?Lmgh1w0zo+97zsRUsEWU6Vu7yLXpKm/fiTlvirYRVRbHDTQazkIcfRWH2Aij?=
 =?us-ascii?Q?Ycfe4uK45gzfPXHp7EQveqEsoA3/mbbr2WU2Jx/xrJl4t4tn9VLFKnSUXbap?=
 =?us-ascii?Q?nJBhbyobZjY/vZOL/2VjiASc3pyIemKZAkYzq5j122+lbitknGLTd7BPpHEY?=
 =?us-ascii?Q?i+mggmLiUSti1yeMJPTqdvjDncop1UQLVRZef6OgU1RxQVirjgN4eSiGDsud?=
 =?us-ascii?Q?kxmFcNmDc29cCVxBwU0QfuuBYoAHZSwZwXHRtEHtQMhc2k9MxfT3kJ52dBRf?=
 =?us-ascii?Q?pVGt39wZVjWEloz/BseCKH2sqxldCekiwQOVZ/j95ElzmHeoRJHd2VmqsRAu?=
 =?us-ascii?Q?5KA8Kgt43hTBepZz++NI2tqyyZAGCccEN/IrtxYhva0puOeHg1ResKGLtPcP?=
 =?us-ascii?Q?tWnQzXMDCJSGy6+qFlMiP2CGo7wzUCLZOrRdxM5Tmxi19tXgQpCgVTqRRGAY?=
 =?us-ascii?Q?UXCkFdlHhF7E9iEpVZ7lmlrKuMdcdg02?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 05:10:12.9220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2f42d9-b4c6-481d-6e1e-08dcd60dd834
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279

In preparation of using percpu refcount for labels, replace label kref
with percpu ref. The percpu ref is initialized to atomic mode, as
using percpu mode requires tracking ref kill points. As the atomic
counter is in a different cacheline now, rearrange some of the fields
in aa_label struct - flags, proxy; to optimize some of the fast paths
for unconfined labels.

In addition to the requirement to cleanup the percpu ref using
percpu_ref_exit() in label destruction path, other potential impact
from this patch could be:

- Increase in memory requirement (for per cpu counters) for each label.

- Displacement of aa_label struct members to different cacheline, as
  percpu ref takes 2 pointers space.

- Moving of the atomic counter outside of the cacheline of the aa_label
  struct.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 security/apparmor/include/label.h  | 16 ++++++++--------
 security/apparmor/include/policy.h |  8 ++++----
 security/apparmor/label.c          | 11 ++++++++---
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/security/apparmor/include/label.h b/security/apparmor/include/label.h
index 2a72e6b17d68..4b29a4679c74 100644
--- a/security/apparmor/include/label.h
+++ b/security/apparmor/include/label.h
@@ -121,12 +121,12 @@ struct label_it {
  * @ent: set of profiles for label, actual size determined by @size
  */
 struct aa_label {
-	struct kref count;
+	struct percpu_ref count;
+	long flags;
+	struct aa_proxy *proxy;
 	struct rb_node node;
 	struct rcu_head rcu;
-	struct aa_proxy *proxy;
 	__counted char *hname;
-	long flags;
 	u32 secid;
 	int size;
 	struct aa_profile *vec[];
@@ -276,7 +276,7 @@ void __aa_labelset_update_subtree(struct aa_ns *ns);
 
 void aa_label_destroy(struct aa_label *label);
 void aa_label_free(struct aa_label *label);
-void aa_label_kref(struct kref *kref);
+void aa_label_percpu_ref(struct percpu_ref *ref);
 bool aa_label_init(struct aa_label *label, int size, gfp_t gfp);
 struct aa_label *aa_label_alloc(int size, struct aa_proxy *proxy, gfp_t gfp);
 
@@ -373,7 +373,7 @@ int aa_label_match(struct aa_profile *profile, struct aa_ruleset *rules,
  */
 static inline struct aa_label *__aa_get_label(struct aa_label *l)
 {
-	if (l && kref_get_unless_zero(&l->count))
+	if (l && percpu_ref_tryget(&l->count))
 		return l;
 
 	return NULL;
@@ -382,7 +382,7 @@ static inline struct aa_label *__aa_get_label(struct aa_label *l)
 static inline struct aa_label *aa_get_label(struct aa_label *l)
 {
 	if (l)
-		kref_get(&(l->count));
+		percpu_ref_get(&(l->count));
 
 	return l;
 }
@@ -402,7 +402,7 @@ static inline struct aa_label *aa_get_label_rcu(struct aa_label __rcu **l)
 	rcu_read_lock();
 	do {
 		c = rcu_dereference(*l);
-	} while (c && !kref_get_unless_zero(&c->count));
+	} while (c && !percpu_ref_tryget(&c->count));
 	rcu_read_unlock();
 
 	return c;
@@ -442,7 +442,7 @@ static inline struct aa_label *aa_get_newest_label(struct aa_label *l)
 static inline void aa_put_label(struct aa_label *l)
 {
 	if (l)
-		kref_put(&l->count, aa_label_kref);
+		percpu_ref_put(&l->count);
 }
 
 
diff --git a/security/apparmor/include/policy.h b/security/apparmor/include/policy.h
index 75088cc310b6..5849b6b94cea 100644
--- a/security/apparmor/include/policy.h
+++ b/security/apparmor/include/policy.h
@@ -329,7 +329,7 @@ static inline aa_state_t ANY_RULE_MEDIATES(struct list_head *head,
 static inline struct aa_profile *aa_get_profile(struct aa_profile *p)
 {
 	if (p)
-		kref_get(&(p->label.count));
+		percpu_ref_get(&(p->label.count));
 
 	return p;
 }
@@ -343,7 +343,7 @@ static inline struct aa_profile *aa_get_profile(struct aa_profile *p)
  */
 static inline struct aa_profile *aa_get_profile_not0(struct aa_profile *p)
 {
-	if (p && kref_get_unless_zero(&p->label.count))
+	if (p && percpu_ref_tryget(&p->label.count))
 		return p;
 
 	return NULL;
@@ -363,7 +363,7 @@ static inline struct aa_profile *aa_get_profile_rcu(struct aa_profile __rcu **p)
 	rcu_read_lock();
 	do {
 		c = rcu_dereference(*p);
-	} while (c && !kref_get_unless_zero(&c->label.count));
+	} while (c && !percpu_ref_tryget(&c->label.count));
 	rcu_read_unlock();
 
 	return c;
@@ -376,7 +376,7 @@ static inline struct aa_profile *aa_get_profile_rcu(struct aa_profile __rcu **p)
 static inline void aa_put_profile(struct aa_profile *p)
 {
 	if (p)
-		kref_put(&p->label.count, aa_label_kref);
+		percpu_ref_put(&p->label.count);
 }
 
 static inline int AUDIT_MODE(struct aa_profile *profile)
diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index c71e4615dd46..aa9e6eac3ecc 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -336,6 +336,7 @@ void aa_label_destroy(struct aa_label *label)
 			rcu_assign_pointer(label->proxy->label, NULL);
 		aa_put_proxy(label->proxy);
 	}
+	percpu_ref_exit(&label->count);
 	aa_free_secid(label->secid);
 
 	label->proxy = (struct aa_proxy *) PROXY_POISON + 1;
@@ -369,9 +370,9 @@ static void label_free_rcu(struct rcu_head *head)
 	label_free_switch(label);
 }
 
-void aa_label_kref(struct kref *kref)
+void aa_label_percpu_ref(struct percpu_ref *ref)
 {
-	struct aa_label *label = container_of(kref, struct aa_label, count);
+	struct aa_label *label = container_of(ref, struct aa_label, count);
 	struct aa_ns *ns = labels_ns(label);
 
 	if (!ns) {
@@ -408,7 +409,11 @@ bool aa_label_init(struct aa_label *label, int size, gfp_t gfp)
 
 	label->size = size;			/* doesn't include null */
 	label->vec[size] = NULL;		/* null terminate */
-	kref_init(&label->count);
+	if (percpu_ref_init(&label->count, aa_label_percpu_ref, PERCPU_REF_INIT_ATOMIC, gfp)) {
+		aa_free_secid(label->secid);
+		return false;
+	}
+
 	RB_CLEAR_NODE(&label->node);
 
 	return true;
-- 
2.34.1

