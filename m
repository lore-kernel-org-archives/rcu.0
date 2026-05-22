Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E654219E3;
	Fri, 22 May 2026 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459850; cv=fail; b=Id1CEtIGa8jTYbx6mh+32Y2UGDXXIJQLIcFGqoNizYcQqOlCQcyefaEDOpnAOv3EdnIBTFVp7ZA80DpZV2mmTJpIVsjBCNik7nXa1SDXDvCvBnMGDa6zwWZBUNVrjZzn9M6DUzgo+EhOJFJfbgsmFt8NB+gMTXxzWhhIox1h6m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459850; c=relaxed/simple;
	bh=fbRjpXyN/E2RaoqyvhlPNuYovKwltiVbHlD9OAiwTP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=haU0e5zNgCDH19WfvqiWfdEt6nIIc41VMXjwWhlhQL795e6gHn+QGVCR7SbChdk7ln5rbq4Gr+F48UWU5rn604yGjJCEkfS3TDXmzWrJnw4Nilyjt506suegmOXM6MfjW8ATffGRI0VlV2u7YYZ3k7HnKXnc5iC7nfc2YkNVsBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dKKzalxY; arc=fail smtp.client-ip=52.101.62.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dKKzalxY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIKSGopHFMomoUQYbNJERMG2FqIqYnJKQFlwJOSsTs0AYC6VcK7LPPgjXB78EIuFbHDvvlDz2xmMfHIqdKylDXN6a+0xwzfKXuC8NsR0P4YYFTlNtEdQA73WlgVPoJ98JO4OpN5aE10SPecHFzI2Pb6AN9+Y2TRWKlx1++mrDBoEQBoJKJ7z4iruQ/ewq59+jn2+Q6kDxoDvSWHumKSKQOVKfVkiEvAT4zLCWqqyCs0bAa1GoWlAUZymuJw125R08F/2ljPwq/xOVHjRV3/34Jv7qQM5aiJRcVGwPFUbsyYc/9Jos1bQaBiZ+19VdwPzzSURMZxHLlwhYOkMhXQcMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2R2eohlshkyhTS7BzkyvjP9idrWHREPtQXCoqfqD+AE=;
 b=ZcKI884g0Bn4HzYGoSsyCkKZInT0uUO8m0Gk6T+4ef06dc9j8Q7G1902krSuAflDfxI3Nfrn7F6pAlSLxD8O1B9ATGZKqomzOVGJa/iWDvMq8jUlOVxLZt4ds1klSvozt07OSFiC2anqqoKz8uKZ4vyzcuZTcShSNDZfYziXFjJAwzvPR5m2Yrja0kH/QBsns0AQf17uND4/oIDIuKk++QuzBWHY2cPMJrDVFyDKUCIw0daUUrYTsl4uxfHHbImCpr/0l8M8vvS7pN5UPIX376ncH9QzRa6q0unR7SbbtnIgs12PVxolPUo/IIMDfkKfVycYsGt1XoXHcy14KYNMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2R2eohlshkyhTS7BzkyvjP9idrWHREPtQXCoqfqD+AE=;
 b=dKKzalxYjfhpMQDE0hDizXqpFkW7hljIphXNtY0YMMw14Qyi6ys8Bz8+qR8ClzOHOzk/jXZD9KvZfrdssQHrLcDG5EZURLZ5xHhfhZj+ozZUql2ttJlu48EmRXiUkaNNm9csEEsWrEM9dNwXKJIeOFLOuBJP9E7UQGk1VqnKYj6fCCuP7qr0Plbhdgxc0E8f3iWCSr67emq62BT/qvMBd/iDpSoK1h429bpv6luBAnAzOXAHkjPH0caHETtSkUKvgWZ0TZ6zsbOvzdSgP42zOtNxNGFbvwz3XczGH53eYio6IZjAe6I3t7s5WXYBNXVA+hOIYxLd4oxyUsqyxVuPJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DS4PR12MB9793.namprd12.prod.outlook.com (2603:10b6:8:2a3::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Fri, 22 May 2026 14:24:05 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 14:24:05 +0000
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
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org
Subject: [PATCH RFC v1 3/6] rcu: clear defer_qs_pending in handler for compounded sections
Date: Fri, 22 May 2026 10:23:37 -0400
Message-Id: <20260522142342.1536533-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522142342.1536533-1-joelagnelf@nvidia.com>
References: <20260522142342.1536533-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:208:239::17) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DS4PR12MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df51c03-64f9-4af2-7909-08deb80dc72f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|56012099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	PA4rXwiWK+BF8KW4RHi+IzVkVTt0rt0GAdIv/+WCYfjDAagMMVF1NOu7svWkJyjPOrf16ovO826yX5vIO8guMJebnCv+stlnIa/fVTJwtwY52snQGuLKEPfTaC8+HjbMQ7CcyqzkAkmjalwMqvtzL17GqfhBf35aY9OitvFC8qPxo9kdnKSIW/QjPWF2qJGmAMVhudr9ZYQH0C2KoaJgRFi4awR8zLDvPhfiN3VKqZE5qXdJkEFEnr07MN91Y4mnIGWudea4QsTREq/RMQ8ImRY83ZMbq+4/RIsEpNBCLhOnyNHE6VGq8sPjHeQhR3m0nwMWcWk7u4wqJGi94mvOIxNg8QLTCqmNIjDHIaQ1vK7bKkKQp2FgKHcxbW+v4pFHPONZvJD4uLn8CzGoXk/3z+hFqM3dPXOeWbHumYo2zryZdc5yjzWUsv94bHjyRKPplKqPGdiOgifkyuCHFGcY6ZIi+tIsH8/0R1vvmvCpORNy9QrHF6wrqxFmZbpi55XCh9kymAGnxSldElWx/9yctGbSxp8EQu2QKAiJoARBTguz+l40v5g/3btYPDxmmzBpigPBTw0kGOq9ZHZGHYGdOor8e0LuW86RQHu1VYYbU5qMDrYVXsz7fnGhwMmMciLbPykLVZX6rMu41sCxhfPaqw4MmNxTzEZgPfNjoRmllEGq0/wF9UUyVgaL/5K5ASmvqmPbsxV650G++FvBLbZLaN+Q97BOAgMC4ER4drIR/Yk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(56012099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?31dPGr1NmY98LN0XBmNEdYs3ndw7oZVkHe55WU2sB/vCRTQTaHIMgEIuQXly?=
 =?us-ascii?Q?aGAii0tNs7yH8fDSDYYj7JEx5m5bZlh81ZShQhGHjmqySgZz6dKOlxXbfYSE?=
 =?us-ascii?Q?DDHEwaOS0AsopG2JR9xkl4rQDIJ12ekVxwNDKaco6cYpBy4TvA7z7KYhEvGa?=
 =?us-ascii?Q?Exfd44tQwtT5+xofrWwDNAHCelJvV0RDl70s/2cMCkZFHyWL1tmXMJW57MI5?=
 =?us-ascii?Q?GaTbDKRhZSQG2HOzxiU/pL9KztGs+BxoCgmZwL+feqSFcB5waZmsmkiLADiK?=
 =?us-ascii?Q?vYj46KhMgu8Aotep8/yN63bhXi4E4RT5iixCFPmRqi7gC3lk6tFwvvnTSLjR?=
 =?us-ascii?Q?ou6IECZ7R069uyFNv12nPJ70Llznv3CoyHaU9Jj1f+WOjVXd5vk/TLQRhgPr?=
 =?us-ascii?Q?KfnVhAtyfA823izCP45c9ytnsnv62H+eMWe4heCYwn8I+xg0mKw9/S98z1iF?=
 =?us-ascii?Q?y2agm73024hW3YrxMmybvQmyJzZkYIQMvWCiBPkyNSJWPBb/Nf+QYyR48yrq?=
 =?us-ascii?Q?AbmsioKXKT1wcis5Ln2WeUa69TuzNCEUmh9Sy6bradUYPqp0CRPAXM11VpSB?=
 =?us-ascii?Q?/FeW1qvJmVHG8y1tA5p/Papp7SGO4WTZaxiC7v/nDxXrp5EUjgYLBT5AgIPx?=
 =?us-ascii?Q?LjIqafI2Gb1YZH536SkoTSrdZEM3RdtjNf0BbJSJc31WB3Vzhf5MYtmV/GrR?=
 =?us-ascii?Q?N+fhKpfLGLD5TzFEoL3jnhL2M0223CfZdCpabBdrUYheCtqBzeLGSBbznDeN?=
 =?us-ascii?Q?49NPt+137d2i0YodTxRstdXmbFsrExEbfXC0eY75N2sTM61MBb3+RgtZrE9a?=
 =?us-ascii?Q?PYUGBGvgT9xp1Se76/g7mOwBnJMJ0jgrAwiOY0mv9YLCSN+VS2vtp6Xpfda1?=
 =?us-ascii?Q?YAtFQWDwGoGFtSrBWHvd4nOu3I8aBcEL7imBJKI7B8Gfs7MszdKjI9g1Mh91?=
 =?us-ascii?Q?PKjLA0By4/n00gxJp0CgX2DHuCeVT8nnBg5omVA3WNQiSKVc39GM2a75buhR?=
 =?us-ascii?Q?dOrlUYxwo1j6WZ7sp7pISJ4NwM8MuK444bh4C16M5M8uTHDQcFhASGiDFJ5z?=
 =?us-ascii?Q?Yv+2C7HQzfBDPTrn9+O6L4huxZeShfAsszZdaQo9VOtXNa2By+QBFJhuA95F?=
 =?us-ascii?Q?rRfSyPoc/cEFDLmQliS2GPKPFixqCuRYAxsiM9XtaWq/oO4TNW/3G4ntWVgI?=
 =?us-ascii?Q?ksbsoO8Q06TloeEM2d49Ho8HlKF4mCVGQ8YdGDV5Cvl3cHJqWq38BQhSdvXi?=
 =?us-ascii?Q?vt71h6OidNM3yWmqi4c91WTQSqOLu2OCjIkMO7OoGBBBjeTxBi8UrnvaBUI0?=
 =?us-ascii?Q?Ia8TZ/lTA4cNl5/u9SeOt2V0Mmfy3KPcnx28OHkroyeir1kpKuzTmqrrwEBo?=
 =?us-ascii?Q?HVIh6eztBsGUUzeUibHnuC7lBzJcJlKxZA0QwsrtFmVP66javoyA7uDmNAnK?=
 =?us-ascii?Q?AZLVQk62Lyn4w8pDmOtAXAjis0DJI7ua7xSJrI8HOc7ZUBWAuOLYZmRInGmf?=
 =?us-ascii?Q?YzhKbmmHUS3QGF9GojhVAyYXEZ0oG1EkIZztFxwFygGyp1Ecej3Ce2YIPCGP?=
 =?us-ascii?Q?6wFQQg9oCSSLZU/TZQKSVfFyq4ahMUNVjTkCQoAq3EkUgTaPeSOUqpn6ggqS?=
 =?us-ascii?Q?/Vcu94Iwxr4lIAZke2OlmU1usixeY351+WwTCSC9VaZHxtideKuBIUh073u5?=
 =?us-ascii?Q?tSmsVHIsb3BDoZA1PoV+mdfc5gV3yiSzddwhpijRN2t4cO8CQavRGJi7y2w9?=
 =?us-ascii?Q?e9leTUguiA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df51c03-64f9-4af2-7909-08deb80dc72f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 14:24:05.0128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+ASmIafYgwGZ5Qv9PEoV8V7/NDDMyF5dIfivrXvyRc99vhL9U21NCPOFXksXOWdulIajaBa1Wb/L9BAa8gNVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9793

The deferred-QS irq-work handler previously cleared defer_qs_pending
only when the handler ran inside an active rcu_read_lock() critical
section (rcu_preempt_depth() > 0).  Paul McKenney pointed out a common
multi-segment compound pattern where the handler fires between
segments and segment N+1's arming attempt is silently suppressed by
the rcu_read_unlock_special() pending-gate:

    rcu_read_lock();           // segment 1 starts
    // may be preempted/boosted here
    local_irq_disable();
    rcu_read_unlock();          // segment 1 ends; arms defer_qs_pending
    preempt_disable();
    local_irq_enable();         // handler MAY fire here: depth==0, but
                                // but preempt is disabled, so it cant
                                // nudge.

    rcu_read_lock();            // segment 2 starts
    preempt_enable();
    local_irq_disable();
    rcu_read_unlock();     // arming attempt suppressed incorrectly -- (1)
    local_irq_enable();

Waiting for the next __note_gp_changes() clear is too slow for the
compound case, we need the deferred QS report sooner.

Therefore, make the irq_work handler clears defer_qs_pending whenever
rcu_in_compounded_section() is true so that (1) can do the arming.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 8637f405cb47..2da009dbe64c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -621,6 +621,17 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
 }
 
+/*
+ * True if the current context is inside a compounded RCU read-side
+ * section, i.e. either in an active rcu_read_lock() (depth>0) or in an
+ * outer preempt-disabled / BH-disabled scope.
+ */
+static inline bool rcu_in_compounded_section(void)
+{
+	return rcu_preempt_depth() > 0 ||
+	       (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) != 0;
+}
+
 /*
  * Minimal handler to give the scheduler a chance to re-evaluate.
  */
@@ -632,19 +643,10 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
 
 	/*
-	 * If the IRQ work handler happens to run in the middle of RCU read-side
-	 * critical section, it could be ineffective in getting the scheduler's
-	 * attention to report a deferred quiescent state (the whole point of the
-	 * IRQ work). For this reason, requeue the IRQ work.
-	 *
-	 * Basically, we want to avoid following situation:
-	 * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
-	 * 2. CPU enters new rcu_read_lock()
-	 * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() > 0
-	 * 4. rcu_read_unlock() does not re-queue work (state still PENDING)
-	 * 5. Deferred QS reporting does not happen.
+	 * Clear defer_qs_pending when the handler fires inside a compounded
+	 * section as we may need to rearm the irq_work.
 	 */
-	if (rcu_preempt_depth() > 0)
+	if (rcu_in_compounded_section())
 		rcu_defer_qs_clear(rdp);
 }
 
-- 
2.34.1

