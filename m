Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013057.outbound.protection.outlook.com [40.107.44.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB373376AD;
	Thu, 21 Aug 2025 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783700; cv=fail; b=OyIE6pNicM3Bx1lg9TCW/s/ROSeTA1Yd5/3BShLu+u6QMOLgPVYppytnETZZugkNDf/vvCfDdNqk+Os8KlXhRgemft6zsx8sRPyyS87vesdFA0T0w8N4MKccqiiPVECjYQ3Xgid8K3Z63b2/QAiLAs9I5WX/UhJUPf3vQFgGPCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783700; c=relaxed/simple;
	bh=l+K3NKZUlFJf4KOqXQu6eL1nZGfUn6pA/gmVuqASlp8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FVgTSRZ6PvSJENazj6pMKKIE2m5w+T78RmeFuPvn08h7IxAZA0S0xhJ16i86Z3fJu+Q6PKlehePpXUA4yjiX2TrQ//TjYOALpGd6LzJXt1TqqLnGG5jwgQFt/VMTH+Nq5qjE8/fmnJ8kd+BYJ3f7RhMFF55n9ilco3Sl5NUksHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MEmFYPiP; arc=fail smtp.client-ip=40.107.44.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MEmFYPiP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brtyNafCJXzprjCBX0zSFYLjoc/IGWGDPaQf+/frF9Ma5R5MXHiCG5tqIaCOB1YrAJv8l50Nq0NLZAZ+xB5/7t23xViVZfdTOb3BiCWfSx0A5hU88YK+jh/b+xaqKJcqQLFMFqz5L3rw+3RGjWFz6ilSCACksoAMUzLSTJXxoNCA6miHxORt0XLb7IE5uUgHhxtgnHXvFzzCu7hVCHDqvqZLsQLE76acZjvlGNJ2K/K8j/TNJsupa8xB51fBkGHKHbTvmum1Ux+rO/DS3OPellO7hTVUu/9Z7Psy1RBCzil/X1aYVnuwhXjZDRFFuRyAdOD6//yHAXSLMXb9vfZvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbwsEHPLOY6/gYW/FxK7bl1uB6xtUzezhVdMUnOtH78=;
 b=CeZKcNTtuJ/I3rxlIQUKK8B0L3nzgMgPKCKzp2Ei7I5NY5jd7FHB943tZA5hpTAeh33votm7yL5CLjcBuJnHYNj2cnzucYPNN8A9cZ/N8cNAJLtk/DsoY178aANAZMDAYPUOk8VVyQ0d2258EzyuqiJI0LU0ANqdZtCmavpFftnvWlJ/pGyQS7kYsTK5YS97t+jq0ybO19OB0WcTPmkh9GtqkXofosDrJIa7hDMd6pKstc2fcjwlnGBO0wDR2Zpdhn0rkQDc6wXGHyirGxwNlFYUSEg6skZQTdGEjop287Nd3XEshDpHHl+MAWFdcMQFxQHX3NKu/36RLngdOH1yuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbwsEHPLOY6/gYW/FxK7bl1uB6xtUzezhVdMUnOtH78=;
 b=MEmFYPiPufGIjzwcEMJqH8rZfFZ7gzsyrC2CRoegOTVEhjH6fHH7I7AKXBPIcF/dQwOpWLGyN+p8xafVEcXRAHisx+oOPj9BUx7+N+INnDE9vS5Vtjy8NCb1F7G3A8xEC9XkTsXngknKnizlr39kOyx3brOxWYnLRtwX62w7WMhjxOIZi8Wj8NTnZDGxUVVz/gOtg1T/gMV0Ly3E60U69oFx1wf2EU+nbbGWM+CBHBJgMxvY6GvJIBdlFplGdpbAwLNPFFaDhfm6rQ0J2GkHSGfCC9jwC1+kSgdYqNMBQleC+Do+3c43gcot4S6TdtAxRwdC5UjGixFkFOt0CF48Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB6215.apcprd06.prod.outlook.com (2603:1096:400:33d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 21 Aug 2025 13:41:30 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 13:41:30 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	linux-kernel@vger.kernel.org (open list:TORTURE-TEST MODULES),
	rcu@vger.kernel.org (open list:READ-COPY UPDATE (RCU))
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH 0/2] rcu: Use kcalloc() instead of kzalloc()
Date: Thu, 21 Aug 2025 21:41:15 +0800
Message-Id: <20250821134117.6347-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b8c3705-0bcf-4693-c046-08dde0b86f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JOVu5C/8cpvcbm64Qm8tNygvyhU8FrCXfdJK2AyLfjU+J97zQEx42/R07hnM?=
 =?us-ascii?Q?pD9v+CWZYn8iNMYvNNk0dKnUcXLSsyNbMTh3SZB6FsE33mgEXwEdB5Sltwhk?=
 =?us-ascii?Q?sku5KISfbRgxQ5Au7Sma1DhYLsnIab4uAIlzVJ8ZGU9ytb6o9oKw/4chjWH5?=
 =?us-ascii?Q?inu4FLQx9kmPwfcYwFXa3ImEIsbczqnO+KHdIsicOLRh1x5ra4nYZS9+Lxy6?=
 =?us-ascii?Q?puepknBcKHZvlKPOJ4LGTFxhWexE1rP7ERrnzhIk/gWzqu0Ki0nEJlyV84ZX?=
 =?us-ascii?Q?we1ebZL14a/KKAFIDzMjJHnKIIbBlrwj8RNfQzg9x/FqV4dS7lKbVw27B6ZR?=
 =?us-ascii?Q?nBwYeGJhpogj6bioHS9VN6R4993dFoA3SQvHiy2//bizqc9GJGoRvSlTEM6x?=
 =?us-ascii?Q?HXGe7LPd+7BwS1H4rXA5wSYrC8KM3erII5dI4K47+GskP/9PBSLe+FJJWkK8?=
 =?us-ascii?Q?lrWyznj6wYPW1D9FI0VUGiolk+mnvl8CjBoV90mG4GGLSDJAjbUEOmFgs5Ns?=
 =?us-ascii?Q?E03UlT/QDItAwwHivSVG3zU2R6xHrJO2UMDwDHhdWCo+3rec6iVxJmdcK6nJ?=
 =?us-ascii?Q?QXPZsle86R7754TEGtgwbF2Z2gkeVlvHjdDpTFhNSMeeETc9eoP/55aJBQuH?=
 =?us-ascii?Q?GbIKqYYm1k4EDAH1b3KC85hr84MwHoVch5h8NPBJTjRwi/pvtwYfb7/eJZWe?=
 =?us-ascii?Q?Wv47BfO7c6KUEkUqa2gbXCq0jBETJaBCBn9uTvSJ/NTFJ0Hxk7kflvzB38gU?=
 =?us-ascii?Q?ze9DqQL2CjFy53kK1xsWIexHWieNDsq81cB1Lu8fQaWhAcMrZB1rHu7/AcIG?=
 =?us-ascii?Q?/bOD4gdsi6UeEhIJvHfm+Kqqx0U/NcsjM3d+IOVgtQ3avBZYgRS5MeMzCdA3?=
 =?us-ascii?Q?Q6IzSMeQMdAgdy3fczRB71OHOhxgS644v3AQm3NKPgJDKfzFyeo6aDYTW8CP?=
 =?us-ascii?Q?V8E/0nnNeHhsT5ot3S+L4t1UN22b+oIxsP8dVtCU/H9eYksUTRrgTYOAdXL8?=
 =?us-ascii?Q?qS9QQFU7/UF5rHqxapOYI1ojONxJ6BlwpUtAu0dpq8ybJHfBEkAdkgQF+JPm?=
 =?us-ascii?Q?k6k6A2G03xnTm/QGNpJcScMxfiuYq5aabTA0LNSOHH3feaQ1qdpR+NLbNGEy?=
 =?us-ascii?Q?qdSBd4rjTXBohxakMKPxIjqgZAszNApKpy1+d3gaCcGKzHhskRR3bymiavmW?=
 =?us-ascii?Q?gPsXmpPCu5Hzl/NxjJOT3wQCqb5KM0CQBJu4PHfNX3CixXf8HtvGZk1J5b8V?=
 =?us-ascii?Q?i2zDLBDQON4/Nk268XResMe+SFNEuvm9evhxUFpHlyGrj3dcikhFf6JfonxT?=
 =?us-ascii?Q?G1AI2D1dgpGq9NsRApaqCK2P5N37UWGV53dPc1Rqzi9LMzwHImRkhWadicdg?=
 =?us-ascii?Q?r5JHEmE7i2EiNgBJf3V5djTOQLIk7k1IReCoZJ5ESyofjQBxbBVZGLDSA1EF?=
 =?us-ascii?Q?wa0L5Po5WfuCrCzi5UXvJRPmtRxt2WZTZnQz5XF6QpFfCWx6SNT11LKXydgM?=
 =?us-ascii?Q?9gHXrZC7pVMy/Xf6eHgrRsBz2VaJM9yMkKdo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?plEX4rNkScV93//AZV46cyezoEroygcpPDwf37jiQta48tkcWJ8xx0bHVSdC?=
 =?us-ascii?Q?mwJ/fSAsXVe42dfyC6p1QUOjk9Vk+BJsX4u0CI6SEZp8DxNxyHp7l5he/AJd?=
 =?us-ascii?Q?fw4v6Zx6MNZDOyfZ1/Rg8UrqW6i1Q+beE56s7I5WI31IUScqb17wNGfsZQoV?=
 =?us-ascii?Q?BgeupJnqRxeETITIplQ3OsRbkePZ6dq7DbQtqJovgi0yTUciMG5+MdXFBZyl?=
 =?us-ascii?Q?88Z907x/KE292qTw92ArR7VHl05ln5tCSEl4MW4qGqsCcwHPHq6WhkOac6YU?=
 =?us-ascii?Q?ybVFXog9rbrRjHXScoUOoHfWIKoztGG33lnylM5w+FtUVd00mMVN2kzeu3wz?=
 =?us-ascii?Q?NWjPp0LMhldM7JxPvgPncnaVn8q9HGySdMFfu7399JrV/KmukRYFNu13D4Ur?=
 =?us-ascii?Q?C2NTLyjexuS+Tl+gq1LYZ7g9voJsOdZ/JSlR+1YntQhp9AueuGR3AyEQVrBd?=
 =?us-ascii?Q?91Df48JsB80gXWunHM+D8AS4T5I9GtDfwah/PMMgXEqDRVb1iFE9prTK+BJ3?=
 =?us-ascii?Q?dqnXjanoR8tOReayAxNGBtkvHxfCkZVZXAzVAJE1bCk+qRvyFuY/G1vjhUkO?=
 =?us-ascii?Q?u17wU2iz9XyUP5xmkGhr2Emoa1blkxbRIY4D3gXmUB3iEGR3flXJtBVWr3tB?=
 =?us-ascii?Q?20aR4rZqE/mvFRuB/7AZ3CMWwYYIdPDnlzGTw5eDNYS5GPReigMqN0zB2mTt?=
 =?us-ascii?Q?LaCgEwz8HlmM1eMoHo19dgvwSxvdgJHXC+Zs/7ytQjaYZmBKOu9R3m54P2Eq?=
 =?us-ascii?Q?hiJBd3RMALL4qDHlSAgwCDW5X7dRsZTuWt/heU4xLsJnQLFw/gOKR/mavtvy?=
 =?us-ascii?Q?OkJHKSse1yahoD3D3zAqOy4lEqrZrtgH66DztQLNnyMrGiqRaeDRNOdQ51TU?=
 =?us-ascii?Q?WUGPhHo9NyJ/t4PweMUeZCg+wYeWc4r5FDh4gknm0LlPHu2UuZcY1cLi7M5e?=
 =?us-ascii?Q?yEmsucixu/ERdGboOUxjmFHrGqc5ks+wBoAW2ctS1DHEG50NQL+Zo2tbinZH?=
 =?us-ascii?Q?OiGiXTvxSv3ydEMtQFJG+QE/ujsJrfCjwEeeFZUP+Wc2l1rXDH+n16HmuZI9?=
 =?us-ascii?Q?3vxCsudr0OCJBgCSaKbCm5u52xQh3Y3slUuVbfSC+OVOfScQE69EKKnm/sNp?=
 =?us-ascii?Q?6SosMKk0CnB3b3PtnCLqjo/jgiFQ1C8gtdSplajuCdAPQhmUr8C0ChfzxtyH?=
 =?us-ascii?Q?sJO9Q/FIj5Nd0VampltKUh6usJNzbSgA7Ha8UzhQjmjH54ZXu2MTFeUefGBn?=
 =?us-ascii?Q?cqFKhHg15pV8Q57lZcGdO5sDdb/2v2PATYIQfijsQF60Cpm1HZt8g+ttEnzQ?=
 =?us-ascii?Q?LqM25GZGsIbJlt6u9jJLSDLQu21UPU+freBKUJHbmPf4FcbzQwuSTMZXxtrm?=
 =?us-ascii?Q?PqlGlChzTP7poN/beroHe2hNrxtIIA8u5KYq72bmUYMKaYtXRvwMZdts5DPG?=
 =?us-ascii?Q?T4x87Wjzqxv+nBzqh3LFlU5mV+zDRWBXBumCxdLbwRdnZn1uMq6POzpXrewx?=
 =?us-ascii?Q?GVBWtLUqSreV1tnsBJ+ZFCUzPk1RvCV/oIKo8X2JdQo1YkWK/vLwyybxml75?=
 =?us-ascii?Q?ZtfJ2KCGll50AuIQ1thKUKIflLkS6GBm3ALxEJUt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8c3705-0bcf-4693-c046-08dde0b86f6a
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:41:30.7726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3+VfPW+6Ms/GK7XLqxZATMViYs5lyFJq5U0KA6fW7h626i4CrHsEocKTkeERIiY/8v2nmpWVhpKzYLt7DnSrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6215

Replace kzalloc() with kcalloc() in kernel/rcu.  As noted in the kernel
documentation [1], open-coded multiplication in allocator arguments is
discouraged because it can lead to integer overflow.

Use kcalloc() to gain built-in overflow protection, making memory
allocation safer when calculating allocation size compared to explicit
multiplication.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments #1
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Qianfeng Rong (2):
  rcutorture: Use kcalloc() instead of kzalloc()
  refscale: Use kcalloc() instead of kzalloc()

 kernel/rcu/rcutorture.c | 4 ++--
 kernel/rcu/refscale.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1

