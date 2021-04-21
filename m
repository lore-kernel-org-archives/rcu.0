Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5068C433ED
	for <rcu@archiver.kernel.org>; Wed, 21 Apr 2021 03:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B89B61415
	for <rcu@archiver.kernel.org>; Wed, 21 Apr 2021 03:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbhDUDOE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Apr 2021 23:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbhDUDOE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Apr 2021 23:14:04 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA85CC06138A;
        Tue, 20 Apr 2021 20:13:31 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d6so12044735qtx.13;
        Tue, 20 Apr 2021 20:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fUnGKH/ZPQskGhid4V66jzQYmJVwxxXo93yIoVD9gfY=;
        b=Q3ljRnULwU+Y8mXeICsiUAwjkmhXss9PUwaVa6W+/xilYoh2YqF/thDOsUSijQ1QSO
         Mq3BnKuqtKqHdiafaMf+SimSFhOiYK4er1OhQTcAXw4lDOSUyQUB9OqzRGj8Lu6BbW3d
         uxbNjxDgi78Ub1GVU90N2UC+1ySiek2xwH2weTvRp+ptx1RstMK+W0tMc7m4ypicCngb
         nFfw9uqz1jm3j8n3UZJry47D2Y0uucfJfzsctingHKM8Lba/SucyxlOF9BPSk0APur8G
         dCFRQnIeN5sfKcwX4HJgfoZprPwYGAHpDqonct9Tr7nU57WauYPIlncalfCzRnc2oeV0
         8DgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fUnGKH/ZPQskGhid4V66jzQYmJVwxxXo93yIoVD9gfY=;
        b=VtZwq8VymTN+m6/qOuXpc75FScoyJ1zDaF+nzr5u3FRM1na7dOZtcWl+5ipKit1dz0
         iHIlkuWcq63lx8UMcn5ycIHzf6CyWXTaxkh3uT3vOy/ZSRZE33I6/F1guo7//ppxZ4NX
         qGxP72a+Fg4ly9iGEKUkNC0Ngx7KHlbOkqjxR+HhBnO7WzWM7s4ZJIWHy3nLH0fMUexQ
         FxGwqHSpaUHhVcgDeXwL3lF1mD71V2sPd8B52TpTuDedSdf0L72o2Zdw/Tl2wJ1wQsLK
         oiHA8A9bNL4pMVJvfoTzABcV9hblc4KAMSYfeDzPvooAlU7uYrt1wMx4fRf8P+6pJHNl
         drEQ==
X-Gm-Message-State: AOAM532nRCqd6uXyIXR0aNKXTSMrv0ErDxUPEAdkvpAka9X16Rg42ZRd
        lVYMEVhWzErZeG7PoH7hGCi6fTga5dg=
X-Google-Smtp-Source: ABdhPJz7WPid5YpYs/ozPGgXqbbOWTGgnhueWCtjhWxHOPz3vzTngFpkzuOGwJaxSsNBQrKv0ge3NA==
X-Received: by 2002:a05:622a:6:: with SMTP id x6mr19737161qtw.1.1618974810624;
        Tue, 20 Apr 2021 20:13:30 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id c5sm982652qkl.7.2021.04.20.20.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 20:13:30 -0700 (PDT)
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
Date:   Tue, 20 Apr 2021 20:13:25 -0700
Message-Id: <20210421031326.72816-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210421031326.72816-1-yury.norov@gmail.com>
References: <20210421031326.72816-1-yury.norov@gmail.com>
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.rst | 5 +++++
 lib/bitmap.c                                    | 9 +++++++++
 lib/test_bitmap.c                               | 7 +++++++
 3 files changed, 21 insertions(+)

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
2.25.1

