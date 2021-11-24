Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6409EC433FE
	for <rcu@archiver.kernel.org>; Wed, 24 Nov 2021 11:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241709AbhKXLGk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Nov 2021 06:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241692AbhKXLGf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Nov 2021 06:06:35 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AD6C061574;
        Wed, 24 Nov 2021 03:03:25 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id n12so6220169lfe.1;
        Wed, 24 Nov 2021 03:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6GS9qnVuLxYBDvzRkgzw+4+LD4QN5MInzOQXeRmrw4c=;
        b=P3f1cHcqNkKOo+ZzRvgAaB+6LqOoWQbDM7aIDJS4rtcJFeiOd7VanKVn8OC/F90Faq
         L6sculJ3MKjIEN+0yxGbnWChGMG6PN954z6zwSBLjQGjc7iKGWLJnL2TtezkRLKECZ+N
         dNw71c2Hjj83e7JA8J9177/IYphCCI4ueJP2aU2d/9wCV/jle1jO6WxgyjKDG6LbwrtW
         mRSD20jr0ASdEsaYMTiakchtZJR4fK91LH5IWBHRb+QIJ/9LtZaG1RQ1zDrGMCYayQ6y
         rMMXj3MIpHWXZCSeLxgP30DdXbjbj7AKrTtuo7sFBV80W/iAwR11YHGwi3YJk+86+OwU
         Etwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6GS9qnVuLxYBDvzRkgzw+4+LD4QN5MInzOQXeRmrw4c=;
        b=kXnspyXNv4uC9DCPvoeBhH97U3q4lRimcs+8L56GMPhKKJdP6SvHB58Om/xv4ap0Pl
         S/bD0v6DFoOKOrRKVtgmY8EW8qwPlvs3LpUWdn772PSyWxQX+zKpPnXDUIpOoAiGb8MH
         ytmgoFiLPQb2aOFbRnNMniQdM4pLUt0JPOGBhHbeTHoZWIEok6uWf6yeE5NUYBsgH9l2
         OsC2APmBcsSXZtdcJY4RcV029SVBAu8y93F/MUz1ToxokMA4Z4KhLhBeiH+kwNui5Jsl
         VCpX89pWki8jW+PACQFswfewiJuD4EeBcaGBtMag+flIAJpYmW7SNNoq9DqUkzxZfF65
         jgjg==
X-Gm-Message-State: AOAM533g2ZIWCuoUDWvKpeiDfiKSfKJ5j5sQdgF6uX7g5m+AghJFla/N
        YIsnh6qka1cn4xepdb/BOmOkdwh2sYCuOBfp
X-Google-Smtp-Source: ABdhPJzohli7Ud490pl1E17PQOWk3ntoxBiEWp6nSdOhtIOfiv293LJSYvfzEgyW6mD03GObn2milw==
X-Received: by 2002:a05:6512:3e09:: with SMTP id i9mr13635811lfv.239.1637751803778;
        Wed, 24 Nov 2021 03:03:23 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id u22sm1579907lff.118.2021.11.24.03.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 03:03:23 -0800 (PST)
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
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 5/9] x86/mm: Switch to kvfree_rcu() API
Date:   Wed, 24 Nov 2021 12:03:04 +0100
Message-Id: <20211124110308.2053-6-urezki@gmail.com>
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

CC: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 arch/x86/mm/mmio-mod.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
index 933a2ebad471..e75137a06c32 100644
--- a/arch/x86/mm/mmio-mod.c
+++ b/arch/x86/mm/mmio-mod.c
@@ -307,10 +307,8 @@ static void iounmap_trace_core(volatile void __iomem *addr)
 
 not_enabled:
 	spin_unlock_irq(&trace_lock);
-	if (found_trace) {
-		synchronize_rcu(); /* unregister_kmmio_probe() requirement */
-		kfree(found_trace);
-	}
+	if (found_trace)
+		kvfree_rcu(found_trace); /* unregister_kmmio_probe() requirement */
 }
 
 void mmiotrace_iounmap(volatile void __iomem *addr)
-- 
2.30.2

