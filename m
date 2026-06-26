Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011056.outbound.protection.outlook.com [40.93.194.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B7B296BCC;
	Fri, 26 Jun 2026 00:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434600; cv=fail; b=LQhD2Z6pdYDt5VmUVm1o9xLDd6Tajk0Lm4RelG3IRZtV/Xf1bNMFijUH/SEThlLz46+EuZiBtBmdHldgAHzyw/89rT33FkyStzMXky7nub0sueWr8stwOqkoZcLAuvLLLOxuW7i4Sfc+9RvDfskabaum8HuGcCfemfaif6gQp1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434600; c=relaxed/simple;
	bh=I+FhjyCpA5TKw/bI+lcXvD1/eBs4K6vVwoJuQl85UYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WbCvmuBx95ljhbVHZ6iOIwwYVH0S/oYUj38aDqlfH87fUqTdoBkP9uwFUurOFXO8rVN5cuzWpIFkiSpil/1E3rD2HZIa+RO5q5abLWJX6yYH6Gsch+3p0aEgYFF7huBhSeziQzhjaw4YVhXyQtg6OqUe7Fb+yhWz8J85Z3ibvl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Va+X0zpj; arc=fail smtp.client-ip=40.93.194.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Va+X0zpj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cf9Cckgqr3mhiScvKdSPaVO39CROVETPUvBQwc2jG5h5jsEqNs1zCqmSrEld5XnUrN4DG+q+lh7Z6fhdRCMszAByChQnKp5FVKcpmAp251gfDvgSFA2+WBVvWjCR4Zezjd72jGJl6ikVhTHJvF5ZP77osAcFe5ejlgSII+Nt4BIs+FHs/kx+cM+6zsjstopFTK196hCKyETNycxR1TpsNpdV433KrB9LARjX8cpy/kMTj6QVVCzDErfP3oqGiKMalc/IzSWgYAKV88afW+k3SXCBASGBfPLtnvdpx+r9YmdE38Le5GEgfiW9mrjTZ3655SU8TZKk7/ogRIamtFXDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeD473my3Kre8uQrfQh2fdVHq/IRaos1/4gC3x7Af7I=;
 b=C45WbNqDzGzc/ZMBVScWWkyuMcVtDzBU7ifEKFCfJEgLqTQ0ngyQ3/Y4zjh6RAAkIChKkbLy7Babi+x+2oeAb0SXb3u+8GwzhgiYNhOoXNbpXEs0gBwlwkoHg+dSq3fkJheI9QVjmKo0kZWZ/HiOm3fv73GavWE1l3JMH1aRSap9stBXOd3vht6SXzuJBLimwVK6hOhNtro9pZoKuOJlMZQXflLhqwykghNWH6PxYvULM8PgT/eBBROqJTcXEi5It2J306w5beNAIat5qjM4333ttQFqLUbe43PqS5HQfEFL2r54plwXgScfapNyFK/ro7uDedEhVuC3/28eVfsf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeD473my3Kre8uQrfQh2fdVHq/IRaos1/4gC3x7Af7I=;
 b=Va+X0zpjZisIZmbKOtpv6u9egeFdBDrUEEUsurHfCNrynKMdjMJR3dHOvGHPq8ZRoqUDXoWbEMWsY/pWpFo0i+mRtN8YHH77yoJ2Bl9TqM4rLdEzF7rv+ykxXYTFJsZoEpzDbND2HeNJQxoH9fPIeP24cJ1JBeLInF0ew0kPUakSF+phi8dIFqhqX5kevBqFa2IY+x+Ao8/45UYODFj8fKG6THeqSKEML7QeDGY3IeGvTiD2bGSc5tJOyv7dxhCbmmXiyLlR9Df8aZVpNwJCpelhTi4i0uRaa8GT9DHPZP5oEEGjLpzmu/Ra7hHO1zlf0u6x921XQjTFngFj6Po22Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.13; Fri, 26 Jun 2026 00:43:11 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 00:43:11 +0000
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
Subject: [PATCH v4 4/8] rcu: drop redundant defer_qs_pending clear in irqrestore handler
Date: Thu, 25 Jun 2026 20:42:57 -0400
Message-Id: <20260626004301.1632168-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626004301.1632168-1-joelagnelf@nvidia.com>
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0064.prod.exchangelabs.com (2603:10b6:208:23f::33)
 To DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c64784-56f2-4b0c-167b-08ded31be666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LaaPG48tlaUChjA+UCTgwcVZVU+QJ5nWSwWbq2vHO+RQYXndb2nmaWNW3kwuWW0FlFe8F+j29CaPkAc8lgiBQ/Ew/Io522SyKCK6ugp0VHUJ+ktHnGZyySjGx0d1Lafm/Fg4CEN17zP4X9k+MtC4RCgFy2tddo0DQ9bgMyUVcnk7Jg/jO3Ws8lbcryEwhbasl2c7pRFGddpO5PT8VGVl97uCCj3DLqOubxDFemq2N3uxciRWRf7Btz0N+DY49sOp5Hqpqptnw8LhfCfZs0DSufsRdUnYNvdiYHGxbRTR/AMMIM7SZXg2twagvYxO59o8kVWsl01N8EAzs+Mtksqy3+9/fiTFUim18f8W9m0r3GBqqJmSB0UP7BZFNuzZZI+PBf2yRRb9q3ycQewvXz4kOrUUZ9kdKhiWGki4d/OGQwJvi3XdYOHBtrtI7HINrMoosO4VN90Hzsn3qWXnxEToBQpd6+jNkiDuh1JUR1KYL/eZixjMoVf8b4YOj3EPNgNs9fAJ/G7myI/umeUrI+1Rb4m0K4F73PIyhViRa6nzMnchGpW6eXATfPqQ5SqIi2JqQd0AXnna22sSUrVE67KP0aygIOIsPnJpH9sQS0zQZzkAZg8D8EYJTNDPhPxdtSUkQb29C30LEFKVYOBO4Sh+aAYwJRGcECujfxGcvTVqs4g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xf4GBSMNGgIv9/QYjV7yUEPSU/P01deh2/7wH6Ml93aFVeQTCKUdW/0dO6Wm?=
 =?us-ascii?Q?xg4lC5+0KxmVMdWT6xAvRsxHwTgkeGH6wtt3FvPghV+AqS5kzaOY1jybTkVh?=
 =?us-ascii?Q?uq0h08jl8hz5SAtjt1McuWpNkrUy4pFuRkRI58FC7R13QGq71TDdfeo+pWMZ?=
 =?us-ascii?Q?/+TbqR6BTekBSRGekdJQ/LLEeIMcuXvdxd84CfyDGHf9XJCPhaU52XcOrofb?=
 =?us-ascii?Q?QgEdv5+F4iYnIc2Uz4bnLyuc2QgajTFqQrc+RIDgzHdr4iaBvpToVnKpxP51?=
 =?us-ascii?Q?KYRGNM4jkg8Fq25lm+h0QTqq7i00H/CCIekmkAF9rnbVNNiTA7mdcY5ejzrJ?=
 =?us-ascii?Q?fhFvFinkabqvNvApjRlMZ5FOG0f6s1LqAJNIADE6Z14xKDUpqMr8ONCnLFFz?=
 =?us-ascii?Q?G2/PyPkUpGRs19If6Kjr7oKu0Coz80BubB6Weefpq3i1PU6LZszQimoKaUCy?=
 =?us-ascii?Q?9vt02N+E4C0cBp+W/fGFsScAQ+jsIZWxG3SmOOGiDsXlRn9gDeQINw93eXmZ?=
 =?us-ascii?Q?VtNhzXo2HHrFA198BuzNsUJMGA3zIOK/XuKGLfHoKFMr3hQXzrnx8q9vNL5a?=
 =?us-ascii?Q?TAeT3pKgxaiiJsfqMimGfl6GB277Tk/Zf2mibrtaoEcMoreaDMBR9HQ2MS7B?=
 =?us-ascii?Q?a5NG13AaYkzyIZ6U7zVPPlk/Zj/rsyHC2ZsFQPt79BKi9fzksM5J3lD/jzZq?=
 =?us-ascii?Q?b/ejjRlkNrtQEp1iVlTkOpblmeJ/i7a1sQVdZW1VcNRulzHoKte+uRV/xa3K?=
 =?us-ascii?Q?ICfrM5iHFKCZOW9JpU1v0+ipZ5CNVjAgapo34OAN49g4j4L1dtQ8w6O/h4GZ?=
 =?us-ascii?Q?5DKfn5rGhUHklqn8XBthswleqZjPtsWx0Xjw2CG+Ql2/RJgHASar7AWED0W2?=
 =?us-ascii?Q?UsNJ5N5cxvZqkHHF2eezFGuvWXhG+cR+Sm7VkXNvmagmNjEMwxkxgnzo1y2R?=
 =?us-ascii?Q?DUhXQw3Ra+8sfyFWLyW/jZ1jvK0xJoBTQsIxTXkGm/L9ZK+BJXfy5x7pTRPh?=
 =?us-ascii?Q?tImN41lTKbwpjQaoSc7hPwgoDjIfXykDwqAPYPioPHcQ14mE1eY9y5jZA44f?=
 =?us-ascii?Q?Zt46zhwGE53qvw//2muxjGE3UNTCioBqgSMPVlCbAhV5GJYpHrf3UR7jd6UE?=
 =?us-ascii?Q?Ili8DSO0Bq1BvQ1dZP/gBH0ItEPEv0jBr86MJIOsl57R4VqwrWtxf5Vn2XFV?=
 =?us-ascii?Q?20V9tTrLolNHrCNH7nr9ZZTd6pUCWOufWkbVfl36zdsRZDC8gzGy8G6EblpZ?=
 =?us-ascii?Q?95phYOU3LL5L/Dry2moltQxGNM3VNNMYAVSIuXOLQuG/EeWidE/0IMkgchAX?=
 =?us-ascii?Q?0t0Ajz2lJ7TS8iN/i1Pf9Kpuzc8bZUioxNif6t0VqY0nH3xxyja2gfwbsJNK?=
 =?us-ascii?Q?89TMdVUiiU58cUNa8oXi4+zkYA+9U8eagyKx8oAxAeGNxVcqcR+uDjgmhbny?=
 =?us-ascii?Q?VqHpNjkPIGpGB3rcBPDmz4JdAu7MtQqt6H91w/7/ZJkJ01Gz0Thcj+/FRw+F?=
 =?us-ascii?Q?520d0YfYFnmHHWc2rkA6Zu8qnYrPDvqdCLq3Pq8obR5J4vj1PlMLVtF5mEDx?=
 =?us-ascii?Q?dn+beIyf3tjjurX+Wz/Ro+22jN+JBsv4UFsj265vcIAcWcpnzr3BR0luLEJ6?=
 =?us-ascii?Q?6qN7UMZKo12PwQ5DiziJz23OE1Xs00b9E2hAEhAHzc6PGCMzBCfhyl5FhP2y?=
 =?us-ascii?Q?c+GRrCRm5EIc+pk62tI7/umBqv2tHu0m/PpRPl+It0x71FkLgTKKZeDOf0dn?=
 =?us-ascii?Q?SIXzGqvDVA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c64784-56f2-4b0c-167b-08ded31be666
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 00:43:11.7273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/b616V9cD1yi6D7h+yexXNY0sENIiXzjjB8j6wb3MJOrtM7WkkRQusj67G0E+S7e0uz1PCjnf07893FSQOMrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207

With __note_gp_changes() now clearing defer_qs_pending at every
per-CPU GP advance, the per-irqrestore clear is redundant.  Remove it.

Effect: PENDING now stays set from arming until the next per-CPU GP
advance, future arming attempts on the same CPU within the same GP are
gated by the rcu_read_unlock_special().

This serves both as an optimization (should not need new irq_work again
this GP - for the compounded section case, we detect and clear it there),
and reduces risks of recursion due to clearing too aggressively.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7768a40677a4..c37d8cfeb714 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -581,8 +581,6 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	union rcu_special special;
 
 	rdp = this_cpu_ptr(&rcu_data);
-	if (rdp->defer_qs_pending == DEFER_QS_PENDING)
-		rcu_defer_qs_clear(rdp);
 
 	/*
 	 * If RCU core is waiting for this CPU to exit its critical section,
-- 
2.34.1

