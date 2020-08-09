Return-Path: <SRS0=RTr5=BT=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48100C433E3
	for <rcu@archiver.kernel.org>; Sun,  9 Aug 2020 20:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23E75206A2
	for <rcu@archiver.kernel.org>; Sun,  9 Aug 2020 20:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPiShrji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgHIUoJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 9 Aug 2020 16:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgHIUoI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 9 Aug 2020 16:44:08 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24ABC061786;
        Sun,  9 Aug 2020 13:44:07 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t6so7432340ljk.9;
        Sun, 09 Aug 2020 13:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uuKzMy8ewGXUSBJtIFW0KX3RN99yxbeLmlHXP4MWBpY=;
        b=oPiShrjiXPEdy2Cco0DaYWuVYysn0jRQlB+C7ArO0yieudE5NAPxFgcc78p6eCl6xQ
         eUYcIXo3hUVx6AeVpVePfK4c1s4oxxqecRJST0kCQRYovO+T6bv/0FIhNs7vbqeo8wjB
         EameDLmP6EniKNI0ezXFKoLzlNbtBaBOyvLrWiYI4iLyBsvrRIBQ1buAzjRdl8gRzcVF
         6Q2n1w99ZlOq+QtQcheIWmvxXVovkoko4w+eKO/NrpSFYVbi0P1cF5MciP9XteH+Lbc1
         SXNF/RYhb0uAEfjx1sfex+S+O2DRjg9b4+oCIGIdgJAdfKCnik70hP7mk+cjjUsUbZgb
         b/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uuKzMy8ewGXUSBJtIFW0KX3RN99yxbeLmlHXP4MWBpY=;
        b=YwiLSHvOaGbOhIhSGDDhpTW4OmQXfRoWCucNLOlVUCfxwpA674mKNBAfGtAVcMB5vl
         thZ2ED7S2n8tcaoFxwIxswb6fN6hAJJh2NILzqvroWjj/PmwjNMQZg4FP4dR4hn/+FwJ
         ai52RZMjAYjK610veUNV29IZesjPkMXDUoUwGR06cR+6PBPoT7J8aRuE1LRJsDVeLRjk
         j0ClLnkr7UDM6L6ZDGzE3RGs2u5v9aiVCnBI6bGYPTYmSqL5zavEN9gKCzYlAdIyrFCy
         YoFhug4Ctqxkgy9j20EbB385WUAdeEUeRgAtdsPTAZkg7Ek3MYPa0EU65a9H2uPb9xWd
         8PhA==
X-Gm-Message-State: AOAM533F57eBHIt7YT10LjeQ0tQMaJeh07SOAD1XQXzTt1MFY7xJRBdw
        epo1xsz7ry4ur4FulirFmeYyECG6qM4=
X-Google-Smtp-Source: ABdhPJze7IbNW/h8CDiwh7ppwJgta/7FPLU8nmFubdLHUR0XB3cjuCTYs4AdpvuvPw70SotORU6WdQ==
X-Received: by 2002:a2e:8084:: with SMTP id i4mr11562182ljg.447.1597005846020;
        Sun, 09 Aug 2020 13:44:06 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id c17sm9529603lfr.23.2020.08.09.13.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 13:44:05 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 2/2] rcu/tree: use __GFP_NO_LOCKS flag
Date:   Sun,  9 Aug 2020 22:43:54 +0200
Message-Id: <20200809204354.20137-3-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200809204354.20137-1-urezki@gmail.com>
References: <20200809204354.20137-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Enter the page allocator with newly introduced __GFP_NO_LOCKS flag
instead of former GFP_NOWAIT | __GFP_NOWARN sequence. Such approach
address two concerns. See them below:

a) If built with CONFIG_PROVE_RAW_LOCK_NESTING, the lockdep complains
about violation("BUG: Invalid wait context") of the nesting rules. It
does the raw_spinlock vs. spinlock nesting checks, i.e. it is not legal
to acquire a spinlock_t while holding a raw_spinlock_t.

Internally the kfree_rcu() uses raw_spinlock_t whereas the page allocator
internally deals with spinlock_t to access to its zones. The code also
can be broken from higher level of view:
<snip>
    raw_spin_lock(&some_lock);
    kfree_rcu(some_pointer, some_field_offset);
<snip>

b) If built with CONFIG_PREEMPT_RT. Please note, in that case spinlock_t
is converted into sleepable variant. Invoking the page allocator from
atomic contexts leads to: "BUG: scheduling while atomic".

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 30e7e252b9e7..48cb64800108 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3327,7 +3327,7 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 			 * pages are available.
 			 */
 			bnode = (struct kvfree_rcu_bulk_data *)
-				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
+				__get_free_page(__GFP_NO_LOCKS);
 		}
 
 		/* Switch to emergency path. */
-- 
2.20.1

