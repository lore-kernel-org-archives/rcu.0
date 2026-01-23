Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D939531A7EA;
	Fri, 23 Jan 2026 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769181624; cv=fail; b=IxIV79yKSrdoSc03K9wTvPn0aiqf7S3xAUCSfHTcg/RsQew8M9dsWUX7RaEnvilWcq+HMmbhQWXX2Ew8AJIQcoljtiIcGx8ytfPr102/7JgIoXZezHuZ1uXvb/xPy1DTCMIPysdERnNfDBIuCPVY8vQ1Qv3UeZxcM98r/hQ1TOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769181624; c=relaxed/simple;
	bh=YrbJA0SkAJPavaLGsfgQ8Ktiux5k6RMNrYSQGPEgMGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qS5VGOh0zd23d+uen17CQRDkk0+kRAKrIBau7QW7cEbYVG3uo4Qjfs0xghCg3RCAtzK2kb9mF5X75v1PIbu0+7h8Mt/sW27QoPdBAxidbWgQqp+FsExyryx//raSrrJgkpVExjjYJbN78zX0zZzzQdxciXhOmCjVFi2uLrplwfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ns+OTqjd; arc=fail smtp.client-ip=52.101.62.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ns+OTqjd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=an5pjfn9Z9sV3m7FqI1EnnSi+2rs+vUKsQiwTqlLe6AZ8f2CwdWJwikN83wnIZMv2eLY/VD1xsLvimyhcsAUQQFxtc2EDL5kPX+EzdeHneDLRbi30XZ9gM8JsPSAaJhjF/ANAA188EKBEoutdo/8fa5GMP0zGFTOGDNyfhe69hFrxpmW3EOt5F+7W6Lv3Y5st1GqTeFRAlmdmhKhWYqOgKwGA0j+9wnT4MQuqSlkTdNOHxIpgEJRrgEKk+TwSFcMsqi+IGh5RQo2uYoxcCW8pN3ydjTzT9+6hq4p/57aL/RtU9005PpLdR2DUcaenylorF3fx9mT+zKFdEhXJpUBTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNqPRUcEzkDdq2kpca8rU1HMYUr+VP9MPskneOXQJrg=;
 b=DuYbaH77WPkRsVs4FaupdDksq1q/Op7+iRdeT/uSFAo8vrtTzpW2f+uMISzE8FgpMn5rUKo+kVx/NvuFD2gOutfJW6CFE1o7UhXj9g4frwpk70fcjZa2N4ZPu4aNoThGMqmRCtzosKxf6Ysa40nvlwQfC+u93pjfuoeA1ktdlpkGg3hzOsKDgfxKSXPMs+xvm0QmxQibuvSfS4o4KSEVy1ABMWnCpegAQ0QehOpD4SDrUOuKp49n69DfHgeOaVWr2T21knX0uOtORexHQhO3RFiujWx12HANlLB6yGQVjriYqXTVXtQ5u91RMahCTSYQXxP0Bf/DwsfrTMjJgfieKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNqPRUcEzkDdq2kpca8rU1HMYUr+VP9MPskneOXQJrg=;
 b=ns+OTqjdQaxkVre6TheklgW0wqUBYB1GPTiVcG5HAZ/X7NEZYQi2FLIJ+Kl9j5P7rnPApuzmZ2JAfiDGVyOahtYB5xjO3Ok1o05ok45UnqYRLbJo0iIsTYE/qn6W8tOGleuKsIvhHq+CrNB1RqtWmvUUeB1AsmYB7gZMj2U3IBeDVxmnYkNx/c7ipP39AiGyvWNJYv8M3EBNLyD1AR/95V3GWWFGcfzvBXYVm9pK9eqyzhvB73Sid3vjLo6BQVjs9Pzd5hWCxZkaENN01N0mJaFdhbOhhW18fv7UJW0fJu5VqOqnP+vrHgb8tm0v0XHWPqmeyx3SjfeHj4dukXgeMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 15:19:52 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 15:19:52 +0000
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
Subject: [PATCH -next v4 2/3] rcu/nocb: Remove dead callback overload handling
Date: Fri, 23 Jan 2026 10:19:43 -0500
Message-Id: <20260123151944.732328-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123151944.732328-1-joelagnelf@nvidia.com>
References: <20260123151944.732328-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:208:52d::32) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: d02ba481-899b-4015-5f7b-08de5a92dafe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hcy2EauEDBQc56PL1McNfcdDvrpr9n7dfBP0whP9uz5Zsqy0Sl83aPciTid7?=
 =?us-ascii?Q?xHVa4xZpOuJu08PylyUD0phoZeObf5aH3jL1Lg9sNPF/Oao/r5xFgdYcKZjy?=
 =?us-ascii?Q?YGmm+2lg9kSlckO28Xbksg2AmxpoE+agYc+ebPsK9+rRGm9Zndzgc/jy3LLn?=
 =?us-ascii?Q?X0dGlraaWDPEu0ruISUsAV3iob+i5oxP16gsFaqabI7bc25GuQ3QuKSwHwWW?=
 =?us-ascii?Q?lHQn2qXJFXS6c6gHha0/xhY+27FGSSnwtvNSgrsNVyaeCR+8cO0CfBMddlZp?=
 =?us-ascii?Q?wV2ZZbjG2OMhvd9C+PmcSMHpwC6nhRd95o/PA6izav2GsG3UHo/E43xJYsVL?=
 =?us-ascii?Q?riC0v5bfYzTHPLge6Nwvi7+6dhowSZPlIVpTQX25En0WHd8LIDN02Z8Pz68Y?=
 =?us-ascii?Q?ChFl+8WU5vnLy+uTYXtfp5qqBx0DP3liPXFJPW3oG9t0yC2lR/yQtqnRD0u6?=
 =?us-ascii?Q?V9Kln6BAQ4b7skgdfq9x4X0vHqsSFcGpYE2C0dagB8pCDABoca3HnD8sPcCY?=
 =?us-ascii?Q?X252VThhW/z0A5fC5MpPvfVjFZyii6G0YzHZVlg6Aff4+n790O8UG2TlXcS+?=
 =?us-ascii?Q?qNzopaCJto+bynreKtY2JHuD94EItG6LgAJ4SGWvN0Ch2zaiOW69WdPLaMZv?=
 =?us-ascii?Q?lQRtFp6ro0oZggHprKMq4KsWBkhif47bjUgb16DKrR7PT58JPvfU768puVA7?=
 =?us-ascii?Q?p1F8Xc1XbM0QD+LlsVMQNrhdTbksJj8yqNwdt6sPjifP3gf4dy3+K7jxrBx+?=
 =?us-ascii?Q?XTr588PnOnUx3F4ZPpe2Ze77Bpy+qytctayouV8Gi/z/+kjEE1MiEcKZ4C+t?=
 =?us-ascii?Q?8tgrCZi4JkG5A7P3dzi64ylFzmBrZdh2Fp9l5ylZZTaLh3zkrXmo1Jy2WgsD?=
 =?us-ascii?Q?54ObEb+7ZoyGVrgJxOqXzGOqhn+cSNI8IDuhSURYd/zBx52EalL1EdoMFN3G?=
 =?us-ascii?Q?u7nsTCb62xMQziuQdYwS8zbp+g0RJoK2kgnpXrFoOxwXM6bql3ptFc0mQ5ck?=
 =?us-ascii?Q?NFvj1C7JGLmTvFIkgBsM07v3VCc6WcSOI5cgEdxwOeZoDp+XNXOPCsqudjzc?=
 =?us-ascii?Q?E4TkiPCdBZjz7q4DX9pI+j0UJvXJu45hXq9Zl5YdFFY+566HxKcS7uvpuaav?=
 =?us-ascii?Q?eTmAsdn6C6mGRsMfamr6roqa75P/qA5WgKPNyIzqGqw5q39pn2cMZ1nkl8YB?=
 =?us-ascii?Q?9M4jHlFKCQXNaDAo4LY7cT0iAh2cioKCCMqvzAGDCLzCxwkfsfZLa3ySulIR?=
 =?us-ascii?Q?sQOlAPulfaAFN9RIhNARLPKt/kyRR8Jumgf2IqmGzRKu1gwkx9ETTXAVFTyh?=
 =?us-ascii?Q?rztvTMjg42/Nj7E2sObxA6b3gTHgbIcXsNnFsUELRhP9Ytpur+uOCH/pxYyD?=
 =?us-ascii?Q?+2O2lo8gL949eSWLSq0T69R/npO9jzhgTjVtkVRL7ebBm3TQBiAqdlR9DMSY?=
 =?us-ascii?Q?4/BGduGiTUDDtt1W+7Wh54MHAsU7urFxDnZPfYh9skF4w0NK/u17LSmmS3g9?=
 =?us-ascii?Q?xg3xRuy9smtMBbKgqDj7NbxtbQF5uh2RTIO70cc8r3mpVK9livb/wXUPF7DF?=
 =?us-ascii?Q?hjScVE5c2JrczElfNJs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xwpJNXw7ynSzCKBMdF/dQqWeR/H1Es5NVp5N2bImXvy7hHYlKXxYU7JFK7qd?=
 =?us-ascii?Q?jXiwWk/e7UqLWic53vci8ZHklB0m/prtFiQCi7LcQwkFQO3ZhiH4GpVLPcO5?=
 =?us-ascii?Q?fwB6wcMNOG4lMUROPGhaKbEAfsAX/POy13ZYKmgdl4ZNBmAirNh1PNooqX8w?=
 =?us-ascii?Q?dweXa4lwQAgRkTpqmuxQ1Q/ddTy7uTJ1eFxlB1btThZv79H6xClUhTpycNW2?=
 =?us-ascii?Q?mwFHzMW2DrESVCVh/sIE8HhQmmzw4B2ijTxwuo6DpNKsiQ+3cLkucpo2Ikp6?=
 =?us-ascii?Q?GDw8mreLvq7ISq4sMSoB855gZ/DaoRA6+hkkqHDffUmM4uKujh+BSVColhyg?=
 =?us-ascii?Q?Kc3TfNBnNrmwsywdaNKpFADGZlXsfJEFGDw4NJNfGsJaEx84Nd+Usvf0hctZ?=
 =?us-ascii?Q?5nM+KYSfXufbEF331AT4OJn6XevHcJyrIBBJOh2AW/ZVQ02D9gRTPkSHVDjT?=
 =?us-ascii?Q?fqB1BymqNhQiCvlE+59veBoMUuMCnmO34d9XeH02A+EPqA5n/NGlMplSkqp7?=
 =?us-ascii?Q?otCPJrQs6PC7D2vkcQNHXzl7NvU7ZjY1gUggk0ZvVytnrrKutgGzXKtIomIK?=
 =?us-ascii?Q?ifObdyvL/7lPYPCjdW0RoCvJ+vEeVsbsXmLrnrcn/2ax1bSaSX/Rpuy1J5W/?=
 =?us-ascii?Q?dITDYe+dzqe9oTVOc2uol9pFjOiv3kp8iqtG6hFCXm0G4esqGeKzEGr0x08L?=
 =?us-ascii?Q?SheXyi6IgYg9O/+jqCGeZY6oRhq1KsqpSla2ag8zjtMHms1PFvFrCHEdAmuZ?=
 =?us-ascii?Q?But7VZaoVBAtFYvLsB2qZbRbQIm/H/cgEOPEkvkVC8+qTgSaV3c2AAYRDJVx?=
 =?us-ascii?Q?iO4yL2jj1eoWUdCTQ6PlaRhmU0KuM6WEzxhV8mESxie0BVfsV/8tpGnU8tzt?=
 =?us-ascii?Q?5UgaFPft9Ko8qvRMjIUbHZ32eHwip63q6nQfFlLuxSp+Dfqcn4NFxlid8pJZ?=
 =?us-ascii?Q?5/9ApOJDtJGbZNP/hDkvgwHBpJBy6qirYSVavwZR44OQbNoeGTmBfJbcjFaU?=
 =?us-ascii?Q?9JkYHYwvjioHH5vAgBC2qt4fOKzEE05ZLCq62rCwaAgumwRxcNer0bL1fSrW?=
 =?us-ascii?Q?/yS8o0/lyFN4QnG5V2nzheHQNrzLNzSrGluA/AePWzh9dHCUlP41XZNMkmn6?=
 =?us-ascii?Q?1l97J/5UUheOafsibAZo/GqiXy6L5O6GZcfZtzI3M7kueVecIGdghg9ehPq7?=
 =?us-ascii?Q?aw0N76ziDZSAt6WUTwmgqHmSmuunUoWIs/s2LJCKqdfau1Awn7Z7JvR7/LDL?=
 =?us-ascii?Q?4QnKUpIvUSM6tZrtbULVIuwfJbrbramspmWtoIY0nQIP9RQ0JR8XmeprWtk+?=
 =?us-ascii?Q?qElyIGfncVcIo5nLepdHb9mE/upFIGZVsIQ9KnFdXITJM/3GUKOlu17Pzkyr?=
 =?us-ascii?Q?CDw3Ho5ulXzEFQewEPm/PgSo2Gz45t6/YeXdWnYSgC3d99fs1O+4RUn7NAbX?=
 =?us-ascii?Q?B3zMPD1zmQzRMBlwG0zbzwZIR0mtMR0qR5neLvuaciupYz2D1/fIKVKqubaH?=
 =?us-ascii?Q?MsPb1oxizSgiyqMPkKU/ecq3mSLUT1JBDeMXwbBoXy6DnziOQXpMGpWS2qJh?=
 =?us-ascii?Q?n96WjUwLXCfZbWpjP5/ByAG5P2NtUtGfbkgzzt2I1tNlaM8wEOS95c1ZmTOX?=
 =?us-ascii?Q?PHzd/zGjb3tAuz9E44ruu8kg83avf5QXoCMQFyPWGYgrOg4bZuy270UJ4CzQ?=
 =?us-ascii?Q?/ddmrWZZblmchzV8EkIh4ZBcxsubxCj3/vfdOAlmUNlg/yZp4Y0tCwR+oUOO?=
 =?us-ascii?Q?AmVHsaRdug=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02ba481-899b-4015-5f7b-08de5a92dafe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 15:19:52.0542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTBfQvIYQDMEQNSB0Nw7XmPcq9jHAFbLTi8sdipCzSwXSIvovM0elMX+8BhTfjeHMkE+VDRNiiSw9vvj40Q3kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524

During callback overload (exceeding qhimark), the NOCB code attempts
opportunistic advancement via rcu_advance_cbs_nowake(). Analysis shows
this code path is practically unreachable and serves no useful purpose.

Testing with 300,000 callback floods showed:
- 30 overload conditions triggered
- 0 advancements actually occurred

While a theoretical window exists where this code could execute (e.g.,
vCPU preemption between gp_seq update and rcu_nocb_gp_cleanup()), even
if it did, the advancement would be redundant. The rcuog kthread must
still run to wake the rcuoc callback thread - we would just be
duplicating work that rcuog will perform when it finally gets to run.

Since this path provides no meaningful benefit and extensive testing
confirms it is never useful, remove it entirely.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_nocb.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index f525e4f7985b..64a8ff350f92 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -526,8 +526,6 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 				 __releases(rdp->nocb_lock)
 {
 	long bypass_len;
-	unsigned long cur_gp_seq;
-	unsigned long j;
 	long lazy_len;
 	long len;
 	struct task_struct *t;
@@ -562,16 +560,6 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 		}
 
 		return;
-	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
-		/* ... or if many callbacks queued. */
-		rdp->qlen_last_fqs_check = len;
-		j = jiffies;
-		if (j != rdp->nocb_gp_adv_time &&
-		    rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
-		    rcu_seq_done(&rdp->mynode->gp_seq, cur_gp_seq)) {
-			rcu_advance_cbs_nowake(rdp->mynode, rdp);
-			rdp->nocb_gp_adv_time = j;
-		}
 	}
 
 	rcu_nocb_unlock(rdp);
-- 
2.34.1

