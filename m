Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF6CC43461
	for <rcu@archiver.kernel.org>; Tue, 20 Apr 2021 00:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2AE061042
	for <rcu@archiver.kernel.org>; Tue, 20 Apr 2021 00:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhDTACH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 19 Apr 2021 20:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhDTACH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 19 Apr 2021 20:02:07 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937CEC06174A;
        Mon, 19 Apr 2021 17:01:36 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id x11so37686259qkp.11;
        Mon, 19 Apr 2021 17:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lAVjizTcv4p2g5vFOsCJFIVvgpEW8RXS0mds6x3mZ/c=;
        b=EStoaokBvpEydWdJbBAs0jrp9bqrF+3cng2Puj13gR/Nq1fRQ2pwauvyZ9bSW1IO3Z
         y7e7Ow9DbCo+Y3eqBBiOVhsV/0UdAzaDGQeYvhXNSm49Shql1fwieEpNiDjBg6cxWbj8
         dOE1hZAAomNGvqEJ2/M8eOS5Xab60BNn8U+ht/vP0OpxEuXt9BCEyLK34L9ovzcPTwEm
         vmqYO9C0xf58IZba9rpjNyhGh4Oq6lP4Vn0RkSeFWdAAATxuIRdBGUrjNSCuhH76AkXt
         +1dZfAYwpBShYdVmx2lWuaTqzIlbWy6P+srZjw4mfsMf9z9lNgw183WUHgE72IBVroxu
         wX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lAVjizTcv4p2g5vFOsCJFIVvgpEW8RXS0mds6x3mZ/c=;
        b=LwkXKEjcA0uJnWgczN2R2Rql5SsZgW6VClEEan46B0pF8h2BLQogqt8LxF3bXiQiBU
         sKlNrVCpspZuIBlQNTVRsMtxIlVm99Qv42sMB8BhLsjKDCy+byarA6bbnPkIaxtUZs9T
         xNSLlvCwuGuAgqUccjDmtqHz3XcElTbXq0KGnxdxYXqbqq8D1hVelmt6kMno8KARexZA
         KzEY242NYE7uDJcHUag/iPnFCk9qCgJ6eAJhsBhUXBL6LjzuGklFBQ6k5YGlqYdyG5h5
         oLaoO7uQIc3usHlPptSPVSsV7jcftUP1/H3kAq4afyJVfjoOopSgJ+1VgOd7t3W9ZPvG
         6juQ==
X-Gm-Message-State: AOAM533jwo/T5rGkQQ3Iaeipi7Ak37imOmLhh67A2TF9MprhN8yZgJEH
        vejlIN7rmMA6QBfI03IN6uE4O0h3IqM=
X-Google-Smtp-Source: ABdhPJwwJic+ymY3Waj0B8/cmL4SyAjNIjpTDpitCjNL2Hwvrup+E4TA/UIfzi36bcRVGU9BxaIOog==
X-Received: by 2002:ae9:f114:: with SMTP id k20mr14703967qkg.386.1618876895454;
        Mon, 19 Apr 2021 17:01:35 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id c15sm2904385qtg.31.2021.04.19.17.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 17:01:35 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/2] bitmap_parse: support 'all' semantics
Date:   Mon, 19 Apr 2021 17:01:30 -0700
Message-Id: <20210420000131.21038-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420000131.21038-1-yury.norov@gmail.com>
References: <20210420000131.21038-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

RCU code supports an 'all' group as a special case when parsing
rcu_nocbs parameter. This patch moves the 'all' support to the core
bitmap_parse code, so that all bitmap users can enjoy this extension.

Moving 'all' parsing to a bitmap_parse level, also allows users to
pass patterns together with 'all' in regular group:pattern format

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.rst | 5 +++++
 lib/bitmap.c                                    | 9 +++++++++
 lib/test_bitmap.c                               | 8 +++++++-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 3996b54158bf..7178d9c4de7f 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -76,6 +76,11 @@ to change, such as less cores in the CPU list, then N and any ranges using N
 will also change.  Use the same on a small 4 core system, and "16-N" becomes
 "16-3" and now the same boot input will be flagged as invalid (start > end).
 
+The special case-tolerant group name "all" has a meaning of selecting all CPUs,
+such that "isolcpus=all" is the equivalent of "isolcpus=0-N".
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
index 9cd575583180..ab278cfa9145 100644
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
@@ -384,7 +391,6 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{-EINVAL, "a-31:10/1", NULL, 8, 0},
 	{-EINVAL, "0-31:a/1", NULL, 8, 0},
 	{-EINVAL, "0-\n", NULL, 8, 0},
-
 };
 
 static void __init test_bitmap_parselist(void)
-- 
2.25.1

