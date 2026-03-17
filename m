Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F10385517;
	Tue, 17 Mar 2026 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782598; cv=fail; b=OY9JnUu5khdxW2ak+y3JEXHHEPqm655bK76IWAUVy0a134TP6X5QyPveXE8MDWLG3d1gBTtMBDrNFQgnq9DWK9ElPDf6ZJ8t2MR0A7wWxfzqiSABdOwTEr8/wURHmI+5PVNH4xGXGSA6TQ47RZOqXghYaDxqQxPPKGRVB2zcTB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782598; c=relaxed/simple;
	bh=vjhlL3PzyQeRgwOzL+Ei+JcPfm0mVzleM4h5Oit4O4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OiqrdLUddkQMPQDnw9lty6elgx9/xOVST6zdPh1FtkFZBClyG0bKmQBLsJj/xhAK3Rr9v83otb0xuczsfaFDk/HQqkLkZx2TBBuDoFu32tgKamW2kRPqcuqfZ/ElzailIoGXrz7fb+tKgqqvc0H2W0S0kkcQ6c4ZaSE2wK0yNHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rnahMsIF; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rnahMsIF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVk3Of/fW7YuZZU7YTis2FMPps8yEa0+fxo/dfiEHL8ZZWSU5ZI+jHrVELR+/m2wRHPpxKQHfGg78PNmtMhiheO/2+V8DAC22fLod6xLsR7t9eEsIkDTlh03El5sOyiQjJJj1Nsa5kqwuDvzLm0VeJsuYu9CrxtwUxCwdgRr6fUtIIEmcXBvffUFfwctz5TY3yxDXzKYc8V7bPBCLrboTsDfQF9/Ct+JsXrbGDtBBdaWmG8yh/I0q9ZU7n9D6uv2FgkwxqOQdQl/W0W9uG4yHtPML4mzVARJ3qNQ38KcbEuNPwzsTX3l+egMcGPVyhrlqi7YPYkkVtLA6ksEJMtTfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFHydx7hiQjULHOd/DAPpjIxHkHDEx2W14JRaIpFSK8=;
 b=d47w55lpc+GAqPZo2wKsvxawM8Z37rHf3ZuryZgIlnnlE3IqB+hBXq8UKcplRguneblXZslHEXB1d2ewCP5wWXHVRsAgYqOtmVWeQeOmot341FIvXeej4T7Osfif7DKC/gwVfVo5+twKz9bDYDL7K7Iody4CE5Mo04VR1PO4k9/kxbls0lmLgnQKmsKPRsLCUqg4RP4nWypykfyX03ICuxNMJofe3IeVmsCebc4MwcQjMXvkZVTRhMbHoVXRFav3NzbcOCqVgiTtGDNh/OI3USwtqielqYE6Julv2XoMd5iqeQMsz+9suW7guAVzrehP6g2LUmqSJflmxxHqMnxdHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFHydx7hiQjULHOd/DAPpjIxHkHDEx2W14JRaIpFSK8=;
 b=rnahMsIFiVfQnPVwe7aMA7BLnRneHtCk0U1hdkZKKmV8a6pXZloQYNfU5gO27/qU6WzjmQ1K0t//UespMKyxfW01oRDND+r+gDQSocr3qC/1cAzthtHB0AlYyZMz5RZKTGMP1uC6qMKigwSH9ZAiD5Jh+ZMywIpxsL5r9L67+t9+Xn4wV0ANM4A57Q+7tYahvzju8ghmE4b6EwCmYQ7SH2e514UkbYSHiXbSf5C0Uxvm2OUeY0Cls3mnw38phM7Mh0olUSp3uAa3xSRpKDHG7/+E8p3FdyNFHJKb7UCwgFiO9gyRCa14E+NfVKp2iHWs4CowTdDaVfUWQ+Q4qmpXvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BN7PPF5D27497F1.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 21:23:12 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 21:23:12 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: rcu@vger.kernel.org,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH -next v1 10/16] rcu-tasks: Document that RCU Tasks Trace grace periods now imply RCU grace periods
Date: Tue, 17 Mar 2026 17:22:11 -0400
Message-Id: <20260317212217.1527644-11-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317212217.1527644-1-joelagnelf@nvidia.com>
References: <20260317212217.1527644-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::16) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: f4878df1-f0b8-41cb-f415-08de846b63e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	ZtppRbU3a/k17UxJORmna5vXzxUu+z2Yqm+afFncxS3cB735n00WBjvd8kcdqYM5z+Aw9p/hbc/PFqqL7r9p004LJzqM5YULbO07qn9CKs/SGjy/UocwxPYmBg1u8Jk9TDLFb0FmZ5rB5lcNiooK+unWVsqPQDYG6LHeDnijHSq76h6fX2gsCPIfzbcwqDdd1Cle22lbFNmHB3C6m009V+gc8glPAqjCtgYJDe4+ZG8PO/Q7Ka/O8advcFQ9WPrBxQdl36jmAbqK0i8LZlFXeYE8s9hTOPinM53PNz7mA/KhhBMvi/86NQMwX6gypN6vIlz3ZBdTX48jrKNYQzzOaKC4shykld2EKwYB5uUwtoZMQ/GZDSHILEpOBfOs9OG4duiITZKlm4/uhnKGirCT25esMk+5LQQ70feOlz/9xf6JkE7dHBLrHQE+h3NNjckXq75GxtD8GOmVPZvVAOlomhHdT0NjxIB1Gp0C0lV2gvt8qKBYVRV4kWgqMk5F6JM8Gmyp7NHWHfIHwpWv62ZSwcBRVF9x/WJWm3V3agV9YRbZH/nBCwjVTSzLyXaamY2zqrRvuTFEwgzcIe8QVl13nCC6S6XwZsn992x25dMhVvtAoBZ8NdHKWuZW+ldyuKz7gFEsrF6Oe7k95O1b1WmUSJ/tGJQVLu9aRI8Q1UqoIa3FHjd2Ay93jHCbP/ReBrj8KLkulkdsftqHCHs0Jdlz1OgDSr8UVklEa7W8vlChFkLjzGIlyNHs0HMr7LweYsPF62wI3s/h0WivfnO/ZZ9WNg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9hdNbMGRAjPTRwa8cDjW3NixaLkq6NVwSzK4KWdYPTQUghYwlFjPWLHTdKX6?=
 =?us-ascii?Q?c3XCLuiYVAe65Dds5Hvp9w08VHCP3zWdPFGUUbXw7NBVrE2rAfI4JaNVbdFW?=
 =?us-ascii?Q?2M+pLH575g4Vu8tuK+yB4HuOLRBcqiCU7Zd28kh3bOhuhRaqsd/mDvrxyGau?=
 =?us-ascii?Q?wX6Qyov6hmnFtbXeafjIajSBT1BO0gIaDOusIJ9IjWe8PX6Hfsh1oNvc+V0z?=
 =?us-ascii?Q?ttDCjDE3ZpPVv+UsyXAH9dCpc8X98qJfdc0wnZeX6BcDam6G5nQDUJuwBbCO?=
 =?us-ascii?Q?Cs8i0ttd4cw2qUfIvtCsAUYHSy9uy0vKFL/bXrX7TKt5b2u0w1wRsqgTlIMB?=
 =?us-ascii?Q?cxwk+11gUwZujPOUG6dYejMhuEmi9v8nOLvJ4LTqc6Al3Ofkh6a60mt5VWGy?=
 =?us-ascii?Q?93NwvIXfAKPEtuwOR6ytsayrDm6/DsPTrsvigP0jvu6TfzIBTRqfKV+s75Sb?=
 =?us-ascii?Q?ymuPqnokilALZRvhN1MZLLiZVsNDR6cCwwaUz27EOF85tFrYs2Z3vBKWXtxH?=
 =?us-ascii?Q?Nu85yp6egqkkWQAHIUm+2lLw6GaSfIZ0b/U1069zn5O1ku9qTxOkp17VslfZ?=
 =?us-ascii?Q?jRgjNj3sI0BE8TXahK5X8tHfmiDh5CTqUk9eYfF62KnVsqhK9WueTP6+GXJg?=
 =?us-ascii?Q?9Eq/IhL+SP0GLUZClIJxw8CxrW5Hj5QvonTfL5+CjGhndTxmVv4PFhwgSojd?=
 =?us-ascii?Q?iKoZk/zEW8b7d0dc1xlRM37HO/3JB7XXCeccQC3reop0Q5GNOrGMXtZmMabx?=
 =?us-ascii?Q?VUt7BT4a6tNUyohMC7JmmlIZ/u8sRPKGmiC66Kkp+qEca9YkOj4Z46yb7xA7?=
 =?us-ascii?Q?Odbk9fYVHz8i9QPOVFOTJciJrEhz2/xoXpYvV9WVfj6PC8WRUBFECQYEOx2k?=
 =?us-ascii?Q?5snCHBFJdEf41tEY4ij9qrw2dNf5a7ZD4Esp46rg+0m5GMaq9hHisLBw/wPQ?=
 =?us-ascii?Q?GgdZC9W8g8ybz978iP2F5E+Zt7NtWTjNrdw7jLGRcRcQ2S5tdHyiuthQrwJP?=
 =?us-ascii?Q?fMPMb9oG+jyj6u/sZf8tK7OpJoIa5MisLXuvUiJ/VeQPjg2AkbWhNN74ET2N?=
 =?us-ascii?Q?OBGA4Avh3t2t90lAyLTxTDUhilnr2FoIn5MJvsfEPrZSV4RrPCbBTa8Ti19j?=
 =?us-ascii?Q?Yl3PSBie6UavyOCHbR3URsAoaZf8imO9BSwIR6ybjvEhfZd7TIVi2d2ERGNL?=
 =?us-ascii?Q?IYAMxA7ZQWC3FUde2bSfODpX1V+k1Fn/J3vSnEVKzwKr8CVy+gDEhey+5N8p?=
 =?us-ascii?Q?QErLr5e9qxZihxDjrfnOA7+PjzMicepn//cM3Plc3MpGU/9ro7kYG3A2uj8K?=
 =?us-ascii?Q?EfDrHLeR2EyMkK5mkmDGfPTi+MmE1K3id44Mm5v6aSLpOtMyK5Ppe+c9JmCD?=
 =?us-ascii?Q?WgT6eCTQyxd3rxRJwIMWHlE1PFPVrbd5GRFMb6XrLDKYFMaMPq1Ht69ASahI?=
 =?us-ascii?Q?PX1VoUrPLTQTUXYPxJXrd6h/BlzE8tZ3N636hCLQ1oDy4088DiSZCaQthRLu?=
 =?us-ascii?Q?LmNtpE9FDe4GTwt+c18LyBEAOrGCAiuRbnc/tBAnXLPtvEd7oTa5tGP+/mZP?=
 =?us-ascii?Q?hGiwIhy3y9fBXPrgvYMAqQP3W4k83nQ9ChWOrHlCm3vB3IllYX7xWL3HDSsE?=
 =?us-ascii?Q?b+EABN3rNiunGOgRl+jmf6g72WlyMHlTQF0+ockse/Z4XUMA7d1Czq91aHKa?=
 =?us-ascii?Q?aFa/GyhupRcjK2LI7/7VHW1CNGlnWHcfd/DLZ483i0v6I9yPlWBFXnc8nOk/?=
 =?us-ascii?Q?FHWnyOHVEA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4878df1-f0b8-41cb-f415-08de846b63e1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:23:10.6935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9b56VNiQt1UFUAfP9ygL/UqJi1xSDq2feJ4Ew9Qx1X+K2Lm3xQ63DM6myGJGdsU6mkdNXxR99IgGdyg5fCUgHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1

From: "Paul E. McKenney" <paulmck@kernel.org>

Now that RCU Tasks Trace is implemented in terms of SRCU-fast, the fact
that each SRCU-fast grace period implies at least two RCU grace periods
in turn means that each RCU Tasks Trace grace period implies at least
two grace periods.  This commit therefore updates the documentation
accordingly.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 7 +++++++
 include/linux/rcupdate.h                               | 9 +++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index b5cdbba3ec2e..4d886e7c7a95 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2787,6 +2787,13 @@ which avoids the read-side memory barriers, at least for architectures
 that apply noinstr to kernel entry/exit code (or that build with
 ``CONFIG_TASKS_TRACE_RCU_NO_MB=y``.
 
+Now that the implementation is based on SRCU-fast, a call
+to synchronize_rcu_tasks_trace() implies at least one call to
+synchronize_rcu(), that is, every Tasks Trace RCU grace period contains
+at least one plain vanilla RCU grace period.  Should there ever
+be a synchronize_rcu_tasks_trace_expedited(), this guarantee would
+*not* necessarily apply to this hypothetical API member.
+
 The tasks-trace-RCU API is also reasonably compact,
 consisting of rcu_read_lock_trace(), rcu_read_unlock_trace(),
 rcu_read_lock_trace_held(), call_rcu_tasks_trace(),
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 04f3f86a4145..18a85c30fd4f 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -208,12 +208,9 @@ static inline void exit_tasks_rcu_finish(void) { }
 /**
  * rcu_trace_implies_rcu_gp - does an RCU Tasks Trace grace period imply an RCU grace period?
  *
- * As an accident of implementation, an RCU Tasks Trace grace period also
- * acts as an RCU grace period.  However, this could change at any time.
- * Code relying on this accident must call this function to verify that
- * this accident is still happening.
- *
- * You have been warned!
+ * Now that RCU Tasks Trace is implemented in terms of SRCU-fast, a
+ * call to synchronize_rcu_tasks_trace() is guaranteed to imply at least
+ * one call to synchronize_rcu().
  */
 static inline bool rcu_trace_implies_rcu_gp(void) { return true; }
 
-- 
2.34.1

