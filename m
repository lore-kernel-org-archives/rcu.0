Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE2F3932E9;
	Tue, 17 Mar 2026 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782610; cv=fail; b=q+M40wKZqkhTIsXvDnmVFOb1XSuElj/i8cXODbxxQwkrEO1/IkBnDw8dyQJboPVb4Frle6HhzKOivaVJROOl04ggHr2DrDF+Cvu2FxVSATd+WBL4BtD2pKcg2TqL6QPw1WzD6R2J1SAU59sKV4hajqDdCFzALrnGOE/0bOMZGyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782610; c=relaxed/simple;
	bh=gVyRAqSyS1oepk2JVmQyV38HHz+b6cMXEmz/8b7EqEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l1n4YYMLsbufq03Wcb5VCl3BlC0xhAItSOgbCJZCed5rzwboW31oxariDCj6/If4EXiRuAZgzXp5yTxaHgVj8ZiT1mKzJOFNrSIYcLqPenAw9QWyzYPMYMxdgbNtJ/Ka4FjuvytdIf8EVVae7JGrFHv5RzEUOTAANy9ZOLDcqmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O0V1nsYQ; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O0V1nsYQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdswpRW7nTRF0Hz0G0dOKaZ+xWOba8iEHvNPO7IUxdKZzfrHCrwQEUZhjSgEgqCLUY2I1eX1gvgRldNYlxZVbFk27n2vLzkl/M6WyKj3ibCvbK81ChLFJ4WjBK9RqaRI10kPOaF0hfEBtY5E0WadmhabrEuLadjtUdfS3Eya1EF8YXpAOn2N/VSHaMHBnhQuTDWxjKZoDMehBsEND4Pd+3xnYkqEy2t+YV+bIyvqmzUeC6/oP39HB2n+NdvzLJea3H3pqFZyYxc5m8dJNWTBhvYbn6B8TGdOCkr3B7PsBDpuegDQxhnI72GwUiO8E1QNNsR4UlnDDrzmjmnQwGLTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KotJTiO49uLxXG+8qPuW15mpe3ljIHqp5B0QEHNWn6k=;
 b=c3hMWdpKiKxzwNFTpu7MDLlN55VtDG3A+PF5crZ0WfI22zm7OLjEZJ2Y3K2aqyMChJDRszR+76/pAzULmebxBCiYp1T8yanGJwtI2ZcVM/2VqZq20LQ7pncgraADYfTRSQHfhBsGCuj9psEI+AXKE8R/p+Dd4ttwfBz5F+LXGHmtfquJ/HnrB55wdioe7zIbV8FRRzijgiGjF/umlwDvrR8BhUAcSvRbASSe0sZktiBhm59hgp6Tdx+b3hu/IjWCevMEZlWKh9zRKH8cJfbiTHm6K3UBpBSAoprkmsyO2Mik9Vld7lzUvEvnAfETT7a7x2XTB7eXxjdSqd7snn0c4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KotJTiO49uLxXG+8qPuW15mpe3ljIHqp5B0QEHNWn6k=;
 b=O0V1nsYQEhQafTWU8bDy/FxYlavH5wh/ybAyFmdciQZ+cQKWL0L/TQV3voIio9i99d6hzz8xy4rgqpJ/BIKFlvnik0zLc/4fLtF4PIe+fKgNHFyJhu+2OGFw6ql0fc4E87dJmdlihBbc/qcpRL3aJFqZnvkclwg4gtq4sxKOazAl1F8Mfhacxu9WNbmOitB077cD6QKMTPHyELsm1O4oO99Bn3fip9GbbUwPemXc2Ew0gY2w7ocC18CvCTBGLwjmMYFE/0Kd7igeia2e13ErZasH4ebhEHnmZuunhg/7Zz7oR+/kqWz1Y6UQm2DGH4NRIKQ3mIwLR388e8E+tyTMAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BN7PPF5D27497F1.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 21:23:20 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 21:23:20 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org
Subject: [PATCH -next v1 14/16] rcu/nocb: Consolidate rcu_nocb_cpu_offload/deoffload functions
Date: Tue, 17 Mar 2026 17:22:15 -0400
Message-Id: <20260317212217.1527644-15-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317212217.1527644-1-joelagnelf@nvidia.com>
References: <20260317212217.1527644-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYXPR02CA0094.namprd02.prod.outlook.com
 (2603:10b6:930:ce::22) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 7134ec63-ec76-4297-798d-08de846b69cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	HFr+x40M3FP/HDOsSF+Hyg5kSgfIqAbTDGCKl04v/bDpJ9oycTHggQZOpSBc2PA5tHQN4ZP5yQrMTlmNqxkwP/C5Vt9UD+QvGOi952gmNlC67mNVnFLhUcafxo9A/vNTK/7IHQWqBXmx4hzA4KNuT44pcRLb7M4pQYc+TFzfBG8hu264o3BlTdSnvHePTbWi02Uz7TgzpnXsdlrGuDOtsQmheDCeA8qTJVeYoPVHmoz4Hgf+Ba+wu1pgJF2JtCEYDiExDk9cpc+3aRWn8CNZqFVmTh7NP6FKJpegkyEmzfL1s6+yM4v29vBWdX1G7+yDzOEIHGqZ33hq68+beciO+8gxHA+5CD4v8XODtScLu+dr8CSTHSGwrKTqQ9dt9+WM97hUmSfgTCHnAHJ4y1dB3vcJToMxURddgeEK0DKyga7+UYlp8uFxNmI1kOKpECcTF8MXgsNcpaJAscKoQvzS8UpNCil019GgWSxhVCTGLGRW0fhNxxl/1lMjzgQnUSH1hbEhLy0Mg0HqL2jNFLmTEsveii4XtLIc9Tm2Mx5WT/a0GxxFt05lpt/C7cMZXUhlWcJvSu/YB4/1NzkeWgvPBnSADGz7VFqlomL1hDVxei7OHGtoxjegOQaUowj9F3Jeyu6i+cQxfuV7nVUfrSYYBwtqbkP7efYxtlNGQQ4cEafd0ETXLS0TnFbSbPIcsQiUy26AY7sBwjuHvYr632GLtQAJsmaQDuesDb9oIB01K/zb4FdNxEvCdMAq3JHASTtQq/Fv6bwfj6VW3VFQEizT7Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fHgnPpK9Fv6sFKc18LBfr/3tzfF+MwVCfsjecIRJ78d4cRlAwgjdiv451AwW?=
 =?us-ascii?Q?E+KPpo+yTiYUjJ1dlsAeF+1vFbM1n9jVlbVOPVTiEBifc0rtodZUwR3oHlUD?=
 =?us-ascii?Q?Tsp5zDyYUG3RZxGqE+4MB3PDIKMb/F8kFXNXN1tsiLmaaSSWMVz/SqrnsbfN?=
 =?us-ascii?Q?T91E44sIFlI9YY8mZqQqVGgvNt6qFgvhq3JMl0spfT+M9tQO4iXeTITFhDTG?=
 =?us-ascii?Q?3XDLVlyKJcTc2Sf52qkn5KwKry/nHGTlBtM+CEk8u5SjGvDQHQra5liUIzhy?=
 =?us-ascii?Q?4BGv56zZ0UW/o3wkSWSjMKjc7PS4t1d0lVOARaosknvAzrrEmKM3G+JIkdbk?=
 =?us-ascii?Q?gW5zYAK2NkwU2cjz9duzuKi9AiZqMJey2KOm7F1OK7JdKTD/bMWO2lcL8mWz?=
 =?us-ascii?Q?g2i7oko9jm4vQoTNAOpV7+Gdb6OVCyez5WrnmUS4p9o3SFg6je9+yu98M7Y9?=
 =?us-ascii?Q?s7Hg3SA2Ut10w3p/BHZrZJBof5pCk0kfszGV9FWcYNCT1WjGwrPEHl10Iim5?=
 =?us-ascii?Q?RrjmLqlRAQISxwL+l6b4M33+/c8b5HSIVYCmmPUpL2iHe8Nfrd1W6aDS5kJv?=
 =?us-ascii?Q?D4N3Xwp9qneOpJ4xaYbZq5kW60oQAq9elm4iY2Z3bluaPu1lCVL5WiK2tCKF?=
 =?us-ascii?Q?5yUx+ETaUqara57abM80erOvLqnSwOk8a4Va85+CDO9DveRXpfOXqFSgnnSo?=
 =?us-ascii?Q?L2RNhc6lH44lH7XpR2QgBJJ/E1qgyZwkMDgDaWC8WUI7OicZTp3IdOxxY+CS?=
 =?us-ascii?Q?TkMOylLs4usCrLjF5gAnfNfSmBW7mVboAoW3SNR4YDt/SX/6bCtAmwqBivgt?=
 =?us-ascii?Q?GJ1cYJi38wlu654j3bCmZoPj3ZFZJ9tM05V1BGesMb6cZGiRXMAZpCUr4VAL?=
 =?us-ascii?Q?l/KE0UdWivwLWVqAL16HDBIxzLkRemS88EMBilVrfAq++yWA1WWIvBy6PR4a?=
 =?us-ascii?Q?z+4EcXq9KRL6JXihKASL6UhmpzulUgBcTAzD39vZbE8L/SdrQ9bHU6HZb1JU?=
 =?us-ascii?Q?OYuySco0A7M9YtAaU4DXn9di8gsZsRWWlrlgT3jSMA6ZvYkMZJ5gb8tke2mY?=
 =?us-ascii?Q?G8VdQqXswmWup5F/I8lyfiDreSlhX9DzkV0dEL6TJiECE8LRL4gCm0P+LVYW?=
 =?us-ascii?Q?0PdptUxneXg7RdquWkogXdY7HqK3jA8fusHmH83Tmpj5Z6wU8NvZET01nuS7?=
 =?us-ascii?Q?O1PLXDEX9a03bblSiLqL0LckPu8flyqyZnFlsyVosaawqYg9UgnrJ2kdyaVf?=
 =?us-ascii?Q?2fcYaVCA3D5dkcRaW6PPP/6orsXUtlPmFrRe1Vm6ru/m3BO0NfFb7W644CkW?=
 =?us-ascii?Q?ExIg2bbLXH8UTxxy+zOMpMAmxmcFrUWRJuyEy34gsfPbPZ/HjQAeuHfgUcnq?=
 =?us-ascii?Q?9bouK+c0FUHLrJlINLxPz7g50p9lkqwPbVZLB7cYOysd+xXitYFHjJjSU0Z+?=
 =?us-ascii?Q?lsrbQC71DlxMIZfW86PYNsqKMEimDlMUuqSIg26F+U0Q3ELcEoyIHJL31ulr?=
 =?us-ascii?Q?73WTbpBfFqF7TRDe6eDjFsoHMGCcZR9Nl1tBjzRg+0hleSfbZBSkrIb9/YRp?=
 =?us-ascii?Q?lWkrDXAmcUAuYlTF8VT4PMkIyyg4CRBd+Y/Lx5fv0Ur8VdgkTV8YeAUQFULQ?=
 =?us-ascii?Q?9lYlT2H1d7mJ0HYQW28Irv+ulBnc19OPnQLfhV4Wm3HxmTWp7X8mcrBeKje4?=
 =?us-ascii?Q?fhor/cQ4LIkA1Dqa0tJYFGeXsYuJea2Zo6J0nPMrEJ/esjrLP+Xa/H5xFKb3?=
 =?us-ascii?Q?5mibZ1u6mA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7134ec63-ec76-4297-798d-08de846b69cf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:23:20.6158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocJ0mPKVU2j6I8fX9SksJUDOWqv1ogqij128nv0YKgfu7jbSYBgDxNrPYkflA+YRCbTk3M40MU8YgV8acIuVGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1

The rcu_nocb_cpu_offload() and rcu_nocb_cpu_deoffload() functions are
nearly duplicates.

Therefore, extract the common logic into rcu_nocb_cpu_toggle_offload()
which takes an 'offload' boolean, and make both exported functions
simple wrappers.

This eliminates a bunch of duplicate code at the call sites, namely
mutex locking, CPU hotplug locking and CPU online checks.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_nocb.h | 86 +++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index b3337c7231cc..d5e4d23090e8 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1081,30 +1081,6 @@ static int rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	return 0;
 }
 
-int rcu_nocb_cpu_deoffload(int cpu)
-{
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	int ret = 0;
-
-	cpus_read_lock();
-	mutex_lock(&rcu_state.nocb_mutex);
-	if (rcu_rdp_is_offloaded(rdp)) {
-		if (!cpu_online(cpu)) {
-			ret = rcu_nocb_rdp_deoffload(rdp);
-			if (!ret)
-				cpumask_clear_cpu(cpu, rcu_nocb_mask);
-		} else {
-			pr_info("NOCB: Cannot CB-deoffload online CPU %d\n", rdp->cpu);
-			ret = -EINVAL;
-		}
-	}
-	mutex_unlock(&rcu_state.nocb_mutex);
-	cpus_read_unlock();
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(rcu_nocb_cpu_deoffload);
-
 static bool rcu_nocb_rdp_offload_wait_cond(struct rcu_data *rdp)
 {
 	unsigned long flags;
@@ -1149,27 +1125,51 @@ static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
 	return 0;
 }
 
+/* Common helper for CPU offload/deoffload operations. */
+static int rcu_nocb_cpu_toggle_offload(int cpu, bool offload)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	int ret = 0;
+
+	cpus_read_lock();
+	mutex_lock(&rcu_state.nocb_mutex);
+
+	/* Already in desired state, nothing to do. */
+	if (rcu_rdp_is_offloaded(rdp) == offload)
+		goto out_unlock;
+
+	if (cpu_online(cpu)) {
+		pr_info("NOCB: Cannot CB-%soffload online CPU %d\n",
+			offload ? "" : "de", rdp->cpu);
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (offload) {
+		ret = rcu_nocb_rdp_offload(rdp);
+		if (!ret)
+			cpumask_set_cpu(cpu, rcu_nocb_mask);
+	} else {
+		ret = rcu_nocb_rdp_deoffload(rdp);
+		if (!ret)
+			cpumask_clear_cpu(cpu, rcu_nocb_mask);
+	}
+
+out_unlock:
+	mutex_unlock(&rcu_state.nocb_mutex);
+	cpus_read_unlock();
+	return ret;
+}
+
+int rcu_nocb_cpu_deoffload(int cpu)
+{
+	return rcu_nocb_cpu_toggle_offload(cpu, false /* de-offload */);
+}
+EXPORT_SYMBOL_GPL(rcu_nocb_cpu_deoffload);
+
 int rcu_nocb_cpu_offload(int cpu)
 {
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	int ret = 0;
-
-	cpus_read_lock();
-	mutex_lock(&rcu_state.nocb_mutex);
-	if (!rcu_rdp_is_offloaded(rdp)) {
-		if (!cpu_online(cpu)) {
-			ret = rcu_nocb_rdp_offload(rdp);
-			if (!ret)
-				cpumask_set_cpu(cpu, rcu_nocb_mask);
-		} else {
-			pr_info("NOCB: Cannot CB-offload online CPU %d\n", rdp->cpu);
-			ret = -EINVAL;
-		}
-	}
-	mutex_unlock(&rcu_state.nocb_mutex);
-	cpus_read_unlock();
-
-	return ret;
+	return rcu_nocb_cpu_toggle_offload(cpu, true /* offload */);
 }
 EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 
-- 
2.34.1

