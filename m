Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73BDC433E0
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4E122D01
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbhAFBTN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 20:19:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbhAFBTN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 20:19:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DED8230FD;
        Wed,  6 Jan 2021 01:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609895872;
        bh=JZ/A0Ej4DAs1pgQNQqM4FCqjxD7UEtQkZzWwKn4VsH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hpZfLkbTX/cwRuUA535Txxwqp3jKj2UGCk47A6JOieqgFc0C03FDtut6txIvNx0Ts
         wHYqAN3rEEz2sdRjaz2deuyZn2og00LJ0xe8haAgs2jr04EXTRNhS1AFkTOek5PBMC
         U8s/EyykT+Zn5RuXGNIcppzXnqYv2l3IjXXINpM3t7zPEbXIJLzezw/vEhs4v394zG
         llIiCBQt63QL0nGZxPxssMw7KUebJEjOJFdqrYeAdbzF6GvfMEHnGyDkjT0GTee9Sm
         nVxtv0HJT8wNAjkMHq7Jipzrec/vXRSI+sJdHott0mJaA31KUcP0KGhAisNjcDLRGp
         M///Q36MEEj3w==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-mm@kvack.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        ming.lei@redhat.com, axboe@kernel.dk, kernel-team@fb.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH mm,percpu_ref,rcu 6/6] percpu_ref: Dump mem_dump_obj() info upon reference-count underflow
Date:   Tue,  5 Jan 2021 17:17:50 -0800
Message-Id: <20210106011750.13709-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106011603.GA13180@paulmck-ThinkPad-P72>
References: <20210106011603.GA13180@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Reference-count underflow for percpu_ref is detected in the RCU callback
percpu_ref_switch_to_atomic_rcu(), and the resulting warning does not
print anything allowing easy identification of which percpu_ref use
case is underflowing.  This is of course not normally a problem when
developing a new percpu_ref use case because it is most likely that
the problem resides in this new use case.  However, when deploying a
new kernel to a large set of servers, the underflow might well be a new
corner case in any of the old percpu_ref use cases.

This commit therefore calls mem_dump_obj() to dump out any additional
available information on the underflowing percpu_ref instance.

Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/percpu-refcount.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index e59eda0..a1071cd 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -5,6 +5,7 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/percpu-refcount.h>
 
 /*
@@ -168,6 +169,7 @@ static void percpu_ref_switch_to_atomic_rcu(struct rcu_head *rcu)
 			struct percpu_ref_data, rcu);
 	struct percpu_ref *ref = data->ref;
 	unsigned long __percpu *percpu_count = percpu_count_ptr(ref);
+	static atomic_t underflows;
 	unsigned long count = 0;
 	int cpu;
 
@@ -191,9 +193,13 @@ static void percpu_ref_switch_to_atomic_rcu(struct rcu_head *rcu)
 	 */
 	atomic_long_add((long)count - PERCPU_COUNT_BIAS, &data->count);
 
-	WARN_ONCE(atomic_long_read(&data->count) <= 0,
-		  "percpu ref (%ps) <= 0 (%ld) after switching to atomic",
-		  data->release, atomic_long_read(&data->count));
+	if (WARN_ONCE(atomic_long_read(&data->count) <= 0,
+		      "percpu ref (%ps) <= 0 (%ld) after switching to atomic",
+		      data->release, atomic_long_read(&data->count)) &&
+	    atomic_inc_return(&underflows) < 4) {
+		pr_err("%s(): percpu_ref underflow", __func__);
+		mem_dump_obj(data);
+	}
 
 	/* @ref is viewed as dead on all CPUs, send out switch confirmation */
 	percpu_ref_call_confirm_rcu(rcu);
-- 
2.9.5

