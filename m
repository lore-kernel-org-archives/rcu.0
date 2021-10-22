Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE864C433F5
	for <rcu@archiver.kernel.org>; Fri, 22 Oct 2021 10:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B604E60E96
	for <rcu@archiver.kernel.org>; Fri, 22 Oct 2021 10:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhJVKyl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 22 Oct 2021 06:54:41 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:61164 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232560AbhJVKyk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 22 Oct 2021 06:54:40 -0400
IronPort-Data: =?us-ascii?q?A9a23=3A2DGs2KttnY+un0lpGbxIKrrNiefnVCtfMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3x2cXWmuHP/eDY2vxfNkka9y09UgGvMfdz4A2HFM4q39gHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x8hGQ6YnSHuClUba?=
 =?us-ascii?q?eYHgrLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1JtI6wS?=
 =?us-ascii?q?AUoN6vklvkfUgVDDmd1OqguFLrveCHh65PJlxeWG5fr67A0ZK0sBqUd8/p3AGx?=
 =?us-ascii?q?Ts/AVMzYKfx2ZnMq7zry6QehrnYIoK8yDFIEes3dv1jHQC/IvQLjMRqzL4ZlT2?=
 =?us-ascii?q?zJYrtpJBurTa9YxZj1oYBHBeFtIIFh/IJY9hM+pgGXyd3tTr1f9jbI34mzS1Ep?=
 =?us-ascii?q?10ZDsNsbYfpqBQsA9tkSfq2bu/WP0Bh8XLtqWzzaI6TSrnOCntSH8Q4I6Frqj9?=
 =?us-ascii?q?uJwgUWXy3APThoMWjOTufCkjku1WPpcJlYS9y5oqrI9nGSnR8fwdwakr3mAtxQ?=
 =?us-ascii?q?HHdxdD4US7ACL17qR4AuDAGUAZiBOZcZgt8IsQzEukFiTkLvBHzdymKOaRGjb9?=
 =?us-ascii?q?bqOqz62fy8PIgc/iYUsJecey4C75tht0VSUFZA+eJNZR+bdQVnYqw1mZgBk71n?=
 =?us-ascii?q?LsfM26g=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AE4G1b6O0aQfIisBcTv2jsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEUdfUxSKGlfq+V8sjzqiWftN98YhAdcLO7Scy9qBHnhP1ICOAqVN/MYOCMgh?=
 =?us-ascii?q?rLEGgN1+vf6gylMyj/28oY7q14bpV5YeeaMXFKyer8/ym0euxN/OW6?=
X-IronPort-AV: E=Sophos;i="5.87,172,1631548800"; 
   d="scan'208";a="116272028"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Oct 2021 18:52:21 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 769614D0DC6D;
        Fri, 22 Oct 2021 18:52:18 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 22 Oct 2021 18:52:20 +0800
Received: from FNSTPC.g08.fujitsu.local (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 22 Oct 2021 18:52:18 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <dave@stgolabs.net>, <paulmck@kernel.org>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>,
        <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] refscale: prevent buffer to pr_alert() being too long
Date:   Fri, 22 Oct 2021 18:51:11 +0800
Message-ID: <20211022105111.29455-2-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211022105111.29455-1-lizhijian@cn.fujitsu.com>
References: <20211022105111.29455-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 769614D0DC6D.A134B
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
 kernel/rcu/refscale.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 2cbe2a2ba387..b1b9052010fd 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -604,7 +604,7 @@ static u64 process_durations(int n)
 	char *buf;
 	u64 sum = 0;
 
-	buf = kmalloc(128 + nreaders * 32, GFP_KERNEL);
+	buf = kmalloc(64 * 20, GFP_KERNEL);
 	if (!buf)
 		return 0;
 	buf[0] = 0;
@@ -617,13 +617,15 @@ static u64 process_durations(int n)
 
 		if (i % 5 == 0)
 			strcat(buf, "\n");
+		if (strlen(buf) > 800) {
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
@@ -648,7 +650,7 @@ static int main_func(void *arg)
 
 	VERBOSE_SCALEOUT("main_func task started");
 	result_avg = kzalloc(nruns * sizeof(*result_avg), GFP_KERNEL);
-	buf = kzalloc(64 + nruns * 32, GFP_KERNEL);
+	buf = kzalloc(64 * 20, GFP_KERNEL);
 	if (!result_avg || !buf) {
 		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
 		errexit = true;
@@ -701,10 +703,7 @@ static int main_func(void *arg)
 	if (errexit)
 		goto err;
 
-	buf[0] = 0;
-	strcat(buf, "\n");
-	strcat(buf, "Runs\tTime(ns)\n");
-
+	pr_alert("Runs\tTime(ns)\n");
 	for (exp = 0; exp < nruns; exp++) {
 		u64 avg;
 		u32 rem;
@@ -712,9 +711,13 @@ static int main_func(void *arg)
 		avg = div_u64_rem(result_avg[exp], 1000, &rem);
 		sprintf(buf1, "%d\t%llu.%03u\n", exp + 1, avg, rem);
 		strcat(buf, buf1);
+		if (strlen(buf) > 800) {
+			pr_alert("%s", buf);
+			buf[0] = 0;
+		}
 	}
 
-	SCALEOUT("%s", buf);
+	pr_alert("%s", buf);
 
 err:
 	// This will shutdown everything including us.
-- 
2.33.0



