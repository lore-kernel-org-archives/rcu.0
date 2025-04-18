Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F1B2222BB;
	Fri, 18 Apr 2025 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744993258; cv=fail; b=fybK9bKbXJ05UXUVMf1WE0KefQEFV7TVLEtTZ5Ze0BOItgmpteFKE7XiI5VvWhuNHBhKrrSVColzByUR/ImpVutP2xbarX1kGSGLAJdJPH8CqOGO2ex0kExkBa4FXFpdCejBekB5CK4aOGmZmm5QVADQpfejGt8zg9+X9eJ12/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744993258; c=relaxed/simple;
	bh=H95hVklH24R3FlSo9lsaTw7bvUyrzBIfRe7PeltmVOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZDD7qgEuTIMjmtWT+MXipQtClYfgrGPgchV71QWn9jpW3zsReqJ/Fxa1lfbMAaiG2JjvU0tOZqdyk6509odEhsd7YSrux1hb52cw01Rf/ddBnMOk21K5GT6cTOWZu1DRdhgqYvNYjIRpHYSHw56QkQ80YvCpY705OwBGq/Ykp/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cTb6LzrT; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cTb6LzrT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXFSDnLwDmsBVjSir7JwcLzoH+6Rbwo6Bre1AzWGBsLD/ylQeVdDju34JC6I51RkYaMkB0HJUHylgBKcpIM3bIhJpM3H7fMbDOM3MjWghwXA5Gq4IUNE3cfB1bi3TJxRjAAPZvt8JNAnRAyBR3duIVOcP8GCS3rvh1xXdjZsLuPMppqOBIxSx1x6+I9oF1cHQogQwHuGeushHfy/gbUEi0FE+/2MiFCk384Lki7PXA93w/o9nvww9oEbnbIS4VDBPFWxSJ015MZBNXhBZVmVDBfukd6VYPlAztmehw88naKLlT1gJ+N4VPSYcv1brxETN33yMCeQIRC7vc52tD27dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mt3wdWcdnkChPtNzKKYPgjGTDNQrKKMKSwzqzP4j3v4=;
 b=YFgJWndn/NTjfp6pttLolqn1oz3MiJPivzJCkQ3slnIbN4I0NHDwaZJcPMKaxeAc5cV0ebRjbRkz/L5EjRQDeCbcbroKN8cKGTicxjriE6hETP2wEgTQOTa3yR+V3/qVR3gsmWzmkxKFLfrCrQu9Yvc7XCNvLZDgoJbcJAMjdqeGqrzTODLFnm+IyGIqLnX26glQ5W9H+XoAs6TNSujOMmW5RvDPSRw6LM4k3HKJxtpJKVEsrUIfB0DNvIq1Z2wLrzAIltzRN5xqSXt6Uu2MqJkq/iLZOuONyh8TG0AiEhU85FsXG+8vlurdV2cW8pGOTQdTiMv3P1y8DkN0xj9tBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mt3wdWcdnkChPtNzKKYPgjGTDNQrKKMKSwzqzP4j3v4=;
 b=cTb6LzrT4kBatvic2tcjwREWjCQ7dlByTXRBHAe2HPChr0gKEBxxHAKWwc5NhZiPuyVBemjo+LNUYDHPIaIyl1yz3klCSU8BVjvBjCDne4+5bAJozTOJdVSYcwLEVPZUy5zwWhVeEULCclHWnXRV2pjDQxafBncOU4kFEoQ+HGWwJeVLGEPLz5GNGQntetqwsOA+rKnYXMqSqMOQD3MQWJ6EqaSXR4TkO6LrjJ9BFIFl1ZWiYGgz2ZZNTDv7Y9fqLpeEBXGuhXLMvoAS0iHv2NSZEGYFI2/KFPRRQnM6dCydvZQJngwATT+WwluwmISNsOmlw0+z1jAdCVcQ+43Q7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 18 Apr
 2025 16:20:53 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:20:53 +0000
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
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 3/4] rcu: Comment on the extraneous delta test on rcu_seq_done_exact()
Date: Fri, 18 Apr 2025 12:20:39 -0400
Message-ID: <20250418162041.2436282-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418162041.2436282-1-joelagnelf@nvidia.com>
References: <20250418162041.2436282-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:208:120::30) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CY8PR12MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 595e1720-feb8-4877-f84a-08dd7e94fdcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K0QjVHvgAe2Ze1xXRy0LxJCRF+BWXdJxH+t8ynQ+pMMo9H6hcjyamHCc2wkl?=
 =?us-ascii?Q?W8j+TcLUV684UriZXtXGY+VcT5YDP/JDUMMlRGLi8ZBEb+2c2sadAaNHV5GZ?=
 =?us-ascii?Q?kUH2ne4X/1mk8DWXN2s7lRdZL/04u5jpYSH/slr2TZYSEkwPLpCbgNkyHhO8?=
 =?us-ascii?Q?IFf+GFe9SLhVDNomvZRd0P/rS8HlRfeQZimu9IZ4Ik9p3cDwU0n8wa5fLgsI?=
 =?us-ascii?Q?olFcBLPMHckvBXlZ3JCm0RtqyP7BxtwA62WwFpIf9dvrLfjEW0JR/pvqDDuH?=
 =?us-ascii?Q?/l51wLqJlDrW2Fxs3Thz33PL28Nbpd8WCVTrN8FwllJQNszMbR0DkJRHF2gf?=
 =?us-ascii?Q?RcjJTzEZjf/60IbUhvuNoxYl3IoI7DyknCkaLlMRas8Rkv2Xm6Y/M9qQQV51?=
 =?us-ascii?Q?+JL2XsPwP+aG1wMEL3DWYeCj71JsvXNbUQfS5JNciBVpXRiBECQ3YxAtreo8?=
 =?us-ascii?Q?DmwwTzJJcDIq48V7ve0aywwGNJ47V36SGkWEHZAHmCOR+oZE4W3Nemx22fjj?=
 =?us-ascii?Q?R/l/uiAfOYP85XGmlM4mBz9ceL7ZVrKHe05uO7+DR1nkgJqFTLUcJFJl4ny9?=
 =?us-ascii?Q?nn0flOskRUmnuADAfWxsEWN5yE5fPVeXa0Yd+FfLO0KyxSIuLn9eAo1aVu8n?=
 =?us-ascii?Q?SC/ektftHD9/i9TAANBo7vv7NaIVlgUIVmI/HNAYFJMZX0NcaInOOmLekSf9?=
 =?us-ascii?Q?hgBLzS/o3D4LmkIMNsxSMaxWUzIyGsyuJJ3YJWhjXrKm730jZsbb+3e7cxnS?=
 =?us-ascii?Q?2fuwARX0W1iYGKY0XaGU9zGFCH50x2Y2lQa+QjjbSf9mZTHEd8aDE53fvcU7?=
 =?us-ascii?Q?GsT1VDBgYaWeYEp6Kj8LibugR6JIkOg4uNA/bG/Qj3vamVJOXIqo79z9E3/q?=
 =?us-ascii?Q?Y3ro/vHYMVOD0RH58NvJ5R3fMjDqNzhNhTnU9TbAwfR5ua9FyOP6F7nQ723T?=
 =?us-ascii?Q?InGgsLb3sdW8ra0hMWtPqKpuy+IjxYQbbOMVRKeT32G6x1QcVSg+0aPK7gH5?=
 =?us-ascii?Q?Pm7VVN5GDkpcZM5lUbKpRaLiyMbMwCVuzJmcQySV9I3m41BZf4XL8Y7FWS94?=
 =?us-ascii?Q?7O9KhtAthrbjCxpCREhWx9iDMI0G+NWnnRh18QcLfWh5PwbwGjqgFY9jvnTs?=
 =?us-ascii?Q?6WX5KcSlH4whsL5bUXtA6iCsVQK2eNDLqejY1DqQ09U2Gw/YqNEDYuxMR0wx?=
 =?us-ascii?Q?7g8b5VbFP3HxoN+DUXfb0ZelegLKjM7xa1r9UE/pbKjm02GkfiI9JkAueDIi?=
 =?us-ascii?Q?+2+kNgIffgLHGiJ4mCF/D9Vp7z2QLAA42Kbj4gNoxS+EXYQYHR3JuZnMMBTE?=
 =?us-ascii?Q?/msLUag+bzgrC0oLQe/2cJv4F/SSfolEa39LnXIaxcuaY5vUD16OgDAXWjCl?=
 =?us-ascii?Q?7ZUG6XFXD0D6NLgIJlr0d+vcwuMElgsrFzEHfQ5SHc8QjI7QnjNonkXQP2wt?=
 =?us-ascii?Q?MI2eqYNB+VKmui3Ynf2xG2uiH2gLVXwHJ5tyQwdS7y949G0T0JkJFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DieuFv3zqipa8n5knwcYrG8cO2i9FgpPCrrf0fSJamqRR/2CsC9kRr2snJF+?=
 =?us-ascii?Q?gzXeka9El0H7R2kUt+VvuaMgiIiGXd/CZNv4oT01s4jqcWnGO5xEzNck18Go?=
 =?us-ascii?Q?ICczIAnDSsisnssq1StE/XPvSGwLrxw2qzsNU3/QtDEVsJEvRxfocEIfeaq8?=
 =?us-ascii?Q?eUBi/TshIQaZxMLN20c+9La9FdGwlojZ1RvMS0gmRCNQYkGWCkSZbpeR1AOz?=
 =?us-ascii?Q?y0yFH6qoDATwzEx2s3A3sOKh/Wy+OcN4TAwjGkQ4NIL2p+aJnsmrSGhnRKq/?=
 =?us-ascii?Q?2c8Tco+oUlsZ3IqfevPmS9U+Xcgz38wMCaSB+NP4vPGvLqhEuuKp+57PhEhl?=
 =?us-ascii?Q?lWEb+wgTcVO3a9rGuc0t2dVF6ncnLxFlSFYjOID53thIqY7LFAI2TNEr1Sw4?=
 =?us-ascii?Q?7OIkXKDXDDuuZlq/OrLbB+hUw8qvPfTC2dRZs24hhGwEo7pGmrUPdPcJNkly?=
 =?us-ascii?Q?ScSe47hRa4MxF9t8XIS/moQLPPOwdJT3DSFNZUE0NjU46KxKlLsbXWROJE43?=
 =?us-ascii?Q?N7VZ2aGqC07CtTtrQlZeKm36gwe6SIm9SuevK+zW5MDlJS0d/KeWOdCMmIm2?=
 =?us-ascii?Q?VHNaTGy58p9ayOFBC0Exu6k8NbLdMJcYYTcjHVuUtbU55Z3gDd1QYH7H6xkI?=
 =?us-ascii?Q?J0AJPONZIITHcQ5QOJFhvqNJvZp9OimCdrIPfDuUiAzD2uTMeacTkO6YFhJu?=
 =?us-ascii?Q?AzaZ03AChfm/a4QWVnXnC1X6PqE+XVmKd6F5HXObQBIEPIUUe5qZbLj1PFiK?=
 =?us-ascii?Q?aqq332hZjYB567HrniKjU0/2Kcy8EkqZ6OwGMd7JDNGkbPCK9wA6qv/UKhdV?=
 =?us-ascii?Q?1n3Ub8r5ovPMVaCJlFgdZDnVT/R/lEo1Lpa1QZ+co6mfFNA9uIVv5/DYRdgm?=
 =?us-ascii?Q?cb4p0cMpKp6O8xjGr0c86p+f8zMyOoPai3PhJeizE5+WRcp3WOglJJugqm0L?=
 =?us-ascii?Q?CAtCCQweolDT73SsCOZumEPtj2uIr3559IS9Jsdj5Jf4bSjGcJ1HX+Yw57ae?=
 =?us-ascii?Q?yzDu4GpV83sT0rFkaevP1ghPvAJCpRZSpSIdpIjpMZFFM4x2EwZ/k6dFbdFU?=
 =?us-ascii?Q?sAF4byAurxR3BYF17acx+hUw0CkRX3d7pyvozFOis68qfwTQKrNmJc6w4xil?=
 =?us-ascii?Q?CjotXkZbdI0PVzLbntnr5Dyi6/zlpcN1pGIKXsCN+R7h8sxkOxEpuP/NhVjO?=
 =?us-ascii?Q?BcDvruyA470+niVrR5H1VZ1OhlV1uN4+NImci/+KpaF3a8dbP72kQErHOYW2?=
 =?us-ascii?Q?TlC67jesTyq/ScKpVcxL910Xl8h76A7UY+4Swm4g/BatK3zpRJJplf5xkFef?=
 =?us-ascii?Q?3JbBMIUkHRE820oXJU0AARfAW3hsxo22Bl1J0+yaH9xpMoFY6BSZexd+JkrQ?=
 =?us-ascii?Q?QS5s8lLX+CtoL3RcnmBdwz4H8dAOB9k8092wjTM6TqBFU0qSryoJBv2pdwIm?=
 =?us-ascii?Q?llT139VxgB91kVvnuqOCmK4NDXVFnIgUtQP8n69KWul2BldmylEamvSZM4+0?=
 =?us-ascii?Q?Vu1s8Y8H1PuXvfX4MmSDCAsyh1W3woEgZuVb4oAhA7bbUfGQVlfgkedbjxAp?=
 =?us-ascii?Q?yFFOfsFUdXrs/oSTn56cHXGyPLKOULZgO/bKb7gg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595e1720-feb8-4877-f84a-08dd7e94fdcd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:20:53.6187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6ult6uh0hglAgSaoy/UsiKr/dpwI6lGl98A/wV+e9kzHCKE8YMtxW6RVOqk8NA9x6TFFolTWJhq3sxUyS+FSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7289

From: Frederic Weisbecker <frederic@kernel.org>

The numbers used in rcu_seq_done_exact() lack some explanation behind
their magic. Especially after the commit:

    85aad7cc4178 ("rcu: Fix get_state_synchronize_rcu_full() GP-start detection")

which reported a subtle issue where a new GP sequence snapshot was taken
on the root node state while a grace period had already been started and
reflected on the global state sequence but not yet on the root node
sequence, making a polling user waiting on a wrong already started grace
period that would ignore freshly online CPUs.

The fix involved taking the snaphot on the global state sequence and
waiting on the root node sequence. And since a grace period is first
started on the global state and only afterward reflected on the root
node, a snapshot taken on the global state sequence might be two full
grace periods ahead of the root node as in the following example:

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

Add a comment about those expectations and to clarify the magic within
the relevant function.

Note that the issue arises mainly with the use of rcu_seq_done_exact()
which has a much tigher guardband (of 2 GPs) to ensure the false-negative
window of the API during wraparound is limited to just 2 GPs.
rcu_seq_done() does not have such strict requirements, however its large
false-negative window of ULONG_MAX/2 is not ideal for the polling API.
However, this also means care is needed to ensure the guardband is as
large as needed to avoid the example scenario describe above which a
warning added in an earlier patch does.

[ Comment wordsmithing by Joel ]

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcu.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 5e1ee570bb27..db63f330768c 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -160,6 +160,15 @@ static inline bool rcu_seq_done(unsigned long *sp, unsigned long s)
  * Given a snapshot from rcu_seq_snap(), determine whether or not a
  * full update-side operation has occurred, but do not allow the
  * (ULONG_MAX / 2) safety-factor/guard-band.
+ *
+ * The token returned by get_state_synchronize_rcu_full() is based on
+ * rcu_state.gp_seq but it is tested in poll_state_synchronize_rcu_full()
+ * against the root rnp->gp_seq. Since rcu_seq_start() is first called
+ * on rcu_state.gp_seq and only later reflected on the root rnp->gp_seq,
+ * it is possible that rcu_seq_snap(rcu_state.gp_seq) returns 2 full grace
+ * periods ahead of the root rnp->gp_seq. To prevent false-positives with the
+ * full polling API that a wrap around instantly completed the GP, when nothing
+ * like that happened, adjust for the 2 GPs in the ULONG_CMP_LT().
  */
 static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
 {
-- 
2.43.0

