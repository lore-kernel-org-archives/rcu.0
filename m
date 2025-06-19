Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D1422F38E;
	Thu, 19 Jun 2025 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750355423; cv=fail; b=gw+3ix3P/4c2Uu0X7dCsuvhczp6Wrul3QwrEEUIyJ3zy9Gt3uJdK1MX3621UEwzLMMwS6cF38+tGwIE69jb0WEiy9QOG+C1Ra4PBpJT/0FoW0da2yOwnWpbuNVUNswDxY7cwNTyzi2Pe4FZSVVCq+ylbw9IODbhDXRZ8JC4zQ30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750355423; c=relaxed/simple;
	bh=7EE1fiZeF4AUPTr85T5jrjsMKXs1MJMspeyGqb0zHPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rd+hDBiUDyj2DWu9LI9AZnNFk/zyGZTPLf8/gyuxY4rop5BsS4Hsm4tr8PxbAYXLGmqRLex31IT3CjfBqDs26gY2tYT9fdoDrkRHCpiRVd/S8vI+r5tDhYlsFHIf8SZEWk5dYaBCScNS/tDaXZJZUMH7scss0JOL4gT2klATx/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OhdfxigZ; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OhdfxigZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryf79bKqaVNGUw0Wt9ASDef2ztOElkNWhCZ9Q2mKZMd+eca0QUSvt5GBSdOi6K2JAhwWJw7O5NvAp3QVX/8GOUzcasnTUaDYI/mFFBDG3x3rc94hcDVhbLgTn7E0uoYRy9WEgKZjs193rze2NeNC5Z9ItjMRT5mTmjDPPbQX7/J5jgAM6mNDTOMK0GGR3juyNGbZQ40RvCg546n1wZOqXwd1b8qNr9mKsr8ECmp1ehorjFxELXWNFBCzmRZLluJdDZnekSx/uKNTFz60DxLkHM2P3+1lsNOYU7CNqgUP9ybyOw+l24j69VZxwFoF7/zkz1pgAMLBR3DR6LcUCLMstQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xx2MvIxTqvjMITxf8erA+E/YZi9k5LSupDGqka2rRpI=;
 b=nvpZRfwfe8rbSnthTgE1+GRKY80hpDD9dtmvdAfPAqkLSIvyxEL0wj1NflAzNVgWjQxvBrkxxfyeF2TCQctWI89YQQUCcwk0OyGeKnYI3Q20LdxlAn6CtRHX9mPPvUb+3986m0PrRQtS74GL2K1/CgO0poqfFRNspORfBTjyxTSs2Gyg0Isw2i1dXx5SPOXRxlfwwGsvBVJC8UFJum3tJ3ux7bgKWRG1ogc9shmAKppql/iqyc/d9fq/zmMF+Ma7+XPsoUwpHjOOt7mkcd4Ri3Lcx+MuyGsJyqzpogo+EEb6HOEGMDJT8JNCnLErmwdadonk9VonOJoko/ktglqeNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xx2MvIxTqvjMITxf8erA+E/YZi9k5LSupDGqka2rRpI=;
 b=OhdfxigZRsXsKAE6iuTGoKWpLGEWHDXiuaQuw/d7nCu73SHLgqK3moxyx1s/9RGFdetCm5AxuFboAJ1fO/kRHlKR0Xv7qMDzAaO1sqCYD0tHOWRExLT+9wER85pXjz/zowyF4AtyyZGN7rRdnTWC2G9BmpOlJ6ym8kEmqW44N7+eplyMuowg8oqeOgGIwQO4MlMV9W+OioaaXWRtBC7opJxvbEBcx1oYBsXVqmBLAEtxQVKr+NfdpCCa/Ta8qGJEoDpAch0jVw6W1tQSwrHDasrhMmT9vYQMhR+FM4qQCekyLz8+Jn5+0PDLbOsDS2fDHjJCss1exPZuexk1SUCvsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Thu, 19 Jun
 2025 17:50:18 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 17:50:18 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
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
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>,
	rcu@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	rust-for-linux@vger.kernel.org
Subject: [PATCH] refscale: Add tests for local_irq_disable() vs local_interrupt_disable()
Date: Thu, 19 Jun 2025 13:49:20 -0400
Message-ID: <20250619174921.2903605-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0229.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::24) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: 00143237-90bf-4d52-249d-08ddaf59c0d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A0AfciLAOer71ePcYfVizgrtRWLN8hqNQFsMgUpyHzbM4Dhprzj9iq8zbc00?=
 =?us-ascii?Q?sw1TPlNXJyaIHL8xyloZxfOSCYq/HeBhSYIg56Qn9m2/J8gLkyPsUnzA4M2+?=
 =?us-ascii?Q?DStbKp8ZdpaCxFnx+XqgPSzadkn0nK51fE7WbxFK9U0O4AteKUC1K/msxHxL?=
 =?us-ascii?Q?wzsPkj359m8WdzyIapTJBdtRtrBMa02o3BfHyRJaCF8+Gug/QvgI9WMsOX+Y?=
 =?us-ascii?Q?lFvw/HZ1VER1auqFoZ6Ufk/3vnZhnEsZsp4w1YKdC6XRZC/zYCryCIYmCbyV?=
 =?us-ascii?Q?rs4Tq6l1xlVMmOkAvAQiwibc7WjMppluPZ/9cVdtgnKuAgg2seACqvjXoiG2?=
 =?us-ascii?Q?mc/0bzBbwXBARxY2U+U/2g+RKcN69VE5XXdLzWdJlQRnru/vaVHDymfWNewZ?=
 =?us-ascii?Q?SyDg/gcLt4pbqmKM8DmspZHpWMTOXAwYL68XH3mfLmXtPfKXKO+dK/tKmB0m?=
 =?us-ascii?Q?kjLjHh+LK8YQ4PYDlhaqoKzFJHtHEGyeZtLukkWJmZia65JyoBv09uaZ4863?=
 =?us-ascii?Q?cympNIcn8TEVBfPNqvrNI0Ng9Rju8geAzygRYKVM7q5QczJLGcCQTGc6H8No?=
 =?us-ascii?Q?G3C7uFUZGI+nawSZSjYMatpkiRl6R3xwa50gSmLgBdBIgomAieehYl8WqM96?=
 =?us-ascii?Q?UUajD4O03THTUQMlwUDE039wZ59ndL7jX+tcj6RA3G2o4h3AAnESqzZu1PxR?=
 =?us-ascii?Q?SyblqpmysLHyI2/uCeVUDhhRm6z/Lrpa+F1cJWHpOCLnu/ZZT3JL338q8TYw?=
 =?us-ascii?Q?L7nFYmcSVwiBFpQZ4jezBdE5am/6H7O9ZzdCYGwH+bWzCGCoU1qKmBl7Gg2v?=
 =?us-ascii?Q?6gjTxeZuS6HK58CkpKWvh07D7UBHyZenGKxAnp+jEzSyKcWcvHz+VOanyBQ5?=
 =?us-ascii?Q?/qPersBdS30m11CDuEwNQHz1Cg7TTmxWhQEoj/Fjpo7lITp8IXDZQZKpcA3t?=
 =?us-ascii?Q?tWhLy+yubLLSrgU/+hRvBT+AsaSgFzlDAxGCN5MmfwHuRogJ1hgvKuMd0jB9?=
 =?us-ascii?Q?JSyi7JnvSWQDsrYZGLDZBnPPYVde5ZJdCYEwSund0G9MK3BdbmBZDP6lRCgh?=
 =?us-ascii?Q?RKdmpT1Ylwn98hU8ohtjDnI2JrOARabKmmbZjPJm03i7kqWbSIZmm6d4shKA?=
 =?us-ascii?Q?L8WrAmHnw0OhJb1hwxciLc8x6Wm5XjvJJg+1pf7Rrv4cxbrlifY4psZ+8hWJ?=
 =?us-ascii?Q?s8gsbUg/mwcST3bkI9s4NJydoG+gLw9+LSpI+OBkEU/g2ndf0lsneENoWw8p?=
 =?us-ascii?Q?9JaIJmFNYl5/2exmCBfTUY2nhYH+86Kwty2GRlXDClwaEqxM51ev7irPqgpL?=
 =?us-ascii?Q?vXs+JluokDSg3XsU2IiqGm0A84vESTuTStYRYm1mn2ppbaJRgKjujbW32vvc?=
 =?us-ascii?Q?8FrxKR/NkWVJSjZ0HZbloeGyAdebJvcnnrh6AWoXMWKx+SuppjOu5kBBEXP1?=
 =?us-ascii?Q?P3Cq0x9BMuzTTqK7V3donWUjgtECVb5Hou4io8OPkdiYvQ5k7+3ACg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oNACw4VglX3RW7b1Z9Y1zi77iEFDG29lw9aBQOhzZucVWfVqewz+twNvelok?=
 =?us-ascii?Q?TrlJkgcG3wdD8hZ3fcY25zjJlTJ3/qHbi+KgWmTboN4800snaFyu5SAzaHwa?=
 =?us-ascii?Q?nr4xSUxk8w68STaKOzbLyEDwyJn/6iTMZEbfoTXAC0apJ7HAVd9Fyr7o7fcl?=
 =?us-ascii?Q?e7UFbZ0A1ene+eY0vXPiWGloQ8GgF8zkbkH3nQ5iX6ecj/da+K3nYXBXcyaI?=
 =?us-ascii?Q?uQkBuuasovu4ULZ3PP2MRjABhsnZaIqsgDgOr/b7+ZfeG4tAcmaxXB8n2S/Q?=
 =?us-ascii?Q?5Pe/yjRTdD9ewXE8oD5xJBkYkEj3yPNvCEkyl8H2uiOjCRVu8sXIUjWvF80r?=
 =?us-ascii?Q?Ku1svzJQSN4EvXMqJ9773C/0UmH8OaVQEDRzWAPRf/ThLtOGUUi7oJPD5r9n?=
 =?us-ascii?Q?nNiNneIiKMofVMnIwrh4Qu2pesgDnKlAYqiJFXXK5gjDEl2bNKvedVHVJYXn?=
 =?us-ascii?Q?pbzayGHu4yQVS6NnHEz+NiqrrsBh4ko9MFVwWUtf1LGA+ZBZkyOd2JWGOvBY?=
 =?us-ascii?Q?bDhuhdsk1KsYhB/mvfhAr8BCrV58OYx22G+E1qzmYN42seCNiLrRh7qHH0DD?=
 =?us-ascii?Q?TMbnJ4/uPZnqHP01MaTES8vEhfPYyOQfaPUacaDLOZ3GwKflloT0krwHFYbt?=
 =?us-ascii?Q?d+zKgVohIquZUfYBQ5GErUlX0JLrtjF9uiE212GrGVTJazdjScJ5ehEEB7yf?=
 =?us-ascii?Q?Kri5FziUmgxSwUW8uhLpFAcNxcgg2zPH6du8Kr/MP2u3RTafSsDLs4Pn6FAK?=
 =?us-ascii?Q?KFIUTw/SvkUqPAxGYo++ALQZZEMqoiKJBzQ1McjyqGuJBl2oVMBsVAxXfEYW?=
 =?us-ascii?Q?MOFBWDemTquyMA2uWXjgC5EBzHww+GfU6nn4L6A925s9dOJ7qLaTL+OgiNu1?=
 =?us-ascii?Q?mjHcxePqb1tm60OWpVnujtu6l0+cneslGRi+sv6U5o0YvTkTeHgszp2rTGeg?=
 =?us-ascii?Q?4PqNRbbkzB4lg7TKvZ31+AuRwAn7BkaMXJkYOvFAJPhgYI0fKap+YxJGvllI?=
 =?us-ascii?Q?JeaahtlvqGTZ+3o4fiyF/5AMjxb72fPv3leChpheOSMEXjJUc6jaSHshU4rd?=
 =?us-ascii?Q?Kbz0LRflFQDhtZXfd9KWfCkR7gu96gF4ojBe/lXkugY0rP3bSlNYAWGvw6FT?=
 =?us-ascii?Q?JBlJLt5c2Qkm+m2OP3vsFfstSuq0VtL9Qdcpb9wrHxl8TuN20wv0HpPf9IKs?=
 =?us-ascii?Q?KogYFDbp2yfSOA+CCsO8nVQ9E5nqCtYcx/M4uS11NsHj4SRToRCfPLeFF6Fk?=
 =?us-ascii?Q?3vedu8QNbj4GNwp+wRH1OraxFz+gqjikDjRZwpQvx8MrJbKvX5Wcm4xWccwi?=
 =?us-ascii?Q?07E9A02KY7KjjoTBu/LS2SxGSsYY/OAnyNElB3Bk2coG0h7M1TJCKnY/B6K4?=
 =?us-ascii?Q?64did3Rs1Nvn9X2eHV6s5DItjVRdnK7yBGcWg4dGlawYfOyq1DJRkGKIoQjm?=
 =?us-ascii?Q?QPGKNo1GpE/q1VlP9tLU72/ETEvl/Y0oBHvJcX4YeN1oKxO4H17iHijUvw7Z?=
 =?us-ascii?Q?neMMI+eqV68u6D3YUQNPTWcV/bg6Pi7UwkpaIIFSXidbxp29Y7dg6E8grxow?=
 =?us-ascii?Q?BxsH6xy8vv/dG4k5uVi2lCATOyaeogYxRXUFhNMu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00143237-90bf-4d52-249d-08ddaf59c0d6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 17:50:18.0534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsmlPXCo5d8tWcXw0S8ItnPybpisSNUAOLbP6gIfYEMXzNN77y7ltnukpoN1p72iKIodMprwO5nYLfQTutLt0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061

Add two new refscale test cases to compare the performance of
traditional local_irq_disable()/local_irq_enable() with the newer
local_interrupt_disable()/local_interrupt_enable() APIs.

The local_interrupt_disable()/local_interrupt_enable() APIs are
introduced to provide a Rust-compatible interface for interrupt
control, as mentioned in:
https://lore.kernel.org/all/20240527222254.565881-1-lyude@redhat.com/

The 2 new tests are "local_interrupt" for the new API and "local_irq" test
for the traditional one. This allows direct performance comparison
between the two approaches.

Test results on x86 with 4 readers, 5 runs, 10000 loops:

local_irq (traditional API):
  Run 1: 1.306 ns
  Run 2: 1.306 ns
  Run 3: 1.305 ns
  Run 4: 1.307 ns
  Run 5: 1.085 ns
  Average: ~1.26 ns per operation

local_interrupt (new API):
  Run 1: 4.594 ns
  Run 2: 4.201 ns
  Run 3: 4.428 ns
  Run 4: 4.905 ns
  Run 5: 4.566 ns
  Average: ~4.54 ns per operation

The results show higher overhead with local_interrupt_disable()/enable()
possibly coming from the additional state tracking.

To run the module, modprobe refscale scale_type=local_irq (or local_interrupt).

Cc: Lyude Paul <lyude@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: rcu@vger.kernel.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/refscale.c | 50 +++++++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 461a433e3f53..ac6e2391d672 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -71,7 +71,7 @@ MODULE_AUTHOR("Joel Fernandes (Google) <joel@joelfernandes.org>");
 
 static char *scale_type = "rcu";
 module_param(scale_type, charp, 0444);
-MODULE_PARM_DESC(scale_type, "Type of test (rcu, srcu, refcnt, rwsem, rwlock.");
+MODULE_PARM_DESC(scale_type, "Type of test (rcu, srcu, refcnt, rwsem, rwlock, local_interrupt, local_irq.");
 
 torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
 torture_param(int, verbose_batched, 0, "Batch verbose debugging printk()s");
@@ -524,8 +524,36 @@ static const struct ref_scale_ops lock_irq_ops = {
 	.name		= "lock-irq"
 };
 
-// Definitions for IRQ disable/enable tests.
-static void ref_irq_section(const int nloops)
+// IRQ disable/enable tests using interrupt_disable/enable.
+static void ref_local_interrupt_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		local_interrupt_disable();
+		local_interrupt_enable();
+	}
+}
+
+static void ref_local_interrupt_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		local_interrupt_disable();
+		un_delay(udl, ndl);
+		local_interrupt_enable();
+	}
+}
+
+static const struct ref_scale_ops local_interrupt_ops = {
+	.readsection	= ref_local_interrupt_section,
+	.delaysection	= ref_local_interrupt_delay_section,
+	.name		= "local_interrupt"
+};
+
+// IRQ disable/enable tests using local_irq_disable/enable.
+static void ref_local_irq_section(const int nloops)
 {
 	int i;
 
@@ -535,7 +563,7 @@ static void ref_irq_section(const int nloops)
 	}
 }
 
-static void ref_irq_delay_section(const int nloops, const int udl, const int ndl)
+static void ref_local_irq_delay_section(const int nloops, const int udl, const int ndl)
 {
 	int i;
 
@@ -546,10 +574,10 @@ static void ref_irq_delay_section(const int nloops, const int udl, const int ndl
 	}
 }
 
-static const struct ref_scale_ops irq_ops = {
-	.readsection	= ref_irq_section,
-	.delaysection	= ref_irq_delay_section,
-	.name		= "irq"
+static const struct ref_scale_ops local_irq_ops = {
+	.readsection	= ref_local_irq_section,
+	.delaysection	= ref_local_irq_delay_section,
+	.name		= "local_irq"
 };
 
 // Definitions acquire-release.
@@ -986,7 +1014,7 @@ ref_scale_reader(void *arg)
 	// of preventing entries into slow path for rcu_read_unlock().
 	// Exception: for IRQ ops, use preempt_disable instead since we need
 	// to test actual IRQ disable/enable performance.
-	if (cur_ops == &irq_ops)
+	if (cur_ops == &local_interrupt_ops || cur_ops == &local_irq_ops)
 		preempt_disable();
 	else
 		local_irq_save(flags);
@@ -996,7 +1024,7 @@ ref_scale_reader(void *arg)
 
 	duration = ktime_get_mono_fast_ns() - start;
 
-	if (cur_ops == &irq_ops)
+	if (cur_ops == &local_interrupt_ops || cur_ops == &local_irq_ops)
 		preempt_enable();
 	else
 		local_irq_restore(flags);
@@ -1231,7 +1259,7 @@ ref_scale_init(void)
 	int firsterr = 0;
 	static const struct ref_scale_ops *scale_ops[] = {
 		&rcu_ops, &srcu_ops, &srcu_fast_ops, &srcu_lite_ops, RCU_TRACE_OPS RCU_TASKS_OPS
-		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops, &irq_ops,
+		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops, &local_interrupt_ops, &local_irq_ops,
 		&acqrel_ops, &sched_clock_ops, &clock_ops, &jiffies_ops,
 		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
 	};
-- 
2.43.0

