Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013045.outbound.protection.outlook.com [40.107.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262E417BB21;
	Sun, 11 Oct 2026 00:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791679577; cv=fail; b=Avy/WkeQMoRwQXrYvsbxpVI0YhAbsr02AOQCCkKSvNfHAHMI0Qqcibi+nzeMqkO7TqZH2MczAkW9E6uLIp/2DHHjAqVrDn31XPlHJWhI8f0VsbnfckO8Bej+AzFryarmB+DN5I3vDWqkmEoUPaThOEbPoHvgdFvruNypJpdGZVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791679577; c=relaxed/simple;
	bh=P0FX4F2mIJPuMw/UxSwEjW48nBLqaYBH1MX2bsJctOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Cxhs8oPGtB4MJ4QnRxPoI4NiApnbqsmSU+mdGQfqjvlQhQR0QgZ45aKEhiKva7VhJ4omwaaTZUPLYq21BCuI7BJ4/sVlxVJCrjaIeHQzda+iUuLWhun8ynugzV1F7VOvQrnaNPDcq5GhAvDG80bRChTqZcsCP4fqzigzEW+t/s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nAhRZFfr; arc=fail smtp.client-ip=40.107.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nAhRZFfr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXo8cgKS2TztwtwI14N2nVoA8OEUK8+1mgLfCano2mMfhXPG1mAwFkpl6g7IMNJq+Gwgx0ShNUD791UxtrPfbofKAH2LfBwGbPN30K+x0f3toBaYRLkjWQtzsBG1/jqOryldtNwcOZZ/Hj67ivikDVAaL0Y30g7MyGSlcZhfdHiEZdhqp0ItXmg6m4xh9niu21bJ3f4BYJs2ysGnASpNoWPkEkvbqwE7lRNTJYeKX0mgyLL9k0fFrWcFeYrTrTxiXkhzoKCZAsi1K6O3vwZtBaiy7EhxoN7mctaa2S3TJioCFGTF1XFdrXuz1cwC9IKaXSud2Msrq5vAV8XR/fzL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZagbk3k4KX50LvFVjBCy9VrphaRcx9bhc1cFLh+Tog=;
 b=gtQZQIgxocAszglYMYQINj7H7Zp40lM5REvxGqxrI7EcPGHprjz+Bjp5i3yKcxLsNX2+OvSFVsTh7JpwjwEDuz3kxKLDlEmu5t4Rjyx5gVFh05p2gtPPvoUOuU0qp8V8iatYdKatFNNzDCVIBay7XdjHYHn3mpGC2De/ahgMCCo9Y8aN+Ua8OyAK+V1Zyn+onrlPWQOISe60nQygLNRLuMbLnBYqn96w1IEaCs3FJAkrU5BpxFEGyDUskmZXSVlHmqg2NVuV7xi5MdGz43WKc/Bd/To+YTWrLI2REezyJcm7cmHG35zXOTq7SlrsgaUbPGz9eU1HQsjbrWyYDug41w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZagbk3k4KX50LvFVjBCy9VrphaRcx9bhc1cFLh+Tog=;
 b=nAhRZFfrNkIhQcUsDKN9CVQJi4lkn1RTToq5GuKcJb9K46+W4joHsb4n9trYwV7IY3rYOamUeg1bu74xbBW4akwcZQVPqfHFABnPnIyh14lGrtvTzIzMY9j90b9ZSZtB4/vluZHVyguS+H4OZsRZPmMNUhVVaYqSpqwHzJVnpXkczDVXEo1vYSbtWwfy8rToU3DMISUJoaItTVxLfew1vPJbCJOK8Z2PIDgkAEBelU8HoGGFJH5RwyHcx5qO8WZwJkIqTC/OJ4mWilt0+zd22t6YWjE2Po32i+QZWHRreJxV3Op+/aYxmlHbFWFBMrKpKT++VZiE0V2pNW/FQYB1Vg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.20; Sun, 11 Oct 2026 00:46:09 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 00:46:08 +0000
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
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: rcu@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] doc: Document atomic SRCU in Design/Requirements/Requirements.rst
Date: Sat, 10 Oct 2026 20:45:52 -0400
Message-ID: <20261011004553.2905142-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P220CA0104.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:25d::19) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: dadfb3b0-479f-4e5d-27a5-08df273109e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|11063799006|5023799004|921020|56012099006|18002099003|6133799003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	MXrwlB+eraXIGxnblbppGk8Nw/xPCXm5QxiLOJnp+noxbc9URb2ggJNGJdkOlFaEIP1sFihDOz0QywzDfoKZMkouBTAdPWuL5oApYC8IeimTWF1CUjhla5aKJu7RbJfB9UNvBwu8ZSn4qKjkSv7yTkrJv6PoTl088gqmMH9lrBXqOi3cdYIwe6CaV0rOrclhBoaiTySjpFjHaPsctZOBO7aFtkyn0+RWi94bCiyVw7xwGj8nHvX5LP11G+CsGKWevMW1ZU53A1tFIsxHRUai2l8lSviFchxvkC094jOub2h1KsHcs4HUFzFL1esTcYZiAyr/jV+sLUYtYjVHjuPRWSgtfa+vpDsXTT3GpXcTL1FaUuEWI2QwbFdGmTqLs/HxbprhJ+EHSwbcUO6aL/RWWhp8ch+afFU+CCsM1tnUW6+42+jiJAZADrZbTocxcxSCTdk6BD89rlBh5GQksPNkXXAUSTVXjjPvbGhL4OdSIfrf76tk9t4mnzk53PSMBXlD3FN7rJuyTGTAipFHjIcksRyyVGerxPF0uPiYKlIiZgJOWUaaDccDU3w9AN1SSzNvot4VGyIyVFEtgj+cqMHIRM0v3jKToa7goO8DaFcjWwuGDQILdJt0mjF2vIYFqm522WXWnUQZfDVVNbFHDVSNMC9YQMsWEhcNLPR05Wc0uGzVENgRDkBeefEvE7h35AVZDU/8FM4niL/3PunPJoLgww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(11063799006)(5023799004)(921020)(56012099006)(18002099003)(6133799003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LqAc8oJuTCVbutR6C5GG+zEiteOAdVLEMOazE2Pjm4/HS1M9mfP3jOJ+SEaI?=
 =?us-ascii?Q?s3+2ZSnyUEivJsa8glnX/kjnOtfj+amxaqiKIMk0ioK+gXjiZVrb9/CKCNwn?=
 =?us-ascii?Q?XGfoYX+g+JDkwkC70s5RGzOTEQqFIUTtdAhFphYexjaIKqjat4s/vULnd0lk?=
 =?us-ascii?Q?a8ghJTapzlqZ7OHS7TwSHUHHCX5mdkW6YZN7OhM40HXFkhVNhgvNk8kotMqH?=
 =?us-ascii?Q?w6Qnzlv4gBgwUJ1Rg27EGWZBgnwWh73nEZ+mQivFPFi3MDWP/LpvQnbGbJer?=
 =?us-ascii?Q?uI93KWo2BEBouFM5wYGpam1Du+JIwrLW6QH/iQJsmV2Dv6+sijA/jdELz4jD?=
 =?us-ascii?Q?dTjBbdDIOL1UnrR3OEgCeSoqt0Pm3yN4o4vXQQlYVFYvuqLmoFkl985EfdRn?=
 =?us-ascii?Q?t3pt6vTZkP+nTCtnL8EjMvcjnd+9wGqDtYicFB6FZ7+ki5ov0zuNht+Ge8p3?=
 =?us-ascii?Q?3azkBnt2c5dzyWQwr0W7r42YPuWwImmcIhLNkQ9o7r0gaNrUnGLszVSUZzOu?=
 =?us-ascii?Q?6T+CiBdkDsOVHvNXDLTgkOac4NjHvBPbZUf6Ktl1eB5kzhMlGlQR2V07jRnx?=
 =?us-ascii?Q?FFqTYIJcdg+cqekjlj7MMOqbDRszdjdkOLoygNqn9O/H1I1QLqVyDPBNVeOC?=
 =?us-ascii?Q?tKgfSxve65vg3VRSR9WMWX6pGQx6mqpALO7GcOuBvgHxSdaLEIYaC2shrnNW?=
 =?us-ascii?Q?aW4uIbZI/EK8ke4JiSSNA2Nz4xaJgBOjII9cyOr8p61kLEfMvMotZxNX6h2K?=
 =?us-ascii?Q?2gvxC8XOzf9JQR0gaKEGM4eFG2gw9rGTTYbaGTeSRbTpjwLBrl24HYYKcFUO?=
 =?us-ascii?Q?ASq1CNlmN2lfTnpH/7zvETYm3iCvYNjI3Lzj6lFXKsZwwPuNdX3M6C14sff9?=
 =?us-ascii?Q?rFLbr7G2XDk+wLhv/yWUbFfBaAPAI6/6+EEhMQzUQr2gxfTrPAvDlXQ1G7zF?=
 =?us-ascii?Q?ZOKhsUYW9yhH46K9VNNEK700/EG8UyjpdoZQYXGnmmUID507HePcwQBaSWox?=
 =?us-ascii?Q?0yxzgEzGMTNnJFbO6NI0F4hoM/GAKhJJX9C60G+tL5xiOLpfuskAlkStaZV8?=
 =?us-ascii?Q?0KQLFETo2vNui2GdqKsynfoMCCV42oaLkixHZEZA4K+5IcAYxEq4Tf3vMHCO?=
 =?us-ascii?Q?a+bEzd4MQnxRjHrC0qe70cbSCoOscQN++g/ZCrHpC8nKspjAS82na7WplWKr?=
 =?us-ascii?Q?xbYmOcaxxotb36PgF1bURDdrC2DOPXrnBVjiC3dd13UBnWMOWbvLwBL6GVqf?=
 =?us-ascii?Q?kbi/h3MNfbDGYp/xRGRtU1qHjCLsZJgv8vmO8Sz8sBqLMR7hZzjJSO3dmpl3?=
 =?us-ascii?Q?LGn/kwSu46YJGWDl+rbST47CuQpSy6h8rl5IBjjHt7q7wdB9+wIAKRywhKjl?=
 =?us-ascii?Q?WUcW6C8xAXLP9aIL6SaYEOHfHf82tnDDZ8Fr6OjAG4HS2WeRpaUN8XvK9CS6?=
 =?us-ascii?Q?OTpFGFTrc+N2IJ2m0E/DRZ8cqll44gIq7hka4lVlgbWNHBf7ZCWSZCTsh49T?=
 =?us-ascii?Q?a7axxdc4tSPpgbwu+FILpOwDPPffLnMhno11zgDEMUFvlMHh2dPq+5mE+E8G?=
 =?us-ascii?Q?hzQG0KB2NunkNjypkf+LnjWZBbgLOxUAEUDZl96IETBebScx0Ta8vxs2UvAV?=
 =?us-ascii?Q?jczmO2NpAdHw9eKJC4v/SKaPa9a/2p8V3auzTfuDEew80emjqvz6IwXPQvuA?=
 =?us-ascii?Q?KcmQssBPCwZSPDlA37KbyBNZLGo8Loff8WWEIPX2BgjmcR0ufGVa1cbU/5da?=
 =?us-ascii?Q?yoDDGGqNLQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dadfb3b0-479f-4e5d-27a5-08df273109e7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 00:46:08.4846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ve2STpk7u96LtT0rsagXNdPvqc9UmDUONdEdNlFiv3mK40JD/o+qXS4pffywPb09OsVbWUAU/woP5kYAN90CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399

Atomic SRCU (srcu_read_lock_atomic(), srcu_read_unlock_atomic(),
synchronize_srcu_atomic(), init_srcu_struct_atomic(), and friends)
added readers that do not sleep or block, plus an update side that spins
rather than sleeping.

These are missing from Requirements.rst. Add them.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 .../RCU/Design/Requirements/Requirements.rst  | 28 +++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 8101fe6229d5..d43668595872 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2686,11 +2686,13 @@ The `SRCU API
 <https://lwn.net/Articles/609973/#RCU%20Per-Flavor%20API%20Table>`__
 includes srcu_read_lock(), srcu_read_unlock(),
 srcu_dereference(), srcu_dereference_check(), synchronize_srcu(),
-synchronize_srcu_expedited(), call_srcu(), srcu_barrier(),
-and srcu_read_lock_held(). It also includes DEFINE_SRCU(),
-DEFINE_STATIC_SRCU(), DEFINE_SRCU_FAST(), DEFINE_STATIC_SRCU_FAST(),
-init_srcu_struct(), and init_srcu_struct_fast() APIs for defining and
-initializing ``srcu_struct`` structures.
+synchronize_srcu_expedited(), synchronize_srcu_atomic(), call_srcu(),
+srcu_barrier(), and srcu_read_lock_held(). It also includes
+DEFINE_SRCU(), DEFINE_STATIC_SRCU(), DEFINE_SRCU_FAST(),
+DEFINE_STATIC_SRCU_FAST(), DEFINE_SRCU_ATOMIC(),
+DEFINE_STATIC_SRCU_ATOMIC(), init_srcu_struct(),
+init_srcu_struct_fast(), and init_srcu_struct_atomic() APIs for
+defining and initializing ``srcu_struct`` structures.
 
 More recently, the SRCU API has added polling interfaces:
 
@@ -2710,6 +2712,22 @@ certain types of buffer-cache algorithms having multi-stage age-out
 mechanisms.  The idea is that by the time the block has aged completely
 from the cache, an SRCU grace period will be very likely to have elapsed.
 
+A more recent addition to the SRCU API is the atomic flavor:
+srcu_read_lock_atomic(), srcu_read_unlock_atomic(), and
+synchronize_srcu_atomic(). An atomic-SRCU reader runs with preemption
+disabled, must invoke srcu_read_lock_atomic() and
+srcu_read_unlock_atomic() on the same CPU from the same context, and
+must never sleep nor block on anything that might itself depend on
+memory allocation, which allows synchronize_srcu_atomic() to spin
+rather than sleep while waiting for pre-existing readers. This
+requires that all other SRCU usage be excluded from a given atomic
+``srcu_struct`` structure: every reader must use
+srcu_read_lock_atomic() and srcu_read_unlock_atomic() rather than
+srcu_read_lock() or any other SRCU reader flavor, and the structure
+must not be passed to call_srcu(), synchronize_srcu(),
+synchronize_srcu_expedited(), start_poll_synchronize_srcu(),
+srcu_barrier(), or srcu_expedite_current().
+
 Tasks RCU
 ~~~~~~~~~
 
-- 
2.54.0

