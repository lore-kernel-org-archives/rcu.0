Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2789BC433FE
	for <rcu@archiver.kernel.org>; Mon, 25 Oct 2021 03:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BDB560EFF
	for <rcu@archiver.kernel.org>; Mon, 25 Oct 2021 03:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhJYDa6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 24 Oct 2021 23:30:58 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:17025 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232370AbhJYDa4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 24 Oct 2021 23:30:56 -0400
IronPort-Data: =?us-ascii?q?A9a23=3A1yGVl6MpHJjY8YrvrR30lsFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQO61D5w0DwFn2oZCD/QPfeJY2H8ctEgYIq+pkgP7ZPcm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHiC0SiuFaOC79CAkj/3QHNIQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/jzSbn9FzydxLnZKtS?=
 =?us-ascii?q?wY1JbCKk+MYO/VdO3gnY/YYouGWeBBTtuTWlSUqaUDExvxyDEA7IMsU9/1xBnB?=
 =?us-ascii?q?D7+cwJT4DbxuCgPnwy7W+IsFuh80lI9LrNYUbs3BIwjTQDPJgSpfGK43Q4sRE0?=
 =?us-ascii?q?Tssrs9JGvrbZtFfbiBgBDzCZBBLElUQBZYwkf2uj3/zfiYer0iazYI15HPT5A5?=
 =?us-ascii?q?2y7jxKtvNftGWWYNShEnwjnrP4mD8CRIyN9GFzzeBtHW2iYfnkSrlVaoJCLK/8?=
 =?us-ascii?q?vdgmxuVy3B7IBkXU0ar5Pq0kEizX/pBJEEOvCkjt64/8AqsVNaVdwezvVaasRM?=
 =?us-ascii?q?GHdldCes37EeK0KW83uozLgDoVRYYMJp/6pBwHmdsize0cxrSLWQHmNWopbi1r?=
 =?us-ascii?q?d94dQ+PBBU=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3APH37t6vd8WESqLsAfrwsUpEA7skDktV00zEX?=
 =?us-ascii?q?/kB9WHVpmszxra6TdZMgpHnJYVcqKQgdcL+7WJVoLUmxyXcx2/h1AV7AZniAhI?=
 =?us-ascii?q?LLFvAA0WKK+VSJcEeSygce79YFT0EUMrzN5DZB4voSmDPIcerI3uP3jZyAtKPP?=
 =?us-ascii?q?yWt3VwF2Z+VF5wd9MAySFUp7X2B9dOEEPavZ9sxavCChZHhSSsy6A0MOV+/Fq8?=
 =?us-ascii?q?aOu4nhZXc9dmQawTjLnTW186T7DhTd+h8fVglEybAk/XOAsyGR3NTaj82G?=
X-IronPort-AV: E=Sophos;i="5.87,179,1631548800"; 
   d="scan'208";a="116362691"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Oct 2021 11:28:32 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id E28344D0DC84;
        Mon, 25 Oct 2021 11:28:31 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 25 Oct 2021 11:28:28 +0800
Received: from FNSTPC.g08.fujitsu.local (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 25 Oct 2021 11:28:27 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <dave@stgolabs.net>, <paulmck@kernel.org>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>,
        <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [PATCH 3/3] refscale: always log the error message
Date:   Mon, 25 Oct 2021 11:26:58 +0800
Message-ID: <20211025032658.22889-3-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025032658.22889-1-lizhijian@cn.fujitsu.com>
References: <20211025032658.22889-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: E28344D0DC84.AD43C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Generally, error message should be logged anyhow.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 kernel/rcu/refscale.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index a4479f00dcdc..f055d168365a 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -58,8 +58,8 @@ do {											\
 	}										\
 } while (0)
 
-#define VERBOSE_SCALEOUT_ERRSTRING(s, x...) \
-	do { if (verbose) pr_alert("%s" SCALE_FLAG "!!! " s, scale_type, ## x); } while (0)
+#define SCALEOUT_ERRSTRING(s, x...) \
+	do { pr_alert("%s" SCALE_FLAG "!!! " s, scale_type, ## x); } while (0)
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Joel Fernandes (Google) <joel@joelfernandes.org>");
@@ -651,7 +651,7 @@ static int main_func(void *arg)
 	result_avg = kzalloc(nruns * sizeof(*result_avg), GFP_KERNEL);
 	buf = kzalloc(800 + 64, GFP_KERNEL);
 	if (!result_avg || !buf) {
-		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
+		SCALEOUT_ERRSTRING("out of memory");
 		goto oom_exit;
 	}
 	if (holdoff)
@@ -837,7 +837,7 @@ ref_scale_init(void)
 	reader_tasks = kcalloc(nreaders, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
 	if (!reader_tasks) {
-		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
+		SCALEOUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
-- 
2.33.0



