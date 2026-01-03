Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8932C21F4;
	Sat,  3 Jan 2026 22:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767478294; cv=fail; b=JUEu01lSjUJc95T/75MXKySGlWvBWdMqfO6cBH1pY6kQFo5eV6rtl3tPSLlPIL8XuuvF6eknIfOr4TkYU/LIyXbbC5m9M+pb2+PQkWpc37ZyR/i4R7ELdiyoBjUMxMQSWz4s2fl0tGP1miMt2ROba15WubRF8Ubu5s8pU0sqKcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767478294; c=relaxed/simple;
	bh=iJIRYSiPcQca+XAnoIywv+vCEHVEccL2Kmhwv4CxVx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m7WTrlADQ+HFl9r3dy0GH667gELbcS8TBf55Jnp6F7ccKVGnSJ6x5AuOBqcP/Bbt8etCs3nnfxnEuZ+pZlgBV7ZuPTrT3/No8IskJi+GWUt8SwUQo7HC2+ohZjNnr/9S1l5SAAuVnLX5G0BhnCZiPG1+eSTqU0G6PL6IL0+xQh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IqnkkEu1; arc=fail smtp.client-ip=52.101.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IqnkkEu1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8QHiI7jObylsOdJCpqUMnp4bye3GXbYFcixPP7I8no1v0CNhs+1YZ7QvauzskW26Z6QAwlbedl062AB8ZabLBEQqfZ0F6hlA3L1auWxQUTivMqQkdh8THGeJbWclFfPsZiXScKlqDoqoLM7w7mnSUJ59vsEePHQ69Y5k1NpkQ84ZDh+hnvlX4Cy9z7sQehOnPy4gLk4Pecvwmh8l5XpXrLwx7GCPNcLW4yYMVEKdSVKicO4toOsUIWIxFWbzUgb29g4bDErNFL41ViNdWU6duYXDxBjw7g8MVGBYPlOd/IIf8jFrN8D+nI9267J1o35ynbTF+MtoR53cPgL8+Peaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctRE2dkWI68OQyif1JL4+2nHgaCoFWb2CnLQPgDomLo=;
 b=XYXxNiVJ3+pmmMsgeFJWH7HmghM2gHcMDDnVytg3Nd0B2YOPOhvqb+4k1zWxMRvGuxyJke1Mtq9sa+vdtIB6qj+e7X1Zmzqnr3FBqYFpYf229P8iUdDSJFEiTwwYpcm1wyR1Ii5IVFNGEzDAFABcg6n1YVeWpYEsRT7KzUhwiWKizjzRcsE2DaZgvD/pp5zpG6DAbEVBv9ZTRllolpmMK7974q/PebwOfO1SIy7de+hJhvSZkxbwAQxg1Tz7BfMOwMrnhwlP2qsKbA5XE7y8FpBSBimaJMhbqPoHvfA2AqjFQOREKoSrOFdEefMvfAOTyx5e3acmQMHbFuTzKq2o5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctRE2dkWI68OQyif1JL4+2nHgaCoFWb2CnLQPgDomLo=;
 b=IqnkkEu1TU96j2tauO0RRt1US4dKzoI6dMn7aVgtSWgWJ9hK2cIN7OVG0KrmKccPsRRS/Gz9STiAYeFJ8V5mskny44mgni/W2/gWSMWBwZ1QPrSfRSuKqklEbRQuwdxp1Z/OSHTmSwF48Co1/+wxBm51ZUmS6HxUFVpj0F62ynrZ3sumc34DbbdwfiGqaFTKNDW01mzDDQXBb6vpyb7CpvNsSMtw7LlbsNyktSP/j7Bo2t3Xw/4aIT/3E/itlUyusOaT2CWgouhGwOhZiwhKOGThbGDjH/DSJJex2SJELjdObgLPXzRTbIvcv/0AypfMbwAarUNQzEMNNWcx/07Ujg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 22:11:29 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 22:11:29 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 2/3] rcu/nocb: Consolidate rcu_nocb_cpu_offload/deoffload functions
Date: Sat,  3 Jan 2026 17:11:16 -0500
Message-Id: <20260103221117.521087-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103221117.521087-1-joelagnelf@nvidia.com>
References: <20260103221117.521087-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0035.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::8) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c0365b0-298a-492a-7103-08de4b150b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4prvjfyEXR6qimp23nb01f3mTYO6TJwSghl6TivlEqRhuJ/y2w9iM+gYwkeC?=
 =?us-ascii?Q?HQUw3DrFB4vTAAOE5BRGGkhPiKgk0Z3EJJs6fKbZMt5jOsQoPQx+CVMz2/82?=
 =?us-ascii?Q?dbs9xC2aJU0ejTM/vx/5khj5ITTIneV4wTb9tmzkXBBA2uUwpwWZZrDSzWt+?=
 =?us-ascii?Q?b4ZNeNwPbotiedmEA4lDgTgqRZQbx3EPoCm3z2f7iAa0zt8PgwLIiSmwcEuZ?=
 =?us-ascii?Q?gstt18EENbytZ/tTfA+JKqoA0fQIyDkT+t8g3U2kiESrPboxiSWWeGXSva+Y?=
 =?us-ascii?Q?2ALnwhw+CMOrKPYdCQPEr0mcFInSij68Psw66eL5CDl1RteVYTzZZh9C7iiU?=
 =?us-ascii?Q?KRjoEn4tDKWjKZF92trFjjWkiWE9e2eldrHh/ui6/z48L7K2DqfwNJ7E8cHg?=
 =?us-ascii?Q?LilBgDaS4g+/FW9wZUdua0vPmvMUWG7PviVqhHnCQIm4uY19c2pdtTMTBjpg?=
 =?us-ascii?Q?Hj22hVePKEvTZcvj/OBdc+CpLGZoD3JokGEWW3VVpgMe988fQKnrRzPqtxRR?=
 =?us-ascii?Q?nIZSlJfd1LOLFTgaHG3SVScZIC2KSXBRb2mQBCE8ffClMygUOFge7/M5BlWQ?=
 =?us-ascii?Q?nZ0FtdRHxVJ589SBkDimHFFVGNqX0eJqclm1saclt62WMABk24d29dcSFtlC?=
 =?us-ascii?Q?6WSegJ3AEarxbeOVd9Y7hsei0B0VRXpVQ6QmcXxjpG8JGwPYirIYcauy69B6?=
 =?us-ascii?Q?+1X8/EhUcVb+DhDMEAyVang0hU+WoKDIr/SH3DvNK2jGgtpKKMt82VD7H9g3?=
 =?us-ascii?Q?f66JIqPCuh1qDuWcaRXNqzJZ5CSAcZlE08rW6RIstEVmkpXpK5zBhc1iOVTM?=
 =?us-ascii?Q?O0te3p5BJ/2t63cjc73D5xyXSv0qfb/bCcyym0bGpEBOFxTdHWLcfusYBYiZ?=
 =?us-ascii?Q?t1AMi1NA4b95dZZHHF02fhSjabWZZMPk2+zHsuKye/E6/+E5CFCsOta+ru2Z?=
 =?us-ascii?Q?zXBMvCNtj9ZoSHhOO4JoWfJPHxhbRKDeghc9ZnipWfbEqXSoMEnHdfI5qMLv?=
 =?us-ascii?Q?UAHP7JjQLgsvbB0YMW7RZ798izOgDBHUxelPGhX4PCtSCyrhnU93gBK6h9r1?=
 =?us-ascii?Q?eyPvInBCcpVjIRT2bnvSvxXaCYU4/qDP7uBbVWFgQD7Z7SIsr/TNcqy+ZsvP?=
 =?us-ascii?Q?MKrjDDSQIWzu7bAdY6vYjqxI3h45m5SdG/MlVnVStoSU+OYUnMA0zJBwWzeN?=
 =?us-ascii?Q?4adcEWpDMYnOnxCuAzawU8lEt/NUjkZK1Hs0SD50vCamiHqicZpOuZo2Jycg?=
 =?us-ascii?Q?lViGue8dtbV0bex1FDMxfLlobWhLs5iZlRydKtSaHoFaeDkiGGyg3oGSAHOX?=
 =?us-ascii?Q?htM65X1dCoRlmuT+vrw2KrBnxU3scDGRzNk7kDh2R46jRrQhjbbXW4l8Vj1K?=
 =?us-ascii?Q?xvLXseJsR/ex+7RTloMHo8l4Lgr0akZkOMTF94eKLDGVLFhXF0DKaRHVe5qP?=
 =?us-ascii?Q?W30wFw76DECi+sDYrpWlazZ49v6ruY2T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O4l2ZKbFY3CZqkrNfu3/BdFpvrjMkodB33Gqb+cGxYKFXEieqNKx68TQ5dmY?=
 =?us-ascii?Q?Ec8ca/tn8/iTUqjhYzDVTUG/EvaXNF//ZW77ob78/LJd1N2nv0xxs8fgX3K1?=
 =?us-ascii?Q?VmVphdvBFRFMAG+mUyCs8gGazUAqz5X01wTJzS6PBK4azMTEg/JBZ6dqHI6m?=
 =?us-ascii?Q?SvHmANhqYLV/KpXwyGP5lp0DNGv3jRuf9eLakKm/VSVcwjwxu9exIFNUBusk?=
 =?us-ascii?Q?/AKUWZvnDTZr+0aTEK1dEq+0q+Next5uOd5f4QBuBuCINF+MyG5IK1bbyDOe?=
 =?us-ascii?Q?KglbPLdBA3R7XtXmLmEtMeKHTXKsPz8Q90CS1aTSr8oTr74xh3s3Oo+fT7L3?=
 =?us-ascii?Q?pYHtf7fANeZNiRp9Nr7O6wXwGvYPr0Mi11zZV+hU0Ks6Gad0ljHPHtCZ0brr?=
 =?us-ascii?Q?26KyA64/axiXJn/cCmIYzPD3B8Lt8mLUhOyRPifHlqQrsZJIu6obcJ1H8TA0?=
 =?us-ascii?Q?sK9EgSYXnceYUL2sdOZffpdrsx/mFmzGymA/fGXX1xuPJG5h8Ao3Y2j/JJOE?=
 =?us-ascii?Q?xNbLmvWIiuQK1SvXmzWhSXlOa+opGTcXZ3jTdxMRy+j8nA1pMCfafmXRjMre?=
 =?us-ascii?Q?hua1aAq7rn7yxipsO4BhvJS/tllTRdF/m6u2q5TCJT5RufOZi5uWIwcdJHX7?=
 =?us-ascii?Q?fJe12cxeFyGrdMrVCLhSx4pjVsOdqprpjlpoMoUNFU0IbWtEXQDtYn1TEajT?=
 =?us-ascii?Q?cmuOmPVh0gcpNZH2SZ5qPKys+CcvZsX2doX4n91h0v/WBWMYLRWlKL+SLjX7?=
 =?us-ascii?Q?ZOPctlV5KZ4kjuUHBFxuRKPvjGa3/4uKocYPqZ3LVQZuZqpsKp8ZfCDHnzj/?=
 =?us-ascii?Q?sFlIekp9O2jp9x+gJozs0dvJ67mvtKVkmBLjthtxtF1AtMV8biBXOrF3pnba?=
 =?us-ascii?Q?XV6DgsD3LMLWP7ZSw19SnsqMBX2UNz+uOW1UgnnEWmX4UiV3/ne9+L9p3g0e?=
 =?us-ascii?Q?DuygVCc+gV8LEjDIJqcbjYLQ3vGkSjFhhm3qmF3m20CZiXsAvF/ff8+9kean?=
 =?us-ascii?Q?80dSqFaAkKc+fhZMSzirimxN3XTq3jeH5l31IZfBfD3L5EwjXoWSfPCX4tuJ?=
 =?us-ascii?Q?YQk3BW27rfgXr+So5Ed3TdzYjwHHhP6wH+Dzmi6Om02PcZ+Rzh39VpgSQSAv?=
 =?us-ascii?Q?obpakwqBgsbc3agxhyfFUEsrahByBLwA5HO/lwnbsbMJs1J9gX3jqyVGFyoP?=
 =?us-ascii?Q?T7++b3Li9tQ2n4d7nMCTpJF/e24skXQ8iVFzVd1TIZT7oqWEoUJlVXdLNYGz?=
 =?us-ascii?Q?uH1qfC1+mZ/HF098+Pxow2kjOSQ+eoXRc2siNzGmmL/Y90pdDHMbPs8aVFvW?=
 =?us-ascii?Q?xOoKa23GBm6hclM3PblX8U63GYy90+pJSG5qCBwrduCIJtlI1A/auuXAWxbB?=
 =?us-ascii?Q?YjrdZv90jR/aCbOPaTsjgpv5Nda/8DQ68WQvVDrRXqkNlyaTwtj979HejM6I?=
 =?us-ascii?Q?TN+LBIbJyjhPR/AA3xtoyITbff0uwISdA6McXlU7VFsNOQwTkeis2poSiL7U?=
 =?us-ascii?Q?NHE63bYMky2z6rmO5WINvlqAQ0lzQf/xhGtPNSBsGEF8euo3SA/URmhkuAuJ?=
 =?us-ascii?Q?c6qhCNAMmASmcJHrUN06Kt4rak3iAS9BpbVqtQTkW9bkIhy0rAw+UZhzvXHI?=
 =?us-ascii?Q?PvbnQ6ewAMayutK8ekzCyDsIQY1JUR6FWJ5+4JoiD+6EvTDSJvLblTcmcvdt?=
 =?us-ascii?Q?8mtemD/byK73GrVzdimd3Jipls44XK9idge89c3ppBUCob6z+sDF9HJ92Ell?=
 =?us-ascii?Q?sS/ke3Qp9g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0365b0-298a-492a-7103-08de4b150b6f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 22:11:29.1987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDOxcfbwAuKc55B/v1ot8japLsUY4/2TBXfvaYV+e8Nt/vEnODJRhBeWqZD7ulv9+HJc1Z1CouP8k4gnKy4h2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242

The rcu_nocb_cpu_offload() and rcu_nocb_cpu_deoffload() functions are
nearly duplicates.

Therefore, extract the common logic into rcu_nocb_cpu_toggle_offload()
which takes an 'offload' boolean, and make both exported functions
simple wrappers.

This eliminates a bunch of duplicate code at the call sites, namely
mutex locking, CPU hotplug locking and CPU online checks.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_nocb.h | 73 ++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 35 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index d9687317a2a3..946795ddf7d1 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1108,30 +1108,6 @@ static int rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
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
@@ -1176,28 +1152,55 @@ static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
 	return 0;
 }
 
-int rcu_nocb_cpu_offload(int cpu)
+/* Common helper for CPU offload/deoffload operations. */
+static int rcu_nocb_cpu_toggle_offload(int cpu, bool offload)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	bool currently_offloaded;
 	int ret = 0;
 
 	cpus_read_lock();
 	mutex_lock(&rcu_state.nocb_mutex);
-	if (!rcu_rdp_is_offloaded(rdp)) {
-		if (!cpu_online(cpu)) {
-			ret = rcu_nocb_rdp_offload(rdp);
-			if (!ret)
-				cpumask_set_cpu(cpu, rcu_nocb_mask);
-		} else {
-			pr_info("NOCB: Cannot CB-offload online CPU %d\n", rdp->cpu);
-			ret = -EINVAL;
-		}
+
+	currently_offloaded = rcu_rdp_is_offloaded(rdp);
+
+	/* Already in desired state, nothing to do. */
+	if (currently_offloaded == offload)
+		goto out_unlock;
+
+	if (cpu_online(cpu)) {
+		pr_info("NOCB: Cannot CB-%soffload online CPU %d\n",
+			offload ? "" : "de", rdp->cpu);
+		ret = -EINVAL;
+		goto out_unlock;
 	}
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
 	mutex_unlock(&rcu_state.nocb_mutex);
 	cpus_read_unlock();
-
 	return ret;
 }
+
+int rcu_nocb_cpu_deoffload(int cpu)
+{
+	return rcu_nocb_cpu_toggle_offload(cpu, false /* de-offload */);
+}
+EXPORT_SYMBOL_GPL(rcu_nocb_cpu_deoffload);
+
+int rcu_nocb_cpu_offload(int cpu)
+{
+	return rcu_nocb_cpu_toggle_offload(cpu, true /* offload */);
+}
 EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 
 #ifdef CONFIG_RCU_LAZY
-- 
2.34.1

