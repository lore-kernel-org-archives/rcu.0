Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344FFC433EF
	for <rcu@archiver.kernel.org>; Fri, 22 Oct 2021 10:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A12660E96
	for <rcu@archiver.kernel.org>; Fri, 22 Oct 2021 10:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhJVKyq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 22 Oct 2021 06:54:46 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:61164 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232663AbhJVKyp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 22 Oct 2021 06:54:45 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AKhaerKjVFBjfMyXrHApL4ISGX161MREKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUDxzFKXWHUbq3cZmP9Lth1PNiw8xsBupLcn9E2QVFrrHw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOi+xZVA/fvQHOOlULS?=
 =?us-ascii?q?eYnoZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14NFMp5yxS?=
 =?us-ascii?q?wYgOIXCheYcTwJFVSp5OMWq/ZeeeCbl7pbLlBSun3zEhq8G4FsNFYgR5uZ2DHw?=
 =?us-ascii?q?I+fEDLjccYwqYr++4zrOwS+53wM8kKaHDPoIWvH57zTjfCf8naZ/GSqTOo9Rf2?=
 =?us-ascii?q?V8YnMdVAfvSe+IWbj1jaRXbJRpVNT8/CpUzmM+qgXT7fTBCrluTqacspW/Jw2R?=
 =?us-ascii?q?Z0r/2MPLXfceKWd9UhkKVun6A+H72ajkCPcGbzDGG2nGhnOnCmWX8Qo16PLGx6?=
 =?us-ascii?q?PNCm0GcwWgaAgZQU1anydG9i0ijS5dcJlYS9y4Gs6c/7gqoQ8P7Uhn+p2SL1jY?=
 =?us-ascii?q?GUMd4DeI38keOx7DS7gLfAXILJgOtwvROWNQeHGRsjwHW2YiyQ2EHjVFcclrFn?=
 =?us-ascii?q?p/8kN94EXF9wbc+WBI5?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ao8ICjqARW36QBjXlHemQ55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9F/b0qynAppomPGDP4gr5NEtApTniAtjkfZq/z+8X3WB5B97LMzUO01?=
 =?us-ascii?q?HYTr2Kg7GD/xTQXwX69sN4kZxrarVCDrTLZmRSvILX5xaZHr8brOW6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,172,1631548800"; 
   d="scan'208";a="116272031"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Oct 2021 18:52:27 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 4CF764D0DC6D;
        Fri, 22 Oct 2021 18:52:23 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 22 Oct 2021 18:52:19 +0800
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 22 Oct 2021 18:52:18 +0800
Received: from FNSTPC.g08.fujitsu.local (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 22 Oct 2021 18:52:17 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <dave@stgolabs.net>, <paulmck@kernel.org>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>,
        <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [PATCH 1/2] refscale: simplify the errexit checkpoint
Date:   Fri, 22 Oct 2021 18:51:10 +0800
Message-ID: <20211022105111.29455-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 4CF764D0DC6D.A1A5C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 kernel/rcu/refscale.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 66dc14cf5687..2cbe2a2ba387 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -698,26 +698,25 @@ static int main_func(void *arg)
 	// Print the average of all experiments
 	SCALEOUT("END OF TEST. Calculating average duration per loop (nanoseconds)...\n");
 
-	if (!errexit) {
-		buf[0] = 0;
-		strcat(buf, "\n");
-		strcat(buf, "Runs\tTime(ns)\n");
-	}
+	if (errexit)
+		goto err;
+
+	buf[0] = 0;
+	strcat(buf, "\n");
+	strcat(buf, "Runs\tTime(ns)\n");
 
 	for (exp = 0; exp < nruns; exp++) {
 		u64 avg;
 		u32 rem;
 
-		if (errexit)
-			break;
 		avg = div_u64_rem(result_avg[exp], 1000, &rem);
 		sprintf(buf1, "%d\t%llu.%03u\n", exp + 1, avg, rem);
 		strcat(buf, buf1);
 	}
 
-	if (!errexit)
-		SCALEOUT("%s", buf);
+	SCALEOUT("%s", buf);
 
+err:
 	// This will shutdown everything including us.
 	if (shutdown) {
 		shutdown_start = 1;
-- 
2.33.0



