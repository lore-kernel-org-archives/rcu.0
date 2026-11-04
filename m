Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793803455;
	b=eE7pN4wp7gqvooWNHwHPNtSDzh6OjMnHO4bvrBEjPmgyxu/jJo4NUdC42vmr8hXG7pjd
	 jeyQ+7RN//s0ovdTAOswcdmxK9Udy/PhJB55svIs6zqST1B5w+J5lPPEElQekyGUSuRMG
	 aSHYO7rfCassGYsOb8TRcEnrSB8xeaFz310/bjawUbtbGW6OI5otForWHZBKQylen/8Z1
	 jKixUk7AicvXq1Yyci3nJg6zdUR0FSQsz0TvRWerkzeFYM924YP46Qtub5PiQJsnRyatu
	 h2YWJ+XY50LIRHoGJMHUP7DZyaKJQblurAQRHgvOy+Nq4k7YgBXVyrrmWC3Z33cbpXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803455;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:Content-Type:Content-Disposition:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=8CWsXGRW4cXV/4Ig9ZY5w40sEg5DWBJ6K1rA5X6kY4c=;
	b=hrB0OHa7NRyXmTD7Hk7ef7peRyGj+G6xEqWBl5KbtYS3oUm+T6MjCnsIZuWb3+06LcOA
	 0j4b0/8BhMHsOXg2cO2/b1ZmDj//RxNf+7jXR4U7PVy0FGA3nkY6j2Y1KWOPtDi3O9eqI
	 r2IimoCpb9HdgfzwMPUL/XIZmjvW4HpCcYz9ei1dPw8XLlSfL1I9hwEBdFC3d3D1P3k9D
	 YhEztHxdJf9zlRJv4stgRZCbjdqREUGkYTfK1urNv3KRLIC6t4vuSdLnvWTB7BXPA9SY9
	 /KVzxg1d/bPCgSZs7awcudYtNVbm3C2sOMJGWBH34M/JUl5owa/K5S/rGzni98m3bBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kWRhfuYX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.45
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83848606A32E
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 14:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83848606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kWRhfuYX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fbef0O0XmpHBx75fkqxR85jMvYv6dQWEgjPKI1lLd2+1QYshcaecUKdGJS/IvobUQAm3ei6fiAPPegi9lv5PQqnHQp7gE2UL96Gt6oMc/eAG/8kKxj25o/mqsP8QeZ0Gic6jjMIUfi77BnUaB+PYXHXzhUR/SkpB9pMHTNyOJ5K7IcuoiB/rF6m1uq1Z3yxXkzs1JmYDok26I3qBDjeCvuvnMpSTU5qMhmwXuZzvkY6HV/oCJOq/kgnvTlaiAEw812rohuocxVeX2yqEtlp4rAOdo1ANaGjZ6/32NgDgyaWCls8jbbjfZyxHeBfd13YsarhXUURCpyLm+2qZyaGx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CWsXGRW4cXV/4Ig9ZY5w40sEg5DWBJ6K1rA5X6kY4c=;
 b=gcF+7CoJTzGeaNDT+exnJmicDqPkelAjEYEA2HcP4Hs+1wAAfExfngIRjxBqgh8zzwWN7fzzXea54X0CyTH/EBFIc+fKuikLYX1zs62ZyWMbeYJB1s7DtH0rzHZNzt4n96EUQ5JueLQz42iuT3M+hDJWbz2mGeckjtW5RfErr/vCxX9uWptgwU27RaxVq2UDER9XlzThzilxDmqjavBj6emtinISDnNtevBViqleHrE58BLxUc7tWekHI7Pc6hkSWn+QZeMZryIkNtVVzR1bsGdE8Hg1ktsN3I3sO2rPX1EnMoUMsLQpsPW4sFzAxQ3xUkqXpnbQaGIk9uoVvxzP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CWsXGRW4cXV/4Ig9ZY5w40sEg5DWBJ6K1rA5X6kY4c=;
 b=kWRhfuYXNY+SpzqYpfFTwj9zdaR28kbSPQFZ0Npi/fEGmQ8xMomHpaIxw8LEzgTqcRTLljaSpzgJONScM8XeRFV36nGZaVsE+UgJk3lS2l1XtHfatLIEen0W3L+7KDKQRHjGKHueMr7ejrnLeYRdmYjG7TiNBIB2g6XgOjcIOu+dF7SfHUK5IsRG/0WE+/05PHN8JQqnGp+R1NB7NCDnh8oGGRhwWewDeGsHbNDQA+QB8JAzVn3P1WdeQiw0UPu9yeGf+cNqbyhNRnKoFdiXwxgOBV6SjYNXbph+w15r5YQL5CSPn/IfH5+pEuCUi4Ew1YGmOYOLinVWilKSdFTDXw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by SAAPR12MB370563.namprd12.prod.outlook.com (2603:10b6:802:303::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 14:44:12 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 14:44:12 +0000
Date: Wed, 4 Nov 2026 09:44:08 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: rcu@vger.kernel.org, paulmck@kernel.org
Subject: Possible debug objects issue with: rcu: Make call_rcu() safe to call
 from any context
Message-ID: <20261104144408.GA250870@joelbox>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH0PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:610:75::23) To DM4PR12MB7742.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|SAAPR12MB370563:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f5936e-439f-4230-9925-08df3a82172e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|10070799003|366016|1800799024|5023799004|11063799006|261009223027099003|56012099006|261021121427099003|261021123027099003|261009221227099003|261022075727099003|261102123227099003|261022105027099003|261026121527099003|261028144727099003|261026140227099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	T9f3lzq0BV+gA8C9F3vjl4WgPSbDTRTHb3BUiAQ/QE6IH7sqCoF/hJC+7Zt7YWBP/I/7qWJpJ0baXh2WHR+C39BttWo7DtmzEpkfbPTrsFfS8najIfK352shbiWpnF+ZPfGKijUZ4nC154blY8Pbt18NSf330eVmGLfXlvgYYB790oelcBcZ/TBJINumlJ9gi8QAi7xr1I9h+u8LA75xv1LYVuG/lu5KTAYLo/BDbPx7RH/LpGrePZMERzb3xud9MYJjQzO2PIasGGCV3HWZPzPfyXkD8Fz6Fy9fbvWGbphmrcPrLjnyja3n1zLttRZRcgGocKIMm1JsoEL5yjJVunoqT3JAzeCqRpZEjBwgnhZImcpe8kE+F74OyTZiGVxBMBEuQnLc2A7ATtBP9g0I76XtLeWhVzQxGXt3aES5r5Gh0sAd1pp0/jYxHHqQjzO8hBZH40Ylz6QpLJAb3CIVYImaY/h7K5R91o/pQB2z/f8d3a6x/QGGhXyiNoygolViUtJSNUa2BUUdvQxwTJ0UhOoa8YMKEtfzy46AosbyAUP1RX6UFf+e7k3B7jML88sjd6o2UoItyysENc9SN9xBOP+m4RbPU8soOlXS0Q87qUi1K8+/Q0UjEL2oTmRk9fD/mkAQFcsAxJr4evvaNKUqQyXz5hed1ARuaYoOyuXkR1s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(1800799024)(5023799004)(11063799006)(261009223027099003)(56012099006)(261021121427099003)(261021123027099003)(261009221227099003)(261022075727099003)(261102123227099003)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pu4OO3mnym5hRkMp9i7YGcX6yeYlOGbQ9MVai+Fppud5yGXTzSy/++2kJIKC?=
 =?us-ascii?Q?GMVH07JeZcwaiZeymqQiblBo3a+HDR6udiDL0628P35fNNpplS7+H+HjlAIB?=
 =?us-ascii?Q?fShbwvUHwh2tAvk+wGJQqRRRBjbRtVosl6Dw1dNYtYYW+YL3XZxsaVRPLEhu?=
 =?us-ascii?Q?erBKbp0hV8J6BoMK+7WZ6IB7zPtkJh+12egG1HxHsepJKX+AZ7WAiQfBm7En?=
 =?us-ascii?Q?0qij3+c93ZqcugJc9MN05ZiaSKgLUmPGVoi9RRkDvSP3LScQ9ZA+Gpe4XaYb?=
 =?us-ascii?Q?Y45LA0v6I4BghoRZ22WViQ3uwxcNlF56UyAgWkA5JOqHrU8CNyBQsuRg3HYk?=
 =?us-ascii?Q?nHRnrWZLJXpwoXoXWXJl+GB3RSLIfP3WsYxg/KQgeI2vHJtClo+/ADCU93ea?=
 =?us-ascii?Q?wgOR45doX9Emi9InMWaT7fzctLERH0Y0hTUko/GGgKeZUzIBFZHuqat1QBs3?=
 =?us-ascii?Q?R9lEKfN8VTtSOr+Ki75zImO6mDQZ9NfBHXsy4ilxWg8VnIfBb/Wr6Fxb6E0l?=
 =?us-ascii?Q?0V1j7bmvjgCJ1nRPmM29uc5ZL+4txjaXrl7IOge8EqhCiFsCNrlhmJQP20mh?=
 =?us-ascii?Q?BspWCmHYI4iQmSAehKScBrh98qpk9XEsHrIDKtAFznSWwqQ4uraLWxxXPnd0?=
 =?us-ascii?Q?Z2tCKjNg7fXc0tEW0aa+JPE5Rbo3zqqDhe0CQjp9+F9mvR6Gb0EcyKSeCrnx?=
 =?us-ascii?Q?JuXcH0ytXLW5QHYMP+sSE1e/psxiEOZ6FUKbm7piq+vfkrkPPLs7OlN3vsiQ?=
 =?us-ascii?Q?+XOlxOabGcrRVa58TooC/E5p7KX0bQ0P+2zZiHiyXyIOLpDCuyLr2HouwEqz?=
 =?us-ascii?Q?4KN5Bdk4GioIU1JCt+tNfms1PkRXAoiGKmQ3CHG6BwSxECQ6UaijuBSa+BZQ?=
 =?us-ascii?Q?7ROIOdGaCbiUhbd4bIDvQwzgRZJhP3vs20qtJt1GHkdC3FeRfShwgPtaU9ov?=
 =?us-ascii?Q?Ib9i6voJziC0BV6g7PS8rn2NCr6bo1IZd0V2JV41AfzXKCwE1OeP0ZzpDW23?=
 =?us-ascii?Q?x5WxdvY+f7I+nIo2WVcijLZslTN8NqTzs3nQ229iuodPnnKvL3s7mSUr2sn4?=
 =?us-ascii?Q?H1srFjtNgDkbXGxpK2rU6xAIptMueLfS1qx1Bwp5w0fhPvekpaG6NnscdbcK?=
 =?us-ascii?Q?lK0VSm4lVWmUqpNGIBDkqcIeAl/P5frd/oq4n5ZKeozx477o+ANrmLQJofK6?=
 =?us-ascii?Q?h6awYPv5uySjrt1KjSjWDTWOytN/1pzhmOTBUdJRjD6gWsgi7SOcEptqIto1?=
 =?us-ascii?Q?JW6T86zTMpvSaUu5ORdZzu/s3fO0o7WvTka3kVFknNmUSnHaI4Oe8cP8sDYt?=
 =?us-ascii?Q?HNa+jOl+ie8FHnXOxBxELk5oyU3otWM86IQPFDMK47mkpEuejF6++8nTWQ/8?=
 =?us-ascii?Q?8olqxNe7nqsiLdaUNeUfrfGmAYoaZHf9CTRg5D9W2MjsN464/UF08+ecMUvF?=
 =?us-ascii?Q?jDsnWKKcWjcBeNnisZqddOIavabc3aC+fQXZz3IQ9b8J+5YvhLQCoHkkBwUC?=
 =?us-ascii?Q?wFNrjcvRmy7bYLhgxYa7ViRBMkTttEsE8ynoWgkP8xveNhxaC7LzQtrmNWQV?=
 =?us-ascii?Q?823CWwhbj6lV+84e8G6yXGB6xddQZ3knpP9T6y+k6IH5BgsIayCUAerZVNkU?=
 =?us-ascii?Q?G/aNUL6fOeM6g8xc+eQ+0E1JC/tvCKm9ka8rBhHdd72DyqEVdxObhvJoQVQ9?=
 =?us-ascii?Q?/HIcoeOChkPed4gjv8qJkzKvL8nV5Z6RhaRb948VMSKsTqCst+wJ7deLwW5k?=
 =?us-ascii?Q?o70JFfGh+UXYbkjnHM/9BzCI+QA2chYgrv/E+kj1YGDnO+jO+oH/5H2DvlsW?=
X-MS-Exchange-AntiSpam-MessageData-1: L4D7iapcc8eubQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f5936e-439f-4230-9925-08df3a82172e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 14:44:12.1249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMx7h2F5qDlL1m3Rm1zNiWk09ls/95O8o2JecttLFjj3xTTTmFmExM5ka3Lpwqtd0P239h414Us4rqW4wEbYZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAAPR12MB370563

Hello Puranjay,

My local LLM flagged a debug objects issue with the Make call_rcu() safe to
call patch.

Apparently, it is possible that a double call_rcu can result in corruption
of the deferred list before debug_objects gets a chance to look at it.

Can you take a look at my AI slop patch below that fixes this, and do some
testing on this if it is a real issue and send a proper patch? Thank you so
much.

---8<-----------------------

From 1a550f5c8386761aa9c5c5bf2ec28dcd74ecebec Mon Sep 17 00:00:00 2001
From: Joel Fernandes <joelagnelf@nvidia.com>
Date: Wed, 28 Oct 2026 06:50:58 -0400
Subject: [PATCH] [TBC] rcu: Preserve deferred lists while checking duplicate
 callbacks

The deferred call_rcu() path uses the callback head as its lockless list
node. Registering that head twice can self-link the list and lose other
callbacks before rcu_do_enqueue() checks for duplicates. The IRQ-disabled
object_debug test reports a missing valid callback on both Tree and Tiny
RCU, and an invoked duplicate on Tiny RCU.

With DEBUG_OBJECTS_RCU_HEAD, stage callbacks in independent entries so
duplicate heads cannot corrupt the list before the existing checker
runs. Keep the checker in the drain instead of moving its blocking locks
into NMI/reentrant registration. Use kmalloc_nolock()/kfree_nolock() for
the entries, and drain them through the existing irq_work, barrier and
CPU-offline paths. Match Tree RCU's leak callback handling in Tiny RCU.

This costs one small allocation per deferred registration in debug
builds. If metadata cannot be allocated, retain the original intrusive
path rather than dropping valid callbacks. Duplicate containment is
therefore best-effort in that fallback, as with failed debug tracking.
Non-debug builds do not allocate entries.

Fixes: af78eca13b03 ("rcu: Make call_rcu() safe to call from any context")
Fixes: 0ed912d346fd ("rcu: Make Tiny call_rcu() safe to call from any context")
Not-Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcu.h  | 30 ++++++++++++++++++++++++++++++
 kernel/rcu/tiny.c | 28 ++++++++++++++++++++++++++--
 kernel/rcu/tree.c | 25 ++++++++++++++++++++++---
 kernel/rcu/tree.h |  1 +
 4 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index d60444bf3a02..07613693e567 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -10,6 +10,7 @@
 #ifndef __LINUX_RCU_H
 #define __LINUX_RCU_H
 
+#include <linux/llist.h>
 #include <linux/slab.h>
 #include <trace/events/rcu.h>
 
@@ -583,6 +584,35 @@ static inline bool should_rcu_defer(void)
 	       rcu_scheduler_active != RCU_SCHEDULER_INACTIVE;
 }
 
+/*
+ * Debug checking must run after deferral, where it can take locks.  Use a
+ * separate list node so duplicate heads cannot corrupt the deferred list
+ * before debug_rcu_head_queue() gets a chance to reject them.
+ * Allocation failure falls back to the intrusive list to preserve valid
+ * callbacks; duplicate containment is best-effort in that case.
+ */
+struct rcu_defer_entry {
+	struct llist_node node;
+	struct rcu_head *head;
+	rcu_callback_t func;
+};
+
+static inline struct rcu_defer_entry *rcu_defer_entry_alloc(struct rcu_head *head,
+							  rcu_callback_t func)
+{
+	struct rcu_defer_entry *entry;
+
+	if (!IS_ENABLED(CONFIG_DEBUG_OBJECTS_RCU_HEAD))
+		return NULL;
+
+	entry = kmalloc_nolock(sizeof(*entry), 0, NUMA_NO_NODE);
+	if (entry) {
+		entry->head = head;
+		entry->func = func;
+	}
+	return entry;
+}
+
 /* Drain an outgoing CPU's deferred SRCU callbacks; see rcutree_migrate_callbacks(). */
 void srcu_offline_drain(int cpu);
 
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index ef0b0474f207..3efd151d30b1 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -48,14 +48,17 @@ static struct rcu_ctrlblk rcu_ctrlblk = {
 /*
  * The callback list is only accessed with interrupts disabled, so a call_rcu()
  * that arrives with interrupts off stages the callback on a lockless list that
- * an irq_work re-issues later.  One global list and irq_work suffice, as Tiny
- * RCU is uniprocessor.
+ * an irq_work re-issues later.  Tiny RCU is uniprocessor, so the normal and
+ * debug lists share one global irq_work.
  */
 static void rcu_defer_drain(struct irq_work *iw);
 static LLIST_HEAD(rcu_defer_list);
+static LLIST_HEAD(rcu_defer_debug_list);
 static struct irq_work rcu_defer_iw = IRQ_WORK_INIT_HARD(rcu_defer_drain);
 static bool rcu_defer_draining;
 
+static void rcu_leak_callback(struct rcu_head *head) { }
+
 /*
  * Also called by __rcu_defer_drain() to re-issue a deferred callback, so it
  * must not re-check the deferral condition.
@@ -70,6 +73,7 @@ static void rcu_do_enqueue(struct rcu_head *head, rcu_callback_t func)
 			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->func);
 			mem_dump_obj(head);
 		}
+		WRITE_ONCE(head->func, rcu_leak_callback);
 		return;
 	}
 
@@ -108,6 +112,17 @@ static void __rcu_defer_drain(void)
 		rcu_do_enqueue(head, head->func);
 		drained = true;
 	}
+	if (IS_ENABLED(CONFIG_DEBUG_OBJECTS_RCU_HEAD)) {
+		llist_for_each_safe(node, next, llist_del_all(&rcu_defer_debug_list)) {
+			struct rcu_defer_entry *entry;
+
+			entry = llist_entry(node, struct rcu_defer_entry, node);
+
+			rcu_do_enqueue(entry->head, entry->func);
+			kfree_nolock(entry);
+			drained = true;
+		}
+	}
 	local_irq_restore(flags);
 
 	if (drained)
@@ -124,12 +139,21 @@ static void rcu_defer_drain(struct irq_work *iw)
 
 static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
 {
+	struct rcu_defer_entry *entry;
+
 	/* A re-entrant call_rcu() during the drain would livelock it; drop it. */
 	if (READ_ONCE(rcu_defer_draining) && !in_nmi()) {
 		WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
 			  "call_rcu() re-entered during callback drain; leaking callback\n");
 		return;
 	}
+	entry = rcu_defer_entry_alloc(head, func);
+	if (entry) {
+		if (llist_add(&entry->node, &rcu_defer_debug_list))
+			irq_work_queue(&rcu_defer_iw);
+		return;
+	}
+	/* Keep valid callbacks working even if debug metadata cannot be allocated. */
 	head->func = func;
 	if (llist_add((struct llist_node *)head, &rcu_defer_list))
 		irq_work_queue(&rcu_defer_iw);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a8ede50dbeff..9674cc44618b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3229,6 +3229,16 @@ static void __rcu_defer_drain(struct rcu_data *rdp)
 		head->next = NULL;
 		rcu_do_enqueue(head, head->func, false);
 	}
+	if (IS_ENABLED(CONFIG_DEBUG_OBJECTS_RCU_HEAD)) {
+		llist_for_each_safe(node, next, llist_del_all(&rdp->defer_debug_head)) {
+			struct rcu_defer_entry *entry;
+
+			entry = llist_entry(node, struct rcu_defer_entry, node);
+
+			rcu_do_enqueue(entry->head, entry->func, false);
+			kfree_nolock(entry);
+		}
+	}
 	raw_spin_unlock_irqrestore(&rdp->defer_lock, flags);
 }
 
@@ -3248,12 +3258,13 @@ static void rcu_defer_drain(struct irq_work *iw)
 }
 
 /*
- * Stage @head for this CPU's irq_work to re-issue once interrupts are on.  Only
- * the drain side takes a lock, so this stays safe from NMI.
+ * Stage @head for this CPU's irq_work to re-issue once interrupts are on.
+ * Allocation uses nonblocking trylocks, and list insertion is lockless.
  */
 static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+	struct rcu_defer_entry *entry;
 
 	/*
 	 * Instrumentation on the enqueue path can re-enter here from inside the
@@ -3265,6 +3276,13 @@ static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
 			  "call_rcu() re-entered during callback drain; leaking callback\n");
 		return;
 	}
+	entry = rcu_defer_entry_alloc(head, func);
+	if (entry) {
+		if (llist_add(&entry->node, &rdp->defer_debug_head))
+			irq_work_queue(&rdp->defer_work);
+		return;
+	}
+	/* Keep valid callbacks working even if debug metadata cannot be allocated. */
 	head->func = func;
 	if (llist_add((struct llist_node *)head, &rdp->defer_head))
 		irq_work_queue(&rdp->defer_work);
@@ -4345,6 +4363,7 @@ rcu_boot_init_percpu_data(int cpu)
 	rdp->last_sched_clock = jiffies;
 	rdp->cpu = cpu;
 	init_llist_head(&rdp->defer_head);
+	init_llist_head(&rdp->defer_debug_head);
 	raw_spin_lock_init(&rdp->defer_lock);
 	rdp->defer_work = IRQ_WORK_INIT_HARD(rcu_defer_drain);
 	rcu_boot_init_nocb_percpu_data(rdp);
@@ -4646,7 +4665,7 @@ void rcutree_migrate_callbacks(int cpu)
 
 	/*
 	 * Callbacks deferred past the point the outgoing CPU's irq_work can run
-	 * sit on ->defer_head, which the ->cblist migration below does not
+	 * sit on the deferred lists, which the ->cblist migration below does not
 	 * cover.  Drain them here, before the early returns.
 	 */
 	__rcu_defer_drain(rdp);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index b7cac7a13b4f..da1f29c7c238 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -231,6 +231,7 @@ struct rcu_data {
 
 	/* Deferral of an NMI/reentrant call_rcu(); see __call_rcu_common(). */
 	struct llist_head defer_head;
+	struct llist_head defer_debug_head;
 	struct irq_work defer_work;
 	raw_spinlock_t defer_lock;
 	bool defer_draining;
-- 
2.54.0

