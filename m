Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D256C433EF
	for <rcu@archiver.kernel.org>; Mon, 25 Oct 2021 03:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E649860EFF
	for <rcu@archiver.kernel.org>; Mon, 25 Oct 2021 03:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhJYDap (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 24 Oct 2021 23:30:45 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:37820 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231998AbhJYDao (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 24 Oct 2021 23:30:44 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AP9z70KNu/cnEuTzvrR30lsFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQS61zsi32cAy2RMUG6HP67cZ2ryfNl3aNmxoE1Uu5LSm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHiC0SiuFaOC79CAkj/3QHNIQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/jzSbn9FzydxLnZKtS?=
 =?us-ascii?q?wY1JbCKk+MYO/VdO3gnY/YYouGXfxBTtuTWlSUqaUDExvxyDEA7IMsU9/1xBnB?=
 =?us-ascii?q?D7+cwJT4DbxuCgPnwy7W+IsFuh80lI9LrNYUbs3BIwjTQDPJgSpfGK43Q4sRE0?=
 =?us-ascii?q?Tssrs9JGvrbZtFfbiBgBDzCZBBLElUQBZYwkf2uj3/zfiYer0iazYI15HPT5A5?=
 =?us-ascii?q?2y7jxKtvNftGWWYNShEnwjnrP4mD8CRIyN9GFzzeBtHW2iYfnkSrlVaoJCLK/8?=
 =?us-ascii?q?vdgmxuVy3B7IBkXU0ar5Pq0kEizX/pBJEEOvCkjt64/8AqsVNaVdwezvVaasRM?=
 =?us-ascii?q?GHdldCes37EeK0KW83uozLgDoVRYYMJp/6pBwHmdsize0cxrSLWQHmNWopbi1r?=
 =?us-ascii?q?N94dQ+PBBU=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ajx+Wl62aY6iiDpwS/NPM9AqjBFokLtp133Aq?=
 =?us-ascii?q?2lEZdPRUGvb3qynIpoV+6faUskd3ZJhOo7C90cW7LU80lqQFhLX5X43SPzUO0V?=
 =?us-ascii?q?HAROoJgLcKqAeAJ8SRzIFgPN9bAspD4cPLfCNHpPe/8A+lCMwh3dXC1KipgN3V?=
 =?us-ascii?q?x3BrQRoCUdAY0y5JThacDlZtRBRLQb4wFJ+n7MJBoDa6PVsNaMDTPAh8Y8Hz48?=
 =?us-ascii?q?3MiIn9YQMLQzou6Ay1hzuu77LgVzi0ty1uNQ9y/Q=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,179,1631548800"; 
   d="scan'208";a="116362686"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Oct 2021 11:28:19 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 858CF4D0DC94;
        Mon, 25 Oct 2021 11:28:18 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 25 Oct 2021 11:28:15 +0800
Received: from FNSTPC.g08.fujitsu.local (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 25 Oct 2021 11:28:14 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <dave@stgolabs.net>, <paulmck@kernel.org>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>,
        <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [PATCH 1/3] refscale: simplify the errexit checkpoint
Date:   Mon, 25 Oct 2021 11:26:56 +0800
Message-ID: <20211025032658.22889-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 858CF4D0DC94.AEE72
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
V2: permit further simplification # Paul
---
 kernel/rcu/refscale.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 66dc14cf5687..d97427e0b9d5 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -637,7 +637,6 @@ static u64 process_durations(int n)
 // point all the timestamps are printed.
 static int main_func(void *arg)
 {
-	bool errexit = false;
 	int exp, r;
 	char buf1[64];
 	char *buf;
@@ -651,7 +650,7 @@ static int main_func(void *arg)
 	buf = kzalloc(64 + nruns * 32, GFP_KERNEL);
 	if (!result_avg || !buf) {
 		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
-		errexit = true;
+		goto oom_exit;
 	}
 	if (holdoff)
 		schedule_timeout_interruptible(holdoff * HZ);
@@ -663,8 +662,6 @@ static int main_func(void *arg)
 
 	// Start exp readers up per experiment
 	for (exp = 0; exp < nruns && !torture_must_stop(); exp++) {
-		if (errexit)
-			break;
 		if (torture_must_stop())
 			goto end;
 
@@ -698,26 +695,22 @@ static int main_func(void *arg)
 	// Print the average of all experiments
 	SCALEOUT("END OF TEST. Calculating average duration per loop (nanoseconds)...\n");
 
-	if (!errexit) {
-		buf[0] = 0;
-		strcat(buf, "\n");
-		strcat(buf, "Runs\tTime(ns)\n");
-	}
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
 
+oom_exit:
 	// This will shutdown everything including us.
 	if (shutdown) {
 		shutdown_start = 1;
-- 
2.33.0



