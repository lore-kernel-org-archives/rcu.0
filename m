Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C0C39184A;
	Tue, 17 Mar 2026 21:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782607; cv=fail; b=ChGvPUgYTw0aSXvVe1F0GkSdS4i37anm/+u2M0HhDzzJ9Hux3i/dF/FeFyh0+0tlyLVfYsXVJuJQnVCBJ7oEC8LzERnd9JdSB6pUOC5IYUKZxr0qauX7sU5arsdQMtba2xtUfU2y6KugK7nQT1i3qGMMp7zbPF1/rRU5ylz2cEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782607; c=relaxed/simple;
	bh=OfxUjIIoPZIgp++LrU1pNIUDdDEFSRM/b7Na6yUNtnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kmvG1bCGs0iuj85sZDo2XDXvALy4qVY3lwjL7WM/Q/KMoXeH9IiZOZZaVufPMaA3W3jdoqsKROoOqipz4PzuVVj1/QrrcEzl+oZx46BWOSARFCkSL2svSePjRUBXcZ01K7wL0ZovWfDnAdMwYkorD6Xlg+7zcuKVGBJFOi81/FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UYn1qlz8; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UYn1qlz8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBerAcDBRjjDDfr3zcJiRuLdsyelcSDuqunVMgj7IiB1hGPIy/+ZAnzmzLXPeKzRjmMN2a8EfvcYjXKUfkSNwp686QMP2Frj3UBt24rHsCidY761RdRUad2sAFXy2ROp5sIhz3/YtJd33n5PL9D+LA0M0i6jMryW2DYTrbhwXqRFyhhDTZR/2abxlmlqP/KjMbEvkB/OOlg+uZv/UTpWdKpLzqE/bSLfGMBtb9uEQ6qzFKPYYInjY4/w5uWDbiNp5pujFuFBhxR03a1Z9im1X3uUappkVzElVrRAQ/i6R314UKrSrngfMWJTc2AxYzb59ZA2nYe9v7rcPAGmYi7jkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gM0n93+4zd3jsLFQN02B3ly3etDUwhvs6UodWa4bDSE=;
 b=QXhehpIgusDMKk1ZXz50BdwSSn4R5i6q7lUXz/p8T/73WlZbPBdQf/JPZG/NFf+jAUSUaUDaLTv+y8yOWCA8JhuOJEb22GN/09p9cpjETWKT8DDg2csORZEcNRIzgk8UGV9XTAPVY7nQGz9/fbsFIQi5tsrda4cWyP8llyGCYbGFIIGi2Fa5tQqp8ubR9/ojkxWSVKnqejtUStmsRtSbvDGLSxmsls/QhtrxXktV8fswdr30E+wEdxN8/oz/GdazXol/9AU5nDtj+3oncLSJ9foksoIUPCBZlDEG9J0h8BlW6FdKHn2LbAl5G/OHIKqzQqcgoTS3ogHdoqrhxmDbrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gM0n93+4zd3jsLFQN02B3ly3etDUwhvs6UodWa4bDSE=;
 b=UYn1qlz8v+BrMFlPOoVIF58R8nwVvVJGFTF1GIF+k/v3IrDtrtABXj58FtEWgVRsM4tZyr/8cmmN0tgrKMt4pyOyzsDaLpyX3girm83H2LQgIemB+MkdLK3492xmSraSnjiZ5RGUPPUmaOyH7aFSxt3pDfDrp/YGZDjslPjojeOWYtNV32RXKRdKM3So5Of0eoMMoXy3m8l9uRkSzbApFWqxBhr+Q7yFn80mhyI9Geksj8n+0fn8gQRsgtfstN4hV7YMBMeFfgbDsSS2IdGyFk3U+7YM1OfMernXHzxkNSZSRsI+AcLtOR+Uviwq4cQbJ3vSy2JK78GKvgbc1VZ/ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BN7PPF5D27497F1.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 21:23:16 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 21:23:16 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH -next v1 12/16] rcutorture: Add NOCB02 config for nocb poll mode testing
Date: Tue, 17 Mar 2026 17:22:13 -0400
Message-Id: <20260317212217.1527644-13-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317212217.1527644-1-joelagnelf@nvidia.com>
References: <20260317212217.1527644-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5P221CA0109.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:1f::21) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: b18a3295-1b1e-4d68-c875-08de846b672a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lnMZOmojsfb48lYu6KiF52E7tvKUBg58eEq6zr4Q1KsXnW6imxQ2tLy5WRuZmOHvbEKYxK6qLjdO+dV5F0aJ3q8UavVMveaWlmDIXrj5cKFPuiyGC3dVadXy9hxzbIfGfpeOOk1xYThVcmlwujzAlf2z7jZZib2wxcO5vhrrajiiGmoxXss57gsSwOfCdadAdigPM1IuNPrj7NtFncEX7ZdmeqtFxyQVg7+1VJdLLW5pPuVuqrxkxIZb+cMOkjjdzU2Tm1OUdmH6T9P2Aj+8Jrv458aD/SptxFWTmlp6W73fb+yfsjsgX4wkvdo9hHanGZIMCL5wO7Y2FC49bDdwgtH3//jl9xPEeiEiTp1xsHDbHNKBQpiZfVzQTTh1WK4uxbPU+bugrxG2QG+BSm/rhBqIzXqgsPSBq8su72psT3S3PDOBBsro/Fx3VYZLaDWH/H5+YrMvVZPGZq7vb9ZJ5CmnHl0p9t1ToewYKt57eyGx4l/2/mpSywBZXTQ8Fwm6hKTk47/PbZ75bvCb/EyNzKClwx7Ny7HHbqrXYku1BP2n76G7toLR/7nmOPOLjYLu6nvBzfJ3nO2YfriMA1SJw5hbXFSM+ndoey0WlJQPOiXpevKYoMQNnhUkn3Gl0l7C6nZUO/qs+71T5he3uVBCei8doalara8srakM3cpQOC7gXmHHwo8vQE9LmnFXukf81VShZ2kpbEzgc6vL4eeDd6UbHAOj6FqKANTdhWz+X/Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9IN7dn7h9PdQp5pPUfaUv7cn4GgJCqISPtB9lX2ZUy6as/FCQRQ3va7h0j1Y?=
 =?us-ascii?Q?OTwFTYa8bc+X6s0+55jDszYqc4Tt/hjVXvtoeQWzVg/YxneYeHhJ8UKh3KCK?=
 =?us-ascii?Q?EecHmHDe5h+FcRa1uiPLFtiRXb2lCHMQDJ2dkwpPU3MBA/JHzr+0DbUWHh4I?=
 =?us-ascii?Q?S+aab9sHQYmIFd2AcCtfQv4rsZtY1mgdii3OZ2SwsAKYqJYA/6zwRshVoGkh?=
 =?us-ascii?Q?9sZNvlsxdqXb6UD/ZMwcbb+S9VWMbPdAgusjFYoAisunsJcmBbEhqAW6eO3u?=
 =?us-ascii?Q?4dx4WvOe8PiBF7xD7Iwrgbv21vsMdPu6WKvM7kyia5qF+HHgwuoTzJL9M2d5?=
 =?us-ascii?Q?zO5DjIOuIgUvLibB+R4M89OpOFxod9hnRM2yN7rMGH+8nbjgUYe21Rr2Io1m?=
 =?us-ascii?Q?NNWs3YY/XB1emVEWyyhdHrzbbhgoLEgAOisrglVtrcTmNJDcsGXapXuPzAFc?=
 =?us-ascii?Q?3DGJ0moNbPNWx5poYf36M8LAAZT7DweyIbvPJ7Kq3YRLpDWGVDrYF+pl/g+S?=
 =?us-ascii?Q?YUDNLDwvkgck4KmUXtF16UjLiH3kkU2ot7iGe9k6PJam2FIaFiG8Gmll286s?=
 =?us-ascii?Q?7ssrLWb8rLPRU1RceIUKFCZLkT6vHvecBe7BXJcsND2RjNsFXtG0nfM7c1hY?=
 =?us-ascii?Q?DngSOACI5d9ZRemTLFPk4/pm/nlYcdaBHnAOKXD7q9eMLNX8gjWmk6/MOCV5?=
 =?us-ascii?Q?vExzkFEKPtEdoGS4U/yXySWDQ6SnqopGx91CchEdsBF/TPXrvWUVdc/zsNJ9?=
 =?us-ascii?Q?W90KivjTdlccJKMDH1gmuqXkChYJl/iw7IdpzGc2Tzzk1CVArPFrM47IKZu3?=
 =?us-ascii?Q?Q6jYz8aXYA6d3tsiRplFVrHStTQDG4pYriAtNIwjHGS6S2hM2RQMhAy05GqQ?=
 =?us-ascii?Q?IPlZ56hG11k7aQoDEu95q4YS8HyhfHAYOCwjp+qUt7qR7NCczrnpFf/pQMNi?=
 =?us-ascii?Q?bTnaqVgEMCDMQoHSRQdPz/yncZh3YKwWzA0h2xFJeqaj3GABSimbMi8DfPC5?=
 =?us-ascii?Q?FdvisBo44hA1sCoXNDuy/7UaWliGHS1/bOC+sJXpgk+JZpnDtXX14X0AqGki?=
 =?us-ascii?Q?ccrlXedfmTfUEv/GjNgFIE+HM0CKW9z8izXuaaB20GnEQGfdZczywFdh/J6e?=
 =?us-ascii?Q?e/fB7jSS2zUkRELqpQKeHuSZDC5I15Uh+CBUYUoSJYc75mLciAuLEFFDq3Tg?=
 =?us-ascii?Q?2fRlGOFzmh5j8mKnrs8RKjNcnxeIU0EFkdcPnuk3AcvizWx/Zj/dRbOGSsGt?=
 =?us-ascii?Q?iTlE+uici3QAFoDfX2ZZZYapzPaSmGhrcVeEbZ6dP6JGO8LP5rxZpbspbpCZ?=
 =?us-ascii?Q?RyoHK3TdFWVbSov5hkv5zh7b819jZylp403KuXgPm+ubSavsaHlEmsPI0LS6?=
 =?us-ascii?Q?4xw8pyaVPzH5lwwe+Q9/Jo8kvD2ni+bd5Wgi+HjV0e+sVdsZiTDGvYh8IWao?=
 =?us-ascii?Q?9xYVkcnxJ45yZ2AuL6lNJEGO2Q6Uu9GF77aWL+rQczOI361WYgPigAef1VJn?=
 =?us-ascii?Q?xTaTAqDys1MT6NvFirV5WVQr837ZcMF5DeYQfwAqj669+zkjCUBA8C6qZ4xN?=
 =?us-ascii?Q?hNGRI/H7hTVLw2KrBPS5O8yrN+Dvtz/axphq8DBodlqHoohWBszQlvZAO3PP?=
 =?us-ascii?Q?9eBXs2MaG2dHaQ9eS7rZ8zOhJyyllveOaktJ72EG8b1U29E0p+pcSMQ8LXUi?=
 =?us-ascii?Q?H0XP3G44ls51vdVtUa/3nLhiryxCPxAQiHrd8wxy7PsDH+/AnIEMVTXemFnm?=
 =?us-ascii?Q?EICZweIQQA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18a3295-1b1e-4d68-c875-08de846b672a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:23:16.1588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcmLnJINKXNS4DnAG6iIEeAvvihgsckOODk8nrqk+9mfyM3ElKIT5n4J7W7OZuMDjwy5wzUdHaHyq2xCJQYKpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1

Add new rcutorture config NOCB02 that enables rcu_nocb_poll boot
parameter combined with CONFIG_RCU_NOCB_CPU to exercise the polling
mode code paths in the NOCB implementation.

This config exercises poll-mode paths not covered by other configs,
where callback invocation uses active polling instead of kthread
wakeups.

This config is not added to CFLIST to avoid increasing the default
test duration; it can be run explicitly when poll-mode testing
is needed.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 .../selftests/rcutorture/configs/rcu/NOCB02   | 20 +++++++++++++++++++
 .../rcutorture/configs/rcu/NOCB02.boot        |  3 +++
 2 files changed, 23 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB02
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/NOCB02 b/tools/testing/selftests/rcutorture/configs/rcu/NOCB02
new file mode 100644
index 000000000000..4c2b8cd6d8fd
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/NOCB02
@@ -0,0 +1,20 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=8
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+#CHECK#CONFIG_PREEMPT_RCU=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_RCU_TRACE=y
+CONFIG_HOTPLUG_CPU=y
+CONFIG_RCU_FANOUT=3
+CONFIG_RCU_FANOUT_LEAF=2
+CONFIG_RCU_NOCB_CPU=y
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_RCU_BOOST=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
+CONFIG_RCU_EQS_DEBUG=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot b/tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot
new file mode 100644
index 000000000000..c212ae299b0b
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot
@@ -0,0 +1,3 @@
+rcupdate.rcu_self_test=1
+rcu_nocbs=all
+rcu_nocb_poll
-- 
2.34.1

