Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9162B3D093F;
	Tue, 26 May 2026 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835838; cv=fail; b=oOwOvHus2hfNbjfoTZuxjF+KFIrasspus/fQbBEf/0MqTNCsF6IM6178U7tbIpqs3hs8/1Xp6zqMOowpvb3GfDq/y7WD4P/yg7BpAwj1V36SMFYga7a+3RhhkW88GCZUW1Q/Uv2MY14Ev3CBD+qd6GugiBHoTW3QLUtdvOnQrQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835838; c=relaxed/simple;
	bh=GNaTg8s141w8VgMdEG/oBdXZmreBNvRUazOiAZRig0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sNhPbwSNNLT0Z5ev1MFniJl4F6jUtIio+xmUo17SKMmSBHCKLQqtWFhIMz3p5TbQdmwl7kckpA0iSiiw3id7z0zrJe1RnLkgiJu4MfVTWyQXL69B6Q1lt3iSatsKLfPFroi+S234XL22mxpl0pQS8Z57XXdAjcCjO1lcVwswQ+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I1IfWW57; arc=fail smtp.client-ip=40.107.200.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I1IfWW57"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSKiF5I+a+7bbDeSPclywq27B2sDIj5fgn3I3Wevi/TeMk5Y8Sl6/TfUdLymC3Ql1i8WNJQuqBGAiNi86oLbsN7MQoD433Q5l33WS4HNIxacurG98aCn7l2EvTRQFDngPXdDpeJ6jeHNyFFw7UThYeZAocFlRT8VzXtnX23ZYfasGfqQ8H9ad3Ppo23lwkbSL3yq2vfYx46WNiug46Sd8iypyaXkfBHCp82hkVT93I2/HNTLXNMl3+8DH0m0VLghtmBGA6Csk4954+Z42fhNVIA5z3xm8AxqGTEec21Wl0q2LBpfBBhN7mIFOkJmQxRCc2+zlB6I4F3Vfi+4hjORPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jo7E/v+R5EQurQ54R5j+qUgz/z/u+mIp8oD82ucCp4=;
 b=PQyLn/8j35undPbX7WF3sw/0VQqSDpXv1+ZCimaHxZjL94idQByCp3RybBa7/AiPyEhl1dMtLvVwmv33Qozb1qEtZnNZgEFoX11SpFBvYJInr7Efm9ZWurAfk6Mk1AZAQDDqGaAKi8RSiMtJylJMY08K2gSm9Hp72ysALfA3c0btQDBBY9jmCJLbQamgujvL0e0svFWnJ5yANsRKr2JHf0hFT99qnfheYD7/tSWkB/qRd3ad15OmM/GuNG3EnIAsv3gtswAi7xYeFxzCL7pxmCXrJA/JiK+k6bx8yOY9PXGvlryOA21nwysriuQjZh5ajfKMrMx2NZ8wGMv18XwY+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jo7E/v+R5EQurQ54R5j+qUgz/z/u+mIp8oD82ucCp4=;
 b=I1IfWW57dfBpahRVp4TkUEmpdBXABi4vmkryizszC0TlcAwuy04lFwxv09tGJwtjl1HtGM4x5GCMA0F44OterfExCRgsMc+Ce+L1QMyJkcaRHcCu/5RZAXaj1acINrGjdFbDTZ37kCy5/wSOHkee8Dm5TlIFS4vQDgnCDBeXLrRH8SP2EFYNzlSI0sMoJqjYp0FFT2Z+Ou1GrWeNlifUEcPOb4chcnafdNPvyS7cLh80sas8cbvJLyrQhA0PWIeVhazGqPB5KwtpDW0i9lLUjlmgLj9TgOPHxiKUgdOk+A/20ThN94fw/VoA8I3TM/TAeNGPzGztqQXDrt9X0iL7SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 22:50:29 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 22:50:29 +0000
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
	rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v2 6/7] rcu: set need_resched on softirq deferred-QS arming path
Date: Tue, 26 May 2026 18:50:13 -0400
Message-Id: <20260526225014.314734-7-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526225014.314734-1-joelagnelf@nvidia.com>
References: <20260526225014.314734-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::20) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e05ffd-e113-444e-c6f4-08debb792f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Jbftc1WNgt5XMlfIeed9Sv8rhVerDq3alfv3NCAVQ+n/QhXyaf65ZYm1ggHQ9nFFfjJcdzKdkflasWNBXclB36341j4mbQAJ8bOyQc6tI1TPmF+GtOyaBJdvuu8itO1lda3/KYWLNIVg5+aZzZvEsNTRgd+hXcPnFLZBfPl+0mZIy29jp8s421EqLmQEJXrk3RvMYh3CwWq2xCJ3QwWVILvqB4ae+8Xxn6/rbVAfEVQjACqagm9aCU+UbXckXfuWWxohdp4PsdlHM1gArGD5rWZ5TpYeKHTahjZRtSJKW51sMHQY4397zQ1qmcwrd+zlylK5Q4+KPIiEIKgNMl8W8M4xqwhWTWL9FbeO1Fl5ntgMOltIHjr7zE2STMJjVyGn3k2xI+L/SCSTmzE0AINJI/4zf/RMAPLoiEUFUQV56TlehfSMT/rR6OTal55D6ZNdtUQ18OivRTIKfPBiFgOloHkNJMVOgKucCw/LtugmyX7TwFCUkIy5P9dbUKK+LrorxC0hqadXH0pGV69IPiQLgazoxm/Wl3zi/q3lm+KzRN/PK2tjaLi0UCnMSN86iKNdSQRWa0HZDjxX58tXJHgpChBgQfwKs/iT9VCjecnVRcr9I1fPBrkJQ9AIOUgJ0qkXLYWe+d6NN6VFNy6NanPFsqht/0VbNlxYKJ3VJJS9YDmcxUrGL59MZKGfrfJQu5Hn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SNWuIQFd8QUP/kqzzZsgHN/CGYfVR5ZxJAi41nGOlzAApbwQY3unNSmMVy15?=
 =?us-ascii?Q?h0sVZ5PcuTS8XivXuSRBuS8+7bUL0FkaoI/jqOeoBLJCoJF0aTb68dRiKxJq?=
 =?us-ascii?Q?Cre5U+BUQLIgbKctkFSsnClq1PYtm8Mg+SlZeOffsBEzwJxtU1ZkP1BwyBpN?=
 =?us-ascii?Q?nGY59ZuA68noU8s9TiaXYHwpstAcFVvHBuo4RHwpO9IgJVOSEN63oyQWwwlt?=
 =?us-ascii?Q?VcJny0yVPu7sv22QHvtEmQKf5W6btDqqYAiGQ/Z7PJXTbXSrow7Izvwwu77e?=
 =?us-ascii?Q?M3jrHsP4KI0UI3DFdMU5OodQpRHDsRGGndi+7IDmlF5NozcYmxO27sxsdtLF?=
 =?us-ascii?Q?IFRj6wqEstl1qKRf78P2xVSbG2OxLW8fn+k7M9jDk0WVEvLs8ma2vSxzlQ6u?=
 =?us-ascii?Q?uakoelmq4ZC5sLGRmvX8e0chKyu9LP6Bye9bbip30ZVovKLpWGTCERVj3noa?=
 =?us-ascii?Q?J5mwm/WL4PEBMVq+PJ+IaYtRe+p7bNovwd83ijv3QGlsbWUJjEvPARJIlszV?=
 =?us-ascii?Q?N88L8QbJHrzhtPoPyP3drsbayOavHMs21TA4yWPr8HFbpG1RwTsiSD/0IFy1?=
 =?us-ascii?Q?j9LabN2WarILpajxYDh2Ok5jdJZrswfop1yKnMbdk65+q18abGTW3LxetV8i?=
 =?us-ascii?Q?/yXuld+02/fnTIlReu9e+eEVOQV19vdym42iBnPzxc4aypLPbEcvzvQJpzJx?=
 =?us-ascii?Q?Cg0A0mGob1QbnrmiS6s+/8bxhsFbAP2pXF9Vlbp6J/hJpx88y6h1aOS4Yscs?=
 =?us-ascii?Q?7R7afhJb6x9VOL4PKlbSlwUmHtipo/RGmGnezrvsUZdDtqRocIs4Sf0YiVg9?=
 =?us-ascii?Q?avgJszvWGq1t1vyOMemYo0uIBcrrfWOIiAN1dEJkBPBdbvwUAoqWuIj9e7YN?=
 =?us-ascii?Q?piF1WHSyL/Mxnw1eer+mCthpp9Lq+y0rO3yzR4787MRamjovTN1kVYntKkkk?=
 =?us-ascii?Q?SJMNAB2oPDTEkHATQOfExMJOgjByq+aA7SbQ1gQ6pmkzLlBZvHMNan9qcQFe?=
 =?us-ascii?Q?YwklCqQ9c7sVPh2Bv3BcZg7nXh32AcmuCrjyRdbWf+RUDvhLYHXoheV0Lde0?=
 =?us-ascii?Q?mWMm0M49zdYbnP4veLL/lSPw+bb8C0MlOpS6KEPQG3/CQxUAjvqapSbqIx3K?=
 =?us-ascii?Q?evtkAM3tPU0fpyjiJxrDVw7dOl91rWM88WXLV8PZtCXsmQ2V53nappVbeHE0?=
 =?us-ascii?Q?pYf664WoQ/13+LtO5WUX/+oFLltRit8/jVaHDadfw5zsp0VJFvr2Qil0fzAY?=
 =?us-ascii?Q?efeBZBKb+dqjsWlzFZSnWz1OZrTJgYm2e8tgxs7bHU9drnyZbcewShKXkjpB?=
 =?us-ascii?Q?0M1s942KsehSzgZZvgXHoJ27tTkG5s2yJGnn6q+Tk2qYdnZHBY32Ni/dkehc?=
 =?us-ascii?Q?bduZpEcHVxYAeRNzCeR+oDvMed0yd7EniGEXjgXuFYqra74QeCrNmjOOwIpR?=
 =?us-ascii?Q?mhJIqmmwK1vcNFzgjdZbeezVPFDfQjvZC3aVgevU/kbCYBf0n1knnGAaJJpU?=
 =?us-ascii?Q?pSTxUck3FE3EZX10cCu8Okwuwnd6ZOOeZnZwYYHjsT8T9pUJjcJkmt3fbzTe?=
 =?us-ascii?Q?jZZBVHrGuhhyQxfxzmIy6+Vo4lADxEiTHEddnw5EcWgUzTYdXSCvXv3Mv32k?=
 =?us-ascii?Q?oOnwspNEh7h5HBbv81BtU+yI41E3xmGx2IJgWbTAGLzXIrjsipbP9YAEn9Bf?=
 =?us-ascii?Q?y7G4+LkAXeX72bmAEdgIxwkcn9Y3rOtLsAe0MccIqZmaKdrAzs3O9paK2hdM?=
 =?us-ascii?Q?Wif4ZeiX1Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e05ffd-e113-444e-c6f4-08debb792f61
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 22:50:29.5294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfvP7M5bEG9gjmKgj/MluVVAnO/bSQ5gzeF29f0xhoWC0tZXAE4VhdjumFoRtPuTmI3czwHh/MJKKP+txZWS/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353

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

There, add set_need_resched_current() to the softirq deferral path to
avoid long latencies in situations where GP needs to end sooner.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index bb5f955a06df..86ac1e8228cf 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -747,6 +747,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			// Using softirq, safe to awaken, and either the
 			// wakeup is free or there is either an expedited
 			// GP in flight or a potential need to deboost.
+			set_need_resched_current();
 			if (rdp->defer_qs_pending != DEFER_QS_PENDING) {
 				rdp->defer_qs_pending = DEFER_QS_PENDING;
 				raise_softirq_irqoff(RCU_SOFTIRQ);
-- 
2.34.1

