Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A7DC433E0
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A5264EFE
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348957AbhCDBAp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353125AbhCDAHJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:07:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5470F64F56;
        Wed,  3 Mar 2021 23:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614815780;
        bh=KqbXaZIE78Z0YPuE9W5+U7xsgoAgLUndh2Wmk7Hbmkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fzblqZLXbtjsnEVrhluRfLvR7rQ4N0gWWytF/nnfuDeIOWwjn/5EKiv3OkFGOvja+
         k6VUK6vYUZLIHJc6asFys9B45QKpqk82ieiLjjWHp9qaiW4lr4BgHVG/CFcsfnprJt
         xgs5HTQcDnJ6stZ0pwHaTJO6xWYIc8Mt88Y+sO10/V7D4ZYCOxhY331F5RMrganxda
         Dc0Wp3uMNavo7RgyG+UFhU2R83BhgI/hX0BKqG1WiT9m8xxnPqz5opI6EhekDaXRQt
         bbDmPhjlxHYTwAOpJWlUiLE5VPiFeH6gpFyDPZX6uq2epKXFEwC4d7lkYnCbUYx5yV
         BgLvcLBzP/8eQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        paul.gortmaker@windriver.com, Yury Norov <yury.norov@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH lib/bitmap 6/9] lib: bitmap: support "N" as an alias for size of bitmap
Date:   Wed,  3 Mar 2021 15:56:13 -0800
Message-Id: <20210303235616.22093-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210303235526.GA21868@paulmck-ThinkPad-P72>
References: <20210303235526.GA21868@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

While this is done for all bitmaps, the original use case in mind was
for CPU masks and cpulist_parse() as described below.

It seems that a common configuration is to use the 1st couple cores for
housekeeping tasks.  This tends to leave the remaining ones to form a
pool of similarly configured cores to take on the real workload of
interest to the user.

So on machine A - with 32 cores, it could be 0-3 for "system" and then
4-31 being used in boot args like nohz_full=, or rcu_nocbs= as part of
setting up the worker pool of CPUs.

But then newer machine B is added, and it has 48 cores, and so while
the 0-3 part remains unchanged, the pool setup cpu list becomes 4-47.

Multiple deployment becomes easier when we can just simply replace 31
and 47 with "N" and let the system substitute in the actual number at
boot; a number that it knows better than we do.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Yury Norov <yury.norov@gmail.com> # move it from CPU code
Acked-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.rst |  7 +++++++
 lib/bitmap.c                                    | 22 +++++++++++++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 1132796..d6e3f67 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -68,6 +68,13 @@ For example one can add to the command line following parameter:
 
 where the final item represents CPUs 100,101,125,126,150,151,...
 
+The value "N" can be used to represent the numerically last CPU on the system,
+i.e "foo_cpus=16-N" would be equivalent to "16-31" on a 32 core system.
+
+Keep in mind that "N" is dynamic, so if system changes cause the bitmap width
+to change, such as less cores in the CPU list, then N and any ranges using N
+will also change.  Use the same on a small 4 core system, and "16-N" becomes
+"16-3" and now the same boot input will be flagged as invalid (start > end).
 
 
 This document may not be entirely up to date and comprehensive. The command
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 833f152a..9f4626a 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -519,11 +519,17 @@ static int bitmap_check_region(const struct region *r)
 	return 0;
 }
 
-static const char *bitmap_getnum(const char *str, unsigned int *num)
+static const char *bitmap_getnum(const char *str, unsigned int *num,
+				 unsigned int lastbit)
 {
 	unsigned long long n;
 	unsigned int len;
 
+	if (str[0] == 'N') {
+		*num = lastbit;
+		return str + 1;
+	}
+
 	len = _parse_integer(str, 10, &n);
 	if (!len)
 		return ERR_PTR(-EINVAL);
@@ -571,7 +577,9 @@ static const char *bitmap_find_region_reverse(const char *start, const char *end
 
 static const char *bitmap_parse_region(const char *str, struct region *r)
 {
-	str = bitmap_getnum(str, &r->start);
+	unsigned int lastbit = r->nbits - 1;
+
+	str = bitmap_getnum(str, &r->start, lastbit);
 	if (IS_ERR(str))
 		return str;
 
@@ -581,7 +589,7 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
 	if (*str != '-')
 		return ERR_PTR(-EINVAL);
 
-	str = bitmap_getnum(str + 1, &r->end);
+	str = bitmap_getnum(str + 1, &r->end, lastbit);
 	if (IS_ERR(str))
 		return str;
 
@@ -591,14 +599,14 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
 	if (*str != ':')
 		return ERR_PTR(-EINVAL);
 
-	str = bitmap_getnum(str + 1, &r->off);
+	str = bitmap_getnum(str + 1, &r->off, lastbit);
 	if (IS_ERR(str))
 		return str;
 
 	if (*str != '/')
 		return ERR_PTR(-EINVAL);
 
-	return bitmap_getnum(str + 1, &r->group_len);
+	return bitmap_getnum(str + 1, &r->group_len, lastbit);
 
 no_end:
 	r->end = r->start;
@@ -625,6 +633,10 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
  * From each group will be used only defined amount of bits.
  * Syntax: range:used_size/group_size
  * Example: 0-1023:2/256 ==> 0,1,256,257,512,513,768,769
+ * The value 'N' can be used as a dynamically substituted token for the
+ * maximum allowed value; i.e (nmaskbits - 1).  Keep in mind that it is
+ * dynamic, so if system changes cause the bitmap width to change, such
+ * as more cores in a CPU list, then any ranges using N will also change.
  *
  * Returns: 0 on success, -errno on invalid input strings. Error values:
  *
-- 
2.9.5

