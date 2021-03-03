Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8420C433E9
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BD2F64F1B
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348959AbhCDBAq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353011AbhCDAHJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:07:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E198D64F4C;
        Wed,  3 Mar 2021 23:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614815780;
        bh=xJg00R6d3ySVTLUJzM6dVE6oFWvCNYo+XHZd5o5Muck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KgGdd7kNo1++6RuGcDRRWP+9caQEekrHKf13rstLrEe47g1zLo5TVqmEhPRAFVc20
         s4BKDGmL+1XoVyXEJWs5lVtc57l6TRg6c08VunN/RvhT3CUG/QHTet20lwQlj+mb0i
         /WvSXl8XXHNqiu6RyislRUW73DoLIjereQHhZfPOR2qEGMFWX3rWcdSyZfcBkIW/NT
         UbLbUvo7zMBHRiEOwQ1nfb+rH21z6Y18zd+txLPGD3LwrONB46+jHEaWVA1vxM1A6M
         PhIG5eTFEcs7NdE/jamnuqdT6ryH8WurX0t5GnRCKPHmVHiooNn5644R+7JTfPDrLt
         cnrilMFlkU8dQ==
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
Subject: [PATCH lib/bitmap 4/9] lib: bitmap: fold nbits into region struct
Date:   Wed,  3 Mar 2021 15:56:11 -0800
Message-Id: <20210303235616.22093-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210303235526.GA21868@paulmck-ThinkPad-P72>
References: <20210303235526.GA21868@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

This will reduce parameter passing and enable using nbits as part
of future dynamic region parameter parsing.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/bitmap.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 75006c4..162e285 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -487,24 +487,24 @@ EXPORT_SYMBOL(bitmap_print_to_pagebuf);
 
 /*
  * Region 9-38:4/10 describes the following bitmap structure:
- * 0	   9  12    18			38
- * .........****......****......****......
- *	    ^  ^     ^			 ^
- *      start  off   group_len	       end
+ * 0	   9  12    18			38	     N
+ * .........****......****......****..................
+ *	    ^  ^     ^			 ^	     ^
+ *      start  off   group_len	       end	 nbits
  */
 struct region {
 	unsigned int start;
 	unsigned int off;
 	unsigned int group_len;
 	unsigned int end;
+	unsigned int nbits;
 };
 
-static int bitmap_set_region(const struct region *r,
-				unsigned long *bitmap, int nbits)
+static int bitmap_set_region(const struct region *r, unsigned long *bitmap)
 {
 	unsigned int start;
 
-	if (r->end >= nbits)
+	if (r->end >= r->nbits)
 		return -ERANGE;
 
 	for (start = r->start; start <= r->end; start += r->group_len)
@@ -640,7 +640,8 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
 	struct region r;
 	long ret;
 
-	bitmap_zero(maskp, nmaskbits);
+	r.nbits = nmaskbits;
+	bitmap_zero(maskp, r.nbits);
 
 	while (buf) {
 		buf = bitmap_find_region(buf);
@@ -655,7 +656,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
 		if (ret)
 			return ret;
 
-		ret = bitmap_set_region(&r, maskp, nmaskbits);
+		ret = bitmap_set_region(&r, maskp);
 		if (ret)
 			return ret;
 	}
-- 
2.9.5

