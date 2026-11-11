Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794433129;
	b=v4y14V4t1s+PTFPvCPV8IN3QgFpJFTBzusHdOPA+/dBWub+04iPZbCCcf+bFJV+qrpu7
	 sLzaT8bF2gZDW6wM6Lso8oNQLWCcD5hsEu3nYl1U3ZviUX8/Df6iU4Yh497SbvpqbjinR
	 0CQI8s4TRIjXuBOsbTJoF9yjj+1k707ZoQwgd0GSzNdpdYrlAcyxeS6RGRAPX42lCPk9x
	 2pt5V3OQ+qMo72TdXqmtC6KrBUesuQLgCpoEwr/w/Pxm+r4H8CM3VwuKkgKwZV9/3/A0c
	 WC3lRx3Ks/qY7z0cZ3kVHEyixgACtHeF4MTZDHS9UUnALEekZDoJ3WJJ9JIhiHFDyvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433129;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Mo0oRFz9h3nvKBf3mvrYia8/3goigfXmcVhyS/mQIyg=;
	b=EjbR1+iDvAaFp0/5ijNfrA9EqV7Nth91e3Tyr0RY7m+3q7tGRvur0Nw01QEO+xaPaR4x
	 lNqxlQcKiGCXqKv2MCb5Y/G36gAfXAwooHzghyEW90TRlRiCjGKFNtReBQAYP1ugZ5kB1
	 jArH0HFQTm4ZyxhSJYznotwMx4SmyY36iGGdDoMR7Rbkm0vswBXDo3YCLywJHsNHhxoqI
	 PL9eL8EM9AGlesRvhVvBE1YNBBcbSF9nyhbteKQuuee9L3caK280EAOAPIcVaKIYUQW1S
	 36XMihYvUyJuMhPSdhJ6Mnbr11w0t2WbYZT74Yy/LeEat4MfroriADiPMRX259nxyKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XBZfq30E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.14
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013014.outbound.protection.outlook.com [40.93.201.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1625160A2605;
	Wed, 11 Nov 2026 21:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1625160A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XBZfq30E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrFyc/D5WNix1Nt12A0zk3RYgEkR7VyYNYwPgOojiO6ChJfWIqKJvPB8pmxbINGOIl84sJy2CnkoSQivczq9jaOVoNdfyV9yuN9Nb+A3GF3T4+KFUk8IdzgRaTUQc8KjGhrZJhL1nFEnN9atFxSSMYdg+VLqWBckQLofVORNJxwJT9jKHRZvoku3nW9hSMtkygxlRtsERbrvGyBQglijB57f2CTrHF3beq8SiObPgL9/nT8+6WPkGC8JWP8DBZNA1ock/Q9Wc/8iWUnmX9f8gjPKIWo5RIlliVLsOXxbl3WtpY8QKDeaN9MEKtzKGaWZCJ99eYmOJHzstdWh4tvGZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mo0oRFz9h3nvKBf3mvrYia8/3goigfXmcVhyS/mQIyg=;
 b=IOQm8J2TRsExIqn0xUYnuolqh4j6dV1fTdBmJ6VBCFeFzYhmKhnI7Gc7VCA2cPRnVZF/Z8TdiPgWXUaYJm5rRvMLii1yEUzk7sXaZrcjy0x37XzCJaL35W7pj1vQmIgOuyHofsJR4JkLEqURySZfd+8KA9M91WRoogEVZFPQ/3y1EXOmsMvz6Yo/Keo+YQx7GNueDeHhwPhdBdRs5xdrNc/XkHsdEl7qo/708EkvvgJzQ8ZH47JYPFYeQNd+HlAhFvKUcR9PZwM7tsUfcBmPFOkPhp/kAf7ctTJB8u9GG4SE1A/2Ls2ibNb+e6Ro/JJcoHd1D0CeOfj0XxfuRDlHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mo0oRFz9h3nvKBf3mvrYia8/3goigfXmcVhyS/mQIyg=;
 b=XBZfq30EavUps+HjGmXh46hpT7xUCco4iSiH8860lhYm31PTJaFn929bTkYji7kBd0/RGdpYjeD0bsJnj/nx8exIL9dkw7PbBikrIB6KYqrEnj8mikagpON7yeYLf9V62e98eOqfyVvTKKcRWoQlRVlblF/KuuUsWMQREhywzjNRUrTg0MoaPMdvMUCQznWEw0a/5GNwkTHIArVfc78U/YmwdBo3PT+KiVQSwGFuDgYuwiLf4XRCMchCKK5b0ECiBSFHHZJgox2SqqdLkPOGqaJZcKIRRfh0o6JqZze7Zg1Z4Rgq98zmSIyUejwMo03a+D7G8yCAl84PKV7ODlB94g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 21:38:45 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 21:38:45 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: paulmck@kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC 6/7] doc: Document rcutree.boost_disable
Date: Wed, 11 Nov 2026 16:38:24 -0500
Message-ID: <20261111213826.2035045-7-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111213826.2035045-1-joelagnelf@nvidia.com>
References: <20261111213826.2035045-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:408:e6::16) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|LV8PR12MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b8012e-e745-41f9-b287-08df403c29a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|261026140227099003|261022105027099003|10067099003|11063799006|56012099006|261026121527099003|261009223027099003|261021121427099003|261028144727099003|261102123227099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	jAy6k03N/BWuiTX9uQ/YOYP+fW4ybGuhlFxfc7jNCvK4pQlvIqsII1KgPbDeDNtcZU1PJNbJqia6/HQJkG/DQve7tomRw6hilAn5v5Q6AXYTsEIjqubifRaznvlHeDlTZ+ay+didCt+u3LwZZso9+hriXfLSngvOF+qBmssNALr+eVeTjP+94L4s00+dtNryknALXTF90B6DLYwWbCebzaIGK3zJ3XRU7EdiMb/xN36BExiqEru1pExVnHQ8LNvSIAqsNvIrdx2BofW/zzfqDH0kOzPECtfQsrHSOkKNxW+50RpG7DVCviia5BKWrREjCoq2hTxdiLJh3W3unsn/G0XA951Yv2m28o9bfJlIRzcsngrhCv443PY2upHjtPfYLKYfDahPCtOzXabxYQv0JO1bpJf+Qho4x2nFsJj1t9MISmr7GWl4uniEOKnc2avscgPzM41cMYveYBdZRmtVyfUaQ9Voyji0zB6rJ7J0PLUsisW8/z2d7ci0M3D1719bJsT3ghFWWe6YYt860t0lGoxXwk6HQy+zXWrEJ/mZ4ymz5QO3IAc1V9McYJEFRaEEEBDhN759bqifmB1jVz2empjVt7GbybXfJ1CBez+YueghzjKyZYClrCnhmqEFFZUy2LD6n/s4HEOjqXIv1u5uNlNM0KszfxgtHtyCWra4ZH4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(261026140227099003)(261022105027099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261009223027099003)(261021121427099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SsHS31z4RD6dkuf+jsywLr38uCRpt6Xi0eFH5jHZ5SCJsBxDoJTDTbXKx5xe?=
 =?us-ascii?Q?q/VUUxXWCz0fHY/4lwm3z7lpU/nGTfU/hn9OArQ+Vxp9Km+vCf/+oLe3in23?=
 =?us-ascii?Q?5KnIlKbL6yPCwGnwqIY5JxhJ+FONxA7W2OKE3Ob89n1n5JkNTsN/jHbObCea?=
 =?us-ascii?Q?siHX9rwe8AuV9fjc7RkfmCs7b7nHl3Hyg91lD4D0nOqmMgt2pTJHmf+spmSs?=
 =?us-ascii?Q?DCvT5cmZ/cQuDLMG9lbOqJgwWiNkQWUax2L4sPYwgEUuYHZxf/jAJa5c4VFs?=
 =?us-ascii?Q?2byUa6ptdHguiqnle9dd8dITqJltYV79molTU8jdrHj2LptPTi6sRSCLBjOW?=
 =?us-ascii?Q?UNVzJ0xZzHfA0C5P8MgDIpFIMi7wL+oc01kuIk5VoX3zqeuJGUBSywxwzWrQ?=
 =?us-ascii?Q?JG82nYIbQg8wNdu3Rtzm3YcFPVpTfvxUi5czsYs5/crRAjOYMhZPzRXuTU6Q?=
 =?us-ascii?Q?msdYNo1GZH5WKbQAPNE/m44ueiCyjXMbsmskPUEezCEzej+CBXkjFqYzV3Qn?=
 =?us-ascii?Q?Zs4dJ/QiAcZGxLoFjxswcgInPm66S6ZWE/5fEoXsfAbWtmYJ4Tt0mU2+xNeq?=
 =?us-ascii?Q?jT5BNhdxsuaxVQMOglY5/KGxLKvDgIcmq50APEtDkiMPoSz9J8QkR8r2OHzY?=
 =?us-ascii?Q?TggEt43Fj1R9TfvZ/46V3Sti9asfEZjC3G48BNt9jAuqWWG96cC8tgez9IV/?=
 =?us-ascii?Q?qYiq/+liBpPWih2MAZ1+lJVoNyYzmKpOHe7yvu9QyEMmPAi5EsMsfHvPX5cC?=
 =?us-ascii?Q?1WYdWv04vpLFyyyQpQECr61sL9u0b4hN06L/NGkolwayCY1PhMJ6kxllf2uR?=
 =?us-ascii?Q?GMLcCFUqPqKiwV5ehR34TyObI7/Cl1Dv3yuB+yINL/QGcUh3XRAVzQhshi7b?=
 =?us-ascii?Q?YKILMLEWa+VELFPNLSReu7OF0LBnu2nXpA8fzCt8QZGKO5JjsF3EPyg8xJRo?=
 =?us-ascii?Q?Q/xKwamT3hMjQ0uHqXQRs0qx7j+/l12gpWqUmK686uTW78y7H/6NWSMVK+ey?=
 =?us-ascii?Q?n8ngnAoYnUNDI3inrgftyeqXY06Sik6A/Hb06S/J3IxVHGSDIkm27+nyAtbJ?=
 =?us-ascii?Q?N+Lloa2ETj4pGF+JFELbuz/EXHpaZJ3vF+JBaCC5fLvfCEYLwB0vxvaenaIq?=
 =?us-ascii?Q?Fu1KiagrDeuT/x9wgiPhfVlIFMFvkaNtOEZQQBZ3bLdRrM0Ukw/6DpmCdvXY?=
 =?us-ascii?Q?ETs+IEQlgpb1IC/+2sC55aGJYerzlwjCVDnnE1V0CFr0iQlrGy7RCGe0o5TR?=
 =?us-ascii?Q?e+dic8J61YTbDTw3SAz05Me5UbbUHZIA+eiOs37DpBP0pPHcFeir8AfKbIr4?=
 =?us-ascii?Q?EScUaHJs2LYJeP5ol009UFLZO2q69FXTalRPOVv8M8hx1hqn7SoEAu1RzU8N?=
 =?us-ascii?Q?BrtQDFQFtWhTfTIcXZun/SXvQkXms8fvATQuYWMihCvG95jRIfuT5QlDUYSd?=
 =?us-ascii?Q?jW9wjhOuSne54PjxnWsfMIcjReZEpqLQv++8rKqimX/bG9FuvT/iELS6TQCN?=
 =?us-ascii?Q?8a9TCbKnBsdupzXnArxRuroK80v3J8Wc3zWnZdKBvhQSJ1ocmOjJhP42ycvM?=
 =?us-ascii?Q?RH5e4KTop2OG+IFtDv3/aD2E6gInWykxoTeHq8SDf1wUVVOB8OR6DN6kInRK?=
 =?us-ascii?Q?c5+0wqkv+rAqGi1qdhdpn/c3ScwgAHNYKYL1XRBoOGMz7IA5fgN2ceBy/x8v?=
 =?us-ascii?Q?s5AklIiZG+TGzUwXx7Eh2EwB965DGOJdKFyNntoSt8fyUJLEfuIT7poC6Vlh?=
 =?us-ascii?Q?7mICyBcIPg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b8012e-e745-41f9-b287-08df403c29a5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 21:38:45.2449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6DGDMd8X0rCpFLwu2jbm54r6TzgtTSrK3ZpvXrdVZH2ana6JfVjXLq/ke4aumvjKX8pAqvqiSMjTEajhpNAiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405

Add the new rcutree.boost_disable parameter to kernel-parameters.txt.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ac97cbd98b46..8f91499b3488 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5651,6 +5651,13 @@ Kernel parameters
 			Set maximum number of finished RCU callbacks to
 			process in one batch.
 
+	rcutree.boost_disable=	[KNL]
+			Disable RCU priority boosting at runtime, even in
+			kernels built with CONFIG_RCU_BOOST=y.  This is
+			for testing the boost tests, for example by the
+			rcutorture BUSTED-BOOST scenario, and should not
+			be used otherwise.
+
 	rcutree.csd_lock_suppress_rcu_stall=	[KNL]
 			Do only a one-line RCU CPU stall warning when
 			there is an ongoing too-long CSD-lock wait.
-- 
2.54.0

