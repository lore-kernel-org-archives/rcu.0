Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F78729BDBB;
	Fri, 26 Jun 2026 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434603; cv=fail; b=jj7Y7i586uHA0qiJ7Q/4ZKtuCcIFERIygFM/p+oXLx9TN+Ry6QbkrFgQpHOS1vv4lGA15IuGE/WmQsnJ9Cz4eAAZSvfztsiXoqbeMVz0GxhQiRCBLayf6IXeq2w1MfyDWyrkEJNjjeSdRIabyNf8BGjomP+LMKh0HFByQiCLBlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434603; c=relaxed/simple;
	bh=iIzLMXgz3rIK6Q2S6zRGBfh1T9iIAEsVGrkzgheOY90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=raqoNvlBk9Nij/7VDfvKNn197tez7WrAlfgEUYtxP1qr6Ao3+vF1zRlMuEAi3zdyS4z1jCfM5IT6BpH+HOI6T2qx5ZCJjh0zjLZ8HIr3XEv01xFP4E/fU78pBCZbtBV27Q16snfM1IvdPrFfzmNTDGFaAQ5Bp+mR+sXK8Lyu2fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sf3ZGcjE; arc=fail smtp.client-ip=52.101.61.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sf3ZGcjE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHGiDy+YHcKTL8AWWmRdZ47F6BeNvmZD9sNVeG5vpLoFjWb8OTX3xTX7FnSQA4ET3N7Pv6hMsC+FvDXSpoIzmD7BsBq1FYUTDAOrxFatJLj2QJzzBmSWyeaU42Ha0zAOy/goC1TQ+u4uZPjAi1mRalvSNzFiYTzZtKrzYwQ5Ng9G9MP1Qu9zV7MuV40lZIFG5UjzWWehcbxDXntNDGZm8oQOI8Fy53O3XPSwvyzzit3dOWbqXmEc7aF2IuVvGaemvPkAh8Y4Ou/h5wgHWKZJb+X7FD2Yz0Y8xpB/GTpCkv7xDJqXi7FDxwD0zeXPmZyaEYF8bv1eaCuNLU0mPU9j8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFG6JsgrdrHvIXQ9vFQIJ1RvDPclRs9+c08S7nkhGjk=;
 b=AyUShSSp7NlWGm9xsVzkD+87LfmA4/wSX210fUUbjPPArE2qqQ6YyH3nB/b0KfvBqpPtXlIQWwy41IkkFinSiyhtQhpdkUc9bJzD1AOuy4mLSAtxRYN60UyqaPkmOYZ3P9tH7mEfD7/sfOuSwxd8QVMqOspk9YRuv9e2Bu/+fCT4I4AC/X2VTNc5Bu8XI17UExX5Nkpn+16Q0nN2zeqQseP1RgBSsI2ufFUA67ZIXc2ZNX6ghzC4KiO8Ap55m3IVO4TQSx9EGsX7al2NorH5jZQhNC9cvf9+5J+bzFmiD9rjd8XR+jBMO/TVSQqc4iiNk9sUKpgBqgO3dvMdb42x8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFG6JsgrdrHvIXQ9vFQIJ1RvDPclRs9+c08S7nkhGjk=;
 b=Sf3ZGcjEysOAfMKf1QYgyCJFhc3fp+cLBUrbstFXtoG5Sf7O2AePJ9Dq7BUU4QD9ZXlm5ihOpe+59hHoiQxxhgqqQabzMZQeDL3kKTHc1nNZ03Nt5q4C6g+vpO/TZCjN23u+E8wAQ7QGs86BScTHHTw8FnhYfIMXi9FNhQN72S+6Lbi/d1+x0z6OSgYgpMUEoGyh1AKzDMW4FshAvumEfOgFi3w2rXI6WePqh262whT2QbxOcudSi2tvwXwSdWnIGSHtJPk9lPDNqO44niugxewjbC6xBZuewaLOa6FzEDXnR6W8MJB8jL28+ENS0E9mTOnlp/AKGuKMSAL11nVtTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.13; Fri, 26 Jun 2026 00:43:13 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 00:43:13 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v4 5/8] rcu: clear defer_qs_pending at expedited IPI entry
Date: Thu, 25 Jun 2026 20:42:58 -0400
Message-Id: <20260626004301.1632168-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626004301.1632168-1-joelagnelf@nvidia.com>
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14)
 To DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a982485-a961-4390-b9b9-08ded31be71d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2GqXJhDB0aETA34tRZXNrTAcv1So0mtEw+ALJ1VNaTWW7N9PePeWGlPX9qpQV09PoDHoX0vMunPY0qTWnXTjcg7Wst0TNViVM+VGDSCzbv29zxVpaJcjeXqjYZn9YDHB/vUl4RpER1lwnVA4z0HyDqZBYcgX6N0a6ft3dV8Nb4tQLiHE95l/kzBJFkutpI5CGit2gHvGWZEUmeaWBUlWjS6FFJziHKe7PHYDBcaprOzoDlT0vUuLaEvf/H//Gtabgffc8Tq3LbIvKw1YyfGxds4JqZTZlvdXpI3SPzmfXq6+x46FpVF9R123eAjm3g0nng353MvycencWGXv8XdEFi7nuVfu+UhxymhNOY/5nFAi1uDpdduRBDFP4wnU1iFdCNMLsVuCmsAAWIE2x7xssxMkEYQMjJA0EZMrkwV3IZk/qJSMkuTdVoKWlT6B/AJ9LrtjEZ6yobA7BjS4q6BLj4Hi9ToyQLiNr4q7WDL0fQurXg8nso+IrN0kO3cGOmPWi4dDIjyjT1EgVCGGutEy8nxIjTY6gLW15NT8XR6W2D60XLNjvN/XIUBgdiJffbfzgMn/5UCMeMDAExlaX5xvEKaBt/Eg75k62ZlG+RN3ZU7VXgyKjiQvRlAsXM9IzHX9ml4/o18uxwdFpGLBR+ZuCQnMljgaRHIRjrYwW913uuY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t57J0O9hZdVu1RngFJYRcMX6ktlsDNxYDoZVpYErP/1/40u2CCqHIjfeBzYz?=
 =?us-ascii?Q?iFVk2IH9aiHtf8qS7eri40PoJm4GIXZQa8FNuuF0evYsoUAbA4WHdyGTwuOi?=
 =?us-ascii?Q?Y/tqX8ILNEygnu6hHiQ229VkwYuY9KN6QUEGarmUqdLRBTFwBXPZTdvbqvFS?=
 =?us-ascii?Q?FZJdX4n9EK64Y1C4BMTZYtg0c+7ivRmNhRZn3bMrQ/AkbaL3hz1zA8Xd6Se8?=
 =?us-ascii?Q?18vM2OFDQSYdX/yONs+CxZ/a/WnfiSVsh5nuqjT0wVASyKavujGRVIjZhIZV?=
 =?us-ascii?Q?c9bshTejj+5bjl1qsjTzm8GkRMRfYKtr8fJWqPe5gyFTmYrNDBXrRnBh1/bN?=
 =?us-ascii?Q?Vu4CEGqOCmewL43pX15k8wZ/CaXceBn1ycAJw8NOG0H27ja39bojSqYoG8C+?=
 =?us-ascii?Q?3bh+23wNJoXF4azNiI2OYJkvl5pIZpwuaSANgMd0aC8nwNfDyFHbw7w6XOpx?=
 =?us-ascii?Q?uApWoWa4HIL3jsQyxg2g7hawIL+A43xRLxw12NMzpd98d4eR9PN2NQa9rXLE?=
 =?us-ascii?Q?5TetK5bnt6udNHu9cNcXsFGMmom2iM6jewHSqyDji75APA+LebJNnaAOii04?=
 =?us-ascii?Q?rhZWgqWKg3OLnTmUC5sUMY5hXFxfr5VUThcye7S3fvRlDNQJKhJBnrcGQ72b?=
 =?us-ascii?Q?OKY4AysHtfo0iIpeI8svgfSwzoiO9loBqch2RLoOagjppA1m0fhZObFa+8S6?=
 =?us-ascii?Q?d3bjLH3GQ49sjshevaPdn7XvLQOcbHKunP+fM6ryfDuFqfBZBVQQE05JWTVk?=
 =?us-ascii?Q?Z+eXZJulJ0NFOisrECdRMUpr1rFuf9ohsuLBYtCo1B8OJb3ALS6rP1aC5TEy?=
 =?us-ascii?Q?cKfRIJ2+p8Ogrk4SGNEdNmVvwFT8E/YLW8WzTlnDpAfSXYZ6SV2AZnB2kVwG?=
 =?us-ascii?Q?cBuatqrGeXMMUwk5zmxs7EzrfN09aCmEWcRwlCfuAiZxB2e9yMVP2itN9uTe?=
 =?us-ascii?Q?xL8izJy/l5EqvJATCAdzFa/ZlZTMQki7fCM85+yG/k5QJhVbvLaBPafdZdcD?=
 =?us-ascii?Q?i4qJ88fDZTTL7W70dsb5vvWOLzM6hl9GOaOmQPe0jWgU3j28GVZsa8M4ZiH0?=
 =?us-ascii?Q?0YO3iMGYrH28O/2PuP6b9gf6ADBs5/rOFTzzTSeBK9WNq11e2DQaLHA4gU6E?=
 =?us-ascii?Q?fj2852N1hqkNMwk+zQVwRQsrL7k45CrR215/tNxeyZzUKldXJbuPnnhMlPTd?=
 =?us-ascii?Q?GlsD7UDtx+sR0BXqxLZvaVE8SXt9CQhHMMuy6pmxAD7z57qy3chphl1uUpTa?=
 =?us-ascii?Q?RQOo5AUEkXm5RLEL5SsnrUmifnccSxB+ic2GuoT280sM3CUCHwNlb3GRJ3zF?=
 =?us-ascii?Q?y7omssQ4XNSA07ApHcOkFScw0IOBy1CU4Z2LVVjKdcyS3FidLdAgdrvb6Q6h?=
 =?us-ascii?Q?H/hLaaKBfs8nSddMQlbEbdshS8/ohVBecfhFvVKy4bNdMLPtJZCs/iRQlBDf?=
 =?us-ascii?Q?gKahKnDkS+Y/lMQjA4aDgI4WuNHT16UfexrcHKae+pG5vPiJgNVVmE/e+6u5?=
 =?us-ascii?Q?9G0vrmfF2AZRymhgHu1PF5LazIiuatRqmy1BRIHGTyEcRxcnD8wzUJKODG9g?=
 =?us-ascii?Q?rFGUej2+JzVNQjwhapbZB2smh0OcYeKiB3LTG3NHQponaAmK75Fg010Cqp5+?=
 =?us-ascii?Q?dH9AvFvcQjVJ8FNc+rL1xrR+1XX8JNKT4fY/FYbe/UUMCZ2Ot16HCs+fmUow?=
 =?us-ascii?Q?E5JgKMXTwzn5s6cFdq7zgE9d2vxbOR3iHqi3/4uEzwQljH8EScbq5aqr6GlB?=
 =?us-ascii?Q?plB0jyNdyQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a982485-a961-4390-b9b9-08ded31be71d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 00:43:12.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6O1khNMVAjwE4nTIk8o45WLbiYYfETcJL5jXMDCnJUaURmVrSMOXihgx++lId5BO7ZSqj2ZkXRlHzJ2OgwuhWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207

The per-CPU clear in __note_gp_changes() (from an earlier commit)
runs only when the local CPU notices a normal-GP advance.  When an
expedited GP arrives at a CPU whose defer_qs_pending is already
PENDING, rcu_read_unlock_special() may skip irq_work queuing due to the
pending gate.

Clear defer_qs_pending on the IPI target right in rcu_exp_handler().
This makes it possible for any arming attempt that follows
the IPI within the current GP to be able to queue irq_work again,
allowing completion expedited GPs quickly than waiting for one scheduler
tick.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_exp.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index a43469da3926..5be80d255d6a 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -763,6 +763,12 @@ static void rcu_exp_handler(void *unused)
 			 READ_ONCE(rdp->cpu_no_qs.b.exp)))
 		return;
 
+	/*
+	 * Clear defer_qs_pending so arming attempts following this IPI
+	 * within the current GP can queue irq_work again.
+	 */
+	rcu_defer_qs_clear(rdp);
+
 	/*
 	 * Second, the common case of not being in an RCU read-side
 	 * critical section.  If also enabled or idle, immediately
-- 
2.34.1

