Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D135C433EF
	for <rcu@archiver.kernel.org>; Mon, 25 Oct 2021 03:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E1D760EFF
	for <rcu@archiver.kernel.org>; Mon, 25 Oct 2021 03:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhJYDaw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 24 Oct 2021 23:30:52 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:37820 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232286AbhJYDas (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 24 Oct 2021 23:30:48 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AbpKowqih0IwmvwoYYWemdOqEX161HREKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUExmIXDTuDaKzbYGL2Kth2aN7k/RwH6pDVn9FmSVM/qHw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOi+xZVA/fvQHOOlULS?=
 =?us-ascii?q?YYnoZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14NFMp5yxS?=
 =?us-ascii?q?wYgOIXCheYcTwJFVSp5OMWq/ZeeeCbk75bNnx2un3zEhq8G4FsNFYgR5uZ2DHw?=
 =?us-ascii?q?I+fEDLjccYwqYr++4zrOwS+53wM8kKaHDPoIWvH57zTjfCf8naZ/GSqTOo9Rf2?=
 =?us-ascii?q?V8YnMdVAfvSe+IWbj1jaRXbJRpVNT8/DJEmtOaumnT7NTZfrTq9vao252nLigh?=
 =?us-ascii?q?w+LnrLNfRPNeNQK19nEGVokrE+Gn9DBwAMtWZxTeetHW2iYfnnyTgWKoQE6a46?=
 =?us-ascii?q?uRrmFme2nBVDwcZPXOjqOS9j0W9c9FSMUoZ/mwpt6da3ECiUNTVRAG3p3qNtAV?=
 =?us-ascii?q?aXddMe8U+6QeQ2u/X7hyfC2wsUDFMcpoludUwSDhs0UWG9/vzDiFHrrKYUzSe+?=
 =?us-ascii?q?62SoDf0PjIaRVLuzwdsoRAtuoGl+d9syEmUCIsLLUJ8tfWtcRmY/txAhHFWa20?=
 =?us-ascii?q?vsPM2?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A/6MacK5o4097Z1yo/QPXwPTXdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX8ra2TdZsguyMc9wx6ZJhNo7G90cq7MBbhHPxOkOos1N6ZNWGIhI?=
 =?us-ascii?q?LCFvAB0WKN+V3dMhy73utc+IMlSKJmFeD3ZGIQse/KpCW+DPYsqePqzJyV?=
X-IronPort-AV: E=Sophos;i="5.87,179,1631548800"; 
   d="scan'208";a="116362688"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Oct 2021 11:28:26 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 972184D0DC9A;
        Mon, 25 Oct 2021 11:28:25 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 25 Oct 2021 11:28:18 +0800
Received: from FNSTPC.g08.fujitsu.local (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 25 Oct 2021 11:28:20 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <dave@stgolabs.net>, <paulmck@kernel.org>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>,
        <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/3] refscale: prevent buffer to pr_alert() being too long
Date:   Mon, 25 Oct 2021 11:26:57 +0800
Message-ID: <20211025032658.22889-2-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025032658.22889-1-lizhijian@cn.fujitsu.com>
References: <20211025032658.22889-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 972184D0DC9A.AEA88
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

0Day/LKP observed that the refscale results become incompleted
when a larger nruns(such as 300) is specified.
It seems that printk() can accept < 1024 buffer at once.
Print the buffer if its length exceeds 800 simply.

CC: Philip Li <philip.li@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
V2: shorten the buffer length. # Paul
---
 kernel/rcu/refscale.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index d97427e0b9d5..a4479f00dcdc 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -604,7 +604,7 @@ static u64 process_durations(int n)
 	char *buf;
 	u64 sum = 0;
 
-	buf = kmalloc(128 + nreaders * 32, GFP_KERNEL);
+	buf = kmalloc(800 + 64, GFP_KERNEL);
 	if (!buf)
 		return 0;
 	buf[0] = 0;
@@ -617,13 +617,15 @@ static u64 process_durations(int n)
 
 		if (i % 5 == 0)
 			strcat(buf, "\n");
+		if (strlen(buf) >= 800) {
+			pr_alert("%s", buf);
+			buf[0] = 0;
+		}
 		strcat(buf, buf1);
 
 		sum += rt->last_duration_ns;
 	}
-	strcat(buf, "\n");
-
-	SCALEOUT("%s\n", buf);
+	pr_alert("%s\n", buf);
 
 	kfree(buf);
 	return sum;
@@ -647,7 +649,7 @@ static int main_func(void *arg)
 
 	VERBOSE_SCALEOUT("main_func task started");
 	result_avg = kzalloc(nruns * sizeof(*result_avg), GFP_KERNEL);
-	buf = kzalloc(64 + nruns * 32, GFP_KERNEL);
+	buf = kzalloc(800 + 64, GFP_KERNEL);
 	if (!result_avg || !buf) {
 		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
 		goto oom_exit;
@@ -695,10 +697,7 @@ static int main_func(void *arg)
 	// Print the average of all experiments
 	SCALEOUT("END OF TEST. Calculating average duration per loop (nanoseconds)...\n");
 
-	buf[0] = 0;
-	strcat(buf, "\n");
-	strcat(buf, "Runs\tTime(ns)\n");
-
+	pr_alert("Runs\tTime(ns)\n");
 	for (exp = 0; exp < nruns; exp++) {
 		u64 avg;
 		u32 rem;
@@ -706,9 +705,13 @@ static int main_func(void *arg)
 		avg = div_u64_rem(result_avg[exp], 1000, &rem);
 		sprintf(buf1, "%d\t%llu.%03u\n", exp + 1, avg, rem);
 		strcat(buf, buf1);
+		if (strlen(buf) >= 800) {
+			pr_alert("%s", buf);
+			buf[0] = 0;
+		}
 	}
 
-	SCALEOUT("%s", buf);
+	pr_alert("%s", buf);
 
 oom_exit:
 	// This will shutdown everything including us.
-- 
2.33.0



