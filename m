Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013057.outbound.protection.outlook.com [40.93.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DEA2F361A;
	Fri, 23 Jan 2026 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769181599; cv=fail; b=ZFKoM9ykDtaT1qxC1O7jFOKe9SOrCqlnkk8/jTdwznIXWTEfQkTYtTDKYdH/yb0FD2XDsPWq3l1skgRpJqWBWquGKnAzVv9j5I9FmynSOVHn77S+GMm+vwSaAKkNcVG88SuxpgI6RijIE5bneduHXez6p0PNog+tjaMgoEhPF5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769181599; c=relaxed/simple;
	bh=Fd9bbRzeleiSeBi8Hwg+NeL3C7bWeoJ9ZfyLyRiSMt0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=r1112Al9JmP8g5v/5d66vei+87G3qLWTY5XyfIqkX2f7hrM2pWUlhnrjZ4pdXubZboF+oGCpy52S+PhCxmi2CGCGuz/c5nxBpjpNCKTxlpHzC5h5RuS68ApWFs/MTZJZSJkSUxguSoOl4dgQ2SBYlsRDYBheAMYBWCGxXmAaspI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ou2Be+xW; arc=fail smtp.client-ip=40.93.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ou2Be+xW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLmThPXn0s93eHkwikeAIQ9BmNRpXy5PJnO904/DfeaiRB9PYlv5Q7muQdWk/z2RloOz56FjFFOfkoqLeg0yKywgNhkkeyhh3xPT4H/XCMpQAP0wXXvV5wWyd+DTaYp2hYw7+9/iYLQAR6u94zkNttgWpPCgWABZwzy7W0Ak50H/nwZUzA8G1VxVNTEBzmUtAuJ0zqvRbpiz9DTEM8iX1k+Pja64NiolHd/bEnB4/vpGhr5xkVDeTuuJda2IFFMa34VeLYZORALlZYq+0g0EC+376xrISPUM9ZiYGtuUbhPW1VtIDVl848NXEV7XihqBSFFQw2ky0B482/FIcWPqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lxwTMN9OxQWJTG64Xn6Jf8aO4TCbSQ/WPIEjxin7lc=;
 b=ksjqLvHfB6Q0DeOsWvjjAUEdQDDMjJuLYiCnlM6bjaLaoVNXK5frDl5gMqUYnpI5D7ltit4+cHZQecS7VlYNYI2dYMp+7L/maYLgP7vBsIzPZ0oyD17ABrreFlr9verdwR3dlQMvNDFGIs7DmYaJqny1Y2A2JLcSl1TJif3BBIvFf72GyxkzlLTl7Nbu62Q2PZkFUf6jL7YL973OiftLIfrg3idL3PCFSrLjRNLFHUvADv3HOmfLoxHocG9EQWYlRlwDHGsUUH71BXe/xiP7B9ipyeE7gu1/LBBP18gI43NNNFkq5L8gLBohIeXyUtYAcZ2JaYlZEB0mMclLUXvFcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lxwTMN9OxQWJTG64Xn6Jf8aO4TCbSQ/WPIEjxin7lc=;
 b=ou2Be+xWDTx6OIyj+h9tx7Fp6uycOLk/NKP9vMwCMQ4yKW6wzsjIuTJNuRvraE0zFtD7ionLLeQuj9Ms4jjGKj91F/zPT9wGuIcuRjlAU3wSfvbuUvAQ+INZa+EdYlgpfUemhp5TYE12OUMmSfwhAEY/wKxllZYWFj8/KtQFTgxoiuN3iI3+kSwMVZwdYndB3Hp2KulNxd8olh54hOi4Jd8wUy4HQp3LeaFfCjicJEF+TTmMHl73UGFfv/mV/52D5lPjK0h1SkZBRHDqSBCL+GcrYT3DQbTn+EWxxBlc0klKZOrK8BYopdv6C0KpfpzQYALp7sNVyLOZ+diXOPUQpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 15:19:49 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 15:19:49 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH -next v4 0/3] rcu/nocb: Cleanup patches for next merge window
Date: Fri, 23 Jan 2026 10:19:41 -0500
Message-Id: <20260123151944.732328-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::19) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a83c6d1-8f75-4fc8-4f19-08de5a92d929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g0Ug7YC/aR4GQJgJxdrv+qfloBqFwicTUpF6MoPW4uPvzaTWng6f2NqKyNoT?=
 =?us-ascii?Q?CSidtMR33m28cm39/q1PGclTAoIa1coZSOXzM7wiQVukaqmxxs24Zkx3LvTo?=
 =?us-ascii?Q?gGvVk44G/1s4fYHH7vqXGpKJ1iVvUysbGGi08Mn+6tBAJGDZ7nEYefTznjjm?=
 =?us-ascii?Q?JHYc9EgKSccaG8N6CDNSQDXI9il0mznx24ts+31Cq6LgcoHsqVUhxWXP80Jy?=
 =?us-ascii?Q?jgacd2wOfRvoHqq5ELEO+zFbk5CFYSn0viaJcG4i3RPztAvc9n66VjPBg2P1?=
 =?us-ascii?Q?sgnIfXsYkFui1tn7NHWJ4ZVtXJ3O9dzexSN8PUpawJF189pNRh6+penMzJn2?=
 =?us-ascii?Q?paiMjpaGgwd5OGOCIgLZckJTyYTBUJpFtfsODWRlpfRTnDK/Xg5puKzJqk2f?=
 =?us-ascii?Q?oN8wwWX0ix1D2aro+EGtEuscDeVIZ4ntZArXoPsD6egBihrsMQqt90i0SuaP?=
 =?us-ascii?Q?NDcSgEs0o56zg3PKfA8CBlUN8h9lRJ4p56zN051mW9sTS2vUngKCQPlEASjn?=
 =?us-ascii?Q?4+CznQhNd1WowGdYXDOFGJM5QUnqqsBvg3ngCyBAVDRRHvytu8/AvHT/Gc3/?=
 =?us-ascii?Q?hKcrHwUp4YoRLzId/Ovr7JhAH7Sk5ncFPLCnOCvJgZLgESNbiSU56ZNVAlGU?=
 =?us-ascii?Q?k3NRIHS+AFNawRf2kuH1bqZ11iNr8dRiDEIs00+SMhD6RAnCOWF2sjMYxHlM?=
 =?us-ascii?Q?vwSNyxT2cJyTqGQFaD+3L/KNGuCSJ9VkhTNGTtSPjEQ9jCUdmE5FLzJ+CYuE?=
 =?us-ascii?Q?Gtx6CrZdX1y53pIQ/1AOYU1m+Pp8e/MWmcLwOUkqwXP98l1Owy4xrLhnYU3S?=
 =?us-ascii?Q?PrGfKgEejCgvJ8GmxrLU/yfEyGAAKGKIy/T85rQ0g9v2pDzSfNlJlcHFSopD?=
 =?us-ascii?Q?wrZjV40fZALnvrwuoGavHc453owUfu2AndSRrreJw5ykq50uDXqN7Woi+Qgd?=
 =?us-ascii?Q?Pe4GqD9D+DLcBRa7oSM9bN4E/zxbOqZZgivbVzP3OQEqO+13DZ2y7YPYuF3L?=
 =?us-ascii?Q?cMafIfGD23zREs5MVUgIgFd0qyZavLvItUYJ/kFAWwYnILxPMrc2vErODWZX?=
 =?us-ascii?Q?gWHtqvHWr+WRY4LXwkKObdlFTXtkU0sNR59ZmShrNCGQg/4fu65uRLNHN4U9?=
 =?us-ascii?Q?koyH9i2l3mGkmp8jnSvCdwg+KspgbOFG3BhhoLjgD6LimAYnLrca1APNI4L4?=
 =?us-ascii?Q?o30kbUPrHshZbTH2CW9gmLBznBkqifWe8LWeWNQdOczbjCt5pI1g7fVV/S5v?=
 =?us-ascii?Q?gVA/etp1pHCAttSn2XlQYU0+aKL6UhOXc7Y/wai84cYn48UZwCiLhVMW34aR?=
 =?us-ascii?Q?snKgVpXWpLWp2tK8DFCrlgn65U27tvoPAO7FRb2KzgDlquxpZulNNx0EQcom?=
 =?us-ascii?Q?pwGczZ2PhH8EufkEPjjt2YSwNjxzPEFbEiecHMJ2aKyAKKAGf+Uw5J4RBjfQ?=
 =?us-ascii?Q?3fBrUNOOeTY+ujF39wVSGZNdF3+IrKWsh9sdJOGmNOprVCkJ789AYL+/f4F5?=
 =?us-ascii?Q?Dl9X9x/4QplbbR1/waRVDKJs/CvixXNgrUi4/H22XO02nKfwP+lCS0awbLL1?=
 =?us-ascii?Q?6hFuF73ea6VWcuE6Cbo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?in7vVjLdTSiCIcV9oiRSwilBUMiTT5VJH3YYlnvSLVnl8UN/tDvsq99m3/9I?=
 =?us-ascii?Q?KfmoIB455Xa2OiV50xr/ubea+pzcXGgeJNBexs4b3LDbLs6CGFM7Rf8lzWBs?=
 =?us-ascii?Q?N4SDGpj9s1KWA+nh6LjPGTWYtV6+OCTtu07ddE/urmny0Tcc2BRFyHi88rkN?=
 =?us-ascii?Q?A+c8DU5znV4yu/H9q1+ZooLPn4IS1S7aZzw9XUFOtQZB+MusluJ5mnhJf/Uc?=
 =?us-ascii?Q?RLax+Gx1aklSOQwuR2aT43xwvmhjbhZzAWPv2jRXk/TxDLmPPCBespbaoL+t?=
 =?us-ascii?Q?DPqbRHnL8FMasxASgPqpVQNHtCMS926/u+7uDUlPe67uDaQEjPPiip/RSRB1?=
 =?us-ascii?Q?8p2rLgobLia+KEfwaMLQUETR3Uh7cMLWOmE+vKH8wHj6yw3ORn/GGN32m1yv?=
 =?us-ascii?Q?ZRg1f+aNjvbmG0ciJKgjqC5yS6aVE2STxfUz75ER7eoQ8ZiCc5JMkcl5G31M?=
 =?us-ascii?Q?J0/+cEk2t42kfe+agwOgyK2+iYiFxA2S1gztMr0GJoG9j9SZVecf12BSzrRm?=
 =?us-ascii?Q?noC9QMH3y9xHKiwCAxo1O2YTa2yjgn/QGFesv48iDhfagY7StH30GOQ1yhUQ?=
 =?us-ascii?Q?KyrNGAQ/h9MYbcvUHZC20XFlEsxrVaDvPHMagCUNZHi65cfmbA4OMy7xBDH0?=
 =?us-ascii?Q?pAMLB0z8jMIL0o0wMBPB/ySFnVb9YGXYTdpcw4jdxo3QYd05FXgIt+SjwJcP?=
 =?us-ascii?Q?+Q/MVgfNgkbMYiIcfcDgkmFaLs7SeyuMXa/0xDJIVwivKutdBQmLv4+eDzEV?=
 =?us-ascii?Q?JmXADewjbT6avxqiJlMIR3JKsX6kdDfbL4r93oTlfA5P8eECrr4hPCXdGSwT?=
 =?us-ascii?Q?YKRBnuROPq2TdvxGYPSlpkj/CkNmmTxOQvbFqoSBWvS50ZMCx41/7O/FybJP?=
 =?us-ascii?Q?T0dTWXKuJNsBMs2V+JK2tS7SStRGm8yrhXGXwBK+d4s60m7+y7Vstuv9x8eC?=
 =?us-ascii?Q?BuOYcpDiM0hAKc2IwrwscXwTZEIrnrD2lB8yULk1ztW+YNUn2yDNjhgkWlBY?=
 =?us-ascii?Q?y7A/QynLC22Ojt6Rshn5VAHz5CDE8OZfA75FRuVxBRQWNciK1TzeuYz+vJdE?=
 =?us-ascii?Q?pYgzmnc8275vY5N1j+57hats2h3W9VIin9IPZWrIHcHrthfBDE4UHdrJuRIG?=
 =?us-ascii?Q?lR8xgg+8oPLtHAUG8lQDXXzLNMrQ6ZoW2wtr0CoYwzwk/Cn5dckkGr+8kNI3?=
 =?us-ascii?Q?zVUg9F3e+hzscxMxrCIKBOrZ6svOlEnesJgXJio7aPpiEsdhMBZHpK6Kj1w4?=
 =?us-ascii?Q?Wge4UaW8p9K4nWDimgUHOS4U5jJIUkRvFBJgWbATQr+1m59IiNXD8MNn/6CN?=
 =?us-ascii?Q?W9TzgmXKY5IgZLZywVvO4uLyn/FIlWKq/RX3rMmPhyhgM0kHYXORzy48qW+N?=
 =?us-ascii?Q?YBnNpubhia3f0e3WzAKdnI9NM/DrllbnNIFR84EUtF6hBVLQq20Ur3o8crUT?=
 =?us-ascii?Q?yRfh5ZzittXbTKb+wPqdtLG6ZRn0aNjIUYWVIoi3WLtw+Tk1qJpW4e4hdR7w?=
 =?us-ascii?Q?plNvxkWsIYeOxx07DQLyXS6Z0zCX+bzLg7uqCJ0HLKfNRoLgACtgmChv2fY/?=
 =?us-ascii?Q?47xUP3aI9PljximZ0d2vMseBCYCvBFAmxotfrHT5Nk38iGEs+tT6JWPA1PDt?=
 =?us-ascii?Q?TIc9tNgRfPS+e4etfVSsuE4n3ek6y8veYN+s7SWqE8uVSwEZtym9Sg5aKQ05?=
 =?us-ascii?Q?45c7fi7wgWdLrmdZyFs0gWPU9NX/0Z1MdI8hp7xJWiLR5ayZxl44lzKGcLcg?=
 =?us-ascii?Q?TndNwrbhOA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a83c6d1-8f75-4fc8-4f19-08de5a92d929
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 15:19:48.9760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4Nvm5G8sHf9zw5nd32W0/UoB+HuD/TYOm3TTB7bW72lwOLlXWyALdy5ns0TG0xb+zyO+Y9Ig/0MDqzHpcP4kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524

Changes from v3 to v4:
- Just updated change log since last version and added tags.
- Patch 2 ("Remove dead callback overload handling") commit message updated to
  improve the argument that the code is dead, per Paul's feedback.

These are a few nocb related cleanup patches for the next merge window.

nocb rcutorture scenarios passed.

The git tree with all patches can be found at:
git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (tag: nocb-cleanup-v4-20260123)

Link to v3: https://lore.kernel.org/all/20260119231223.989409-1-joelagnelf@nvidia.com/
Link to v2: https://lore.kernel.org/all/20260114173154.1701056-1-joelagnelf@nvidia.com/
Link to v1: https://lore.kernel.org/all/20260101163417.1065705-1-joelagnelf@nvidia.com/

Joel Fernandes (3):
  rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake path
  rcu/nocb: Remove dead callback overload handling
  rcu/nocb: Extract nocb_defer_wakeup_cancel() helper

 kernel/rcu/tree.c      |  2 +-
 kernel/rcu/tree.h      |  3 +-
 kernel/rcu/tree_nocb.h | 80 ++++++++++++++----------------------------
 3 files changed, 29 insertions(+), 56 deletions(-)


base-commit: d26143bb38e2546fe6f8c9860c13a88146ce5dd6
prerequisite-patch-id: 34e2542a49252718ee5d865e7e3a7229cbb13f25
prerequisite-patch-id: 7bca160efb737a0511ad2104ab1a199753e8cb19
-- 
2.34.1

