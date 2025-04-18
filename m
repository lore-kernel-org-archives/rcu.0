Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276FD21B9DF;
	Fri, 18 Apr 2025 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744993253; cv=fail; b=S9JPnsLHosuKDviKxicVo6NoMu+fI+QneneQrH9kDtkrdL2pxFtgHdETQD/lTqeIfVuRahKlYBnUCUeLLsDIcTD40ZnU+6DGTsEr6IeSQGjW4NDcpPCYlDrc+H28YjnlGPhoyzYVdyzzy0vW1hiUdkCSQiFkoN4uD2Qvg70+EsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744993253; c=relaxed/simple;
	bh=8mvPBLBnX8hYxLA1igFTLQ3Kqg/m41KHzWjUN9Uq+xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ufXxyvLpilrv8b0sdQ6cMs/zOrvGjsxv3bBlJ3fEGTveqVUdQWSt89Nqi8qkg1LAW7GTGe1TZOJuAxMaKzKx+QB5aKC1dLmFnU7piZiXMDNfn7793GPb0o0K1tqZAM/GQU8ry6sWS5Hcgoep2G6zhfLP75e9AB7ue3rAdnGKgK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pa3bmmSF; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pa3bmmSF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GveWR5AntM9uklh/DZscDN20oaYPnyuRfJ2PmD920K946PsDg0ClcD6TL0T++j7X661wlxpJdExSMqMZhJUzzoJa+eRA38D0YzJNh3kwL0CLb2k02tropbZzXHJvSKHSROmdNp7eA4xK+jZSsBAZkC+PdV/5umm9rzFqwV42RTDr/3EWdB2Ko9fAx7YxrkUzL2WRfRKrNeLUwKkauTr/s7hBHltwjXEs9aOeZ1ikv43TegL1y/5+MoIXMpOp0zVzZRTLqV0fue4VJ/vbXJWt+FUN8fgY8cg8xrlO/0QKBOhdjN6sTylGWg2U/72/CWkgAgtrVSNh6g7zlR8eWrFe2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xf6A4icAUxF7bH99Eyn44zlzuJv3d2q4qSWWDEvfb9k=;
 b=PxndpiboX8Klr5RKNncKxx7wpg94NpHbTOJuqRjdXlzX83tnAVstj+vZtcIqo/upnF9GSr4xBbpJ0sbjjydXYZPfd5EdtF2o3fqfTtXwz5ZQKXIik/pXLxB5mk0OjQCHLbjqoUFm+hRD5ypRcpbBLhK9JxG1I6ZIlys0vEzfpwpH0jdIsRltp0yqTUnEfLXFf830sY/YQ6OU40RRw1qw8SFP8GmRkCz0xMihWk70ntbcpme7LYS+CRTGz+o6Nmu2DaT76DCKxeRpu8PkxAlvEd9ilV9OIWrZzKVNDXsZrQFFZ5P2qRGn2JS4A33brUCjIq+YYqv2Te/3ck5RmwNBIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xf6A4icAUxF7bH99Eyn44zlzuJv3d2q4qSWWDEvfb9k=;
 b=pa3bmmSFcaRHe3alhz0Gm/eXvqa1mpr/WIKsF7qG19iPbioOlxpFMowULV89sBRKQA81sovDKQIhZyGqc27Y+lzCk2mybZbL/OzzEXTrrc6ut/q3FwQgKfYTPSxnRIY+sA+0uAzvqUNEIdYWGpfMp/uzRPzyflN0JcPiuf4vGgCZNxFndJQsFyuW2Ro/cy3otmpZ4f32Rf7nNHBN8X7tXqxZVKAMldah/GM8tRHLTHgeCGSyYdL8OzTJez/L0jnRtfNBjKZzYeRE0AYDV+aeEftS8YukdOO0GdFtatuvnzGlfAS57rYFZXBu97RvSZJvShqpww/+4RvPVG7S0dOiuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 18 Apr
 2025 16:20:49 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:20:49 +0000
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
Subject: [PATCH 1/4] rcu: Replace magic number with meaningful constant in rcu_seq_done_exact()
Date: Fri, 18 Apr 2025 12:20:37 -0400
Message-ID: <20250418162041.2436282-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418162041.2436282-1-joelagnelf@nvidia.com>
References: <20250418162041.2436282-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0344.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::19) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CY8PR12MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eeda875-b35b-4ac5-1c00-08dd7e94fb14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RpTDYE9hikjoBz7YG91k9Z7FzgBuiAFL9ahNzbHjpccjb7ZSNPodYKD6rdNR?=
 =?us-ascii?Q?A63/JUguKho5jKRd9jfkukVHbFmFhjayQY+k+tBUG9KqZeTHBVIZHgCp78/u?=
 =?us-ascii?Q?AIvq2KBvEUFQ7chGaFyc6ixqmOL9/wWzsoNKwjC+u4/ttsIhSGD5dXAYqJxq?=
 =?us-ascii?Q?jrisHylUOzayq26BmDsi/F7KA0Ls0dfTNzVh74f6P5FazQWTAq/2Z8wQlMpx?=
 =?us-ascii?Q?6G0Xy3Z4o6bKEeoIaCkuT6XdquDRxlhKq/LQP6Lt/t99MSQdIjewaEoMlBVO?=
 =?us-ascii?Q?PYNrtybrfymjnPQ1E/2F4r04gor9ScPskx6jH97qj9syjia0OP8jzCf40v0H?=
 =?us-ascii?Q?TI98yffMLh939eJbXp4gmVUjFxaTP4WcwZ88KCo/xxOAH8vX+HyIvkyeXaBh?=
 =?us-ascii?Q?vTvBdFUns04fQG6VQ6twdW/uHPgk0PBAAc7YHf+zkAmQeehm0kFJVCE/XyzT?=
 =?us-ascii?Q?LLD5szOB56ayw0oayG696/f7qCLa3cHW60z3+18B6vuY5O6lVsOwy3dB8wtA?=
 =?us-ascii?Q?Y1Jos7UMv+nOX4Zg3DFL3hAi6l8DFuw8uvvgKR0yaHDUVdyC09ebPlDN8rhV?=
 =?us-ascii?Q?Lx9pc5yIrgTGh/HHkT8R6szhcHEtJwb6xToIR1mmM4ZbcZ3xfCef0YN2+3rl?=
 =?us-ascii?Q?zAu/kIxRYksEWR+pQRMtZnrbJLoi5h4Z3BLz7YZbzqWsu+KEWVjrQsq842ta?=
 =?us-ascii?Q?X8Ro2Kwfmn3eOOlEKSHNdLrUdXIsyiRlpZVxa0FLEl0OGQnh6e5xrHJvVEr1?=
 =?us-ascii?Q?aGBz7LNPzfpiAoTmQUiZmvMHuG/Bv1+Ozl8fykBHHzexSHYsgcecBg/pNUFN?=
 =?us-ascii?Q?U99SaqAJdY8h4NUJ5FciquDnWR+GzjkewiG5F5fI0gwN9/wBbFyvbrEeyxR0?=
 =?us-ascii?Q?FaYuAYhCCth6HAJQ3LTqT9IWT3iAbLTrFwUKiQDwqprrGZlMqHYFyAs+qXRf?=
 =?us-ascii?Q?IGZbxTJsM5YXQ17EFzaCjruWEA4FJZSYpGdQQHA8I1Gwy/p5ru/uXeh19BTk?=
 =?us-ascii?Q?uowR+YkbTrWQ1pZrSv3T88ZKQJlt9J1CGUKvQ3ghQheReE5JjJo9a5FiDEBr?=
 =?us-ascii?Q?D5ECXuFUXKIazmv8GrNmzbLt5a+tdANxO2fVtXM6v98WMsgRbZDMZmpkvZne?=
 =?us-ascii?Q?5bnLaMo02ol7MDic5V5gJfhlUrTpuPiFP8QDFdsLn5X3snjLVEDgZG9SSaMK?=
 =?us-ascii?Q?+bCf3ZXAubh9UM2T403JniA83wOzXEuZhsli/VrU0/KmlkIgBryPn5/RK1hn?=
 =?us-ascii?Q?oSX3UB3UqCTkyVca8YuJFQGEgnXWedvw61O0O+O8pZ4YFUUMuyuhJi18VPyB?=
 =?us-ascii?Q?JOAEB+48kuFSA/wfEUKlXRQYoxLstWCeT7NzQ7zbm0fvSW3sjAeu16eYDIaC?=
 =?us-ascii?Q?/blvo/tlS5RJBhXr+5d1hc0AHjBgm0z683hFgw32VY5gjiIAiqD5jeRHjO3X?=
 =?us-ascii?Q?cfa96pi4z2u06tAIwcMXvPG0ywvJPnODTg4H2ZGp3AzZoSkF2Q4Wjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gj74o9hj54cMmT0aB++vyD1ZYDHidDd0/4esnWyK9HqOXB0QJ8l+8emimBya?=
 =?us-ascii?Q?024WBuQLbW5OzZxsksdvuMflP8fMx9hvXN3xBlf9Mw6xLbvfSKyFBpOjAZOD?=
 =?us-ascii?Q?dVaCziRGAmpVuPQQo8Er1y0xBC/1RrpFiS3YFIbDoGmoAjTBKRAJNVF5Ydye?=
 =?us-ascii?Q?N6iH/pKK4Hr9RD54lTfPKQo29aPgvARCgqr1lFlgZ2Yk9SE+BG5iOjYQ2jzM?=
 =?us-ascii?Q?NCyUc2yUsLlhJopxNSMbBPRm634MZXeeDNXdZF7WPstIJH+J/3bIFfpCFKvY?=
 =?us-ascii?Q?mzQbP7ubRzzSAytvf9gGTpJNpZeuqV2ghfBiwvBYSrM8pofwgz3wbmuSUwAI?=
 =?us-ascii?Q?XKCTXKWK1i0H9PS40XSPkcmRPfIqhD5webf69Kl4KPqhpa5k46tWVOofOuct?=
 =?us-ascii?Q?9JJnPL6KnQbr7ZK41AB/SAj90Dq0if6c2H8ot5AoI31pujJHlXa8yKWoo/EH?=
 =?us-ascii?Q?Jh6KWqO3kXJ9D1xuE/WDbYgZSz1mHKpBbjaQW7SUAsaishl90GnJop1dkKAm?=
 =?us-ascii?Q?mEEAqTqvRJbrAZ7LSBk0UiSZM2qzdPXZ5xpIj++KXtxOPvyiJdeWr8LfnQPr?=
 =?us-ascii?Q?A3gWwNkXej0VMO1JZo46jczvwoUTLFao8h0lZFAg2AwiqD2jdRv7KSg5/twK?=
 =?us-ascii?Q?CKj1av7JehOLA+XR8JBVhcj5Z18xTLkh5DP360aYS+qEGRiTFISvPsaarf28?=
 =?us-ascii?Q?hdBb2IKw33HiKt18pAJDqF8WvRih+EKEhA3kZeZalDcbklffiNIog0T2w1lR?=
 =?us-ascii?Q?dmCBZX9jI/1PQOacrh5uxYgd41DSTs34Jpvnh/By88cnkHKc9rsyxtqbmoC5?=
 =?us-ascii?Q?bFJtmoZ2mz/DiNXCDXUCG5cMr/z2gguVok+AWAQ+V0KtREP9WFtfejyi7RUy?=
 =?us-ascii?Q?hl2lt3Mi3Ud7JII0gSnHZlw+6A1NyegNTsIAjaoZEDFqD8MTojFTXr+Q/Jt6?=
 =?us-ascii?Q?srC0bCSPzqL5XEdE1wvWGh8kxaEBWE7agFyeW9Fl8TVJy+upRPx2R0fhhsVv?=
 =?us-ascii?Q?qL3VwPjPZCr+J7MwM703sUUIX/qBllJe31P5sP/aE8yyq8EJGeW9iRchbr2X?=
 =?us-ascii?Q?8gZ7boMZxRVhIXydbXKxgvVLzS6woPgR+wBOnB2kU61udZfsr95WgyrKe4QV?=
 =?us-ascii?Q?XEzKAmCzH2OZZp6kCCWokwpqK80VLOXi/g8Ps77Tfiy+y0JWORNLGPQ5qX4p?=
 =?us-ascii?Q?g22dzJ7WWivycTzw34gaBV+rNfKaWoqAxFzYOC6OZEOR8PNFtvrIr73ZIFme?=
 =?us-ascii?Q?GXfumw0nS+8wS1PJHvKRZ8lo7u7sA0AfIoezWOJya0su872bbcEj1mgIS+SR?=
 =?us-ascii?Q?PhXnqttnNB8ZF2u0VWn4JLax4SAvp6d4I9kV2ksf0cQBeC6wsZsVuDMYp2jM?=
 =?us-ascii?Q?2Rnbpw19lZcletnmKVAKswSCJ7kXawKstZA3ZjqSnUgRJ0/9j1VQ25XZecdl?=
 =?us-ascii?Q?7sKxVA2KdXB/JdgbscgGwFgZdtPhfbmJG8VvxI2iSwS9BPsQy3lRUnaWhIcu?=
 =?us-ascii?Q?t4rcqepmplzz0D5xMaY3IWxdvYIdfIMAk1N2NwQ4R14xCQAq2pssCcG59s3C?=
 =?us-ascii?Q?bwSzJvSWH8ZAENEKPjg36n/dfWwnvs2nHQMjn/IS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eeda875-b35b-4ac5-1c00-08dd7e94fb14
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:20:49.0348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPLPbivDEw0YfuUYCMUT/sxo8jGYid10WqcsMzLf0fdosXVKmSymugH/BGxDNDB3/Uw9l19P+4hfzqMvXid4DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7289

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
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
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

