Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2977DC43470
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 17:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10CC461074
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 17:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhDORUn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Apr 2021 13:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbhDORUk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Apr 2021 13:20:40 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E528C061760;
        Thu, 15 Apr 2021 10:20:16 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 12so40238914lfq.13;
        Thu, 15 Apr 2021 10:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zrr3A+ylD8uq1+KzwyldGlESbE7f2npVDTmbSupGE64=;
        b=EOwOX0BYV86eOQ+Kj9NPv3isScuVKOEdJODiLWX6zZ96jFKf7c1SiEFX7u72SWei/6
         xwraMe0RXvC4VHYdra0WNOoQCSor5HZxc6J+HHeHeAcVS0E2s1YyNlEKq4CaQtRFNFuv
         U0eUlNFn/gxPJgDm0nqAPp8lCtm3BPwG/GRQVyKC2o3k+mjksFWDi1aKmAQYkzA69an7
         b8oIQ0vBpo3f9bcoWyc+CWBLZe8WBhr/gCx4GnT4zu5nRrOYLIBoOnZy8bmTYrHetW7s
         n7lMMIK1vfVy+Iq6UdZty+TH7PscubjMcIxPrY8VqO2KAmF/5Oh3ez9aFmRdJhAZqaiT
         oleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zrr3A+ylD8uq1+KzwyldGlESbE7f2npVDTmbSupGE64=;
        b=VT/H6lIPieODNH34MNSkt6r7dCOTp6TRXiGMmm39pIo6OzDToAe/705RqYsvkRtWOq
         Epxi2XP3hBw+yMk2luwgqqIqJ/yz+TqksPnc+Hdc7wfPNzc3pTL24gAM6KO3jVJGRWW4
         Cn6B4lfG2dNexNjiGcZmwiI7P1u//0pQe96dLFHL+5VaivT4KSC+qmsgoJ0dXhWza5I/
         JFfa0ttMJuxo7UQMFWyk0BHNgVWn5063W9J8Y2CS8wNHQh+v4aB9/p9ZOEq/s+D1TwE0
         iyFbblddLboTF37AHMpJxTF6UAHH3C3abq+/witwN086fMzPj4NtmBXPXnQDNPZdLPzy
         sVeQ==
X-Gm-Message-State: AOAM531LxT0c76TIJyFrzjJ3Ke9iFIkQLJwOVAqnoapzyszr0VEvaVXP
        wJnnwK5WBdg92IwvZxFb6+fohRd/WORYWA==
X-Google-Smtp-Source: ABdhPJw4mUYUJBI4brv7W7MAnpH9X1iMcnTCvLwKgUvTDNeI1l7XV42xnC54JB6Fr+hY/3uf1kh/Hw==
X-Received: by 2002:ac2:4d11:: with SMTP id r17mr160396lfi.92.1618507215135;
        Thu, 15 Apr 2021 10:20:15 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id t6sm84358lff.276.2021.04.15.10.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 10:20:14 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v2 4/5] kvfree_rcu: Update "monitor_todo" once a batch is started
Date:   Thu, 15 Apr 2021 19:19:59 +0200
Message-Id: <20210415172000.15086-5-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210415172000.15086-1-urezki@gmail.com>
References: <20210415172000.15086-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Before attempting of starting a new batch a "monitor_todo" var.
is set to "false" and set back to "true" when a previous RCU
batch is still in progress.

Drop it to "false" only when a new batch has been successfully
queued, if not, it stays active anyway. There is no reason in
setting it force and back.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3ddc9dc97487..17c128d93825 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3415,15 +3415,14 @@ static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
 					  unsigned long flags)
 {
 	// Attempt to start a new batch.
-	krcp->monitor_todo = false;
 	if (queue_kfree_rcu_work(krcp)) {
 		// Success! Our job is done here.
+		krcp->monitor_todo = false;
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 		return;
 	}
 
 	// Previous RCU batch still in progress, try again later.
-	krcp->monitor_todo = true;
 	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
-- 
2.20.1

