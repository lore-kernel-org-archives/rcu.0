Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF15C433E6
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F9064EC4
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348072AbhCDBAn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239237AbhCDAHI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:07:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E98364F52;
        Wed,  3 Mar 2021 23:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614815780;
        bh=PzAaZTYuI9PF2LsmFBWc0xST52WqSacAJGYpWDdxMeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OtZbPHy4xvoTY2/NzaP13K0Qi1o7O4JR3Mpzr4Mpzcl9cWDO4hzrjW8VzYHycOuCA
         IcSLNRbZoH0K0QsSF7DR5WEsAVkHGsZ4qZmjiw1thHwJLj1Y2J1yGTre+NqLN1QeK5
         af3UZhmsoftek7A6d9qGWTQ2G9dS1htNCHiwRi9tI+4VdYXZidwULcdGjqu6itDmMy
         QXB1/+r6dAZbtpO+jx0/4BP2VhAD1mxt3Ram0NJKfQ+xezsD6+2QT6ZsDK0DC+IyGE
         iraTUKu3Pooo7dOdYwIIlsKLZiaOPF6dnEUlM5buOEyrhoT66Wvkazlvct5H4u9GHd
         QBobBHusLlBPQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        paul.gortmaker@windriver.com, Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH lib/bitmap 5/9] lib: bitmap: move ERANGE check from set_region to check_region
Date:   Wed,  3 Mar 2021 15:56:12 -0800
Message-Id: <20210303235616.22093-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210303235526.GA21868@paulmck-ThinkPad-P72>
References: <20210303235526.GA21868@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

It makes sense to do all the checks in check_region() and not 1/2
in check_region and 1/2 in set_region.

Since set_region is called immediately after check_region, the net
effect on runtime is zero, but it gets rid of an if (...) return...

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/bitmap.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 162e285..833f152a 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -500,17 +500,12 @@ struct region {
 	unsigned int nbits;
 };
 
-static int bitmap_set_region(const struct region *r, unsigned long *bitmap)
+static void bitmap_set_region(const struct region *r, unsigned long *bitmap)
 {
 	unsigned int start;
 
-	if (r->end >= r->nbits)
-		return -ERANGE;
-
 	for (start = r->start; start <= r->end; start += r->group_len)
 		bitmap_set(bitmap, start, min(r->end - start + 1, r->off));
-
-	return 0;
 }
 
 static int bitmap_check_region(const struct region *r)
@@ -518,6 +513,9 @@ static int bitmap_check_region(const struct region *r)
 	if (r->start > r->end || r->group_len == 0 || r->off > r->group_len)
 		return -EINVAL;
 
+	if (r->end >= r->nbits)
+		return -ERANGE;
+
 	return 0;
 }
 
@@ -656,9 +654,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
 		if (ret)
 			return ret;
 
-		ret = bitmap_set_region(&r, maskp);
-		if (ret)
-			return ret;
+		bitmap_set_region(&r, maskp);
 	}
 
 	return 0;
-- 
2.9.5

