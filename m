Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD84A2DA76A;
	Tue, 30 Dec 2025 00:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767055300; cv=fail; b=qpkaMmXsOysaE7bbLGdRz/OykkxKG28jezAb2BcNFDdo1anAvLNKbFmiC+1gSDUx80513yfK3g5MXuGbgRzsgVlhGb/JfQVkugvMukb+Yte6raDXIe8Z324DnkXSuoyDl9TaPR2e2cjswLlRD3xH74YQy6gWE983Au0DM3mXjRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767055300; c=relaxed/simple;
	bh=QM5/KDNH0Dqwjpwv3ASdFyEF8Y92YWlgn8holtKeJL4=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GZpFInv9yFF2vJgBwCLyDlr+lQ4YfwPWGXawyeljO2nUpAKfSse0om0SWN/ZGcQhleoUmnfpfLUGVsleGZsa3SlY7YWRZdkKX1XvsGVtMGGCxB5wnFaOU7oUiQd0E7Yzb6tDaC2tvZLgSy+7ZXNU46IuyHGL14JoDrM9ISkdhrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iMWCas5Z; arc=fail smtp.client-ip=52.101.48.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iMWCas5Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dv8khNNKlynAuOW8Ri+CCL/lVQqlTeygYU/0vNTxsd7PWbTq1G5tVbxj5MKJGKiHDhbMvuaLaexF9Hpf2MqahlDoiwuvV2ZnyUZktXujqonnu9zXmkmN1bFJlT9klfXsoTptaH1LHsCbAiG7ryF3KgEHAHE6C0GlHvgpDUKOS3J/DjOgrXZd3VXpLtUV2KFGkLnZJZfpZoG250iFVr8JSr+dPLPAikeT1l3o8w4jIiPhuXPy1dgWycWBhOpkQsSJm3v5ZlhTrP4AnSFI/fvabF/5lE9ge23GD7A44J9jIx9DWlcFErhPLNp4Fk87OY6K5kPsPcdglkpOukvGaD7bcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6z0OFg5dAkqr2XG3+XpyWujbSblQbzWTPOqi5XgTuE=;
 b=MXXoQ5Sb2i9wTMPt8i0V/DaD9pWndaqJ5rUa1WOgniizePTUbzwP2loDLvcVW4YGvzL7N6Z8Wty7O7vapuplgL7/7l0dGCrMdQ8V19Zjm5yY2WUZ+kjnn+2eAK7g5SQEcaEHA9NBgWhm0Ryx0ZgIH1FHwmb2S/XIn3PDfFbAEoPxRaxZ0soR2BeIYO0vsR//nKCbgYWixDCTnpvVAv6YOi12s6RrfKUlac9RYQzT5g1waCKedHp9T5RPUodnukaYzyMp0TWi1QkTDZOU80kpyUThw5cqKn1eSNUuBuRoinQhN3EF0pKJQLRtx/tEIXAL788kSnkhA3V8FzQd8fko2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6z0OFg5dAkqr2XG3+XpyWujbSblQbzWTPOqi5XgTuE=;
 b=iMWCas5ZuO7M18e4groqqYQRNtHxyOSyWnV5QJESWaJSGc83NinAkBi6tvKePZ1Ms93WurKVmesQx+eA6GT50am4VJyAu1uZjOvza9po2QkT7KmZqEmc3d+K5fYW9GqrkHxTVDnPrL2I48dxJ2PFGsVjSt3JIvUnal2ouc3DIQY4U26AReqUQhSqnDD1YPU5H85yhbflTYbn+2gCBUVHZ+HGtEmyfsLOhC1pESf7hLmcTM2x8vnENH2TPDVvoVbv9jEEc2F2gqR9mSv+GoFqWH2m/g8pFbqhXjyI6IyEkrdljW7Ff35Wy/fbKvXDW4GsYTwZhlB2nYrRgRHkohCDaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 00:41:36 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 00:41:36 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH v3] rcu: Reduce synchronize_rcu() latency by reporting GP kthread's CPU QS early
Date: Mon, 29 Dec 2025 19:41:23 -0500
Message-Id: <20251230004124.438070-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:32b::15) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e2a673-74c2-4930-752b-08de473c2fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?seeT7ubP1lPkbSgtwzj1No/H/K8vetg5A8iM2uBbrVwMB1p3MZhuaNQPY/Wl?=
 =?us-ascii?Q?R8dn+EcieFuz2TuCdCKegDqHjKZAu3KkrGVRhJAXBSZOQxh70nycsZi8p/8G?=
 =?us-ascii?Q?8On1Wvve+L++cpWPE5HlnSOvjMTOjgeSLuvXrCVapTgMe89/nkyFj7K0ZXHq?=
 =?us-ascii?Q?fQ/adRLkw2WWTFYzrxXwuiR3ME6XSSMKDLefKrfty5LZ/MAAKgLR2U+sS0c5?=
 =?us-ascii?Q?Y3qy76oUw0mm9uSHF+bGgj4K4Sm0ZswahhVzhZZaIQjc9IZUf2VXOc5rMeBr?=
 =?us-ascii?Q?zT5RX1Lk2st0AVWuOmvbSqJr2QoXSTpPZlX6QgcDEx3Ot6Np5Cwy4hIGZJ0m?=
 =?us-ascii?Q?MRR1lERdoB+SC51/CBuWbeRWyvfbcAQgTuSN9hchJFwhLvlcLEVHafI7Qx0+?=
 =?us-ascii?Q?YWzzufO4x6qlZCp5knFoyGCy/Sb15CJg8eVHDbOtyVFjxddlOx0z2c6dSjXI?=
 =?us-ascii?Q?F+Wpj7fykMZhRC7EL0/96Bs+sX9lmnesc+HfJFj1mIyZDdl0BKApbdhTQC3+?=
 =?us-ascii?Q?1lAmz0wS0PNBDF2ZEDQj5Kmtx4DLc4yjXGqD7+6AASbvifu1gb3q2QOOLAeW?=
 =?us-ascii?Q?sJAdx0tXJT9zvsLGfmJl2xfw+lSj4S/IBFdO+p33CZHsFTHVdGE2kBqdj6XK?=
 =?us-ascii?Q?OO/HeZ/7AxmToTH6WkOix05u5lwsrXd06FHf4OEQaNNy4rkDo8huPYOendMV?=
 =?us-ascii?Q?mCXgfFACvXUU5Xn+0sgwhxKtsxqlI6YxiIpswe8vu/GtG8yar4qXHsZpf6wy?=
 =?us-ascii?Q?nn2Xg32P0tpxAp0W3IE45AT4VvLsleZIBqCBeNz+kg/J9SKzdTfdg1CaDWkv?=
 =?us-ascii?Q?pnlmc9r1OSRVGZ4nul85z0352MCTq+VVB3pRV7xaJAcJQIhpzpb/vbRC1gaS?=
 =?us-ascii?Q?s+PufAVXzBLZ0xYqRhZKcgbkAnjobMyxR9RJjyK8F0gvyeij0NV0Rx5nlIM3?=
 =?us-ascii?Q?jJe/6h50/WdU+YXT4WZGkdDW9r5zWZlQuxn4AUqEpCFMAO/wo+6bhHsUQziB?=
 =?us-ascii?Q?hspo+TZ16vmnvXXTJqrpAI09EC7W2E0kZq6K+e5XROtYNjjKSTJyOKq8SNJJ?=
 =?us-ascii?Q?R9fZ1rPKdx5LQYNVwXIyh+iZmceqFQZdBKkqeg1SInOOci+G4CSloNokc4Uq?=
 =?us-ascii?Q?vwy3kWX2NX+KnCG6nB4Z1CIrDPllFaUuS/ZvAr6y2/I7MO+IYSPvzlwEayuC?=
 =?us-ascii?Q?BRvbk0Cl7M8/U+oKfVvn55Inm76Aemjgp3GpaOrcqrw3U/YqLm+uyWywuOFD?=
 =?us-ascii?Q?DugvTovGTRfw/qgV3m6KrLoEBJIuWBLcCukoZKBUVSmN4BcNLQFckRWEZ49q?=
 =?us-ascii?Q?WCvGGgnnj6WDsmFLCuJGVz9RY1twgnQyiF4m3xnm7P1StJ4i2HIza22sSWfO?=
 =?us-ascii?Q?31bqRpNIlEaIyBu6Pic4Te1c+fbqBYpUKlghW6hvJS98AzuObfp1/gc1M0FK?=
 =?us-ascii?Q?w1DCckP3vl1BCkF3xuvhmbJd8etdOgGEbMZgwwQzI5pkXvgDmabfGVCPjDGH?=
 =?us-ascii?Q?ayj8mtAJBbYC/Ug=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r7CLT7cSf3BPPE29gM9NkABHuIwHPCtkeTElgrN64y8EcyZLn/oHXYts7v6H?=
 =?us-ascii?Q?v95fPpTlC5QO7JFHlbU5ViNdl32zXuD+HPfb050OizEGoeba3PXI2NwoaFHN?=
 =?us-ascii?Q?/0m+PKBTn6yuE1siQMEQ1NzvjxXdFelj+u3bkAzlyE3eDIUFrNcQqQkB+KST?=
 =?us-ascii?Q?ShdTvlhA6z0xD711623C4ww8AgetnUasP/oXrr/OqdNSxpybkaJKhF7kR2N5?=
 =?us-ascii?Q?vS0ibjH360ywzWSVU1STP+y3usP2NvXy/cRqb3qO3IEIZeS+2pytsxDfMLnK?=
 =?us-ascii?Q?YBLTT6V4qiniCax7S2ZcVqB6gqUl9kzuRo77iSfmgx3VKAKkQau+nyXXVZdB?=
 =?us-ascii?Q?4TDJu8IdaNep80eyWRCBCXDvZ70LrkTtw6r8p1TB2Fyr79oXxV4aI9epLLaN?=
 =?us-ascii?Q?E90weevvPkssNe6/087qX1+A++WZQum7cW5FpQ+NsXW4TwfSg2UqV7Uk02JB?=
 =?us-ascii?Q?wY1mHIFQgbb/1LU9XdCsuKfpKqi2Sc/pmjogsyd5aBM7C1sJ/5bj7+logAD4?=
 =?us-ascii?Q?nfLbFZzKNijjbwgLVQuma02baJBDhAycozOcxp8ewh47l9cjp3KNyqmLuIFs?=
 =?us-ascii?Q?sY4Q8tHHYGXjAn8S2Rfs9kBIktiOn2qONT9c5hkx3eObtAHd4FPcwujHd4eB?=
 =?us-ascii?Q?pIzzCumkgDSRnl+mFaFW+HK7nTCL7KsEl9TJg3HfCIsUSPsWM4lCdKcEX0bH?=
 =?us-ascii?Q?lNtsNNB19pOAUN8ORDoXqeCgfe2NVYl5kgG+Y5AUUzVpjam2aiGaiobrjN64?=
 =?us-ascii?Q?vOUl6YN4bOYUlxGSrsk1VaQLMH1S5q9kF3veCixvvdTgQinm5Bt39ic54TiY?=
 =?us-ascii?Q?IvG/hYALvgJjRx2r0Z3R7mEM3JZGx1730UK6kldr97jyAxEeCERHnFmBHIWp?=
 =?us-ascii?Q?zzYhhjJYJ0+NFxrI1MsoVvPE94zY+jt5KD0ZHnMoYxFYqSPFPkRh3zkEB7ZM?=
 =?us-ascii?Q?IFR1HlCfebQjPUUkKLfCEHaKpOPFFWCk8NJgFPOtWAzu8U8yWjyC7smaGp5l?=
 =?us-ascii?Q?ocHylJDKqZW3VKWBeaGdtnF6igheZJ0/gIWJc0SAryduhIVUFLSUmSE3x7YL?=
 =?us-ascii?Q?j255vZF0lH9h47pz+vUA6Mk0xQbff1kxZSvBThjLF9KGqWDFFaVi9Kak4NSe?=
 =?us-ascii?Q?kwpn/2FP6K2er1HnEGQgUkTuama0bADcKf9sovXeiROrxUDIaVnkIQvEc9vJ?=
 =?us-ascii?Q?PEEf8gyJh8S2HU/sXdNN1GDxrHTOkso+0aartI1o9vvIkMo9o9dv1iGbWk8A?=
 =?us-ascii?Q?H4mG13w5Zq5+Qf6nn+ATrNPKRNjttnwAekc+YLZsZD1B6DzIf4Qz9Ld6MY3Q?=
 =?us-ascii?Q?pi1M1ZhlTewOhV2GUjNwXUjPxPvHLagu2kfsSlTpvoFs9x9KljLbwkfBZjYI?=
 =?us-ascii?Q?7n7HE4ux2RNQeEUtTcqjMu4paGVNxI2XSYnIHwbz/WbBj2ZlRz94i2Solvql?=
 =?us-ascii?Q?cWBr5haidrwjhXOT7syboqNkLrCSDNH1GyXHrGMHSdAvzIrHkZqIWmn7D3xs?=
 =?us-ascii?Q?d1cvPBdr0AfItNTGAPOTIhxPk9fFS5woQc9TpM9HWYmVHsfKtl7Hexo1pjxZ?=
 =?us-ascii?Q?uxr57zc58iBjrp7KDC3Umm42+rpbvTY7rsBgYrFRYnwZXUFDUkHXskTISHyi?=
 =?us-ascii?Q?SxtiO5fi7KDimTVmuCsXVRdKIQnL+1DspYELyv2MygYSMquvFjB6BSRvvhQr?=
 =?us-ascii?Q?HDxPm7y52SEVW8ztMftmPex4lYTsXECBVouKbCRdfRoQX/mO8jUysn8xJvQU?=
 =?us-ascii?Q?QnJQWiKkaQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e2a673-74c2-4930-752b-08de473c2fa5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 00:41:35.7757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zk7y2p64Rd9OEj9nxaRiWJLQWvsTI4KQ8SD1B1kGkJKLe4WLmMD2vft5Xx1mk1TEYT5K3gmHkg9Q0H+yre7LjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7558

The RCU grace period mechanism uses a two-phase FQS (Force Quiescent
State) design where the first FQS saves dyntick-idle snapshots and
the second FQS compares them. This results in long and unnecessary latency
for synchronize_rcu() on idle systems (two FQS waits of ~3ms each with
1000HZ) whenever one FQS wait sufficed.

Some investigations showed that the GP kthread's CPU is the holdout CPU
a lot of times after the first FQS as - it cannot be detected as "idle"
because it's actively running the FQS scan in the GP kthread.

Therefore, at the end of rcu_gp_init(), immediately report a quiescent
state for the GP kthread's CPU using rcu_qs() + rcu_report_qs_rdp(). The
GP kthread cannot be in an RCU read-side critical section while running
GP initialization, so this is safe and results in significant latency
improvements.

I benchmarked 100 synchronize_rcu() calls with 32 CPUs, 10 runs each
showing significant latency improvements (default settings for fqs jiffies):

Baseline (without fix):
| Run | Mean      | Min      | Max       |
|-----|-----------|----------|-----------|
| 1   | 10.088 ms | 9.989 ms | 18.848 ms |
| 2   | 10.064 ms | 9.982 ms | 16.470 ms |
| 3   | 10.051 ms | 9.988 ms | 15.113 ms |
| 4   | 10.125 ms | 9.929 ms | 22.411 ms |
| 5   |  8.695 ms | 5.996 ms | 15.471 ms |
| 6   | 10.157 ms | 9.977 ms | 25.723 ms |
| 7   | 10.102 ms | 9.990 ms | 20.224 ms |
| 8   |  8.050 ms | 5.985 ms | 10.007 ms |
| 9   | 10.059 ms | 9.978 ms | 15.934 ms |
| 10  | 10.077 ms | 9.984 ms | 17.703 ms |

With fix:
| Run | Mean     | Min      | Max       |
|-----|----------|----------|-----------|
| 1   | 6.027 ms | 5.915 ms |  8.589 ms |
| 2   | 6.032 ms | 5.984 ms |  9.241 ms |
| 3   | 6.010 ms | 5.986 ms |  7.004 ms |
| 4   | 6.076 ms | 5.993 ms | 10.001 ms |
| 5   | 6.084 ms | 5.893 ms | 10.250 ms |
| 6   | 6.034 ms | 5.908 ms |  9.456 ms |
| 7   | 6.051 ms | 5.993 ms | 10.000 ms |
| 8   | 6.057 ms | 5.941 ms | 10.001 ms |
| 9   | 6.016 ms | 5.927 ms |  7.540 ms |
| 10  | 6.036 ms | 5.993 ms |  9.579 ms |

Summary:
- Mean latency: 9.75 ms -> 6.04 ms (38% improvement)
- Max latency:  25.72 ms -> 10.25 ms (60% improvement)

Additional bridge setup/teardown testing by Uladzislau Rezki on x86_64
with 64 CPUs (100 iterations of bridge add/configure/delete):

                               real time
1 - default:                   24.221s
2 - this patch:                20.754s  (14% faster)
3 - this patch + wake_from_gp: 15.895s  (34% faster)
4 - wake_from_gp only:         18.947s  (22% faster)

Per-synchronize_rcu() latency (in usec):
              1         2         3       4
median: 37249.5   31540.5   15765   22480
min:    7881      7918      9803    7857
max:    63651     55639     31861   32040

This patch combined with rcu_normal_wake_from_gp reduces bridge
setup/teardown time from 24 seconds to 16 seconds.

Tested rcutorture TREE and SRCU configurations.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 78c045a5ef03..b7c818cabe44 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -160,6 +160,7 @@ static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
 			      unsigned long gps, unsigned long flags);
 static void invoke_rcu_core(void);
 static void rcu_report_exp_rdp(struct rcu_data *rdp);
+static void rcu_report_qs_rdp(struct rcu_data *rdp);
 static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
 static bool rcu_rdp_cpu_online(struct rcu_data *rdp);
@@ -1983,6 +1984,17 @@ static noinline_for_stack bool rcu_gp_init(void)
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
 		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
 
+	/*
+	 * Immediately report QS for the GP kthread's CPU. The GP kthread
+	 * cannot be in an RCU read-side critical section while running
+	 * the FQS scan. This eliminates the need for a second FQS wait
+	 * when all CPUs are idle.
+	 */
+	preempt_disable();
+	rcu_qs();
+	rcu_report_qs_rdp(this_cpu_ptr(&rcu_data));
+	preempt_enable();
+
 	return true;
 }
 

-- 
2.34.1

