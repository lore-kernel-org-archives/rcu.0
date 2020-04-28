Return-Path: <SRS0=nxXf=6M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B33BC8300B
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 445E82072A
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMGZ+fe6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgD1VAE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727088AbgD1VAD (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 17:00:03 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43357C03C1AC;
        Tue, 28 Apr 2020 14:00:03 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w20so270398ljj.0;
        Tue, 28 Apr 2020 14:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pFz29Ncgyaz8z/1Qp2+b1WJTbiL+UppT5lx2exYc8qs=;
        b=nMGZ+fe6xiYOw++aC//Z8OF1EzE9mTIAXdtY2wYZBb4quZdq+MAuktQTFSZimsBMfv
         yr21ycB+3x8EE/b74Vi1nlowx9liJrqN0hO2NzaxZ09mbYg4k5xi/sFv5/E/hf/J9SV/
         e68LuotEDHAqBbYzGSwp7SvvkcwdYmbSeLMoXn5Qq0UJyehqB8pu8BGqUIsvl4CBGCPP
         usSTKwwlhyWEonVJtNoaJp5318qEf+frWelZvLRGS7Lrr9DEw+4lr1MSFUEtPNnVYlp2
         ZiNz53ok5DGi27Ny8bImfXSRM6zS9vQSS6Ac2KO1RkonVz58KfwAw+Yk1vsf5eAAN/0f
         KU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pFz29Ncgyaz8z/1Qp2+b1WJTbiL+UppT5lx2exYc8qs=;
        b=I4/F6eKkrFXf7TEt/Lk+PNqJRzoauriEDszQ5f2UPrQvlv2nufWco5VIznNtfUsF33
         LGq4Wv2WxrsqcLJtteU1+aG2rIOa9w8AQ5oANCxlMFKExpAARoIINIQXfLzIZcH3+WQ/
         ifyGm2sN+GdAUQ5h6J2GEtj9qOXBo75cqoGPkN66UDVP+UR0ExQA2b3m4NCH8fd/skjF
         R5eMt9bKF82lprKe2bF4ovrji5soSHYuJ91L2DARtCfzLzQwWbamI9kgkf+w93fvWhXa
         tkfvX3nZiHaozU3vcDLxp2JpZezrrkD5ZsCiQqHbMOs3bIsAD/eWOQUKPVYa7xdO8Quh
         ZhVQ==
X-Gm-Message-State: AGi0PubpnYUwmqTo7SnWOSgoA7lAzNd6vscM7AWzGAxrF/7Lv5YkJiRz
        +Ilr9HvakrUlKbScBc6dVqZwPIM0f8iGkA==
X-Google-Smtp-Source: APiQypLE5mxTFoU3KAMfpCj2cbiae08hkJfL0cpRwE+8diBE7xGLdv5s1UOvFjgkkhBVYoqWhWEgHQ==
X-Received: by 2002:a2e:8083:: with SMTP id i3mr18677202ljg.175.1588107601389;
        Tue, 28 Apr 2020 14:00:01 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.14.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 14:00:00 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 24/24] lib/test_vmalloc.c: Add test cases for kvfree_rcu()
Date:   Tue, 28 Apr 2020 22:59:03 +0200
Message-Id: <20200428205903.61704-25-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Introduce four new test cases. They are considered to
cover and testing of kvfree_rcu() interface. Two of
them belong to 1 argument functionality and another
two for 2 arguments functionality.

The aim is to stress it, to check how it behaves under
different load and memory conditions, analysis of the
performance throughput and its impact.

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

