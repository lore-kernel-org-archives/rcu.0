Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1266C4332D
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B652864EEC
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbhCDBAn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352589AbhCDAHI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:07:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96A6A64F59;
        Wed,  3 Mar 2021 23:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614815780;
        bh=Rk8lbsRx2Lj/ReqjdC1N2YYxcEhLMBywPigAOlTTJ4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lAsJwWynYb46n36E6DbloYuemn47EOTRb+qUDhQ+HccmyI3r4P8cDoFw2GnSeGpB8
         DiHugMBojWlLh7u/l06Wc00/DNz+HJpGXhhQjHkhtl9b3bRKM8f2TUULE53o+Fzisb
         kAeh4katsYa2i02JXb4IzmUbbS7BbcvdgdunWtdLQHVokkxfe90P6HtKO2HT3e/aNT
         +vzdGUrNXX8vYZQ+YnnCu/0iWJjWQQQC/m14Fdj/8nIWMSQMQXLS3mgqEbob8yecJe
         n+PoCENB5w3LbaYSp2ToKPRSpNMOdlwaNFZt9K1U1O7XDO15bm7/vhl7QTLhzDjlc2
         JD69QH5BgOoLw==
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
Subject: [PATCH lib/bitmap 7/9] lib: test_bitmap: add tests for "N" alias
Date:   Wed,  3 Mar 2021 15:56:14 -0800
Message-Id: <20210303235616.22093-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210303235526.GA21868@paulmck-ThinkPad-P72>
References: <20210303235526.GA21868@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

These are copies of existing tests, with just 31 --> N.  This ensures
the recently added "N" alias transparently works in any normally
numeric fields of a region specification.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/test_bitmap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 3c1c46d..9cd5755 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -353,6 +353,16 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{0, "16-31:16/31",		&exp1[3 * step], 32, 0},
 	{0, "31-31:31/31",		&exp1[14 * step], 32, 0},
 
+	{0, "N-N",			&exp1[14 * step], 32, 0},
+	{0, "0-0:1/N",			&exp1[0], 32, 0},
+	{0, "0-0:N/N",			&exp1[0], 32, 0},
+	{0, "0-15:16/N",		&exp1[2 * step], 32, 0},
+	{0, "15-15:N/N",		&exp1[13 * step], 32, 0},
+	{0, "15-N:1/N",			&exp1[13 * step], 32, 0},
+	{0, "16-N:16/N",		&exp1[3 * step], 32, 0},
+	{0, "N-N:N/N",			&exp1[14 * step], 32, 0},
+
+	{0, "0-N:1/3,1-N:1/3,2-N:1/3",		&exp1[8 * step], 32, 0},
 	{0, "0-31:1/3,1-31:1/3,2-31:1/3",	&exp1[8 * step], 32, 0},
 	{0, "1-10:8/12,8-31:24/29,0-31:0/3",	&exp1[9 * step], 32, 0},
 
-- 
2.9.5

