Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011056.outbound.protection.outlook.com [40.93.194.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A132BEC5F;
	Fri, 26 Jun 2026 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434604; cv=fail; b=lGD7umMrmFabrjr3o9aL2AVt3y+Z99Ol+ksDaWmMGP2ZvXMV7XVMiM4ap6jYUYTpPE7xjyexypvdpS8tlzrv8718PdchlKbuwHvyegSxlxet17qevT1wYqk+MJURWib3f6ykpSDeEnjwiQaJ+at0d7em1y0OG4EfefDquc9gvf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434604; c=relaxed/simple;
	bh=jPDog0jAT7cMp8RYj3zBfuedTy0sI5czPyEP5RfdsNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cqyjjRH6AeCcG1il7pVgRIKy8S4WIOK70+YOiwRYy7DcnxY4lAW4NazpYF4/J+6PQMEX5gK9D1uGDzkJxy89hJK7rQYMKz5IzinuCkQvkcGpyQQMKkfZasfaNcdgBfY3cMlLYSmwwlH/MCjbJHuRpemMJbMus3ouTI63YEfDXtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EX6a6p3/; arc=fail smtp.client-ip=40.93.194.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EX6a6p3/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEKeWrDcWUi2D2BfkuoPQkOqCOcuX45hu97wVF9o8dP+MFABN3FKCO5PQggw+pYz9pKxRq9+8wbEG9SKsnKFMjf1ZGrU3SGcPA5tons1gm1Kc3kgm3tVUF2okUYtDWwifd9KGwVlXBPwAnaloUbs5t9Mxi+imKSo9SQxifZuoswDaEEsqavlWcq/4f0rmab69pET+rA503HQuy/aPerdRldI5pmgU9oIyu18GU7K2nTnWc72LfVSe95oi/RYkYL2n5sWSumgi1UERrN294AvXcrjRzjyKBeefweA9ydAJl0xW20EbTtkI9Ae3bsUnJjmOZG3VI91LxscbG/UQLadUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rnyycdkkr/LeDvlTPydJW1kIo9wV7hOYDlkHdSR9BEw=;
 b=RnO//JNZRO8CITWJT+S44I9eHFQeXN/VMZRjH4ytxmbNn6tktaUZ07nYzt3cDParFekwJ8rPYnx0rBEax2235k9l7Jt+mRcRkzq/q3OL7RuIMqzuqkDOIN2NdFxwNT8cyN7KhDR4fJot6QHKybtixL2vpK/ZPUNWRJGzD2DYz3R6WP4Zo/fqHyyGzM96W2dqRFAjWqriWx/8+qW2xdMerhP7/ymxce7ccN328RzN5tlWgmwPG5Mbz5LeU29qkMGj4iFaIb2LAEZ2Pa+i1m2UEsSwZJu/0NVsHi+8B52oRrBE9f+4MP5g98h0MYw1MLMgRraZeilH1Nb/LAUNnCsg7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rnyycdkkr/LeDvlTPydJW1kIo9wV7hOYDlkHdSR9BEw=;
 b=EX6a6p3/8/WEIHRCkROiCvkvZMucSeiVKXhJzAGKUax+z6p1tec3jNUbzbRqMKQEArGpe9Wv5FOtvac2GvIIi88xw7PPajq94/sUCT3h154rNtgdSYWaEdCbHoY06kh76tnaGwToBOW2+huuEGdvY2m6vL8lPL85f4IT4cw/+oO3FjV5pcCFTZwPDrxEecciL59WdBYC6zJv27z0/25gs3DXY11eEqngokhQmfd0IcycmjXN9X38tqm7Fs7Zcx9lRzmbeqsxsVOWj8VTCroX+YydiL6AIF2COR1zLCn2JQTSyhvnPoSXF8Q24HZr1Tuy00OMEQetnId+LaVaLsvNaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.13; Fri, 26 Jun 2026 00:43:14 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 00:43:14 +0000
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
Subject: [PATCH v4 6/8] rcu: set need_resched on softirq deferred-QS arming path
Date: Thu, 25 Jun 2026 20:42:59 -0400
Message-Id: <20260626004301.1632168-7-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626004301.1632168-1-joelagnelf@nvidia.com>
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:208:23a::30) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 38570be1-823a-4efa-0eba-08ded31be7b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	b6rZ3eSN9f8/8V03KLiKvYozVpXFuGZ3S2tIAeaIllqltMboGAdJcLWjLJ5L2tZR48Bqhfc4U2Z1Yn7NyDxfphE/HDjJGoyGEIcT+QWo0xIAPmpDzGYtxaR781G12DEgCfwA8HHx2adkFNtpWS1oH4Moz5if4le4p3q+LYjDV6kMc7XXgBoJL4t38lMgW7L20mng4U/ncXg/up7l59ymx5Vy5mZvORZHrManeXNvHqjNP50wjVjaBnmvFCv8T35ASwHCuvZyjNvc3EFFt9WJv9I6VlgrT+LecLZyCna/wk4AdXOQUs3NN+SjBP4KlluDHBZNXcf6aj1XWU3qPNTZw5PPdYFkNlmbjCFZ766YCYKEy6ppwtlTLa3jtMShnkN1+Jd1JnDOGyK7JfOADcCLliHsaGdaD2UEJl6tLbK/Vb8SB8Uf/83RVErCDTRKBnOMvFn70JxDJ4mWMZYG+nWemiIk0UB+jlEwUv4x3eLxu1HFI0LMaYyQRz+MyFD7+sPnv9OqRBUpdzHeNsxjjy0jQaGIOJMo8gHrzxsWTbAZAfOYueyzAwnm+xlJY6rlpGmnPtbL4wBF2ikwN+CD9BYVNywuFLbDeomD8LKvTBhLM7+lDcUj8cSVYyeJTEYVLnAm7PZzFOkwxS6g7nHEag8s7FHkFJswpxUJpvVjSt427DA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mHNuxKEZ9OyBgEyxazK687O0jreG8Pq9xY1Jg1ZYhMy05PI9DJMucbkYx2Ej?=
 =?us-ascii?Q?fGwKTkKs98BO39XzCLn/t3ufP1BNhfno9XJbnE588bizwG1A5Je+gakHJo2T?=
 =?us-ascii?Q?SdZcHtasj7cLqo+g18Oa8UIlDIcSXJ5JhkCSUSWCva9w4Tph4PCWj/leU9gf?=
 =?us-ascii?Q?VNVaPeZp8Sb99xYOHovATTLbav9gIMpTxK9lKcdEosdJ4LXV2MdwlOpn5vG6?=
 =?us-ascii?Q?RXAam97E0snWAx/ocEy5TRsPoBw11M24ocRCQCyuT+yn03HIHuINgOk7QtKp?=
 =?us-ascii?Q?WOHmiekThKCt0zR0VJcUTNSBh0DNLmL/kph583+Z73r2VJfhrpGGZrd/lyPU?=
 =?us-ascii?Q?dIcHYbbEGsVnrAg3ifkv7wOu2gWAVPon7NQ96Lub0Q2zcdlMmMsj9EFIIvqO?=
 =?us-ascii?Q?lQlkrPGGKkRCuVTgtc48mW/RLTMZCML1iL+/wEADvjA4Jm4fJmtjBpvJ/JFL?=
 =?us-ascii?Q?6CsnryIa02mlZwpwm1cgptc9gTDq1xohGZjowk+/bBvAhmy2jSJYTW2V3YSD?=
 =?us-ascii?Q?ApXOtlW14LdN6rVsAkIndBuZ66SwAmDeway+4mroluJOgnZ5DgOgM+FXdx+D?=
 =?us-ascii?Q?Te08qwtFi8+KHNLxImlixFD4q32cw10gtfuoo4BsU/+nk4kxxyysUFYthMSN?=
 =?us-ascii?Q?k8QI98rID1Z2aldZkrexmMlqvo71m0xixykKEJgrPPXgSHI+tEamqZIeOUei?=
 =?us-ascii?Q?jH34scUQH47HnXknU9O6mYIYSo2de5qtkc4RFAK0spCAMo4Yu+5OmytgkS2U?=
 =?us-ascii?Q?tnItJy6WwdZOjnmFZxr2eA6LaKhlPuRK8rXO6/7Jgtemta3YRVlt3F+RQdc0?=
 =?us-ascii?Q?MIGCVgl0442zGO4AoBnE5mNCNeePZ7LrRT5np+/waIRhM7tmJbaS+lJ83LEX?=
 =?us-ascii?Q?7F0P4SW557RN6XHpTR5LMBWybWkA40HWqPzJxbcdCevSDf5RpiDUpPEbXq2W?=
 =?us-ascii?Q?NQy7oPfewYYSMVWDS27dgfDSI65cyeBHGC0Pb+Pbn45uD9b62nUZ7wFqEljX?=
 =?us-ascii?Q?BqbLU/HgWfwTSDxQXXI6GIpsVoQhbRbJbKfbn6HEQoa3CcJwTqm3QCnXaPiN?=
 =?us-ascii?Q?CjkwOk4pum+2JXJO5y/wqES8c33SKYo+XVcXanxVo4T5IaWqYcma6tNhxUsK?=
 =?us-ascii?Q?DCNeszxgSHJ7bYHAZN0I3PqTyWAZ19EvaWS68vjm1eKYjVWSY35WArLOwSTB?=
 =?us-ascii?Q?ivVgGZ1AYhUDicb/hPdldsW1YG/pYEo5o1oMiMPDu9naUukP7pJ2L+5HBsZK?=
 =?us-ascii?Q?hzoLEk6Iycq2zfv8rCRv7yf5nX3nUkeAFSRAy04Q0Io+O9/SkY40W/Ip59B4?=
 =?us-ascii?Q?nNOnabVt5vh+HCIA7y6vIi/Q8H2UvnvG0SI2aIIqFHBQhMr0JLmV2GUiF5F8?=
 =?us-ascii?Q?k3Ft7paoAYCE7gRvyxqB/kr+wx/e/l1z0/CVBcUSiegaMinJsyiG6FBe/kSc?=
 =?us-ascii?Q?GRsB/3CgxMPHw0Tf6OmV8dMuD5TlB6DLMBGti+Nuo8iEx3O4VkStIGObXL51?=
 =?us-ascii?Q?HHahYsX54ftZcAM32J9yQSP+hsHCdP67Cwbzv0U6v0KHykmNC1Wb1MhI66Nj?=
 =?us-ascii?Q?OVdB4skr5a6Zson9B8CGGNaITh8PO9DjkxK67pmDn7B9iqNGfrT+ad6eFBXa?=
 =?us-ascii?Q?HMTrtOggCCUFq3kKTsX1yhPvlWzKVyKuMSjm0EG57C8TnjbWSxl122A3FH1y?=
 =?us-ascii?Q?pyxasNjh1g92vVxO3kWh34N+3Jx/5kS+MT5RxkVFkoGbtYGuI4j3Z/NFFjLt?=
 =?us-ascii?Q?mOHVTu6SNg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38570be1-823a-4efa-0eba-08ded31be7b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 00:43:13.9886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVyK7YNxKXRlD7vYWtTBCqL+/fmhFhjK4+Qic3Jwl1RL45PezfvNzfGXqFPQiDFOm/efm9XODC/Akq6TEcUpHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207

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
index c37d8cfeb714..f58ae29acdef 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -846,6 +846,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			// Using softirq, safe to awaken, and either the
 			// wakeup is free or there is either an expedited
 			// GP in flight or a potential need to deboost.
+			set_need_resched_current();
 			if (rdp->defer_qs_pending != DEFER_QS_PENDING) {
 				rdp->defer_qs_pending = DEFER_QS_PENDING;
 				raise_softirq_irqoff(RCU_SOFTIRQ);
-- 
2.34.1

