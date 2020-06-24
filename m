Return-Path: <SRS0=iUCR=AF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA6DC433E2
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D13220823
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593029575;
	bh=F1qOCDwwNfeWgzfsj20Di4HSZQFe0hO7B/XOMKoeBHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KK6JJ/LMs75qCUB2rQtqyTG+/KS2Sa/PfgVgqXsCs4kdfoFEtTiQFeXhEiJiRY+0n
	 0fAsp1TdjnbK7v0T4crAyhwNMO+5ebGIHNKvAbLAkEQwn14rMDUTkA4F46DuDq9xrU
	 0o3FF8L9BQvW7Fmj4byoQY6Yd30Phe88mQgWTMcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406385AbgFXUMx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406400AbgFXUMc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Jun 2020 16:12:32 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAC6721789;
        Wed, 24 Jun 2020 20:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593029551;
        bh=F1qOCDwwNfeWgzfsj20Di4HSZQFe0hO7B/XOMKoeBHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zkbK8ZxOIXDbds8E4RML/YUz126+1VNn/MWmc8ASW+DE6tSRn7nJv8xJaEx9lMP9H
         tUdc72fsClxUrH2GkWXo2yZEnZh1AybkeqYvMlPLK+0Bctyt3/zpNnYZlST9ZIPfVW
         +fEk3EvkKKetQDTq5/+g9G7gOeBoCady9WIuPHu4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 17/17] lib/test_vmalloc.c: Add test cases for kvfree_rcu()
Date:   Wed, 24 Jun 2020 13:12:26 -0700
Message-Id: <20200624201226.21197-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200624201200.GA28901@paulmck-ThinkPad-P72>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Introduce four new test cases for testing the kvfree_rcu()
interface. Two of them belong to single argument functionality
and another two for 2-argument functionality.

The aim is to stress and check how kvfree_rcu() behaves under
different load and memory conditions and analyze its performance
throughput.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/test_vmalloc.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 95 insertions(+), 8 deletions(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index ddc9685..5cf2fe9 100644
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
 
@@ -316,6 +322,83 @@ pcpu_alloc_test(void)
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
@@ -330,6 +413,10 @@ static struct test_case_desc test_case_array[] = {
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
2.9.5

