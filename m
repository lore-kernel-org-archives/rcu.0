Return-Path: <SRS0=frk5=5S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C77C2BA18
	for <rcu@archiver.kernel.org>; Thu,  2 Apr 2020 12:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC44C2078E
	for <rcu@archiver.kernel.org>; Thu,  2 Apr 2020 12:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlZDoiBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388114AbgDBMdK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:33:10 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45786 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbgDBMdJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 2 Apr 2020 08:33:09 -0400
Received: by mail-lf1-f65.google.com with SMTP id f8so1188458lfe.12;
        Thu, 02 Apr 2020 05:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3oNMXTSVy6jGvNXMWanVwf0wUd7Pg4Fz/TBszTFSFfc=;
        b=OlZDoiBaVRrpoMJPay8t+WC3BkVs+tt0VdHzuxgyBkOT2r6MXRPRUR9UJ0//vbVKNv
         bEWbizoTcF9IbGwXwBzEr1QZyX42bIzYKshqx8sGRId4dnGSWFNjOMFTdV+0eMME1DeS
         lYCWaeujh92t6PK/3Saxj2ffSYTY4/ZZBTKMOL0xLNZmbDxsjz/5dRkjX5SNfaze+KzJ
         ldQi7LMb+Vdz9SLtHsf0gYNmjpqxfasnvbKtbTT1gU9kBstPflxXVihIlY4I+vOBFCD1
         U/iR2GDM7Evm8MoRLlRmY/qJT3D7jJ8P6GzScjGq7s1zwoZi/mj/jeDNjd0el+pgyDeT
         gfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3oNMXTSVy6jGvNXMWanVwf0wUd7Pg4Fz/TBszTFSFfc=;
        b=b+P34095/3h7tbasqK2wJdrme7qW2xljOInoY8Xw0ksiyl02/Gtwi1hVHus1uUK0Nb
         JOMwhwtEG+fkNds+gfd3q4W/hFdSIUN5XZRPIpod9sq8o5hyjG+8YDAYcOUHLnE0tvtv
         j+LbxZTwjszE7/juOoCrvPUUldI3RetpAccyvtT+YkWKcU4u2DF6H3NiOnZLGBI1LF60
         lrST1uFkDxGOf6m+yKS8zzA2uLZ8j6Hbfpo8p4fGXSfxEhpQ/5nOy6Qo2Ve/M0w3BDnl
         51+EstOygCvJ3cEOt4kgMYcTtZSMFNV3MFfzbKU87BQRSRW24C1vjOHzz05MmVGTgVx5
         85Yg==
X-Gm-Message-State: AGi0Pua8r+3Vfsl+fHquVaF2HmimtXwh3QzsYzrAO6stxQLlWvJkIpoS
        Qhv6YUqLgzBue5K1J33Ql+TBEWE+FRs=
X-Google-Smtp-Source: APiQypKnYbGd+eszPt18ZrxvAEAYuoPzYQvfhiUJdasXhLB4S4rCjVPMPTpyxWOGOWWeRpXnluqc0Q==
X-Received: by 2002:a05:6512:3f4:: with SMTP id n20mr1966754lfq.185.1585830785323;
        Thu, 02 Apr 2020 05:33:05 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id u25sm3833494lfo.71.2020.04.02.05.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 05:33:04 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 3/3] lib/test_vmalloc.c: introduce two new test cases
Date:   Thu,  2 Apr 2020 14:32:53 +0200
Message-Id: <20200402123253.10382-3-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200402123253.10382-1-urezki@gmail.com>
References: <20200402123253.10382-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Introduce two more test cases which are specific for RCU
freeing of vmalloc pointer. One test case is for object
that has rcu_head inside and second one is for headless
testing.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 lib/test_vmalloc.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index 8bbefcaddfe8..1734ba7fc400 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/rwsem.h>
 #include <linux/mm.h>
+#include <linux/rcupdate.h>
 
 #define __param(type, name, init, msg)		\
 	static type name = init;				\
@@ -43,6 +44,8 @@ __param(int, run_test_mask, INT_MAX,
 		"\t\tid: 32,  name: random_size_align_alloc_test\n"
 		"\t\tid: 64,  name: align_shift_alloc_test\n"
 		"\t\tid: 128, name: pcpu_alloc_test\n"
+		"\t\tid: 256, name: kvfree_rcu_with_head_test\n"
+		"\t\tid: 512, name: kvfree_rcu_head_less_test\n"
 		/* Add a new test case description here. */
 );
 
@@ -328,6 +331,49 @@ pcpu_alloc_test(void)
 	return rv;
 }
 
+struct test_kvfree_rcu {
+	struct rcu_head rcu;
+	unsigned char array[100];
+};
+
+static int
+kvfree_rcu_with_head_test(void)
+{
+	struct test_kvfree_rcu *p;
+	int i;
+
+	for (i = 0; i < test_loop_count; i++) {
+		p = vmalloc(1 * PAGE_SIZE);
+
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
+kvfree_rcu_head_less_test(void)
+{
+	struct test_kvfree_rcu *p;
+	int i;
+
+	for (i = 0; i < test_loop_count; i++) {
+		p = vmalloc(1 * PAGE_SIZE);
+
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
 struct test_case_desc {
 	const char *test_name;
 	int (*test_func)(void);
@@ -342,6 +388,8 @@ static struct test_case_desc test_case_array[] = {
 	{ "random_size_align_alloc_test", random_size_align_alloc_test },
 	{ "align_shift_alloc_test", align_shift_alloc_test },
 	{ "pcpu_alloc_test", pcpu_alloc_test },
+	{ "kvfree_rcu_with_head_test", kvfree_rcu_with_head_test },
+	{ "kvfree_rcu_head_less_test", kvfree_rcu_head_less_test },
 	/* Add a new test case here. */
 };
 
-- 
2.20.1

