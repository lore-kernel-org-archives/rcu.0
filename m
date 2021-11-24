Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67A9C433EF
	for <rcu@archiver.kernel.org>; Wed, 24 Nov 2021 11:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241774AbhKXLG5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Nov 2021 06:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241705AbhKXLGj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Nov 2021 06:06:39 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0F9C06174A;
        Wed, 24 Nov 2021 03:03:29 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id t26so6111408lfk.9;
        Wed, 24 Nov 2021 03:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cdnfb6JAC8IqMAPyGf54ho4rdbZxXTjfSiWGorerRPI=;
        b=aV6/kr8THARNLo9CQffteQh8JXkHfpeQEBbDjlBEebivKiWSLjHZ2DNlb54/dvHlf8
         JCJIOSGWVXtzZtqWXQFWqTLigrx+GGDJ+97ycMBzoyOJT7akL5qoT2u/oS93R1kvE6L3
         41d0IgiXtupSnRypX7HRbZVc0364DFXvdk//jNmeAp+bN/d7poNecZFHxrXEW0FqiMzG
         I9AnXst8/hGfF+Ne0ZZJzXZh2mmaXPwyeJjEJCnfJQcXjvGzadsPuoH9EEMHKi5WRIsY
         wiSaITxdXBFTP/WFJ2Fy4DbvqjRsb9Xx1g5avh5wqzoAf63X1l6MU7AHgvMUt1+vXyLq
         4DwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cdnfb6JAC8IqMAPyGf54ho4rdbZxXTjfSiWGorerRPI=;
        b=YV2HwzyWaUh2TmCNcVA6OVaWPkptATda1Smx/j5hBvAK0UKoT2iJc50ved+0z+uqRy
         Acj4vUe0w0le3aGhCfWKu8QLp7p8UeePE/dKSDCNEP3WwIgEms27H7fQfrPV+AH/XB9w
         KRB+t1uOiWlipXg1Yi0Z5WfbOkTa7SzXlrunE+dRm95cX2ufsXFV2C44OzRSlUzJrn9w
         M64bRAKZMZem26URUyNoURPi0MKEm8zTAeiDSltcQQOCwLgI68B67YKPPUFlMGY1jVeH
         bbd5CIJHJxXgpTJaYj4m5ILCLD3oscPHjSfr4XF1jLpxNthShpFpK3I1y2y9AUpdRD7I
         plCQ==
X-Gm-Message-State: AOAM530BncYilyWdb1vTKtVtppUS0gdz0wrRIC39+iAZt4MiGBj9Nc/m
        N15mwb+0pxtatbRb6ijFI/0Jswo1vcKVZVk5
X-Google-Smtp-Source: ABdhPJyj9sK8Pw7Gg54VnENOl++u6v6xBuxa+G407WjBk+UAvR0Xte93hDoqjkoINY+vbGQ1t8UA1Q==
X-Received: by 2002:a05:6512:3da2:: with SMTP id k34mr13279306lfv.605.1637751806826;
        Wed, 24 Nov 2021 03:03:26 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id u22sm1579907lff.118.2021.11.24.03.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 03:03:26 -0800 (PST)
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 8/9] module: Switch to kvfree_rcu() API
Date:   Wed, 24 Nov 2021 12:03:07 +0100
Message-Id: <20211124110308.2053-9-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124110308.2053-1-urezki@gmail.com>
References: <20211124110308.2053-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Instead of invoking a synchronize_rcu() to free a pointer
after a grace period we can directly make use of new API
that does the same but in more efficient way.

CC: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/module.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 84a9141a5e15..f404f0c9f385 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4150,8 +4150,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
  ddebug_cleanup:
 	ftrace_release_mod(mod);
 	dynamic_debug_remove(mod, info->debug);
-	synchronize_rcu();
-	kfree(mod->args);
+	kvfree_rcu(mod->args);
  free_arch_cleanup:
 	cfi_cleanup(mod);
 	module_arch_cleanup(mod);
-- 
2.30.2

