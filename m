Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C07C4332B
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55B5064EEC
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348882AbhCDBAp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353073AbhCDAHI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:07:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C04564EE6;
        Wed,  3 Mar 2021 23:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614815778;
        bh=oYSbdeuNIkGi8aexQolwyr9QZCxFAFATGZ2D0UKvF/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8yHDOzAIm0d8nWlSWWWBzZivcBacjAekIQdIW+obN2Hi3ZM2yy4Rmlc+WSf9V8EO
         DjssTWaq394RDtqbMA3RnZFfjoBMQwQA8ZTbKIG7FnprrjwhyBX2qUlUt9YHeudIvL
         knbSeuOh9/J/ZTcMiHGLEcoIViML3Hn4uStd0xYORiYZSdvdUHg9n1EelX9RGekOFY
         NcQT/KqsrO6Xv1WCi/+ubSI3KtsbnxJTxR/l4LIKWaA1MupTJS+3VqZrKiQzGdagc1
         I0IG5QqoEFwOtJIVzfprYxzaPdWGJWZMYMaH4EXb0KGYr84C2c8eQDyIbztMhL6boR
         X7VG7t5sSDSHQ==
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
Subject: [PATCH lib/bitmap 1/9] lib: test_bitmap: clearly separate ERANGE from EINVAL tests.
Date:   Wed,  3 Mar 2021 15:56:08 -0800
Message-Id: <20210303235616.22093-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210303235526.GA21868@paulmck-ThinkPad-P72>
References: <20210303235526.GA21868@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

This block of tests was meant to find/flag incorrect use of the ":"
and "/" separators (syntax errors) and invalid (zero) group len.

However they were specified with an 8 bit width and 32 bit operations,
so they really contained two errors (EINVAL and ERANGE).

Promote them to 32 bit so it is clear what they are meant to target.
Then we can add tests specific for ERANGE (no syntax errors, just
doing 32bit op on 8 bit width, plus a typical 9-on-8 fencepost error).

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/test_bitmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 0ea0e82..853a3a6 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -337,12 +337,12 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
 	{-EINVAL, "10-1", NULL, 8, 0},
-	{-EINVAL, "0-31:", NULL, 8, 0},
-	{-EINVAL, "0-31:0", NULL, 8, 0},
-	{-EINVAL, "0-31:0/", NULL, 8, 0},
-	{-EINVAL, "0-31:0/0", NULL, 8, 0},
-	{-EINVAL, "0-31:1/0", NULL, 8, 0},
-	{-EINVAL, "0-31:10/1", NULL, 8, 0},
+	{-EINVAL, "0-31:", NULL, 32, 0},
+	{-EINVAL, "0-31:0", NULL, 32, 0},
+	{-EINVAL, "0-31:0/", NULL, 32, 0},
+	{-EINVAL, "0-31:0/0", NULL, 32, 0},
+	{-EINVAL, "0-31:1/0", NULL, 32, 0},
+	{-EINVAL, "0-31:10/1", NULL, 32, 0},
 	{-EOVERFLOW, "0-98765432123456789:10/1", NULL, 8, 0},
 
 	{-EINVAL, "a-31", NULL, 8, 0},
-- 
2.9.5

