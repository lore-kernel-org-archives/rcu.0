Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021DAC43331
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1E164EFE
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbhCDBAp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234928AbhCDAHJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:07:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8273364F48;
        Wed,  3 Mar 2021 23:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614815779;
        bh=lUOmba8vVHnpHV2R1J6JAqgq/r5KVw39qB+bVXwp+f0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uu11XI5ojeNe+/9bDzOsH9XoxJWuVb9PEsY5bpeIWjiJVek0sPj7PW72a6krTb8yC
         M6e+1QuSnyGC+4CM1fHb09//0Cqn7CsSA1yuHSNlpR+7deJb/LlYXsDyLGP78Y9jy6
         KsXxMTOCoNRWXYUc5vaUZzpC+TBpkjVnIZfW97/ihwKRFhuTjEn6vw4cl8WKztgpeJ
         rWPsIBqREDqduFMogG3eIMRIxz8Rhw4c2g/ioiIXUzpWpO41WNC4r1xLS5caWvnIe/
         Q+I1wejBhYTPV60BJfvYoepk+AAdS849mttw8F8IB6EW6vmN4mWBg5u/WyXAiNsaPQ
         gIUM1o2Md3fMg==
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
Subject: [PATCH lib/bitmap 3/9] lib: test_bitmap: add more start-end:offset/len tests
Date:   Wed,  3 Mar 2021 15:56:10 -0800
Message-Id: <20210303235616.22093-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210303235526.GA21868@paulmck-ThinkPad-P72>
References: <20210303235526.GA21868@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

There are inputs to bitmap_parselist() that would probably never
be entered manually by a person, but might result from some kind of
automated input generator.  Things like ranges of length 1, or group
lengths longer than nbits, overlaps, or offsets of zero.

Adding these tests serve two purposes:

1) document what might seem odd but nonetheless valid input.

2) don't regress from what we currently accept as valid.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/test_bitmap.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 0f2e91d..3c1c46d 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -34,6 +34,8 @@ static const unsigned long exp1[] __initconst = {
 	BITMAP_FROM_U64(0x3333333311111111ULL),
 	BITMAP_FROM_U64(0xffffffff77777777ULL),
 	BITMAP_FROM_U64(0),
+	BITMAP_FROM_U64(0x00008000),
+	BITMAP_FROM_U64(0x80000000),
 };
 
 static const unsigned long exp2[] __initconst = {
@@ -334,6 +336,26 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{0, " ,  ,,  , ,   ",		&exp1[12 * step], 8, 0},
 	{0, " ,  ,,  , ,   \n",		&exp1[12 * step], 8, 0},
 
+	{0, "0-0",			&exp1[0], 32, 0},
+	{0, "1-1",			&exp1[1 * step], 32, 0},
+	{0, "15-15",			&exp1[13 * step], 32, 0},
+	{0, "31-31",			&exp1[14 * step], 32, 0},
+
+	{0, "0-0:0/1",			&exp1[12 * step], 32, 0},
+	{0, "0-0:1/1",			&exp1[0], 32, 0},
+	{0, "0-0:1/31",			&exp1[0], 32, 0},
+	{0, "0-0:31/31",		&exp1[0], 32, 0},
+	{0, "1-1:1/1",			&exp1[1 * step], 32, 0},
+	{0, "0-15:16/31",		&exp1[2 * step], 32, 0},
+	{0, "15-15:1/2",		&exp1[13 * step], 32, 0},
+	{0, "15-15:31/31",		&exp1[13 * step], 32, 0},
+	{0, "15-31:1/31",		&exp1[13 * step], 32, 0},
+	{0, "16-31:16/31",		&exp1[3 * step], 32, 0},
+	{0, "31-31:31/31",		&exp1[14 * step], 32, 0},
+
+	{0, "0-31:1/3,1-31:1/3,2-31:1/3",	&exp1[8 * step], 32, 0},
+	{0, "1-10:8/12,8-31:24/29,0-31:0/3",	&exp1[9 * step], 32, 0},
+
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
 	{-EINVAL, "10-1", NULL, 8, 0},
-- 
2.9.5

