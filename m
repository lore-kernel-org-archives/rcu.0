Return-Path: <SRS0=Lsu2=7H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF641C433E4
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F37206C3
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RE8QuoBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388964AbgEYVsk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 May 2020 17:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388874AbgEYVsc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 May 2020 17:48:32 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08794C05BD43;
        Mon, 25 May 2020 14:48:30 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m12so19757602ljc.6;
        Mon, 25 May 2020 14:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rS1Miq61OoUAl0/Xis3Uv9UhAoqrmOOO+XDtwBPTCJI=;
        b=RE8QuoBvpz11xXscw/NKQU3OarX9sgIfyI5WNt5W1Biv8HvIndCiJS++QTl2IwSvJT
         ajSxI61vOnKp7pTICUiVOKWGNtWagy/vwzNvj89DSOgO1+F1TQUUg/15e/v3lOZCrQEN
         m5mKxOPbpn15RJF8FzmG7ZY9CWE+s1N+zGC/q1gjLVzvHB7Fx4E1NEgqsFq3cfrGJM7N
         QEbkhH5Gc8YjB0lP4gPDWNVGcgWrBEhzNk9DQIjbsLSaDERYqhnxl8VzdFMACBAbrB2+
         PCCQJTs807Z/SQ+oSkfzIJ4B2zyUvxemr2+C4CFS0oO8ljLhG8tclbbQDWsng/kE3gPO
         XNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rS1Miq61OoUAl0/Xis3Uv9UhAoqrmOOO+XDtwBPTCJI=;
        b=F5oAQRMB5WoXJh42AoMZ5Wf+NscyykgqBJqQ9sfhpeUyx1nWInq2O3ivX3FISkpAED
         vmLFJyeOesSXvkmVhSh6+qZA+hhN/AZqmKxwO92vosn4Jfssgs152DF/Ak68BNchFpPT
         FrIg0/ntyyh2RZQ1spBQjFD0GIfTCt6Yf6Ojj3tvrxCL2KdWsW6sClX4iOjLq3Ts1/TE
         FwNORY+EE99LwsiBSHZyBT6n2ZXfI6i9Vtzhl+CH2Sre+l0ILL1vgyYmv/aHu01WSEx5
         q2VbA1A5fZg6CcMtzz/0bYjjVUkTyZCtk+0hUjNCfkLjwGp9abFuXvIND6ltBAycCkdJ
         Y3Wg==
X-Gm-Message-State: AOAM530BR67nkjFdG+tyiGfWeGT8lz0BGkNqjRvY+8I8cbF+rZ0F5Htj
        K7uhyNDbEWUbkiS/OBsGQPNyBdTXqAGWwg==
X-Google-Smtp-Source: ABdhPJzhhlCjbYamgKHrmi7RZLTeTakbFK4kj6T3b4UqYW09i9grziwtwzfUWaRmv4ROaQgmVH9S6g==
X-Received: by 2002:a05:651c:105c:: with SMTP id x28mr14812208ljm.65.1590443308220;
        Mon, 25 May 2020 14:48:28 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a6sm2280044lji.29.2020.05.25.14.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 14:48:27 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v2 16/16] lib/test_vmalloc.c: Add test cases for kvfree_rcu()
Date:   Mon, 25 May 2020 23:48:00 +0200
Message-Id: <20200525214800.93072-17-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200525214800.93072-1-urezki@gmail.com>
References: <20200525214800.93072-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Introduce four new test cases for testing the kvfree_rcu()
interface. Two of them belong to single argument functionality
and another two for 2-argument functionality.

The aim is to stress and check how kvfree_rcu() behaves under
different load and memory conditions and analyze its performance
throughput.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 lib/test_vmalloc.c | 103 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 95 insertions(+), 8 deletions(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index 8bbefcaddfe8..ec73561cda2e 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -15,6 +15,8 @@
 #include <linux/delay.h>
 #include <linux/rwsem.h>
 #include <linux/mm.h>
+#include <linux/rcupdate.h>
+#include <linux/slab.h>
 
 #define __param(type, name, init, msg)		\
 	static type name = init;				\
@@ -35,14 +37,18 @@ __param(int, test_loop_count, 1000000,
 
 __param(int, run_test_mask, INT_MAX,
 	"Set tests specified in the mask.\n\n"
-		"\t\tid: 1,   name: fix_size_alloc_test\n"
-		"\t\tid: 2,   name: full_fit_alloc_test\n"
-		"\t\tid: 4,   name: long_busy_list_alloc_test\n"
-		"\t\tid: 8,   name: random_size_alloc_test\n"
-		"\t\tid: 16,  name: fix_align_alloc_test\n"
-		"\t\tid: 32,  name: random_size_align_alloc_test\n"
-		"\t\tid: 64,  name: align_shift_alloc_test\n"
-		"\t\tid: 128, name: pcpu_alloc_test\n"
+		"\t\tid: 1,    name: fix_size_alloc_test\n"
+		"\t\tid: 2,    name: full_fit_alloc_test\n"
+		"\t\tid: 4,    name: long_busy_list_alloc_test\n"
+		"\t\tid: 8,    name: random_size_alloc_test\n"
+		"\t\tid: 16,   name: fix_align_alloc_test\n"
+		"\t\tid: 32,   name: random_size_align_alloc_test\n"
+		"\t\tid: 64,   name: align_shift_alloc_test\n"
+		"\t\tid: 128,  name: pcpu_alloc_test\n"
+		"\t\tid: 256,  name: kvfree_rcu_1_arg_vmalloc_test\n"
+		"\t\tid: 512,  name: kvfree_rcu_2_arg_vmalloc_test\n"
+		"\t\tid: 1024, name: kvfree_rcu_1_arg_slab_test\n"
+		"\t\tid: 2048, name: kvfree_rcu_2_arg_slab_test\n"
 		/* Add a new test case description here. */
 );
 
@@ -328,6 +334,83 @@ pcpu_alloc_test(void)
 	return rv;
 }
 
+struct test_kvfree_rcu {
+	struct rcu_head rcu;
+	unsigned char array[20];
+};
+
+static int
+kvfree_rcu_1_arg_vmalloc_test(void)
+{
+	struct test_kvfree_rcu *p;
+	int i;
+
+	for (i = 0; i < test_loop_count; i++) {
+		p = vmalloc(1 * PAGE_SIZE);
+		if (!p)
+			return -1;
+
+		p->array[0] = 'a';
+		kvfree_rcu(p);
+	}
+
+	return 0;
+}
+
+static int
+kvfree_rcu_2_arg_vmalloc_test(void)
+{
+	struct test_kvfree_rcu *p;
+	int i;
+
+	for (i = 0; i < test_loop_count; i++) {
+		p = vmalloc(1 * PAGE_SIZE);
+		if (!p)
+			return -1;
+
+		p->array[0] = 'a';
+		kvfree_rcu(p, rcu);
+	}
+
+	return 0;
+}
+
+static int
+kvfree_rcu_1_arg_slab_test(void)
+{
+	struct test_kvfree_rcu *p;
+	int i;
+
+	for (i = 0; i < test_loop_count; i++) {
+		p = kmalloc(sizeof(*p), GFP_KERNEL);
+		if (!p)
+			return -1;
+
+		p->array[0] = 'a';
+		kvfree_rcu(p);
+	}
+
+	return 0;
+}
+
+static int
+kvfree_rcu_2_arg_slab_test(void)
+{
+	struct test_kvfree_rcu *p;
+	int i;
+
+	for (i = 0; i < test_loop_count; i++) {
+		p = kmalloc(sizeof(*p), GFP_KERNEL);
+		if (!p)
+			return -1;
+
+		p->array[0] = 'a';
+		kvfree_rcu(p, rcu);
+	}
+
+	return 0;
+}
+
 struct test_case_desc {
 	const char *test_name;
 	int (*test_func)(void);
@@ -342,6 +425,10 @@ static struct test_case_desc test_case_array[] = {
 	{ "random_size_align_alloc_test", random_size_align_alloc_test },
 	{ "align_shift_alloc_test", align_shift_alloc_test },
 	{ "pcpu_alloc_test", pcpu_alloc_test },
+	{ "kvfree_rcu_1_arg_vmalloc_test", kvfree_rcu_1_arg_vmalloc_test },
+	{ "kvfree_rcu_2_arg_vmalloc_test", kvfree_rcu_2_arg_vmalloc_test },
+	{ "kvfree_rcu_1_arg_slab_test", kvfree_rcu_1_arg_slab_test },
+	{ "kvfree_rcu_2_arg_slab_test", kvfree_rcu_2_arg_slab_test },
 	/* Add a new test case here. */
 };
 
-- 
2.20.1

