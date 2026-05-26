Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C82C3CFF67;
	Tue, 26 May 2026 22:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835837; cv=fail; b=a+PA6Krzw/9tkmqAvLcxCF5dZIRUh86kVcGRpWeWWwaF2EHlk7WXgbP9N+iYjMRpbX0IEkoBlWJiIMOWE9Cig0U6aQbJQQly0c8OOMxCeAVioxZPYJTmRsbCEwLm0UJx1mgzSEGbDDB19Why3iykE1UNIz1yS16ynoeSnyJv2eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835837; c=relaxed/simple;
	bh=i5ccyOM6NQzmv+Oq+eBJFpH1UlwsRjLK8QAgVcA9JUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JDnROq+D4m4FpuIGPldE6Bda+b8z2ntHatS2XtUc0Bk2uLf/7pK7BIsBs9HXMYWwT6JuCWacdFS+dCR1muc4npoNuOVyKFNtYILT1PPydnQVCeJAq17AQDff2IDlO1txYAy+IfcygdaH1eMtW1GhGDQOSZMznWtIVKdmw3lMD/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bxf4QB33; arc=fail smtp.client-ip=40.107.200.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bxf4QB33"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuS+mekLlxPeW2uLpcwpWvTeopPTEb+/OvlDcZd9+g7MB2NYfDD82P8dkeCL480/zoM/3PkTLftRtJ/5/5EUPfm2kt7mgfFqT8VmWTGXuE6uN3qebKraW5iOtfcSilNsOyw5ZF3IUwMXsGEjlkhIecbvlEd9O98AvrTVeyTcmWNfaUu8jFj7bPVGor0seYlBDjmWuWxDlR0svJbVQUEmhAl52u8VQ5dNPvCTN5SICYCHb9C/ULjgmeQypMb9VFNZzSlfC2/lPF9Kw8Yi6mjxmO0LhrbdV99k9f3QzHQJ69/bw4xerG7sq3uionHfOzxg+AQrBMknNg64F7MyMdf6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8caone8W+O1koWf1I0fbJ31miabks0BK1rNItW5rdw=;
 b=ccU3JXJk8wITo79ly7yJ5Ct1zP7qq9gg/BFbVUDezu8AVyVpQyHyVSVT/su3f4qnk3LX4wNLwGgz582bZkr+tsPoa6PnbZKdiiwF2liJUof6zVEIw2cmV83shgY2SfbMwde6wNecf6aJ87BrOmMJ5Clbkj9SgBgfEf8NuGtNw4o7bUXkCt6ViJeUlwnr52RDmPL0L+He6kefjxCrb0gWInJMI2BtjRVTxF9q264mu5xf/N1/okaXTHvwQXppdADOcvPUbaS6ikNnlG/dDjvRoq7o2xIXJUqkrwa7y0DrPv5XKPVQqXWwONjCB3X1+/MavELbDgR9Hz3LcbXUcHiStA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8caone8W+O1koWf1I0fbJ31miabks0BK1rNItW5rdw=;
 b=bxf4QB33d8t52ROJC18c6sQ77MRPe0dEpmqBmAIZcY0iRCr+aanosR2bjCaxMkTWDMvaCAOXKcfDL6elOB4E9wfRo0SJU+S7uvXIt8Y5VV3w6ladFWisE1h/+WttbWrsrrEEWXKSCByiIZjSSYbtxnRM4VYfUHdWPbTy+XD2itZtrAxSAdbPW+i7PYG/4TC/Q4I3ojbes0AVS4nxodSD/GCzflg3vJ5NT+IEmkTm0AbpX2koEzFwEdTSQFCjpB4wzULfuYTAmX/e8rSYK2yxyLH4VJvCyr3dH+xvcTPeiv0WTlRULQz0GkF8d09gJoUbqkQvSe3MEksfetBC/DxzGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 22:50:28 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 22:50:27 +0000
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
Subject: [PATCH v2 5/7] rcu: clear defer_qs_pending at expedited IPI entry
Date: Tue, 26 May 2026 18:50:12 -0400
Message-Id: <20260526225014.314734-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526225014.314734-1-joelagnelf@nvidia.com>
References: <20260526225014.314734-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::20) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: adf7cfc3-8edb-406c-27bb-08debb792e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	eoQ4ZlsQedWhhidRYjQUlRlSX3VVIkFKVRDQoOA+TKlb7PrN7JA/7ARqbCcOghkQE6IYZzjOnxOQmzcbwdtQI6bbY3IMxmC+SN17urYbPL1Om85b4/xhLchM5dXtikYYN1jFlkQZm0EvrUuxiCEt7p1Lp8axs3O4imwiSYvxKNMZSZ51h94zqIX2pkM8uJiycx4bJDsJaeLGmrsxo9oHZbzga5pg1DLbfor0nkzU54ZYgLeOXt8BaeJGqhx1yfcdQQuVg2maO4mEN3zJqLR1OyN+19gS3zR8nGTWF9LBQoy5QcYPoTIntVzQIbOCVVEQjeO5V2EqLzvB3PhNwov31eThdN5G3RB0x9NB7TLEMoK/LBC4GPCfZn7R2W8nfRedEsyZJZ1zgkhHawLAZQv0l9eDJtqv9/pKOWD5E3Qr+ZV5ZN2/5qS1spX1o+9tCrwvpocO5ZZtkNrqiS5Hg7a3sXWyKjeLy9vawMURIvwVBdyTCWpA5eIaaxZfqJOHtXmccX6IWxkquYi5wrtiChwE2+Rngaq97KY4xLgkHboBSLG9wWoJzI50VnXYyIGdUzf9cT+u7JaLRq0SWkMREWcwIci8jmEzXDwPy1gk65X/LV/TFCuzX7K7xoAQhc4HA8KznH63so67OvdKSqshRYae5sVmMaosjTOB+1+PQYZunzb82S6tl0leChiHGErNHILI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pWsk4oGmFgMRr56fZVRwIF94ocGNE7+m5Tbwjv3ASQC0HpdU+4MWxhybH1vD?=
 =?us-ascii?Q?kei1FX1cJqzNmoDw81uozdKdxx0KiyhlRD9cfhBr6XCXN3q8mVDIIW1H0aEM?=
 =?us-ascii?Q?WDZ/MvxGaHzohQe0zEXFV6h+WA0pfItgn+j9KLkCreM4R603mhtCVqAzcJzK?=
 =?us-ascii?Q?0vCfx455y3MHOWQRLthTixcTvc4Lc+qRslEq0gmXKSq82lGcmOorVGDUzszQ?=
 =?us-ascii?Q?h/bUNJcR+rGXesMrkZN0hrDSTNyj1Fa9mrMoXXXosWkYCQ4eSQDP5tDFKEx8?=
 =?us-ascii?Q?9Ff2Dso9Qw+rnKY6irGdc//y77ovKuI4RFmTV88k44ImYDUWKUW5OAQ0/owl?=
 =?us-ascii?Q?BvGuQ6HjAX3XgungMVlihxpD2UGNBiCQYibO7wDs/9umVffDJslL6oYEkONn?=
 =?us-ascii?Q?NaHtDgTFFTj164N3FmsDWIgxVmfOaYxoxrlfrEIbIbyzVeW6DPqr1y4P1G8w?=
 =?us-ascii?Q?sNVjR4P/HRRSLInvZkCrg4I3bYHu0ZtYyLz6UavFHSJQe1NfXQq0oJnzs6bs?=
 =?us-ascii?Q?Pzdn/IGWuetbDE0DYVAqMUHo1pnubnlub5O2GQcJSKl4YI7msH+/3QyLwp14?=
 =?us-ascii?Q?Ko2c1B4Je8OHC5q0B9pHTsGT9dug3UemMBzJWcNUJDTwjTofKClrBGxOFTVY?=
 =?us-ascii?Q?meYKJt1Efmej1ctpDrunDOyGghtTOTPKPtLVa0bFo0pmo1LtYxh+AWDOcnEE?=
 =?us-ascii?Q?AJ70QrkFUo3eZVTjTwKerYdRSAolGNlfosRpJj7MaafoOWY5Tno0Ivw26FYl?=
 =?us-ascii?Q?3QZCEBoi9SjuETeFaalYwwFW4WSWaz8Q8mjCKJSulXn82XUtYYHgL23dRiBL?=
 =?us-ascii?Q?L/0c9xTowHAODwxHDLHAJBIjRgDk+rXtvLB4+GVPCW47QIMb0d7uTF/j3z4T?=
 =?us-ascii?Q?GgSPsxhOhxaxfM2fd5lPlkdKtjjhL+S/kgH0Rgku1xM6L84fwpeDFI9XH1vE?=
 =?us-ascii?Q?kcOu3R+4iqVtuMLjmfEeuvv9kH8t3QcDr9p2SkN46MNJY+V5sy03KCkwTPUd?=
 =?us-ascii?Q?6CulyzNb7E2o8gObX4US2dmn2VMXKPBlpU6AV71mLMRr8tXGomVB8sLQnSFM?=
 =?us-ascii?Q?OHacomf0W5CUZpplQqAkbxja+EXJaS+lkBGmWtyJzt3bJDylNoN4B2rN22jE?=
 =?us-ascii?Q?vzEhihso2AzB5d24CEhIftSsPepAAzWrsXohSNo/JnDUNlqQuwmFtc1UdqIo?=
 =?us-ascii?Q?SfR+yGHme2PZg9MVmjEFHJWHTOqWC1B3qR/sabtLrWwmji7g3AklRgAxnKgh?=
 =?us-ascii?Q?Yxn6pzaemWe2hxGc38IqvMsdrfjnG/vTBso4yx4Ma7ZrOJ5L4V8pUVy3ySrB?=
 =?us-ascii?Q?qYajVQimKGcRHrIlo1zjKWHa4X/L65Zipqyl09yQC4xza5qc1iLUxVLwA0W/?=
 =?us-ascii?Q?C4C0qOdAry7RVMclmwQCe3UjLtpOvkFTBhqyVbsgSG58nbTkLnN6pjQkiwiy?=
 =?us-ascii?Q?Cxe35Bsj1nEyfwYzysCrBwkRrcR4Mt/FtBA4TJ+5fIvQSwQBR13ZuSh9E3Wn?=
 =?us-ascii?Q?pk7WDTQ/+NsEHA4B/cj5RaSx1y6jzfTTeD/nDIxEuPAFRIFl8hPpblpPtxu/?=
 =?us-ascii?Q?/9bDUybiYaLnVhNmnMY+0fTY5rVNqBpXcD1/7MFWdRquTe3A3cJgFyBR9TJW?=
 =?us-ascii?Q?+5BJSBaeqOgdNKj/ehD02+TeKA0qwk7yfuyz7KvwXTZm/OcHXiaXWUAZPURo?=
 =?us-ascii?Q?fe4eq6WzsiUdKkMJsK/iQwKqpH//6bmcX4LF0X+v0YPDrhN2gNEmc0BBEme6?=
 =?us-ascii?Q?uzazGcLf4w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf7cfc3-8edb-406c-27bb-08debb792e67
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 22:50:27.8547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJqHjVjYukjH0DXLjCaJmWCudmIE4jo7I1XQoG5LxItk+XIQLXCAe7ZqRAIs8zFXqxNFm2Yg5+/tTBGiGMN64w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353

The per-CPU clear in __note_gp_changes() (from an earlier commit)
runs only when the local CPU notices a normal-GP advance.  When an
expedited GP arrives at a CPU whose defer_qs_pending is already
PENDING, rcu_read_unlock_special() may skip irq_work queuing due to the
pending gate.

Clear defer_qs_pending on the IPI target right in rcu_exp_handler().
This makes it possible for any arming attempt that follows
the IPI within the current GP to be able to queue irq_work again,
allowing completion expedited GPs quickly than waiting for one scheduler
tick.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_exp.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 82cada459e5d..f8564a041879 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -763,6 +763,12 @@ static void rcu_exp_handler(void *unused)
 			 READ_ONCE(rdp->cpu_no_qs.b.exp)))
 		return;
 
+	/*
+	 * Clear defer_qs_pending so arming attempts following this IPI
+	 * within the current GP can queue irq_work again.
+	 */
+	rcu_defer_qs_clear(rdp);
+
 	/*
 	 * Second, the common case of not being in an RCU read-side
 	 * critical section.  If also enabled or idle, immediately
-- 
2.34.1

