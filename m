Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794182575;
	b=St3i2WNUlyF01ppf3Azv9MpucC4EapqnTAJyHkBar7DvpxTbHNZAAf+6/kgX5CRtZXMb
	 CtruG4E7GUrqakKvpaj9AVbZIWwT9JPbrglexC1r4FmxPfXgOtB84SCpJhm/uIOt3ylBm
	 XvFKvTJrbq4SfkfoVm+hCpM3oUJ3i+CkwKdb7wWfjoLwajHDx+x6Gf3GVjtSeIGP8JbSt
	 OhrH0CIKBRbH3MBY6BBaDt7FZSkzQso1oKlkVUphRms1TYZt4vXQKXs97iCrdGsTYpWtW
	 DXsDJ/ADe8zwJT/91uxQmpvUW0ZnQFeeaYzeahbdeuOKPlzzxKgKmP1H6vNHAaKaOyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794182575;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=5SMC8PZ5hKLr+SImlMZWd0cbahZPA7ZAOUzZmRuax+o=;
	b=XW7ZOjeU7SWdhSIARWLJ1MwuUnSgl/KbMG8wJoITltb9qHhWVFaufZ1QGi7b3xSxJv9r
	 HB4FUAMXsYDbCeRs0EZZw864Rg11Qq/NsbCQLFTjQpzCC8Ph+tiAl5xG4qPb0wBWK3VRv
	 VhohLvlPn2PBK3jiQNSQFFSGIowjQbcLuv5wtU6/mn74JlDEnd8xfWrBPszc9GQA7pv8D
	 oO9V9Jou5Hxyd56Qs0GS8ef/FfQYsThBg9/ORB/8Z4S5aQghniiQmubI6bHVcEQWGtiiB
	 sG/gIb9S3yu+ZNzasZVuy08fn9fKbzfYswr14tAchkyme3LFg/8Omk8OqlhLZxGc76g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="aQ/5Rppp";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.50
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012050.outbound.protection.outlook.com [40.107.209.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB66F606A330;
	Mon,  9 Nov 2026 00:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB66F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aQ/5Rppp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YS41uxMW5iIYKfdr6Mw7tBEownrwLXZZ4PqEmAuvfm28eJlpzPRC7/QDiA5W+VLZxEucBlH4qtYn6YVPyPYTuY4855hchdvhGGxhnxRgvT1zinvJGt/j1Q/5T0slZcOop42Y5AnYeB9+5U/GkW7B7va4jvbOQwoZzebVPMysx/ay5MZL5SPZRehJRApcJmYbArgwxpbMpAewrJA9vyRc6NfYHr3xFAuazQIAqQQF8Aj7z8cDZiPAkoTg1EBBRuagJPejIWrR561LULJTvlLfNLS9yxYBObui1LlLwXKiL2XYY41igpQoqHiQBw0rjHX7ZOeSkW1Fe4uiIxErN2l2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SMC8PZ5hKLr+SImlMZWd0cbahZPA7ZAOUzZmRuax+o=;
 b=Sq4lZDnBChKM2/jAh6HRxMXHJKXMZMxuB1J1Vph6DIl/uWcmbMEB3HY4muSrteckBjQbBQU5iPKv2pc2GcxAwPqvXoctJZxl5In7eI4eJw4PVoTngaIriKUQK5uQ/oweqt+mDrhXodO7ntUQcyDb4pFQ4Z1kJPd4o4BOboO+2uRb0ctgR0174+IBjjG2DnMie9+2fTEKVRXSJFRP2m4hPXGBoteeP/M6gEVnBhlqoR5xKKJ5f47sybhTqdZ0omhtTHT8KEPvIdBu8UhV+q5lk7Y6kDC1vSZ73d4tpCIFKsZnOcasAoJeDIfLfjqT8g90a7Bg48NIeblol3iXrg9/vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SMC8PZ5hKLr+SImlMZWd0cbahZPA7ZAOUzZmRuax+o=;
 b=aQ/5Rpppd7LM4tCdckJ7aZSDH1E4AtRfYawvwYyHTpB2D9lZC8TBLbTMtOMAhwNOfpdcIGUYNIfpYVSVq+4Xd4lvQm4Wg+Y1AjazFs9PveM5xbt4V8DuKULOJMW4wde3elln0wZJoGZIvGa0PLRlNTmu8BHVUN5R9ZlWsbK8CevsIlksLVN/x8XR8/ZD2wxGEpxIbfOhYRL3qnhJwqVQaM7gx3s8PbParoi1CEJB9ACvnDqMAVIR4e2ti9T56jGYSj3Qgvi0tbICZSi/2ymrxpyTfJM2/z5SlhB69FrEw2MPUtFt2V6CIDEQJ/vH6XKMutTce8WvDMJd4hCLCTT2ZA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by PH7PR12MB9224.namprd12.prod.outlook.com (2603:10b6:510:2e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 00:02:51 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 00:02:50 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: rcu@vger.kernel.org
Subject: [PATCH v2 2/5] scftorture: Reject empty workloads before starting helpers
Date: Sun,  8 Nov 2026 19:02:38 -0500
Message-ID: <20261109000243.3936824-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109000243.3936824-1-joelagnelf@nvidia.com>
References: <20261109000243.3936824-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0197.namprd13.prod.outlook.com
 (2603:10b6:208:2be::22) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|PH7PR12MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d65a517-7b59-45e9-4030-08df3df4cb62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|921020|11063799006|5023799004|56012099006|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	G+DtSBCSyUU/N/iBdG5jyc50C/YnZUcOQAyAA0hHBgkZ/jjdP6NeM7GKGxgoOq2eyPiR6tM3JIZ5OD9gvJwQzx00T4eB4cBguI937HFjygEoVsF+jhr97shUA6w8THmrr7q6dF094iI9TclpECsQcORvOe5n0myo/dtm6y0TA01Syb/OA9NGb6FTa4rUq5GfFw7TUIC39xSyw+H26mU59GjQUhnmJ5/PNLIKUY0z7dQskO74sRPytbeqFXwszzsqAtXeDQTZPkwn6fbgyzzet2pshvvXet1rQjsgl3qO6HLzxq1N2dIbFGphTpjW60A8zbXA6tn+EfUrIPKo0cEvFl6mV7qQEEssSp2Hx/KVr7yEkI9r/yUjedTYWAqV8jAyZgrXcGKjwvRBf3y9tto4SRN/7pIbbZsAXA4MXXHXfrdS+kE6Y6MWV+cK2LXdC2R2I+jRfeeggMeD9Jc3lXAhCXA85dUEF7l6SutDl1xAFlbjtn8iulXistdGT3r03Zz+wlNCroWrxDqQr/83Mj5t1k1j8SqKtUegN2Mhk8dSQYLXiSVhSci+CtoGiJeXUiIuSUuovPvLMLbTjaN0MdFrxt0A47mCgXDDqpQRnMnd+DQ1evgTpOgm1if4X5iQku+CIayHQ4CYho8w6Zxlm51R/kH7l+ON4L2w/ueC5a7FT9NSlpezM2QBzpl7g7S9Q8Z5o3K05LtS4ydsPPJP7GjLDw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(921020)(11063799006)(5023799004)(56012099006)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J3edhThsJ2rSoNbdmVUDxr8lQAHNazdtdUyHpRvl8j3sa3SV1B4CGGxEzdw9?=
 =?us-ascii?Q?5yyRPcQIT197F8Gp/XZdiNFx/Ff7d5ui5Uxo788EDhpk1qa3veaNjDWqX8ZW?=
 =?us-ascii?Q?OFSztwOcpqssuKE9tuGVa2Lq1FY+OAw5Se5jQM0vjHq8GYovWJ/5pKmBqi2T?=
 =?us-ascii?Q?Nag6EK9Qb0UBt9x5MppZiMKH9C+Kmk6fWqENuZx0LBSYrCOw/5POn0PN5XBx?=
 =?us-ascii?Q?dWMlbqXXrbaZTpS+s5DceSWJrUMfPcLPdIe3rIWAI5BYRwipmjojCKw2a2t4?=
 =?us-ascii?Q?IcdAN2RicumebC6gtud7wf/YVLFzFQXdkBOfTlmRS0y+U++6P4NWfYBCdNUh?=
 =?us-ascii?Q?m6l7oLDJBSE2WhV/w+Ns0EMLaQnBuFL4JKIfPJy6M1/ZJs+aktRzPQkd36rw?=
 =?us-ascii?Q?LD8Qsx3yK8Jich82oHHmKXT6+l2OwH98KlrIe3ELGqBRr6tkGFX2LGYwJCSg?=
 =?us-ascii?Q?8Vd4j3GnjRlVIWgPtGZmAfS5XBzxFTw709IXvo4u8ZCJaxEQosauct0dtjCL?=
 =?us-ascii?Q?MSAi5Bw1lVGiER0WTn5sU/1mxHhdaWfBrqp4VdgsknJpLDJ3Nr/PrcU+FZmd?=
 =?us-ascii?Q?PQE9MzI/2VDjw0LstB60uy5VUEgtdJ3ExlfCAT5lMf9Z4XPGtvitk+nl4Cxp?=
 =?us-ascii?Q?dlNpU153hV6D2UtsFHESFlkGVfwxmJ7vh+91KrfqxtpeIdRYaI2n9/VQLV7H?=
 =?us-ascii?Q?JjS2pA9igIiHGOR0C4oQOWJ3VxZ2CoIk6KXTLbaQDFlgyjwFCY0cmMSenuSl?=
 =?us-ascii?Q?GnOKWjRspydj8L7P53eA3R9/6JoYix7HhNZkUuzhlOYe4Ls4mMWj6j5RBT4T?=
 =?us-ascii?Q?u2YYkF8HLv8/M9ApPRDV1atm5P6KsRZC9NsiJgL4uqCfBSqwQdxPcFfpZIPe?=
 =?us-ascii?Q?mnqrIw5EYrUmnYI2qXtiYHXzc83rUa7QdPDvEQ00T+AdNlHwmRsGs0UYfW2t?=
 =?us-ascii?Q?a4qhaKztAoqR8j5QJSSIjprRI21MiWfqiafLf74zpjNoVEtUQOkxMieDhLBI?=
 =?us-ascii?Q?SHuwWRFfVsz/tcz2UypaLWf56gGlwCnqmSx7HFHx5k8l7nO417Zx/yDIhC7M?=
 =?us-ascii?Q?XH2oATQkhlaur4Om+llwfIdH0kkh4Iuf8CcJLkO9MYAKu2PAPdd4n7jYwfPv?=
 =?us-ascii?Q?SRKvkqZk78Fiwsyjdh1Lp497j2ihbbkPFJvbaa06YHpDrKUIQ2ouWYSkMM9M?=
 =?us-ascii?Q?rZa9DLZcG2uP+pTdHe8QiA5xJJ4vuyWq5nxtHI09xWTrZi6UYPSIV9W8RRg+?=
 =?us-ascii?Q?uQ5wuAkkbWCZ6VyRdg7/iDJxIFgeeRqEP4bgEpLFEwTs4Dz+Ox4RnVqSR3lq?=
 =?us-ascii?Q?SAfEGG3c53akxQZ0MGuplqnYHFZVqcJZb5DMCK+L97upwQWyJ6qk7MhVDRGE?=
 =?us-ascii?Q?YmYK95iNxZDqL7fx7nosvfnFK0xJA3Qa/RX0BebGmjeT2YxO6+acOyKxnhRB?=
 =?us-ascii?Q?rN4+bwXYZmhlYpWFbZXJlOa+6+DIf+bjdwJQWHUjva0Ln9E99WIAXJBTmW/N?=
 =?us-ascii?Q?EymzwzUMA4Gm8bXsjrRlsi7h5hN+gff56KzQUpXFgC9ETyc5qPogJMg4z8xX?=
 =?us-ascii?Q?sJ9wqZsvyG1PyVmP9miMFWTIdzRFsFIpA7fKMT6C8gDLvb2FMAtuubHvgzVH?=
 =?us-ascii?Q?n3PJXcD0gx58/uG/NBaHTlw59Ci4aJ4OeCkKDZUh3ij7Oq/nEjU1k4RCroF0?=
 =?us-ascii?Q?css91FRHiwxopYf/VPkTavxSUkSFtz2fWTbXVJvkxiw/AnwI02zAq+VcwHph?=
 =?us-ascii?Q?ajcfgwNpOg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d65a517-7b59-45e9-4030-08df3df4cb62
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 00:02:50.4670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvrpJp5vgFb3jlBP2F2F14Cexzi7knQjbx7N7yRjC6odkj4s2KIQ0EWjQ9rpS6F1cKfPh0LvqIdki+9IxU8Xjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9224

A module loaded with nthreads=0 starts its statistics task, but cleanup
skips stopping that task. Unloading the module then leaves it executing
freed module text. Reject a zero thread count before starting helpers;
negative counts still select the online CPU count.

Also, when built as a module with reschedule-only, this leaves the
selector empty because resched_cpu() is unavailable to modules. It warns
while selecting an operation, invokes no callbacks, and can nevertheless
report SUCCESS.  Reject an empty effective selector after filtering
unsupported operations.

Both failures were reproduced in a guest without the patches.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/scftorture.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 603b2dba1536..ff9a8271a464 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -588,6 +588,12 @@ static int __init scf_torture_init(void)
 
 	scftorture_print_module_parms("Start of test");
 
+	if (!nthreads) {
+		SCFTORTOUT_ERRSTRING("nthreads must be nonzero");
+		firsterr = -EINVAL;
+		goto unwind;
+	}
+
 	if (weight_resched <= 0 &&
 	    weight_single <= 0 && weight_single_rpc <= 0 && weight_single_wait <= 0 &&
 	    weight_many <= 0 && weight_many_wait <= 0 &&
@@ -636,6 +642,11 @@ static int __init scf_torture_init(void)
 	scf_sel_add(weight_many_wait1, SCF_PRIM_MANY, true);
 	scf_sel_add(weight_all1, SCF_PRIM_ALL, false);
 	scf_sel_add(weight_all_wait1, SCF_PRIM_ALL, true);
+	if (!scf_sel_array_len) {
+		SCFTORTOUT_ERRSTRING("no supported operations selected");
+		firsterr = -EINVAL;
+		goto unwind;
+	}
 	scf_sel_dump();
 
 	if (onoff_interval > 0) {
-- 
2.54.0

