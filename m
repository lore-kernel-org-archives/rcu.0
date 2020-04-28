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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8B0C8300C
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1DE2072A
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5++9uYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgD1U7x (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726921AbgD1U7w (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 16:59:52 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3F0C03C1AC;
        Tue, 28 Apr 2020 13:59:51 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id l19so198809lje.10;
        Tue, 28 Apr 2020 13:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bWLqr2jPDyEQcY7iSPb5llcri1orQdd6DnkilIcs6pQ=;
        b=o5++9uYpB0tejuE6SOx2AEJ39EGXaxcQzOa6BiVWFjcS7yoTvXbje74KUsJfyuRkbg
         fwJPdrquJbOLHCaxqz9Mwtl6FuSvM+KsXMnliBkFsADyVua+6KDH1fCS59qjPVtxRK0n
         dbipm1fl+eKq8q9CYpoaWufW0aRmtdGBT3+unSG/3WWIawdf3TxALo47FGzyiW/IPdJm
         nKA0oWU8najSTRkjsVD0TmMdzC33ujQapFp5uE/fLh1YLZ0yXHG+58rzxSzfgTt4eNSp
         7A45DvCSkx6V0saTuCCdtrbmkF8QTbYJ3Hrf+TmzTvnWaNoe/+pbLk046gt2RE4nFrvf
         CVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWLqr2jPDyEQcY7iSPb5llcri1orQdd6DnkilIcs6pQ=;
        b=pXTmDSGLFrOhDorqdJ5GLJwP48tfsjwfGONtN7fw6YyhYlg/3F0csn705NQAW337Vv
         wvXOZPYEeKfMc+XVkfax2P4/HsUafH9Dade0VpH1jbkwkVSr8FBT1x2ZtkLBgk/TBv7T
         Y+gcMg839LBVq/+GgdYw5iVLXjAVpQ0xg6Zh+3FpnjzP65iZJ2/PMyfeJi7o3IWXYB2J
         iTg4eRfZ0/xJU3Bxf+0HmbBoMm4axnnEuhmlo/Bm0k76DNt3LovKzc9jWn76nC7DimgO
         px4NUONGX1vh4HI/49fCuiODLoAH2zbIAfbAmUhMizaJNqT9vXsfslpf6ab1dJ1MYocP
         yR/g==
X-Gm-Message-State: AGi0PuY65ggVhg8ADYyBW5Wpy0PbRI2KRvHaWq0tMqgbmFu510jSegS4
        o5K9NvdcYRZch5h9sFfWGfJhHWhC9VgAlQ==
X-Google-Smtp-Source: APiQypK9EZpQhwaV5M+lBBDIJenVe52+/F2F7dseEsf9lWqnTDKV8zoEcohaXMvNV1qR0laI6NaBXg==
X-Received: by 2002:a2e:9018:: with SMTP id h24mr18683499ljg.217.1588107589805;
        Tue, 28 Apr 2020 13:59:49 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:49 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 17/24] rcu: Introduce 2 arg kvfree_rcu() interface
Date:   Tue, 28 Apr 2020 22:58:56 +0200
Message-Id: <20200428205903.61704-18-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

kvfree_rcu() can deal with an allocated memory that is obtained
via kvmalloc(). It can return two types of allocated memory or
"pointers", one can belong to regular SLAB allocator and another
one can be vmalloc one. It depends on requested size and memory
pressure.

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

