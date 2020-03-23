Return-Path: <SRS0=+8aq=5I=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6DCC4332E
	for <rcu@archiver.kernel.org>; Mon, 23 Mar 2020 11:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10639206F9
	for <rcu@archiver.kernel.org>; Mon, 23 Mar 2020 11:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qS76gR8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgCWLgq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:36:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35216 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbgCWLgm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 23 Mar 2020 07:36:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id u12so14152765ljo.2;
        Mon, 23 Mar 2020 04:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GphvHmLAhceFYQBa1OZ1h7RBa7vQUlExR2ca155Stlg=;
        b=qS76gR8fwgcl4Ri1p34R8jatA1DUnG172+l7oWlwnJzP2+abTSO66DypYT9p5np6GM
         sv2zIBmkm62x18gBBOsGgvCALynAltxlcLgZByiEY7tjq884dt59n4Qu0tWsb/U+8O50
         DFLC5a//0oRw76uMPBp0mwYBT3ubmiHPIDAbyGk3ztPr13igmVBKMrnCZQF8o3PAYwkF
         81RAnFNccC2jSmglGBHpm3L0U+UpQjxu2owVW+NOoWhqLKnZlkimbGNsAJ9ieBWhH0Ct
         p/O7C0+vD/rFjN8xuvJEyfngkQf/duPKWaKKzOIlBC+DH14GitLAglVhkHPuX83GHr0F
         mDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GphvHmLAhceFYQBa1OZ1h7RBa7vQUlExR2ca155Stlg=;
        b=FPmbG8HMxknBsQe3E7eGqel+fg+tF5nOvnQw2GFcUhtoqZXKi332YE4JyE9g4+DWTL
         k3B5c0OLiQ8t2CdRbsAo4jiGeRYpQ1nAMjW9kvTLEb1TM6It0w0uzHn8Pe1timTZk75R
         a3QQWVG4exwXD+ngwm7cMIl/RizfR0IL+53L1svjWSeBF+7osi2lDIScmJYbe+xrReMN
         YZuBJ3Uw+QKEQ6JmQhmPXuC5SiOiekqeKN887MJ8Wxd8RMcjYjwIYM2uZm2Oab9udzGy
         T0AL/qnFk/DHFtZ41H58mGmdB+9P1M1xX0jp5qPM3DJiN/p+ZFw5fXL4Amm8xaETjJTj
         HSpA==
X-Gm-Message-State: ANhLgQ13oZCnuYtgF/u2C9b10AQKiw4OvDe5YyHbJNrDOGe6evHZ0MEA
        KjEUYfrOirmuci0qK7AQQkZpJJCgHHw=
X-Google-Smtp-Source: ADFU+vvBWQplGGYEHQzPeT5aUZc2YTbon7I5TlSyLNWceXWYZ5QlGyXx3t+RzLSXJ/6u7P0C3heXRQ==
X-Received: by 2002:a2e:a3d3:: with SMTP id w19mr13993303lje.232.1584963399122;
        Mon, 23 Mar 2020 04:36:39 -0700 (PDT)
Received: from localhost.localdomain (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id r23sm8079268lfi.89.2020.03.23.04.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 04:36:38 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 7/7] rcu: support headless variant in the kvfree_rcu()
Date:   Mon, 23 Mar 2020 12:36:21 +0100
Message-Id: <20200323113621.12048-8-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323113621.12048-1-urezki@gmail.com>
References: <20200323113621.12048-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Make it possible to pass one or two arguments to the
kvfree_rcu() macro what corresponds to either headless
case or not, so it becomes a bit versatile.

As a result we obtain two ways of using that macro,
below are two examples:

a) kvfree_rcu(ptr, rhf);
    struct X {
        struct rcu_head rhf;
        unsigned char data[100];
    };

    void *ptr = kvmalloc(sizeof(struct X), GFP_KERNEL);
    if (ptr)
        kvfree_rcu(ptr, rhf);

b) kvfree_rcu(ptr);
    void *ptr = kvmalloc(some_bytes, GFP_KERNEL);
    if (ptr)
        kvfree_rcu(ptr);

Last one, we name it headless variant, only needs one
argument, means it does not require any rcu_head to be
present within the type of ptr.

There is a restriction the (b) context has to fall into
might_sleep() annotation. To check that, please activate
the CONFIG_DEBUG_ATOMIC_SLEEP option in your kernel.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate.h | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index efd3dc13c36d..51ebf2461d51 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -844,12 +844,42 @@ do {									\
 
 /**
  * kvfree_rcu() - kvfree an object after a grace period.
- * @ptr:	pointer to kvfree
- * @rhf:	the name of the struct rcu_head within the type of @ptr.
  *
- * Same as kfree_rcu(), just simple alias.
+ * This macro consists of one or two arguments and it is
+ * based on whether an object is head-less or not. If it
+ * has a head then a semantic stays the same as it used
+ * to be before:
+ *
+ *     kvfree_rcu(ptr, rhf);
+ *
+ * where @ptr is a pointer to kvfree(), @rhf is the name
+ * of the rcu_head structure within the type of @ptr.
+ *
+ * When it comes to head-less variant, only one argument
+ * is passed and that is just a pointer which has to be
+ * freed after a grace period. Therefore the semantic is
+ *
+ *     kvfree_rcu(ptr);
+ *
+ * where @ptr is a pointer to kvfree().
+ *
+ * Please note, head-less way of freeing is permitted to
+ * use from a context that has to follow might_sleep()
+ * annotation. Otherwise, please switch and embed the
+ * rcu_head structure within the type of @ptr.
  */
-#define kvfree_rcu(ptr, rhf) kfree_rcu(ptr, rhf)
+#define kvfree_rcu(...) KVFREE_GET_MACRO(__VA_ARGS__,		\
+	kvfree_rcu_arg_2, kvfree_rcu_arg_1)(__VA_ARGS__)
+
+#define KVFREE_GET_MACRO(_1, _2, NAME, ...) NAME
+#define kvfree_rcu_arg_2(ptr, rhf) kfree_rcu(ptr, rhf)
+#define kvfree_rcu_arg_1(ptr)					\
+do {								\
+	typeof(ptr) ___p = (ptr);				\
+								\
+	if (___p)						\
+		kvfree_call_rcu(NULL, (rcu_callback_t) (___p));	\
+} while (0)
 
 /*
  * Place this after a lock-acquisition primitive to guarantee that
-- 
2.20.1

