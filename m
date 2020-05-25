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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9621C433DF
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA982075F
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oK0yLXUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbgEYVs2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 May 2020 17:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731557AbgEYVs1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 May 2020 17:48:27 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7F6C061A0E;
        Mon, 25 May 2020 14:48:26 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c11so20000225ljn.2;
        Mon, 25 May 2020 14:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ik17svU3U29XQbLhqwF9DkU8YQ7sw6ADmoig1ExIl5o=;
        b=oK0yLXUMmFF5FfsG8+ulkLizK0+hpY4rBoPTkb7nV7T2QcpjbXrOHWDLqpXlwRu3m4
         cpHEgZHagoLqggB6XZw3U7Z5EMBXyn73WUlxG4szDEy/5NdBis46mpdYaavBV7lVEr53
         pL6JUMTe6iYJ9MXw18DSPO0y7fTGv+/w/D40aGkLANqs0eGSKrLL35ML73DOuS3iOIAu
         QxrYZ3+zUPz1Ive73j2u0d2N6NK7xon/ewslNnjgO8FPz7vY5iX55mBVziN6qlT1OBSU
         m0jOzr7OyI5uGSzkJ4MqvCculzjhE4w9LptHuuSMtyZf8ybSgnHIIbZ3ug8CNI5wmhPb
         qcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ik17svU3U29XQbLhqwF9DkU8YQ7sw6ADmoig1ExIl5o=;
        b=S04GZSKIhTmQ/FzVqZWuUpbTOSAT7pUfv7YeA46F9MiLvCxOdNvABeS6VvvzzxcK7U
         GtHyTijKCqmcPGjpFEuPjwmbU9df5zfggc67sK26rKY9e0dFHVN6pxEis2mSk8zfsdCY
         bb1MxuZ+xDZzMKZARWlVzCt44acow7le95dGhRn8hKakcHvjtj9u98Z281Xj6iCk7m9e
         zNDNsA24A+EhjlVO0GAEz5V4vpWckt1rHAMqZnJ2zYAOGoXJe4sMDfcaucY0r+7ljHLZ
         NhvQHc2drmBwmZDIGySb5BHUA4WMXCMVpQLCdbttZgq8sRAJD6my/oIxfx0oLqOyOrMt
         8IcA==
X-Gm-Message-State: AOAM532SGw7S9I//luH+UZLGxCNFJd46Fm876GHQeE+hIPFUvjP/9xpx
        2ZaHShLpPyearkNkiiczPEU555wy/my5yw==
X-Google-Smtp-Source: ABdhPJzaf0nFKQVcNe6lFV+Hv17Rsr7GTfoxNLsSnpb8/RGK0v1mlJ5VKEs+R3jKwSb+XhwZeNmY6A==
X-Received: by 2002:a2e:9586:: with SMTP id w6mr14219809ljh.274.1590443305005;
        Mon, 25 May 2020 14:48:25 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a6sm2280044lji.29.2020.05.25.14.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 14:48:24 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v2 13/16] rcu: Introduce 2 arg kvfree_rcu() interface
Date:   Mon, 25 May 2020 23:47:57 +0200
Message-Id: <20200525214800.93072-14-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200525214800.93072-1-urezki@gmail.com>
References: <20200525214800.93072-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

kvmalloc() can allocate two types of objects: SLAB backed
and vmalloc backed. How it behaves depends on requested
object's size and memory pressure.

Add a kvfree_rcu() interface that can free memory allocated
via kvmalloc(). It is a simple alias to kfree_rcu() which
can now handle either type of object.

<snip>
    struct test_kvfree_rcu {
        struct rcu_head rcu;
        unsigned char array[100];
    };

    struct test_kvfree_rcu *p;

    p = kvmalloc(10 * PAGE_SIZE);
    if (p)
        kvfree_rcu(p, rcu);
<snip>

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcupdate.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index b344fc800a9b..51b26ab02878 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -875,6 +875,15 @@ do {									\
 		__kvfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
 } while (0)
 
+/**
+ * kvfree_rcu() - kvfree an object after a grace period.
+ * @ptr:	pointer to kvfree
+ * @rhf:	the name of the struct rcu_head within the type of @ptr.
+ *
+ * Same as kfree_rcu(), just simple alias.
+ */
+#define kvfree_rcu(ptr, rhf) kfree_rcu(ptr, rhf)
+
 /*
  * Place this after a lock-acquisition primitive to guarantee that
  * an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applies
-- 
2.20.1

