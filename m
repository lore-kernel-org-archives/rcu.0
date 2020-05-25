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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF06AC433E0
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE7A02078B
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCYyc5EZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbgEYVsP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 May 2020 17:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgEYVsO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 May 2020 17:48:14 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CCCC05BD43;
        Mon, 25 May 2020 14:48:14 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c11so19999863ljn.2;
        Mon, 25 May 2020 14:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uuS6fohvwHxuxWslRa3zOPr8O2j4OSUqCY5jL2HzmNU=;
        b=oCYyc5EZyHOL7pZjQCoROI4cZ7ULkiquYBF6HgEf+xj0qvTO/WfJp/9ksJNHuwAW42
         jb4i+YHZK+iYQmSS0jE7yB7qXRO4BUBgpi6FlsphLeExsSAw6Ocz/pm1/jsYkK06L/62
         YVvcqo08OBHInb6GIAoCCdqp79ZMpz73UTzIUY7G7MbGMjnwATjkvVA8htZ8P3cviT3S
         uZgnzRf82KNhueY1bygWe3QbX31XJSqrmPl/p77bhm8kKLCDURdSZcVFzSdmi6BimqWU
         s57xfoqdk5SaNCBIamiosFZNsms7W+239z0nlblFvmGpRWrEsokCqmQ3fGjEyGWRgLjM
         EroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uuS6fohvwHxuxWslRa3zOPr8O2j4OSUqCY5jL2HzmNU=;
        b=lKVonjInBGwuBpuGoCuRV8WVJTIM+zl/pyTByQHaQxjwb+FTe5DsdpozA7kzMmT4yt
         mF+82TjAb/SPa+RMeEor/IDP86g0olCVGETEN4AvqJ8tB8YYJXcpL9PUFjdOFah0gX67
         mN601RfU+xj82D+L30IW7TtBQ2XUhiWmnYO2n7ROyK0ltLf7dfDSiMbi/4l8WR0gdL5y
         HFEZmf/P8bDtVsCeXxisFTs4CAs0mLCvt0a+ckMKyUZhY9cKz/GqXDHsHoWm54ggb11C
         LlbmCCHlAvUzK5QZiBqzpvoNTJezsNmRDVoVIjl6F/mLaFeXrfBLyU05+90N3/HiaSw5
         njYA==
X-Gm-Message-State: AOAM533J0C8bwuYiUKzVic+jaC7iNYKEyT92SNY+HhXjhXA3kEbtIhe4
        TWa7WYlKrRL78HDPo8keH6KSvYW6fzSYgA==
X-Google-Smtp-Source: ABdhPJzeCk2tHSENorydlmBycYrCOOWzwq7850vGWkJweiyMNVAzHv3gLgrw3ynteKptKefS6PxAKQ==
X-Received: by 2002:a2e:9d45:: with SMTP id y5mr13895293ljj.258.1590443292528;
        Mon, 25 May 2020 14:48:12 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a6sm2280044lji.29.2020.05.25.14.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 14:48:11 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 02/16] rcu/tree: Skip entry into the page allocator for PREEMPT_RT
Date:   Mon, 25 May 2020 23:47:46 +0200
Message-Id: <20200525214800.93072-3-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200525214800.93072-1-urezki@gmail.com>
References: <20200525214800.93072-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

To keep the kfree_rcu() code working in purely atomic sections on RT,
such as non-threaded IRQ handlers and raw spinlock sections, avoid
calling into the page allocator which uses sleeping locks on RT.

In fact, even if the  caller is preemptible, the kfree_rcu() code is
not, as the krcp->lock is a raw spinlock.

Calling into the page allocator is optional and avoiding it should be
Ok, especially with the page pre-allocation support in future patches.
Such pre-allocation would further avoid the a need for a dynamically
allocated page in the first place.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
Co-developed-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6e967a9d6704..d28010cf158b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3068,6 +3068,18 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
 		if (!bnode) {
 			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
 
+			/*
+			 * To keep this path working on raw non-preemptible
+			 * sections, prevent the optional entry into the
+			 * allocator as it uses sleeping locks. In fact, even
+			 * if the caller of kfree_rcu() is preemptible, this
+			 * path still is not, as krcp->lock is a raw spinlock.
+			 * With additional page pre-allocation in the works,
+			 * hitting this return is going to be much less likely.
+			 */
+			if (IS_ENABLED(CONFIG_PREEMPT_RT))
+				return false;
+
 			bnode = (struct kfree_rcu_bulk_data *)
 				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
 		}
-- 
2.20.1

