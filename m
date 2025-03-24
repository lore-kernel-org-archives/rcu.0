Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A222641DC;
	Mon, 24 Mar 2025 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835733; cv=fail; b=Me09T4gqCoDqoifzsBvj5JzklijevXdBJeUM/DeRLDamtaDyQ++31lY5fkP8wy+vyqigNXb9HnRZCjWpllLlYkwbVf15ib1hNxKJ4W0aLeFPxSGSOOtI7Ptd2zHAIDROBmLhISI65065ajitaMndDzSO/UBGKRNcJba3Gh/QWZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835733; c=relaxed/simple;
	bh=mvFGkumlMHcFxnG4L/r04wWIoum1t0kM3TSudYgcLhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KXM2OrTJj5DxAvhIocPMFAaJLAI/hjP9bNf/Ya2O1kGpwqu8qrea/SInfMWBFIaLiR81RPnjGJ5SctUr732aavGdb6hU1VuJ3ini104cZlrrVEHGrfb8w9Oc8KTFHaoCJWVGWvL03IXQVQFEwVhTrIExhT1Bgaeh+VTt7C3tC8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PUAw2Tl9; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PUAw2Tl9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJnyyu/445MG8C0BNTI3v2jtqFXep0OVIsMMtxkYloSbEcXD5cq8zMPTu5E3fGDzsIr+pwrNZzygZYLY7Nz5h2DP6pNtpFGypiaEfK6z3xFlqZQS7gU0QvkmjF0i+4HgBazje7EpNakQnJwJfVxTgmrw2myd5eDrejCyd68ltqFrl8zXkEA44y1LPeQjC82wFY5URjETwA5f1n/Nxz+O+mWbqJCvXHEYBo0G+jXLr2p6s/Fp1jB30zx8sZgITIUUoxp3luqAquSHkcXdUYCeBW4nIfhHqc7h8/z5H2Ds3MOACT1/TLvTvXTx4MrmBzlF8lmMnZ0wO3nfJQbfKngthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWey9/ARnWXGLbHAIivusrizkw15EwbLTyJR0KSR/Us=;
 b=BqU0BvFxrKJ68VmekAYLHZvlL0ILG5UGxPhZMAm9E+Vssf5Ctn+jOnMw5g9bsBv5Jxpt+CJBOuF+1eR/02xybQ/DN7uP/nV0QtdMnR6HdDWS0WIDTSouVBXHphCPA1v5fZYh2crnZqGBCorqnwN6dRoTPc9lOJb/OEDzSFqjxI2864MiRYf7967yGs48Xp59gZRW3qSjM6E7g/noem/kmOtsbkjgy/WnkTSTsduhDU7tfNnBVic/b4bf23gsOEbwKrHM4dLyJmzAKaESDakmHWDo74eN/XV9HsqaOQODbxtHa7sQbEDHw3J/s0w1qMmODWdBRCB4if1fuyzp1az4XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWey9/ARnWXGLbHAIivusrizkw15EwbLTyJR0KSR/Us=;
 b=PUAw2Tl9nXD2WmtIVqQIxwAnOuEMa2AXRXV08+mnU7OAqSFha2Os5pOUlyDjlJh+p/8oTh0RlWGpCJAr3dVqhdAE8eOKCqLVmTR6g4y6v+KUTRv8BFcYVCg7fP6LuS5o4W/gmUlBMv/xlZXmun1P1c7RRDK5BEXpM0/1TAe25NX4SYVEOfsoYFJuGsgrk4NvPxzz0K8RzB2zPYmS2ohoSJp1jUSDGkFV0PJohQx2TM7JmCV5RLmnSjBfzHT0kkZCqdZlBQDmBFZcqVCnFWz05QXDuReMBkXbHaUkAVs4wWMoy/Kv9SP3NmR/jd4rtpJlbu2hMm3gb8/WF9I71SZc4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 17:02:08 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 17:02:08 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	rcu@vger.kernel.org
Subject: [PATCH 1/3] rcu: Replace magic number with meaningful constant in rcu_seq_done_exact()
Date: Mon, 24 Mar 2025 13:01:53 -0400
Message-ID: <20250324170156.469763-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324170156.469763-1-joelagnelf@nvidia.com>
References: <20250324170156.469763-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0856.namprd03.prod.outlook.com
 (2603:10b6:408:13d::21) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: b9788194-d031-42b6-f716-08dd6af59cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3xaMZ7ZI19LwdaB8yZ43KgwWo0BqfXUur8YsVIli8k/iKZZhFH9wu7+MJBl/?=
 =?us-ascii?Q?gJ4s51HyJIQ1NNodldLTYbijfd8M58jtPiuLT1NQJKC2OLvBkPJJxT/9CQXY?=
 =?us-ascii?Q?TLaxVah8/ADw++fk6fabrhRW28JUgjKp6bVbDdY/spSXeg/O55VVpp/OXQEK?=
 =?us-ascii?Q?1jFuCwsQ15+ay2CIxLViCI2oqEdrs/an03LoAi99rqQAe4D0i6uZ87LA2Aor?=
 =?us-ascii?Q?uEhOHKOp6v9wCxFVeEdU+APPqbjZNiQU4BJAjs3yILqclChrIYsMlfwd0zoD?=
 =?us-ascii?Q?QGtV/gQkHPGNLQL/CNacvi8WrYSIwqeC+AAkawc26AWb5YUPdzHjoIKzaAxy?=
 =?us-ascii?Q?uO1NkJzWfIyCuvCCsNxMrEAvYyBAvX+cgjkYoB2W6Y5/df2/3cwURbNSl1BX?=
 =?us-ascii?Q?/KYz/l9s3EJUBuzklo8kFi+/jyFaX51XA0hfursjnx+hQFmoBIHi7V82GP0u?=
 =?us-ascii?Q?7oTzJoVleUItcHEFhTEJVbjrHzk05TOxgrKj/f7ZXAi4cLaW3iBCK3X4+LbK?=
 =?us-ascii?Q?Yu6m7vCU1Lw69YC4fMv288xf8+dqMOYeZaeI6IjlNKJzoZcDxoWSFusobUCf?=
 =?us-ascii?Q?gGPA0Ybi7XkIp0Iv/6Ro8sV51Oqgd0XoTP2jBdMQnsTjTNEPv+2AgaEf+GLx?=
 =?us-ascii?Q?srXlsTHHFCxKXGStRZzIGDtqRstx564AWPW1eYmpL67zp61QCZxBchRy+AHH?=
 =?us-ascii?Q?R3y9CMb2gS703CpyF64O/PefTmpv2r2lZWZSDXK7P3O2jfA4rYUaggOCQhuW?=
 =?us-ascii?Q?fj6wn6BULNpF3NSaskuuDx0ym8N4jUv4Eg0ICL9X/O+Tzmib52YAY4DJ8oOd?=
 =?us-ascii?Q?bIESo+H/n5oBoThDmbba5f+6U/wMlihk8szJjO3vT48asndxzRbgU2NKIosW?=
 =?us-ascii?Q?h6hqk1paxLU6KGx1kIjgDyggoXoaJLOAYy7oEfkz+ld1nqxkrApg0aTrqXlW?=
 =?us-ascii?Q?zr8SKpJStHpN3J/TaReMm00/qGX+2uUMFdUBcwpfAhvlYc3TYy5TtGDT6Vp2?=
 =?us-ascii?Q?UlomgjFn3wBKPRfyK784fdOe2zOzhZvgwLbUE3bp40d1hN5uRJRpwAM0xbFZ?=
 =?us-ascii?Q?IH8+5sRm/Yh0bSPJzwkKFHPIrBr2S75QkRBOepM4rNZ3ig0ZUPdxTsNRmQRF?=
 =?us-ascii?Q?QSBw9YthQzNEeX4UhrusoPLvyD66MfbV4teVvzEoMly7vvJLz21vdo+IEvrh?=
 =?us-ascii?Q?VHy9dIiSoCwlOyN2sLdqrPmDEIbcnBwW2Jv2Dz8NC3Kjhn1E2vEDeTb5Erzb?=
 =?us-ascii?Q?eg8gnlcYUQlbtBeipXhfbonxPmAVsic+4qBpPZkovUbFnfyP27TpKvVhnhxd?=
 =?us-ascii?Q?ef9yJFEgW70XqxPrMDgxz0iDgCOGoJFDvD9La2+usTeA2QDEz4LaBXErOydE?=
 =?us-ascii?Q?nPjqxdWTGgo/gjX4QXOuDW3/0uPEGOzQ3QJNuvxiWNewvqtgc+Yc0MH7SDSb?=
 =?us-ascii?Q?DI/Z0AkVyfQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m3uPYSV/OpjmLAMNuNN4Dv0P44hK48urIooaB/8ahJDx49Ip4Ts+ttM3jMaH?=
 =?us-ascii?Q?yq9zuJpNcFTSG1NI0UlMxiBVptfyakoHBFflw4eCW2KZdyeWGz9ylrfIlyGj?=
 =?us-ascii?Q?DA7vOCWah9UgTdQyPxs28jFudanIyBbQvApYeuQo1MEcITCRkPFVAEzeh9uQ?=
 =?us-ascii?Q?rxweR4ZxELXN8LDMXMEzJsm8AOvJhG37JO1YqHXFuGxodnhhv2qWo1TK58v3?=
 =?us-ascii?Q?o/8E/9QL6Y+jqTg0tldDMtum1t3sDtw+Wck8r0u0hpbWZQ66p0Zfwa8YtuAM?=
 =?us-ascii?Q?muLxQKoDjdGJGAQsqjZOCiQ+6lldQRdLK+kpFJYY6C9dOri4eNmgHFeac46C?=
 =?us-ascii?Q?mcozCF2UVB2ymC/qeWmcrEd6oJLhYCfEgLfsAmzmmgcVKvQeaCouautfjDrV?=
 =?us-ascii?Q?2rVj82vKESgIUTWwsBaMpkF1oCq8epPbMVEAOA8699ZiOsLjUQl/zJD85Eix?=
 =?us-ascii?Q?s53gvf6hDpENKaHbu/YURDVucqfPMwPeQnIsEg9kEJL1vTgAdmOtfiV96Wml?=
 =?us-ascii?Q?UrOyObecFLwPoWvf4ApTPGEQLe+GUpFp8crsiIgl1UtNuFdsWH8RcZ5ODd1o?=
 =?us-ascii?Q?brehrkitf9mAWa7NgGTRpPoA8kfNs4W5yH6Kbh5c0NJMZAqd4IuDAU3QPrrd?=
 =?us-ascii?Q?ulLB3KErjRZS7ARCRoykDRLPEduAKDTSiMMVXQkIBzyMLGvpVdfJMUAvNjuK?=
 =?us-ascii?Q?+W4OzGhgiZXgaYFDhZV1zyG36QhEpX7WssJO8v8Y+vP+Jf6hvWbWhk/zPlzE?=
 =?us-ascii?Q?KSxITdyAxKQzn8WJbI2MlfIl2bxx4ilyWOeokbmYg2DwkKUvRjB9niCX/bae?=
 =?us-ascii?Q?LRMBVh7L18e+YQ4DShQYJ8MvKTlj2flIbtLIcAn83i7VK5426LAuCtZOLMJm?=
 =?us-ascii?Q?htdd8KaMqBfcevPN7qqHkkCoR0L/UaTDjoaDhjKpq1lfxfTQo0nfcek7Dryf?=
 =?us-ascii?Q?9yJ8Xoi6AZsq32c7qvZkcnBL9X09aO9cewPj7urp5cIgJ/XOtdjzpA8f77Pc?=
 =?us-ascii?Q?ljCfyfueHYmqtl8NWNA7WwsFBfSlrvt2n0FHnkTSS+Avavsiv5JEjWD/BFp2?=
 =?us-ascii?Q?YagdCDHFuzc4GVbQEdV2Cox8Ji1R3pMn9UpC/jYBcWdsxwlsTjtX9UQ64I7c?=
 =?us-ascii?Q?VdPGIxrKOYvetqvI/LVMx8YK8Cb4aPblGik4glkFIvfv+tmqU7iSooDdFEK4?=
 =?us-ascii?Q?RzcvWbmAsre7LTJYWZ2w46/W8OMSnti5iggCDo1C7eq6NFWoCJPM88CF2PEo?=
 =?us-ascii?Q?q8WnQ+RdehjtBClHkCD3WwERWqC4riU9o5NWbdRk9s1kq85XtjagfY0dchVk?=
 =?us-ascii?Q?WE0//30lMkbDBBiT6ENVLduHbq3UxvyRdS4lq/vT2QnDhpDrqCH6lbPk3c0t?=
 =?us-ascii?Q?K0Ervzo9QJoTcnpNaMcE0/5L3+Sm+LVwrjTqPTiATNU4u1hV0yY4IHQoOtM+?=
 =?us-ascii?Q?D2IC6sfSaSWNP1S3HcOQKPO1jUaxkt5m19VKPKa0W6S009lrfuGOVeGQFYCt?=
 =?us-ascii?Q?quCkAFTjhau9mQhQTLT6VBSdndY3d1+0PuVqjovedM+Lp00y5ySK68qDj9PG?=
 =?us-ascii?Q?fYKMQRVJYcKjtvqYia591nKhIjKZtUc156qtPM7G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9788194-d031-42b6-f716-08dd6af59cd5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 17:02:08.8498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Z1hhc83wSo2ekFe3xQkwyreS1Ybom56D+FvSqAJKi0w0fUY7/8SzE8FKML1lbr6t+5y4EaUWT1TGSDzWaosbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061

The rcu_seq_done_exact() function checks if a grace period has completed by
comparing sequence numbers. It includes a guard band to handle sequence number
wraparound, which was previously expressed using the magic number calculation
'3 * RCU_SEQ_STATE_MASK + 1'.

This magic number is not immediately obvious in terms of what it represents.

Instead, the reason we need this tiny guardband is because of the lag between
the setting of rcu_state.gp_seq_polled and root rnp's gp_seq in rcu_gp_init().

This guardband needs to be at least 2 GPs worth of counts, to avoid recognizing
the newly started GP as completed immediately, due to the following sequence
which arises due to the delay between update of rcu_state.gp_seq_polled and
root rnp's gp_seq:

rnp->gp_seq = rcu_state.gp_seq = 0

    CPU 0                                           CPU 1
    -----                                           -----
    // rcu_state.gp_seq = 1
    rcu_seq_start(&rcu_state.gp_seq)
                                                    // snap = 8
                                                    snap = rcu_seq_snap(&rcu_state.gp_seq)
                                                    // Two full GP differences
                                                    rcu_seq_done_exact(&rnp->gp_seq, snap)
    // rnp->gp_seq = 1
    WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);

This can happen due to get_state_synchronize_rcu_full() sampling
rcu_state.gp_seq_polled, however the poll_state_synchronize_rcu_full()
sampling the root rnp's gp_seq. The delay between the update of the 2
counters occurs in rcu_gp_init() during which the counters briefly go
out of sync.

Make the guardband explictly 2 GPs. This improves code readability and
maintainability by making the intent clearer as well.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcu.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index eed2951a4962..5e1ee570bb27 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -57,6 +57,9 @@
 /* Low-order bit definition for polled grace-period APIs. */
 #define RCU_GET_STATE_COMPLETED	0x1
 
+/* A complete grace period count */
+#define RCU_SEQ_GP (RCU_SEQ_STATE_MASK + 1)
+
 extern int sysctl_sched_rt_runtime;
 
 /*
@@ -162,7 +165,7 @@ static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
 {
 	unsigned long cur_s = READ_ONCE(*sp);
 
-	return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (3 * RCU_SEQ_STATE_MASK + 1));
+	return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (2 * RCU_SEQ_GP));
 }
 
 /*
-- 
2.43.0

