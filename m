Return-Path: <SRS0=Lsu2=7H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E2FC433E2
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E87C12078B
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7gfBC+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388823AbgEYVsa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 May 2020 17:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388755AbgEYVs3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 May 2020 17:48:29 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3036AC061A0E;
        Mon, 25 May 2020 14:48:29 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id o14so22215939ljp.4;
        Mon, 25 May 2020 14:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KLIimAxShdXUGKczejB46X3ypCcUUoC/Csjl4VU2E+4=;
        b=Q7gfBC+1ILDdxSUjjcuyqOmy66V+6pob1eITQV4EIxudn8SXWItz7+TmuY6po5UZEl
         R9G15d3+16vguqYMPAqL/D0TrWStNpcWsltrDX3JiI/R75EcLxe4B/CZQwRfSgkJF1TZ
         8FV3Z7DTSed4DxB7lv4jurttunSqRoAyGXlI+7863ggIzhphlfvWC5zwrr5bYTMwc6Mb
         7m0VukxsGCtGwz0fvIXXVYHTJRYfFLwWdKFVqdMnDJApvbKB4sWYyrHf8HkPx+0wZkeq
         CMaPbWCQZQT6iYkrKqtvBoGipUmdFiDKETIBfRuYxfQkdTZraS9q1ajI3A6vUwCHazz5
         Z32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KLIimAxShdXUGKczejB46X3ypCcUUoC/Csjl4VU2E+4=;
        b=VBEeuKNCPrrTxH0pebjECAAOhnAun8FOuhJL9BTIY1rUzX0lLk+aEOiMKf7vOlGVUh
         Q1+60QE4AzlUn1P/fjXyhvhHUFzr3rqUxc7SHMcidRoDdw5wu4jbejwSmL20kozkKYEo
         QL5cif929qeSkWLo7z6nMtck0FV/hCBQUuAxvHmqZD2I/B5D2Xfv5gHUCxxtsvbJFt7N
         v6wac0FZtF3NHBQCVRs+4gibQQQtjWhCorm7iAK1IKz9jXvX7G2WFZnyQr7SDo+9O7yT
         5gZWdoY67cfRlmwopZ8gJ64UG/JkmBGIO3ZmgiAeeJgBwtblID27QDJfzMkmk1bjtkag
         whew==
X-Gm-Message-State: AOAM533rIyktsOJob4DJeJ5FeeHaCzfJX0QXt/3M977iHcrHc7/7q1YY
        NGS3zaNwG2/0+N8QAKBnkeuCSy0/g6Ji0w==
X-Google-Smtp-Source: ABdhPJwCgQgMm4h3pLJ7oGEz9S8XTUYhEdVg429I3Qh6OkWK/z20EI55Qbu6gIqTJmV4Y79ZmOYkIA==
X-Received: by 2002:a2e:9953:: with SMTP id r19mr13234097ljj.345.1590443307169;
        Mon, 25 May 2020 14:48:27 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a6sm2280044lji.29.2020.05.25.14.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 14:48:26 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v2 15/16] rcu: Introduce single argument kvfree_rcu() interface
Date:   Mon, 25 May 2020 23:47:59 +0200
Message-Id: <20200525214800.93072-16-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200525214800.93072-1-urezki@gmail.com>
References: <20200525214800.93072-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Make kvfree_rcu() capable of freeing objects that will not
embed an rcu_head within it. This saves storage overhead in
such objects. Reclaiming headless objects this way requires
only a single argument (pointer to the object).

After this patch, there are two ways to use kvfree_rcu():

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

Note that the headless usage (example b) can only be used in a code
that can sleep. This is enforced by the CONFIG_DEBUG_ATOMIC_SLEEP
option.

Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
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

