Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C023E122F;
	Thu, 18 Jun 2026 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808696; cv=fail; b=K28xK0VfCiqfrk/wl78jmoqHpwgutg/DI62gQvzrqBfm3he50eZR6DQOWaCbW3B3XE78Cb4yKzMdk1+Gmg5OSbZya9L5NEUGZ4b/obY9Of7qB1xAA2PeOpyZNOU9mOR0WNeP4EN475ewNWvtWyYFMtV12kDqAZAJq9jMmMKF+PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808696; c=relaxed/simple;
	bh=f2BGV9GP/BaPKoBrHX5vbIIo+U8s1HnbmGhbfNCoG/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a3xON4+s6WMOkr2Z1Zwy8zeSqOjTDresetMSywDQRor8KHNhTEY1kpDVcm3b2BDQBKPDK0ZhAKrTuau7Avz79DemzUy4m90ChyAFACuD0Pioj1A8/w2nX+N4TkhL1c87V1t/rqAns+EJa0ssdOyohtA7wOG+VpDFp9/EW8fMGsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ft+y5H0E; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ft+y5H0E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKFa75gZhhTun6dMok1dvUQY7W2NF2b35mzL6mI1Z/Oro3CDrjyKiao8m7t6HxD8JguSS6C6Veyx9iqWB13s1ykK6g3m851hWNEWJzx51ICxs8fveXia9e+XonBXsoBOL1FEXle8+yfJPKFGccKp4eqSgde0KQ0G0wAgwpHrouNw8aFSVju/HrjkpQ3VLyd+6frXbbWGri/br9Tj75tG3dy5Zuk0kmfE4KZxMhBp5tr1pV5h6h5I5gZNeRrYXqISZ4ET9MUl7kCqq+2n3eNWpu1Y+X6KV2REp0chrTJTBi1HMmAIKv/HKt7ouCj6FkJHZ4L8OzfHOph7DJ14+1zOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7By4rAGPYyp00uhRxzYWu4hi/nhuvSLA8fLMdOFbkbU=;
 b=yEF5S4CLd5Ut+C+J5n1MS4/R5l3kUjrQR4zKy5JXSDhvVmvbbK/Hbdy5r9DOeBGqzKLzhTvq3eXgg5rAvyppWUyPrNK726QXFC+aT/QVg7q79nkJEfruGuU7XnxqgGI0UbokD/BlsGcqI01WyjXQCC+JwSYMv7kcDUAGrVOp8BhRH7wait8uOf8igFVRwb0TCCAoI2vDAjhyLoc5z8QS19zH8r6pWUKz0fEJjgJ4skrKt0jpzLxE02Up/z6lbGD9iqNUkezQTKNEB+V7XAz9Dlfdiv51wQxGpL1vwwpaf7IbViev/Yjlmwdv/2twi8Ao/T227J+Hix9ksTMGi/qzXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7By4rAGPYyp00uhRxzYWu4hi/nhuvSLA8fLMdOFbkbU=;
 b=Ft+y5H0EKIsS0OvFX3LPWt3wWQOXEU7qE9pBPkg92NHgWuEBMMNrTbX0MgO27zhDZJoffsf0KkrjugrEi5g/+Rwaqm69SpJkvA7pLo9CoB1eKGhpeoF+10+OWR86GbF74cocvGHh2LBkoF5VCxacXCn5LsimNOLAxhZaflbM60bt4lHQ3TbUM8C2ZxQD1d03pLbpiJmYu+vnOFlgbLkqlKCsItaKdL7Pz4r/WLYv6a/81vJsyD040IjvCkWxWs2hapPEOW8Qs0JZqonuLCr4z2x/JbTk4QLdZSECBFg7cobw2q4y6vUPKs73CnFpmjw1+ipfV5HDIFQjpzp3gAJ8vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 18:51:22 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:51:21 +0000
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
	Joel Fernandes <joelagnelf@nvidia.com>,
	rcu@vger.kernel.org
Subject: [PATCH v3 06/14] rcu: set need_resched on softirq deferred-QS arming path
Date: Thu, 18 Jun 2026 14:50:22 -0400
Message-Id: <20260618185030.376450-7-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618185030.376450-1-joelagnelf@nvidia.com>
References: <20260618185030.376450-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0017.namprd14.prod.outlook.com
 (2603:10b6:208:23e::22) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf2233f-076e-4ed8-40f1-08decd6a96b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SRDbkr9nFn+66KF0jjFkSHyZqAn2rJNJVtiY3KZr61ouBfPxArrvP0syW2AdiqWVyvz6Fw5zDDDr/kZ4lj8AMQ/TErEqZHsHUhB4tPwz4lFhW21J+Q9pDZ02djv+xadTq/DUPiapPkpNHt7sme+ysS0+1Kc+KbeGBJ5JhwqKH5VGAzaNC/A1QCJejBTGqyt/BMv3nlwe6rmjAOa+UKTiZHg0ui/Jb4iMRIk9trW1RUm8Xvi842KqpSlQV46MbXMf4frxahzK8DXqwOQt5jBUEeBWxYLK2kLjB9R+AEFOFTV3/Om0VZyJgHYtUw2U6av1zoTx3XbMKwhGOIQvhpEkLeV9pZDbCP7ppSFo4DFaomQWb1jJnYlMXncfuOu8lzZ8ZL8DD+SvD6uChgtKHPjpzu2epOkd220IJ8pRbZW68Wlv0U8UgqfJTvuoMlwOYXzA4FtUCZ/BM/wcwb6RduoqnTG/C0oZCrl2TuDpf3RxwS8ZbYuKEa596GmG4VZBTxiyo9oU1Q9VE6v6ZKPDO0P68OPFbfwG5ONRJlbR4HrU0cfmC6jsPrpvkVfGif8YH0JgDunMvSpBuLYnS7uE3orCkavJhiaOLB0FSSWsvgLZFvgjPqV51+VBiIr+dUMT2MeH+OJTxRT98GRqk375U8UNi/nKWJtD+lugca8hkp5n6DT4/bq9+wyLLo1cTAI7vzRA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JZtImTA+AGlN1J8F2KXVO6YP0m+th11UEd7O6e7MuBj6rsA9Pc86nmyngi3L?=
 =?us-ascii?Q?ImhaipX/6mi8nrgaHPwjlete6ZTbfbXsiB6dJbCqcPyHfAkKzZsFaMOajHmM?=
 =?us-ascii?Q?w5j9uRhVw1ZoYEm2mF4wCV4yube4keYav8JYG/fHDrOHbd6/YNPIK90kL7mf?=
 =?us-ascii?Q?eVaE8vMiJqfOyhqDPXlUDS45+EkIhzg7fu0PdU08sbztEP3bTPUBYLD0VOQq?=
 =?us-ascii?Q?RjwgT0Oj88W0WKgNY5BV9Ovdg3io/d/h8R5cR8PtKIrkJTZSH1uB4DfSpYe7?=
 =?us-ascii?Q?YUlsHiJj/vJ80CI9RjT0E1oRGHGuzSJftfjlxt6VHk3D/6dJtNhMwFDKZty1?=
 =?us-ascii?Q?O7MM/RccQBXd3+eu/JfVSEEnX0kbkalNKBxjPAILrEvzldN9bzaCi8fowpSf?=
 =?us-ascii?Q?AuJpl4I3zN68LdIM8W84y6uSQbfL61MRKEDcH5+zoJei9IQOvP4TtZYHzS/V?=
 =?us-ascii?Q?niLRvPMr/51wG2OX2BgX52aD9WR8Ag0GvP8VsuEf9cEKfneG/SWWcUr5XUjz?=
 =?us-ascii?Q?MlLNqLjM9X/gIAVouPGhaWJv15xqxna2RqlkrWZM9BVihAYyoX0uWqJGn20b?=
 =?us-ascii?Q?PYqNvwZQZMnO2NrirLrj7zLO0TzFC3ddvUCgWgXFbUiGdimIb5Ci0fcyyz3C?=
 =?us-ascii?Q?fdjySJZ3zA2+m2EjmZfMgXsjllEx3eD+nEwml3HDgHfLga76QlvspL+GiXhq?=
 =?us-ascii?Q?CcpLwWHi9Yt53nIlrlCVwJBzjGlWDJkiAmjIaJ0YCKuFsYCYYup44lOpkK8k?=
 =?us-ascii?Q?+QI2cJJbQCRl2ia7Cs+vW2UoF+tH9+2yidhp4SCTZVG1sMFjdGJAW0G3DxRV?=
 =?us-ascii?Q?2GhFQmXD9D2DtOyx4OzLG8l39luti0WMnuRHiEJux/bcy/qS8VtyBC4KYY3a?=
 =?us-ascii?Q?icAze6OewfaiP/FHA/0aqoxXkUg3I+B0XdHprCJdZS183CJe54cQaUFjcY5E?=
 =?us-ascii?Q?qdDE82OVIHMCZyrl26+WkaKpygKDhxNEx+xWnLZwy815Xf4IAWDmJZgaLPnb?=
 =?us-ascii?Q?VBrcqmHyjoXV8mYTxis4iA2Bue/pZ1aVOjV2DWov/7TawxruMGgvCiu0WJF0?=
 =?us-ascii?Q?DpYOTUV2CmZZwHJgJ77zyYkiHqEywl5SOH1vPTOMyzX7oJTv2Uhtix7XVHr4?=
 =?us-ascii?Q?SD24FwPzG+Irel3TIXudxAXkPh2v4SkUOR4UoBSgsvlO/GXY8tDkHV+THP7d?=
 =?us-ascii?Q?LLLyuml7pfkP6/aSQyRNXIPawjb99CAwJnpWqXU3lIVh1wXFXuTrPTAgUFYO?=
 =?us-ascii?Q?MFF1fXFFAr6ecpgNdXOZa1RNoMscwfSzUZe9aRAB87OpAAkGWSrH+yVUEgE0?=
 =?us-ascii?Q?OoI+iEI9THmhZLubZpRFBzyBvwqrJTNdZ+o1sNCXBix256PeSa+8GrG1vTGR?=
 =?us-ascii?Q?sZbyWCIyN40kmpP4e0wHfWvQdAivxNexSrDEd9lc3mKf0zJFTOhZzklNbiiv?=
 =?us-ascii?Q?FrMb7Fv2Zt2URyumRSHqNOwNMxy58CLfVzRu68klELGA0mzRQCSi69eHjN2s?=
 =?us-ascii?Q?oULHw8FJ+NUfZVLnFvaQai0j+aQf09stMpOoK09wvfkeFVlm1I9Ywz9jKEew?=
 =?us-ascii?Q?DWB86uv1r/yA/IFVdjjvy76q7paDmSZQZmgVwBnLYYueI+EPE1YUR0HAF5To?=
 =?us-ascii?Q?KM/7V1TOFUTUHGBn+SzMRYpx5zXTY2iaHwAQJCgDr3R/pwMDr3Grn1lSlGmd?=
 =?us-ascii?Q?Gkof6byNcn23IXXCRdweihvJ6UOEhNPnw0O+z+LsUU7d/1n0PlAayNWx80Dv?=
 =?us-ascii?Q?WBWCYGEpWA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf2233f-076e-4ed8-40f1-08decd6a96b0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:51:21.4694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C85inL5RHL5TZHgmpsqETOVwEHkDElSUcjn+oWLCRUcSHsfJXq80d4nMXpYPdyBWGxikQ79NaHUtfaXTtt9sqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088

The arming code in rcu_read_unlock_special() has two paths for
deferring QS reporting: a softirq raise and an irq_work/set_need_resched
combination.

The irq_work path always calls set_need_resched_current() before
queuing irq_work. The softirq path does not, relying solely on the
softirq firing to do the rightthing.

This results in a problem as follows:

Consider 2 rcu_read_lock/unlock segments:

        rcu_read_lock();            // segment 1 starts
        // needs_exp becomes true
        preempt_disable();
        rcu_read_unlock();          // segment 1 ends; IRQs on, preempt
                                    // off, needs_exp=true =>
                                    //   raise_softirq(RCU_SOFTIRQ);
                                    //   arms defer_qs_pending.
                                    // Before this fix: no
                                    // set_need_resched_current().
        local_irq_disable();
        preempt_enable();           // softirq pending but IRQs disabled
                                    // hold it off.
        rcu_read_lock();            // segment 2 starts
        local_irq_enable();         // softirq fires: rcu_core runs, but
                                    // we are inside a reader (depth>0)
                                    // so no QS report; on softirq-exit
                                    // preempt-check finds no
                                    // need_resched -- still no nudge.
        preempt_disable();
        rcu_read_unlock();          // arming attempt suppressed
                                    // incorrectly: defer_qs_pending
                                    // already PENDING.  Without this
                                    // fix, no fresh
                                    // set_need_resched_current() on
                                    // this path either.
        preempt_enable();

Therefore, add set_need_resched_current() to the softirq deferral path to
avoid long latencies in situations where GP needs to end sooner.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index d17c2d97ebcc..7045f0deee17 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -765,6 +765,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			// Using softirq, safe to awaken, and either the
 			// wakeup is free or there is either an expedited
 			// GP in flight or a potential need to deboost.
+			set_need_resched_current();
 			if (rdp->defer_qs_pending != DEFER_QS_PENDING) {
 				rdp->defer_qs_pending = DEFER_QS_PENDING;
 				raise_softirq_irqoff(RCU_SOFTIRQ);
-- 
2.34.1

