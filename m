Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31713208CA;
	Mon, 16 Sep 2024 05:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726463438; cv=fail; b=rcjMAE5nI3TE8b1YxHJBy9O8tnP1W2ltLHYNDuUHi/EbGPmWkStB3VGkiPXawq4KZb8BWZtyFINVeOqGlXZdDMfp+3UtYz6x5xykBXuZQbp2zMf5Fy+ZLcJU0d/5MvKBoG3WaJrBr9yJTy0xJLKmiCSzP+DCI8WgFnvi4gOOI8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726463438; c=relaxed/simple;
	bh=wvttXrujNLJgzH/rrugvyM3zgnuLWUqavQEIi6zH5Hg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cr3zMpdjU+Mw4GFbhy9EkLOZAseBM72GaGDUPLKO3sC47u8FRurb0ur/lplUjSuae1Wdic7F9Gf8TCQhoiV8QTQHGiiv1hN2pBtfwOuYhli+rRQnYepvATqOy3eHpKhetuveqxTFuiR88VZh4zt9EJfgyvh8GJqMgxpWSNaD36Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=muAX3U3D; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="muAX3U3D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okArEj/DZhKLzPQxzvOAE0CS2lg3ObR8D3J/oEf2l8DLd02+elRZoBJCXwIC2P5xcmBxvmJZQg3e05ihF2XQQW3Nq/x1bDsJRXpZHgGCKj6RNxY0l6okDih5+j/MckqA5dRLHdIJ4cLjiT2kVlJmi+APvTChDvnnQFtW40S5slXOOiJyx46K96gaTBnrFDJbbW3zkHgfYbhJAexcZn3QvmECZ/PqfwftjwU6K07L1P0qtlX0NoQ1Hx1rgu/CPl66zP0viggFncsGKyX4xbIO/3hGOdKrPO56PInG2E1Jhi+4iCCwZFr9Cx1kdII9J6W/pNNyzilLeqrUX5vVpJg1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB7BKcbtTTM97yXiOXbhtWdEpIfxhfdw595BbvBII0g=;
 b=NoCB76d9wY9NbQn9Y8TrmMCix9rhK9TFslxpTbo51UAfTW4Y9cKZ2iHIg73gXed5BAH5VREmj34IxSGATUGnzntBugL58xH49lniIDqxQW6KOqgx+pk44+3TPrNvjMzxJpsvQ1UiYiY46YrPvk9Mvp7BylFbzf5kEdacM3z6vmhANUSDfv7bYwQBTr6V4jeAxpEKY/ed0iQ6Uukd9lUO+0z1XzHrZ6gztG/i1wOveW0kRgWRIokRe83WUyRqf69Yv1EF+1sdKgpVYX1kWOb1kRGvliEId5UKC8DnLap26WwVN8XlgeDJAyFVMaSWK6R7VnsbF16YgbbIyhUjQuJ9YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB7BKcbtTTM97yXiOXbhtWdEpIfxhfdw595BbvBII0g=;
 b=muAX3U3D1KeYTyVg2hYngVRXNdn4J+POh++7h0IBZro70XEHsCApqaL6bWUVH18eTBKbuHtdj2/TkFhsvBR/vymgsMRlD3R6LgqMiDxYG68I17W14MG1R1PnXhMrdfRmWtsENDuDbjMKbytXxK+3oB26PVi8R+QvTkN/S1QSAYw=
Received: from SJ0PR13CA0042.namprd13.prod.outlook.com (2603:10b6:a03:2c2::17)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 05:10:31 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::a2) by SJ0PR13CA0042.outlook.office365.com
 (2603:10b6:a03:2c2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18 via Frontend
 Transport; Mon, 16 Sep 2024 05:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 05:10:30 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 00:10:25 -0500
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <john.johansen@canonical.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <linux-security-module@vger.kernel.org>,
	<gautham.shenoy@amd.com>, <Santosh.Shukla@amd.com>, <Ananth.Narayan@amd.com>,
	<Raghavendra.KodsaraThimmappa@amd.com>, <paulmck@kernel.org>,
	<boqun.feng@gmail.com>, <vinicius.gomes@intel.com>, <mjguzik@gmail.com>,
	<dennis@kernel.org>, <tj@kernel.org>, <cl@linux.com>, <linux-mm@kvack.org>,
	<rcu@vger.kernel.org>
Subject: [RFC 6/6] apparmor: Switch labels to percpu ref managed mode
Date: Mon, 16 Sep 2024 10:38:11 +0530
Message-ID: <20240916050811.473556-7-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e608f2a-c7e0-4287-eab7-08dcd60de2df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ePpUjEb07aoMGi8f7wdjJyRx/HnaoTGdc6a7YBhnMBpf5KQKoUZ4nQPHwGw5?=
 =?us-ascii?Q?8Q5GktXq3Eq4c6qA1KxSEiXyk7hfgXsIAkz0KZSVW28NTUAP2l9rkP/HL7dH?=
 =?us-ascii?Q?MoQTzee8q9/5osLbLt875Q3El42vtS487gOrStrabu+QLWInXIM8guwPDu9U?=
 =?us-ascii?Q?7Bzi3ibJQp3uFtsprkkemLsjIyJPua5fciueQ8jZtZa0DbS+aznLjZY8hHBn?=
 =?us-ascii?Q?6B3AW3OGcl4l23AAn3eiXL8rf5VUS1tUJ2ZcZhpLP8NH0M2A+icPlRrI/Zxn?=
 =?us-ascii?Q?zvkeThuB4QsT6CUwoR0coq//579lnXGziVm+VipndwELmE76l6LaYCZ3W+mx?=
 =?us-ascii?Q?DMHomnwAv+fCa2Vr866wfg8ODK3eYDJxSeWkSmMjXzuD/EJTd5ya+yeWowAh?=
 =?us-ascii?Q?gLNEQpcos9Qw5QiXu0fJSIpw8bsSWABpZG07GQSNBH0WPUhCxWOFbUOuZiWT?=
 =?us-ascii?Q?iW2HtAzIJx72pxJ8TFwBWJqdXA8A3/i50wG4XDU+NXIATwMFnZIOf0YMQnLp?=
 =?us-ascii?Q?mDXQO0EQVKDX3J3RftgEqYGbiSLnJeY/nGzHokgCiiPfYCSQXEgMiI6Amhur?=
 =?us-ascii?Q?xKDohECYJbNbDt49bOE0w4n7xvlb+AHJycYO9d7VO4WyZ+YqkZD93zP2M2ud?=
 =?us-ascii?Q?d4FD1b/6gCCoUHU1hgFtwo2stXeMsp1hy+zW1ctZkmPP7pL+h0QDGzUpfmPL?=
 =?us-ascii?Q?LZMVQ/v//LVm5YBEUP0dZ08SaU/Qj++gqBbFzfKMaQC08B+BUjw+ukAevUuy?=
 =?us-ascii?Q?h4Lnd072kemS3xjUdtSS4zKEjI/CbdpEOtB2ruMVB42V9nmn0c1T0lSBK5bO?=
 =?us-ascii?Q?KQ4Aicbo3i0rBbA8m01TlS8cUcdn6cC0dKriUd/GzQqzr0lHrqrpBLCJIRVA?=
 =?us-ascii?Q?NGkVqN1GybYooL8aiYmteqIN47vng+gYeJ01pxWJBpJt5lEQaKmMA5ecM9uS?=
 =?us-ascii?Q?AuYkbacODFg7Zs5a+2vu75wxucM0sHCJgJKNGCw28qhrHE2Ah+ZQDu+zZR9w?=
 =?us-ascii?Q?AQwzCHatLnx/FwC7nkiYdYKsHd191OqxDfq6hE1nCGF9wPJPcQSHhXgDBLcA?=
 =?us-ascii?Q?aZKuXEU/IQRbWGJj6rYoRlOcVFll5qm8yN/dRYcS6BKd8sO6KAJFbIkZXxga?=
 =?us-ascii?Q?CW9eqLr57X6XVOoeNNL0eP9b3m0oREfOwnXRfM6FJqe29M8NGTmTnD3TtNNV?=
 =?us-ascii?Q?EbnMCUps3vy0S0E/1QMiscjBLxGYITixrgiMX1UPymedEg2WvEuNFeyK6kmh?=
 =?us-ascii?Q?z2gsM/41/Zkhi6y3fmTVxwHjZWjy4Nb2AgwFxeNOkJvx0nJSUg0nKKC+0Pli?=
 =?us-ascii?Q?Bw+8gHGdUunhIcCAvsY92V17ZL1bFGr+EMx7W8rKeNA467+vPU0AlF77Chl1?=
 =?us-ascii?Q?jqJgtd1sygA33IvaMn8pXIRi/mw5bA/UBBmqfNgZ7VfAIkC2iUBBd6ewTmAs?=
 =?us-ascii?Q?6jX3rMsYdUUjxC1nEMnNuhWkJd7RV9zt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 05:10:30.7605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e608f2a-c7e0-4287-eab7-08dcd60de2df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753

Nginx performance testing with Apparmor enabled (with Nginx running in
unconfined profile), on kernel versions 6.1 and 6.5 show significant
drop in throughput scalability when Nginx workers are scaled to use
higher number of CPUs across various L3 cache domains.

Below is one sample data on the throughput scalability loss, based on
results on AMD Zen4 system with 96 CPUs with SMT core count 2:

Config      Cache Domains     apparmor=off        apparmor=on
                             scaling eff (%)      scaling eff (%)
8C16T          1                  100%             100%
16C32T         2                   95%              94%
24C48T         3                   94%              93%
48C96T         6                   92%              88%
96C192T        12                  85%              68%

There is a significant drop in scaling efficiency for 96 cores/192 SMT
threads.

Perf tool shows most of the contention coming from below places:
6.56%     nginx  [kernel.vmlinux]      [k] apparmor_current_getsecid_subj
6.22%     nginx  [kernel.vmlinux]      [k] apparmor_file_open

The majority of the CPU cycles is found to be due to memory contention
in atomic_fetch_add and atomic_fetch_sub operations from kref_get() and
kref_put() operations on AppArmor labels.

A part of the contention was fixed with commit 2516fde1fa00 ("apparmor:
Optimize retrieving current task secid"). After including this commit, the
scaling efficiency improved to below:

Config      Cache Domains     apparmor=on        apparmor=on (patched)
                             scaling eff (%)      scaling eff (%)
8C16T          1                  100%             100%
16C32T         2                   97%              93%
24C48T         3                   94%              92%
48C96T         6                   88%              88%
96C192T        12                  65%              79%

However, the scaling efficiency impact is still significant even after
including the commit. Also, the performance impact is even higher for
>192 CPUs. In addition, the memory contention impact would increase
when there is a high frequency of label update operations and labels
are marked stale more frequently.

Use the new percpu managed mode for tracking release of all Apparmor
labels. Using percpu refcount for Apparmor label's refcounting improves
throughput scalability for Nginx:

Config      Cache Domains     apparmor=on (percpuref)
                              scaling eff (%)
8C16T          1                  100%
16C32T         2                   96%
24C48T         3                   94%
48C96T         6                   93%
96C192T        12                  90%

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---

The apparmor_file_open() refcount contention has been resolved recently
with commit f4fee216df7d ("apparmor: try to avoid refing the label in
apparmor_file_open"). I have posted this series to get feedback on the
approach to improve refcount scalability within apparmor subsystem.


 security/apparmor/label.c     | 1 +
 security/apparmor/policy_ns.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index aa9e6eac3ecc..016a45a180b1 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -710,6 +710,7 @@ static struct aa_label *__label_insert(struct aa_labelset *ls,
 	rb_link_node(&label->node, parent, new);
 	rb_insert_color(&label->node, &ls->root);
 	label->flags |= FLAG_IN_TREE;
+	percpu_ref_switch_to_managed(&label->count);
 
 	return aa_get_label(label);
 }
diff --git a/security/apparmor/policy_ns.c b/security/apparmor/policy_ns.c
index 1f02cfe1d974..18eb58b68a60 100644
--- a/security/apparmor/policy_ns.c
+++ b/security/apparmor/policy_ns.c
@@ -124,6 +124,7 @@ static struct aa_ns *alloc_ns(const char *prefix, const char *name)
 		goto fail_unconfined;
 	/* ns and ns->unconfined share ns->unconfined refcount */
 	ns->unconfined->ns = ns;
+	percpu_ref_switch_to_managed(&ns->unconfined->label.count);
 
 	atomic_set(&ns->uniq_null, 0);
 
@@ -377,6 +378,7 @@ int __init aa_alloc_root_ns(void)
 	}
 	kernel_t = &kernel_p->label;
 	root_ns->unconfined->ns = aa_get_ns(root_ns);
+	percpu_ref_switch_to_managed(&root_ns->unconfined->label.count);
 
 	return 0;
 }
-- 
2.34.1

