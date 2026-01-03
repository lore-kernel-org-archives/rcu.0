Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ACA14B977;
	Sat,  3 Jan 2026 00:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399859; cv=fail; b=LjiiPHS189YBsDBzQA8zOkLccYPP/yKI0VQavy0lc7GfYBRkh81s/Q3i9lLdneLjK4ULYifNbN3zve+3VD5Lk7Seso4nV0WjBcG/yuH2R13gD6VSlla+Oc/yMo/o/e9Da11ZedVX9dLxISD+U5XXv0ksdDFQn5mUa6saEuOZbKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399859; c=relaxed/simple;
	bh=g+H3zouk+COKMVrSYcs4UtpcnZ/qteKCRBfpU9VsFVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RxhCvaOE5DJfaZPj8LUgiNulssv1uu2+RERC3uHfgzWdPlKmXF+ZZI9dFmcaedh+DEM0/t3cIaWo9slVlJjtY3LKRThXufJgIXLx+pu6SMBJCdBrj+wS48ZPOZ9tpzf4k/lUrDZsR3OwAP9gsWaXHpcB7EeJIBg7U6XJMabcBWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pVd+ejRq; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pVd+ejRq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7CTZdsFdhpGY0aSpLX9kaSo7bV1BnE3uZHLkC2wrfI9F1lhB8lGvkUkBYEOA42kkgdVkrF9OqPeZicZgBENQWwkpqoFl59TW6Gcu+4wDF0w3qtl6yQUu9nplPgJaab5dCbRqmWDgXOMaadoaRGhMPYuXtX2tBe3o7b9StQVsFqm8paTKLpLKD+jWeIis72bn2NtxlzeKWIRnjnOrEhlGarv39B2Gmp6poUdswIhVEi6IpUzvEH3bqKmHMIIdfmn+oAka/3w31uu5BFzounRNfr0kHdbXWz5UZpClbTQ9foU5sdM++/SP/bTK2GnFjHxa1FKYWuOfOagOj2fhse+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8A8psrX9Xcy1zRMGpJ6ObU1owk6vnH6LQzQ/6mDHP8=;
 b=u6X5keYoM8nUHklqNwBTNQh/agfQ9lOAlBt+YDCE3I4aB7wyiFizH0pt9uHnRQpqfX+w924KIKuy5Bpm4ca2Zd47KFLUqdOnzSXWcq+7PiNlvdjBP5J8GkYFyCC4eWfpbd30ebt8LgK9hVMPVxAZsiK6PG9DMCawLqAD0nYR6SU4PRFMTQEPXSkQl8fqkjaZrpKZ+xFnXP27RGVp/cYopKpPekgO1ktwGzRXRPrgD7wTzlgN+pZdyv11B1ZWTVTLReHs3kb2pvGkAXNkr8aKy3l082+/ALxaLb2CLpEYUwRKouvtBPsABxhC/Q7/JCAz6fn4QcxD0ghNAKNa89O1/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8A8psrX9Xcy1zRMGpJ6ObU1owk6vnH6LQzQ/6mDHP8=;
 b=pVd+ejRqedBRl16oSExKkctmVQen2+kr6BdcmNBfzTxmeWDElQKZPQPsKy7ggEMqkAoPJkF4M5NDRcbuNUKG8wC+H91gGj+eY5ySXxOdzLVq5hEVvENlPgarAnLqDxZ+VMrSn2c3LqOxdXQ4pBxk9ebhJqN+ijSlMpJXUfb/BKtcvqUdTBbqf5L0fE+GbliWCXVBX56QiLYFpwuLJxr50oZF3bmlOteBf/RQ63F8fzIf0rxwiNWF+f3EYc/i0Daluf8UhwiT+AbG/QEiVi0D09eYEao1lFVhM2sOW7ubIQVR00xRDbcFLSM2y77Z4cB98cOqvadUlS+P7AbrMIwF/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 00:24:10 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 00:24:10 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Uladzislau Rezki <urezki@gmail.com>,
	joel@joelfernandes.org,
	rcu@vger.kernel.org
Subject: [PATCH RFC 10/14] rcu: Promote blocked tasks before QS report in rcu_gp_init()
Date: Fri,  2 Jan 2026 19:23:39 -0500
Message-Id: <20260103002343.6599-11-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103002343.6599-1-joelagnelf@nvidia.com>
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::20) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: e81bede6-de6e-4b47-a0c5-08de4a5e6a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ve4ifGD9u3cpCwJBpIcHTiiVI9H00e/BCXcLZyeU6tLxqsc5duTE3hIEfGFl?=
 =?us-ascii?Q?YXGxQbZovhh9uD5cXYu+krDv+M+LfVNAFNH6uIH9N0lsRlQRr4iuqgLFyoOM?=
 =?us-ascii?Q?Rx0oJDQLALi/3vMuWJ+sRs7OMR8Urx7sBjQLSDdY5ADvMzILI1a9Yis7cyf7?=
 =?us-ascii?Q?jKOX8HL7jC/aa06quKnwTJhS7UAqUhnSGJiN5TN/HpVtfn/+XjMSljBmC/Uf?=
 =?us-ascii?Q?0G/vKPeTsrb7ABVeFOsqgdaJVMWhBcJOaXByo4CZ/E8wE6/x8PTmQvwV7rYq?=
 =?us-ascii?Q?Jex2hR7NMns6y7/QYk5ixy4kDLJjm45DKYPSD04tzrJFzFyU2yq0k4cnqYLo?=
 =?us-ascii?Q?03dT/M0M/No4wJILAP9arIRJQSshOZ4E+yKoPS/Bpbto0uHI9zJPALXRD6Kr?=
 =?us-ascii?Q?MtGmts62UxGagSne5xXYFfcrY+2nVD/f8Oy+R/mNp7iuUZIO2toXJPPjYHlY?=
 =?us-ascii?Q?/iFA0c+5JjTPExQFKcgh+6N8nbaltHUpN/oGi6FWYG8ucoAV1bYa9VESOJcO?=
 =?us-ascii?Q?Tk7jEC8K/A0bBnYWTSlFZ8goaMmQkRYgEi+jYZ4OKyli5zirtIMiZ+PS3OhH?=
 =?us-ascii?Q?kCXPmaFbJqOzg2H/mjMI59L2gtAOvUUK2mGSs4WMpb9SltIFdhM8lQjoav/f?=
 =?us-ascii?Q?dUoDDmC1iJ7yo3PX6CGQCFGijp/gpDpEG/miA0LzVaTr8aLex6SlBSgMR0Tc?=
 =?us-ascii?Q?qiqiJN1FskVLoq1STve1wSVLBxjb8PyXel575sHM7FvPiXozJ7VtHtUiHgIP?=
 =?us-ascii?Q?W5jw+ankulqDC5Yhgx2qxFqM6g61/gjbZ8pkfy9/TiCWoCJuHrWq2Pds595M?=
 =?us-ascii?Q?2IbmoAhuxK0LcOjpy9hpY37WjWXe+FG4ZdbMTYipvtMT0fb34P3Xe2FbJEPd?=
 =?us-ascii?Q?XgdjGb2Cj3JM5H2sUViiMe6PvGH25hDIpvpeZ017myIEUrxib+v1z7Nmpx8S?=
 =?us-ascii?Q?0CzEDoYqR8DUi/l42L0Oj83eQNKE01gJgcDzSBjkxAhEZJX9PwiYf2iCveC7?=
 =?us-ascii?Q?nuZSLqL7UGvP6wGCKtzsjh/xmG6zPrQQOuibi81LjIp2AsKKU8liBtwJW2RM?=
 =?us-ascii?Q?fPpmmgyblwdfwfw+OONCUSOUkvVDSuqaEaqhwp395fvU5VxGzVuRLhSKc7id?=
 =?us-ascii?Q?sE46kZfY4cBUXq+jr5DRENLOxCQSSpkNXTHWJ0tyAwk4N6UU8UCQ9gNf5ySI?=
 =?us-ascii?Q?NfjP9wi9jMMwC4rfechIY4EXjMWpYU4MKfUoODc9KnC9jsppEFiYmGDEYKDp?=
 =?us-ascii?Q?ISyOPpbQh8Gq88gk95Fl5nML/V7Y/PYGMpT4r4wNr5Rhqu+UdkTRSzkP4D16?=
 =?us-ascii?Q?tRISxHwPvPgasbPJe34iUkWCdxYrepw6SJeu05xTnoOfhChHBxmLWg2LrHdF?=
 =?us-ascii?Q?5KIJx24TZzQVGBYId9NOBiXNRgaQFyobvX2Ven/v2FF5X4SNLEbLKxDJ/TFr?=
 =?us-ascii?Q?fF1Krp8ZGjJ100UgJVQDMaIzOLhZ+SUU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jtP9EqMAalxMZmDFm8XVSerx5nx57PzG5Rs5NIokJNG07SbWL4xKZhS8CLWM?=
 =?us-ascii?Q?kauxSAPqVg3iSabgd6vE1u4dYFLoVKSAT77fWGpalObCxPvj2swzdip+xESq?=
 =?us-ascii?Q?JfHVpzfvoqH0k8sJ5vs8BoGEbPBz7CCZowSQ87V+zHVakMKSgpZXHVNW+Hbb?=
 =?us-ascii?Q?ON93IaxD+/diazxqsw8bDHb4ZETf7qOPGMZFnlVonaPdIS9qANCL3dXoJ6SD?=
 =?us-ascii?Q?Dy/U6X6BZn1vUTmUkaQqMT54FSYVMqYUJqKDQnUnURZUTKDo4ILgHUK0iiWd?=
 =?us-ascii?Q?RGDBpyEEAavIwSImpmfdLF9aUTel6dWay1p4N0hvAPycGJ2j5Xd1t3z6relQ?=
 =?us-ascii?Q?W2+P4qY9CoIgl1D043sRZUzNjS/5HWTHcjy6oFvky74PZB0JCEyKlUta2oU5?=
 =?us-ascii?Q?IB1T811LgjaxsN0n/9CY1HtLeK29ldjSS28vSLe88iqJO8sgrzGpGaTutulw?=
 =?us-ascii?Q?D9ACbJWlrL4go4APxhCVXtZUSbi5pFku1pog7cvsvZd5kBBT8Xwt8Jrqe50F?=
 =?us-ascii?Q?tMNF5JUQRyzQ3VXC/2bV9bod36C6Qsdogw+zSAL8+t0KbjrAcn0fhp1Kj1jv?=
 =?us-ascii?Q?/eb57c6dtSfHDq41GWhW+tqbr4oskGlHlYB9YRHBsfD84aN8JdO+Lk52ZfnH?=
 =?us-ascii?Q?mQQltXBPvJQDoXcVUrohz1asQCGbS/XIzj8eJ4LVdFuZaHw4gTHXTpOBLBl+?=
 =?us-ascii?Q?OUa8KawgPs47YeLNSmnAkHCymBvzw8fGcNPQnHOBakRZ6WrFVN9QrHja4w3j?=
 =?us-ascii?Q?sCWiOUaVmjU+gzzoTfuYqsklmqwCTuIs+RgP1uQcvJzmPGA7AF0RufzlxhER?=
 =?us-ascii?Q?qTbgKiaJksUVw3GJMaYeNczUnMq2iK1/blSE0hlewJPpIZ5obv+M328VczMw?=
 =?us-ascii?Q?RXti4lEyq5NSDc186+TfETZFEzp70w3YIMNCwlEmx3hlgSJ2SlRKyBCr451X?=
 =?us-ascii?Q?61MYNcYl+ZuajxIriepalWSLnvdEfGWMOddGVv6rnzPy5G4yeUJJmrcKQ70b?=
 =?us-ascii?Q?Q0JlZIOcCJ/koz4ABP0LM6R0th+OG0u+n3QOgEV0fCj0RWlK5t4Mqz+zspzA?=
 =?us-ascii?Q?hXJlhJzHSERiXXJ4JPlb3X2+AmSaHChjWHxbUS9OA6//UJBlNHj3TRLyqjkn?=
 =?us-ascii?Q?7H0ws7DdYqSCwSM2QE7j88GU8SELZ/8LuR0K2kOEEEW8KUbNYK5xVHdfUAo9?=
 =?us-ascii?Q?GAPqa0sRE8O1PWqULTcGEfEFXspNmW/Q48zcqnSF1Jn9CM49bV6YUioGNm06?=
 =?us-ascii?Q?djUGb+v5+E9xGqhD623CGPGh4lz5ZtsTz92gEXybEwqI2MqVeh3vTxoZ4Bha?=
 =?us-ascii?Q?2vG9JCzAMkPWr855lcJg72V22mxo9EppciU7PQUAV0bgz5fjJ6o29T8wBi4i?=
 =?us-ascii?Q?8NQZMs0O2vxI3tKupkj6Jwn4MNwspFmpNldGS0mFXAdXxYZdiDj+4DdTP8dZ?=
 =?us-ascii?Q?hhh7zH32IfhPALdkipuO57hvTJgd+bDR7CxTkjuY6ifVI+ThJ0pkArBxkELX?=
 =?us-ascii?Q?awEL/wtZFO4+2R2MvS16QkVV5ShZplLTnPXb+tWWScfsjDEvcdmIKckI43vq?=
 =?us-ascii?Q?31rmdyHlofInkKAkl1xSJNbsJYZhl33Go5CjI8xub0f3i8e25e0Os9C6955k?=
 =?us-ascii?Q?HF5nD6mEa6chJkO90kRIIT6onusCpgzoOv3z3meh2KrjCHEecnN9NOo1kswJ?=
 =?us-ascii?Q?gAkI+2cAV/UHleKcfzivw4DvXXR0wEvhxiK06hf2GCNbEJHnp1chLwV5Z+lA?=
 =?us-ascii?Q?MFIEJm9WLg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81bede6-de6e-4b47-a0c5-08de4a5e6a58
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 00:24:10.5880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rm+tNjwtPA41yHeWclEokBZV6k6bnVehVoqVOGkLpDSp3qVDF0Q8+AhOy7hOYs4R3qfTvpV+lsfkruWNDLZibA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872

During grace period initialization, when rcu_gp_init() reports QS for
offline CPUs, any tasks blocked on those CPUs' per-CPU blocked lists
must first be promoted to the rcu_node's blkd_tasks list.

Without this promotion, blocked tasks on offline CPUs' per-CPU lists
won't have gp_tasks point to them, so the GP machinery won't wait for
them. This can cause "Wrong-GP reads" errors where a GP completes while
readers are still in their critical sections.

Therefore, call call rcu_promote_blocked_tasks_rdp() for each offline CPU
before reporting QS for them.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5e73ebb260e3..468388970c98 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2001,8 +2001,21 @@ static noinline_for_stack bool rcu_gp_init(void)
 		 */
 		mask = rnp->qsmask & ~rnp->qsmaskinitnext;
 		rnp->rcu_gp_init_mask = mask;
-		if ((mask || rnp->wait_blkd_tasks) && rcu_is_leaf_node(rnp))
+		if ((mask || rnp->wait_blkd_tasks) && rcu_is_leaf_node(rnp)) {
+			int cpu;
+
+			/*
+			 * Promote blocked tasks from offline CPUs before
+			 * reporting QS, so they properly block the GP.
+			 */
+			for_each_leaf_node_cpu_mask(rnp, cpu, mask) {
+				struct rcu_data *rdp_cpu;
+
+				rdp_cpu = per_cpu_ptr(&rcu_data, cpu);
+				rcu_promote_blocked_tasks_rdp(rdp_cpu, rnp);
+			}
 			rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
+		}
 		else
 			raw_spin_unlock_irq_rcu_node(rnp);
 		cond_resched_tasks_rcu_qs();
-- 
2.34.1

