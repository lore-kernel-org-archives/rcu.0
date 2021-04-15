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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35815C43460
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 17:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0042861074
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 17:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbhDORUm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Apr 2021 13:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbhDORUj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Apr 2021 13:20:39 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA55AC061756;
        Thu, 15 Apr 2021 10:20:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f17so33349877lfu.7;
        Thu, 15 Apr 2021 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZIMrQiNOYVJWHSh4ss4poBQzNSgDemJ0bNZqAsIHVs=;
        b=Xh/ZOHufM8Q6xlF1ImkpnEQOUZVSA07tJL3QIkKA4VXMd2eNzTQh0GBUFl7Nk6tSKK
         Xq6qgO4ZGauNqn0nOo+lg8KU1OOljQ3R44/LB8gq+ab6aKFVcDPINFMVkmfL1HumYw6Q
         Me3z58OzgwAc1DxIdbmxBtL16f9JZmcEVl23dw3i6LdkpI5mwjqrKQPh4ttzXpalaDU1
         VjqlOUon+5WFe2/OBON4UsmsZNp1s/1rDnvdLLOYy3XU7gnD4WE+MpBQDR17CglZm3dk
         IOcA7Ck+NL9Adr1MCHZcQJ3iQCvAshiuiPzZ77A8ehkKcd+M10fxMbkmzJjY4ZRP7/lT
         i6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZIMrQiNOYVJWHSh4ss4poBQzNSgDemJ0bNZqAsIHVs=;
        b=rJxylRIVTzJxFmzf77HaIRFOnaGbLMx2zrBUEwDiUWt8m7zaO2F4jC1P6kMgxdQ6Xi
         5imjbO0VabKCdfR0IfwdcqrvXBBGmkmao8X6xj+TSYjlGFFaBy6/y3A/731TKyiYbuEz
         LrAFVIyBNX5dpbesGc4Uz08fTtDk/4qkMh0jqOIHp++iXvT0inB9rw9crO2lbpT2zAA9
         XHp9LjPAgWqTBAf4W6mZTJ2bQrtrSzvP5Z9AVzdX0jjkDrmpMDy62i8d31o+TMrkwcRM
         De/TWt99kC8qz33uh2lX6DTME51s5Mqg4ihjf3Gjjr9jxLiPPectNdW2hrvvhO6zyM8p
         6b8A==
X-Gm-Message-State: AOAM533OdOPqNQng3jPA4qCREQz/Wv3eLvszmtqaaMjq6V+1DJRT3gQx
        MRjU0vcW4OP/V7yKocYJWv2N1Ax3G4EPoA==
X-Google-Smtp-Source: ABdhPJy/hwgFRhjhIVyunJFdJ+M1yFapg0KB1nnT7zIcTK8BEUY3jHP1WQO3GyIOSGe55RLzfS/wIw==
X-Received: by 2002:a05:6512:b81:: with SMTP id b1mr143493lfv.345.1618507214157;
        Thu, 15 Apr 2021 10:20:14 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id t6sm84358lff.276.2021.04.15.10.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 10:20:13 -0700 (PDT)
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
Subject: [PATCH v2 3/5] kvfree_rcu: Add a bulk-list check when a scheduler is run
Date:   Thu, 15 Apr 2021 19:19:58 +0200
Message-Id: <20210415172000.15086-4-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210415172000.15086-1-urezki@gmail.com>
References: <20210415172000.15086-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

RCU_SCHEDULER_RUNNING is set when a scheduling is available.
That signal is used in order to check and queue a "monitor work"
to reclaim freed objects(if they are) during a boot-up phase.

We have it because, the main path of the kvfree_rcu() call can
not queue the work untill the scheduler is up and running.

Currently in such helper only "krcp->head" is checked to figure
out if there are outstanding objects to be released. And this is
only one channel. After adding a bulk interface there are two
extra which have to be checked also: "krcp->bkvhead[0]" as well
as "krcp->bkvhead[1]". So, we have to queue the "monitor work"
if _any_ corresponding channel is not empty.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 07e718fdea12..3ddc9dc97487 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3712,7 +3712,8 @@ void __init kfree_rcu_scheduler_running(void)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		raw_spin_lock_irqsave(&krcp->lock, flags);
-		if (!krcp->head || krcp->monitor_todo) {
+		if ((!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head) ||
+				krcp->monitor_todo) {
 			raw_spin_unlock_irqrestore(&krcp->lock, flags);
 			continue;
 		}
-- 
2.20.1

