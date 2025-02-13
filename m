Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A472040AF
	for <rcu@vger.kernel.org>; Thu, 13 Feb 2025 18:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471445; cv=fail; b=IQD9Poy8PG8VRvcjJMr6mCjt16AV4PZ6j5ufzsqvYm53PZ7JddMO2URv7FQBinfRwsEyPn35wH072ttYsVIgSiSvFoZlf8AL1zAeCmVDMUBhfUd4VZJYY/MR0di3zOnieZFBwosZ/Byx/F6WowYt5eTlw6wpnmcn7Y/B6FcKfHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471445; c=relaxed/simple;
	bh=+ARYTDUuIN5fGK50N9wRM/8fcv0aekVI8Ic4JhSToE4=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=DSUyBqT5kQwORpUC4ZbH1KhPoBACob8pQVPLx5aMVWDN6NfXTFOC8OsGHwz933v6sMRUN98yZFpR5KcmvEBVeCemgVSXiNIroVJZOm9jGUv40lo3DqgbVI4moVrLWx90aDPZwlgociYg8b4ItessU/iZY2ifF4bamS+J7Mm63g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f1/1+PdT; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f1/1+PdT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVhOgiqYEWJoIF6uiJFSkO+ccgcS3JK3V7vtDuiedE9VM48LmrlDkyjXqVXmXuYSATBSVG0db3ZH5peQmQ2b/00g8gfz4uWH+Z2TJpNfiOWRXPGfqNiS6QetxDGEzEPyZi8TvxfzQdGrV4wycFc8Jys+VCDB/fEk4s3x4Ad1SAG3b6jy3nV/ti9IMD8RMXG8oUMmCFFDMxwafAe+I5d16kZxPSQQDtfz06VntqSFLZt8Cn4O6tX878LnRoE+8F4h9dI90zbx/ScjOcpVVtRVwZCz6s/IZGiYRc0HsKKgKGODvsa/MJwAt/wJw/jfpFG9y4pI/bi9h4/UukkbLNk2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixqwjEsuHqeBzURGbRdP6lUMqNIwiks+JtsWyzwHbtM=;
 b=YkGxVJBK2lA/QREXD5iRJFuajfHSrzfX4jJFNQOk2svrA9Ez1zqBtanyUnz8mSdMXCQsrJzq/IrZyq2DgTiCKPpJ7vB00SBbPJ3xo9KUH57svsZs30Et98F68Eth/rv6QoCgsWxbalHy6LMmbdKMOIGvycgzD+Oj1TmYBmxI82O9TXhVRfaunws+g6kj9Ect7rUQ26BV72f8S/J5g5CfT0uGe4sPrRJ4fDa/lm7G00QMxCrhdKR1INu6xjgchFeIAhPfA9J+BLxkuHIWAW1hM+I8Wnzkd2CiumR/EkjfARB6c06U/4JRctHkGox6q7pRfRthPCFZFTWfLbakIW8rlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixqwjEsuHqeBzURGbRdP6lUMqNIwiks+JtsWyzwHbtM=;
 b=f1/1+PdTFVZIt77CkZ+1zuCjkufxaffQ+UO50F0Wmm64rg0h1Xiv01DljZ8IHecEgfOoZKxCFATP7b/h2YV4yuppZewn0jCZ61UL+qSaYJwpG+lIjFgfIkfIz5Om5337oZx2iQd8a1MPyJfi2xu4cYeX/5sUVC+8BeJldCmZGaZzz7WckbyUAYSmpXAhmA9tCM0PBU4dna7SNYfuUb3ePmjcAXqWcjUJbjH0d/t8vJEZPJ6cBvKpAgHr/GN4z+a7u75CGLzzWA2Fs3egoiZPzYGloXZ5XMkM3QKLH1X50yW/3HtfegXmKpawbQnKXLDp54LJJiAH9pZRbgPJBYc+qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by CY5PR12MB6454.namprd12.prod.outlook.com (2603:10b6:930:36::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 18:30:41 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6%6]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 18:30:41 +0000
Date: Thu, 13 Feb 2025 13:30:33 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: rcu@vger.kernel.org, paulmck@kernel.org
Subject: The rdp->gpwrap behavior
Message-ID: <20250213183033.GA2635051@joelnvbox>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BYAPR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:a03:100::37) To PH7PR12MB8056.namprd12.prod.outlook.com
 (2603:10b6:510:269::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8056:EE_|CY5PR12MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 7100d1a0-25b0-4cae-98ee-08dd4c5c84f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0tyh0eb9ugP1WoTrO5pK3rP9vqBDGmXoKEoMTZbKbzLi6r9nkdPzZJexdNoS?=
 =?us-ascii?Q?6KZsMBaRLAX8ByPqISC0Z3PI2QGW59R6v0SnOqlaLdWUVE3o1ejU/svecfVz?=
 =?us-ascii?Q?WPUypHDrOG7AbcqSEeLmK2fle/Zjq1pPyxjeMPdf0XraomzheUog8wxFlZxT?=
 =?us-ascii?Q?RqUdxKf7TWOEWsXDgezRLX2LE/Eqju3n2RehlZOHzKt+5kCXX89Ojw4FYHL6?=
 =?us-ascii?Q?FB35Xlow7u2abjEranR53pjGBqMLbvaHqi4GY5/CjexYD/DmNfDnC4jbESNm?=
 =?us-ascii?Q?4iR+Ehf+6wJgNW7Vqx3/W7S3FoGrx8x5WbEs60KrrdiFMS0CNixAB3jvebDe?=
 =?us-ascii?Q?VDLvmc3Z9ta+tHVeUbBResy8GP074d3fKAvGYxdjK2XtNOYaVOjKZfkclya1?=
 =?us-ascii?Q?SEGpnd/7SibP4AQ1HC+63F6VIOJnVCzDJaRb4N9HyQ4Wp0Rj+2Bqd2jdmxfz?=
 =?us-ascii?Q?/DFx5fDD+Uwi+5iQr+6VlKwy2NvTiMHfBVZUlMairjFgYYERHqHqfg936x2Y?=
 =?us-ascii?Q?1OxoghVt1YdlClf2e6MeyekyvfJ9XKyiQ4n3lLNB3lf4C+zcFYcTg767EK/F?=
 =?us-ascii?Q?iN8eZicT3wfj98UEqIzTRAUi0/FYq01+tCQiMVq0DGx42zCYpeDmrBknC82G?=
 =?us-ascii?Q?hz57Jnnn9c/MeLigD176ULidZF6PcjvkIu9isynBLAokqzNhI1nZjjTSKAg1?=
 =?us-ascii?Q?SdEOP8bLY04OliYOFH3yivrkhM7/oLWxT8uXg8uPadmTfTZ3sPILVtoSiwfj?=
 =?us-ascii?Q?s9jwaUlyDvsyOQF51sDJL8nkw0Xxgqr21b7QMV/PdvDnPUlmHo45YvkdQO/r?=
 =?us-ascii?Q?bRNs2gLbQh0xhWwI+G+ra6Y4Y/OZFl//07z/TalFEEcM0UyAW91MTB2oanYU?=
 =?us-ascii?Q?MRtaSNnJrVWx1iwCZjhEjy4xBwSMkbHYQ7Dhb0zN/v8nWSOsFbNpc7BuN8o8?=
 =?us-ascii?Q?sEPI9hFfRL15hbbvi3cNybTvxNjs0mdiVMV1yawgTjTrli2ucsiVBtghH4bG?=
 =?us-ascii?Q?a7Ef7O5ZrIjc1wmMoD0MVzTdnIjL9ZkB0Ndy9DoP28ZCHRQAMwYjGR9emyyw?=
 =?us-ascii?Q?N1ehlFteFdgyVdIwcaM92UQXbR0xLrx8wTklmqCFJn1Kdv72Pw1s6GnkVsaN?=
 =?us-ascii?Q?I6I3GHgjx1mw6d1rWpaSxerBxa1cEJyAaKcHpNkhiYq38cVoTE60nuLVt8dV?=
 =?us-ascii?Q?Cif1F177SgqGr1PDSUnPcjmmph0b1fj0Cs3HB4zwsUgyb5FUEmxr8yJd3Te8?=
 =?us-ascii?Q?r4ZsBtddxF3gsqfefLIeHxmJ2XohvRQazZS7mwMN4PYdzz/9ivpbv75DduXj?=
 =?us-ascii?Q?OITbLt2Lz+aAFcMgm8XqGf7SXMrJluDIq+PUrGp2NW2WJJZaX3JAxSqIbBNl?=
 =?us-ascii?Q?EbgkPsc5XqOTNqJRVFQ7GnBtcQUn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9mb1VqyOJppLni9eohY4iXG3xAZQ2tC3yVPzVK4fWQWuNrpae2MI5B1VEbEv?=
 =?us-ascii?Q?jO0aM4Yc8O/kXKodxmta/7yX0yxtaq1MXvvwrMUEL7Lqvs+2oJ/y/ucQKytH?=
 =?us-ascii?Q?CsZx03XQ11BUdyd1lzcdsIX6eMVyMA9CECgTnirYKSfP3TBmUOABSAMMUhKt?=
 =?us-ascii?Q?dApiE5Ze1/QsuDlZ6Y0uj7lIIw7p1L+DYTrJZBL+t5tzad5k6FruAKvZzbV/?=
 =?us-ascii?Q?tSey+noIlTqaEwtmZ/a7QL+F5zauI+hojWYHS0VeugDvVRXrOaGv5Wp1mtm4?=
 =?us-ascii?Q?4kvK9SVbWer1pBX+92kWcwY9Tbg7gtldv3dsZtxDDvIZU0Cd4R4laxRU4p5B?=
 =?us-ascii?Q?9my/huM0REzUsVUZDNVDXkB2R0FrtNpVaT9hLwHI1AoIbtsCWsrMD7xHOQNi?=
 =?us-ascii?Q?L7LcjiFPvzRcfMm8sPS3chooGuzYJoQmfZRUKB6K9M8lJra9Y+29nPWYtcKy?=
 =?us-ascii?Q?p/JtoMgaVDWk/YwsjruwishjIZBDTftDvK/fpq+Z7Tz5Vdf+BX9yJKEVh1cF?=
 =?us-ascii?Q?jQ0X7vWP1YX2GzKKTA9/OFpjW1AmIv+5lfqlQZzigeZAFCO1ESvwHsSWyA3x?=
 =?us-ascii?Q?ayt3r8hyeP/aLe3EWaQOvKu9rWrQiKuCyNtWez/4w2LiA8NNEhcbUj+OD5XY?=
 =?us-ascii?Q?BbVFM3r8A2Pqpvq31nk3rb/VgW++EhEb+GN27gRogAQbiUAxW+S4OHuOZMik?=
 =?us-ascii?Q?/R4EwET+yyq4jNC+nmgim0L/vMbuatLDi2WsFRHhcI4ZvQBFVfmMW+vJhSDN?=
 =?us-ascii?Q?ihehabUbHKvggCEtderVu7cfll6nCtHhWwe+tapJXCIQG83QzyCAFRqqR6Cw?=
 =?us-ascii?Q?TpjpciKyBfcvL8htnWi5O5H4k06FtKF3hlEALZDGWYO3exKruUF+YeP6Khlh?=
 =?us-ascii?Q?RC2gFdosOWtiRrlNnPa2DXv9qYheCyiqRwAATuEaOUPFliHJM8af5vPnSi+G?=
 =?us-ascii?Q?UCuIrz9ugpagVbtGW6Rt4kkOmc0kpVa/h+P+hULY4a0AzjHX9+j89HSBRRSe?=
 =?us-ascii?Q?w9Mst1wOJdIihxlZBsQQOKaG5NQNiIaZWLUn4uCA8bGpAgh4LSS0Za0buYe4?=
 =?us-ascii?Q?2oIkYSsXAd/0Qg9wwKR9twST5MbHYa40UfUhFJvRkRQyxt7fUYWoEll5ypSD?=
 =?us-ascii?Q?bThPTYo2D7AXeAgKudLOjFqgZyMK7FswmEbK6W8qblMVB0uVC1oXgp79GBmS?=
 =?us-ascii?Q?Rl54lub9sN+GZZ1VV4zR9sMJKAFZbwj7fh8o5Aq2zZR11vrxdqhLzK1KgQJb?=
 =?us-ascii?Q?FaArnRsWy/ufiiAKprXNKYieR1ilR36lV13C4Dtv/Vgub0pxn8MKHEfO3s0g?=
 =?us-ascii?Q?Jli48O6xI0iQa2JfqbQLSYLWdz5iJ3d4p2KKZ8k/39PaSkGqun3Y2YqK+yXW?=
 =?us-ascii?Q?vLKKZYPURK+Mx+FX5WOQ4XTLbm1zL6OysZXgMklvMfPsupON6AxPv7VdY1i1?=
 =?us-ascii?Q?7lyeZxVZFnJchCEru0TsKIMw0ZY9Z3RWVUWX2ew+TaeOhnKo5WkiBb3VNlUC?=
 =?us-ascii?Q?RYWfEq3Ct1xtre3SBDtP7rE1wqUIlxbxYRg9hiJKKks3AFkiX9BE1L/1yjGs?=
 =?us-ascii?Q?I1PHwDJtlfnYcn/HWwKR2ARJA7xpL0Ky65GOn0TE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7100d1a0-25b0-4cae-98ee-08dd4c5c84f4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:30:40.9353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLNiVhjmx8WVLPHlzL0oVSVs2tCtOWGsbwwko/HdG6ghoyyw8aY1eM1y5BO9PyLNEiciRefda1L7bbj1O/A4Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6454

+rcu for archives

Hi,

Following up about our gpwrap discussions, I did some tracing of rdp->gpwrap
with just boot testing.

I actually never see it set because rdp->gp_seq and rnp->gp_seq are usually
very close.

Example trace:

# rnp->gp_seq starts with -1200 on boot and then right around the wrap:

178.096329: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: -3 (0xfffffffffffffffd), rdp->gp_seq: -3 (0xfffffffffffffffd), wrap before: 0
178.096330: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: -3 (0xfffffffffffffffd), rdp->gp_seq: -3 (0xfffffffffffffffd), wrap after: 0
178.100327: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: 1 (0x1), rdp->gp_seq: 1 (0x1), wrap before: 0
178.100328: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: 1 (0x1), rdp->gp_seq: 1 (0x1), wrap after: 0

The wrap "before" and "after" are the value of gpwrap before and after
calling rcu_gpnum_ovf().

Closer look at the _ovf() shows it should be only set if rdp->gp_seq and
rnp->gp_seq are quite a distance apart (say if the CPU was idle for too long
and many GPs have passed. This can happen both with/without wrap. So imminent
wrapping seems not necessary for ->gpwrap to be even set AFAICS.

I think the problem is ULONG_CMP_LT is not really "<" so even after wrap, it
can false. i.e if rdp->gpseq + ULONG/4 wraps, it could still return false.

From a testing POV, the example shows it is not set even when around when a
wrap actually happened.  So may be, we are not testing gpwrap much, or at
all, with rcutorture?

But before that, I am feeling it is not behaving correctly. I'd expect it to
be set even if rnp and rdp values are close but we are actually about to
wrap.  So most likely I am missing something.

thanks,

 - Joel

