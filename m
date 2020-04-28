Return-Path: <SRS0=nxXf=6M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F04FC83004
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B23F2072A
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uT3JK0wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgD1VAL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727079AbgD1VAC (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 17:00:02 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA30C03C1AE;
        Tue, 28 Apr 2020 14:00:02 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f11so264280ljp.1;
        Tue, 28 Apr 2020 14:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7dg4vvvuMGvUTLvHmWPN1Rrhqpd5aScShP8yFUvMy+A=;
        b=uT3JK0wksSzmJdp1AC64KvjdyD8rxvkukt3pYhWUvkn+XTCa1XhRcC+h0weAIylNWW
         5f0SOqHWyVHCSEHwX0q9HOjNPsnQn42cRtWxBuBvHzaC4KYuVFI22rxKRLywnxBir/XK
         7mo2M71F/Fmv3ZXo9S/zpiGNWQNvBtZzOpNyeJdWgvfgG3JM1QS8l895wLB4DQihVrdx
         5EPpzOGrTUGGfDLSf5MINED8eLwhxcNiA2XALr0K0t/iQOUh4koXDkHGBZ1ILsTEC2DJ
         g+LhG8On/9yrFZsL4Prg7zlIOUN0NJPUPcjH+ZC/4g0/Cj4+e11UHQqtKK4OgncU4gKV
         gHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7dg4vvvuMGvUTLvHmWPN1Rrhqpd5aScShP8yFUvMy+A=;
        b=NtFYIBxy4bqPusJT7w20Z8tA3PRALdKv+z//JV7TbJL8G1osiTG3/e6uhY0jUoQBpk
         L1fkXQ4pJR/o7fkoUX5XQzqsaUaupAZj//yo5vi3IyKuHyu0fEptkYk8485ZY0XwP9rn
         fR7JADLOkQ38WaEvBW0LZeMwBB7eTzElc6hmi0FPgY9rTynS4EpgF6aUBswztzBDDyzH
         5AOZIIaKhFlNf0q7bz1DD/7zVWdhee2tj8UH6MMs4py9ekj9lzi4T7kp6yUUNr/wKGP/
         M1pRzysLPAEQLDzno1oNnBObvLVu1CdlJfJeUybyvcWkE4hqolLUOVeqAjlPuFATfuuw
         HAVg==
X-Gm-Message-State: AGi0Puan9n+wjjRqwjTUXoj5CrtUqClpMVRhVZOhIavU3FLrC9nb6CGn
        fQPpKJDkErkEIRYVjsJ/Odj2XGwb8KYJ3A==
X-Google-Smtp-Source: APiQypJ74RE+BeVO/a4be2iqMHLz/Sbx0gEUw9T9zhqkEcIjYEMEfzVvNufri7CsMeJjoPs58csz2Q==
X-Received: by 2002:a19:644f:: with SMTP id b15mr274982lfj.28.1588107600253;
        Tue, 28 Apr 2020 14:00:00 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:59 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 23/24] rcu: Introduce 1 arg kvfree_rcu() interface
Date:   Tue, 28 Apr 2020 22:59:02 +0200
Message-Id: <20200428205903.61704-24-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
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

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate.h | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 51b26ab02878..d15d46db61f7 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -877,12 +877,42 @@ do {									\
 
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

