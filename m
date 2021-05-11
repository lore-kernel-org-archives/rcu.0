Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9D3C433B4
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4975461260
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhEKWmz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:42:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229784AbhEKWmz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:42:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 207EA61184;
        Tue, 11 May 2021 22:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620772908;
        bh=H5/pcagz8FXgM/aK6h5MLOigYHbaIy2AqRmAQ2ggCGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U0/7htkf9VqSU4YJCO2JFGC/XcyDrbf9kFQQC0D82APKhNskD5Y2NU2lAP9dBovO8
         Xlg9+4p5jZwNfWO93XySgZtfc5CzEw+fzUUFMF7PmB72cNWGI7291QeRCta8maIpDG
         BqQ+3MChFxzue5m++8gHyulApeTups+a3KHqqbHYkFbePVsjacmEl0dUKFBPi64H6V
         f/Nf2VFaisWZ0bHcjWno2mvhX/9HIjHDUp/hde5mW7G2+WKHwvy9993wNV78EJPi/v
         rmuFvs04WeCcc+/1CuVVSbVboElE+Zyvau9oEW2J4MxngafRZYR8CCMWRWQZzkkwcj
         XZU3eBDmRaloQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DA3CE5C0138; Tue, 11 May 2021 15:41:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/2] bitmap_parse: Support 'all' semantics
Date:   Tue, 11 May 2021 15:41:45 -0700
Message-Id: <20210511224146.2892226-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511224115.GA2892092@paulmck-ThinkPad-P17-Gen-1>
References: <20210511224115.GA2892092@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Yury Norov <yury.norov@gmail.com>

RCU code supports an 'all' group as a special case when parsing rcu_nocbs
parameter. This patch moves the 'all' support to the core bitmap_parse
code, so that all bitmap users can enjoy this extension.

Moving 'all' parsing to a bitmap_parse level also allows users to pass
patterns together with 'all' in regular group:pattern format, for example,
"rcu_nocbs=all:1/2" would offload all the even-numbered CPUs regardless
of the number of CPUs on the system.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.rst | 5 +++++
 lib/bitmap.c                                    | 9 +++++++++
 lib/test_bitmap.c                               | 7 +++++++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 3996b54158bf..01ba293a2d70 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -76,6 +76,11 @@ to change, such as less cores in the CPU list, then N and any ranges using N
 will also change.  Use the same on a small 4 core system, and "16-N" becomes
 "16-3" and now the same boot input will be flagged as invalid (start > end).
 
+The special case-tolerant group name "all" has a meaning of selecting all CPUs,
+so that "nohz_full=all" is the equivalent of "nohz_full=0-N".
+
+The semantics of "N" and "all" is supported on a level of bitmaps and holds for
+all users of bitmap_parse().
 
 This document may not be entirely up to date and comprehensive. The command
 "modinfo -p ${modulename}" shows a current list of all parameters of a loadable
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 74ceb02f45e3..6e29b2aae6ba 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -581,6 +581,14 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
 {
 	unsigned int lastbit = r->nbits - 1;
 
+	if (!strncasecmp(str, "all", 3)) {
+		r->start = 0;
+		r->end = lastbit;
+		str += 3;
+
+		goto check_pattern;
+	}
+
 	str = bitmap_getnum(str, &r->start, lastbit);
 	if (IS_ERR(str))
 		return str;
@@ -595,6 +603,7 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
 	if (IS_ERR(str))
 		return str;
 
+check_pattern:
 	if (end_of_region(*str))
 		goto no_pattern;
 
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 9cd575583180..4ea73f5aed41 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -366,6 +366,13 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{0, "0-31:1/3,1-31:1/3,2-31:1/3",	&exp1[8 * step], 32, 0},
 	{0, "1-10:8/12,8-31:24/29,0-31:0/3",	&exp1[9 * step], 32, 0},
 
+	{0,	  "all",		&exp1[8 * step], 32, 0},
+	{0,	  "0, 1, all,  ",	&exp1[8 * step], 32, 0},
+	{0,	  "all:1/2",		&exp1[4 * step], 32, 0},
+	{0,	  "ALL:1/2",		&exp1[4 * step], 32, 0},
+	{-EINVAL, "al", NULL, 8, 0},
+	{-EINVAL, "alll", NULL, 8, 0},
+
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
 	{-EINVAL, "10-1", NULL, 8, 0},
-- 
2.31.1.189.g2e36527f23

