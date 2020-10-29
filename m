Return-Path: <SRS0=ZNv1=EE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03E9C4363A
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76ED7214DB
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4fnn4X8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgJ2Quq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbgJ2Qup (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 12:50:45 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CDDC0613D8;
        Thu, 29 Oct 2020 09:50:43 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 184so4185678lfd.6;
        Thu, 29 Oct 2020 09:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J0lqGBTdhz6aUz3zIPQpgMiqURbZy/P6PGnHrNdM2K0=;
        b=F4fnn4X8wMuPwyF7MCqfSD+BpTS399rwGAgA7YgYngp3TGGBQOY0/B8bzVk7xtovKW
         F0TKbRJ4NYi4RAJi5svZ4FBqf5yLrExLwgbFUk0PAq/ypYDHT6fw2VqgTfz4ke7gCkxe
         HG0X6jYc5fJ2w0GorikdwpbOCUPCfhua5h2JypKkaAZFlLjavcxr8jwFYCB2qlPzufZn
         6376GkiRdHkTsxK3yQG6+4F2BESJcydOCfWyX71AOPfVEbWyk19woWt28R/ZjTlERc/b
         Ruw0eZEeTUejn3bDrGwmR2197DXqqkZ+MuN3DLCliBM3Zd1EQyqpcvRLzHZgCgv0qSA5
         QEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J0lqGBTdhz6aUz3zIPQpgMiqURbZy/P6PGnHrNdM2K0=;
        b=DVMag9I44XH75WJ2rjIWJOphTuRrEjh99nCmIyBaWuwkbp8dacnD7nPqfgkWoSNY0I
         1mQNIuSBXG0OB3Dnph1jKugD9FxAQxhB3joE3b+Rne+9BnDDY5WM+lGHGxEtRv3vQ3x6
         r8xQgXHQRdwh+M152fZXGwzZOGXZihRfVUrVxkBdkNp0TOoFAptrxATtCl3PPu+Wettl
         OqJR8aGW4fKsFOL79/o2BeNqomxTUXPoha8gE8XCYnk2AvDWW0k235MIY1F5nA7Uh9/a
         0LD/RxvVv92nPZnK8IXvN9JtZMdFtPWoZY+rAM9P3lq2RLhnUjvTih0kUt0h5RRHIuO9
         SPJg==
X-Gm-Message-State: AOAM531dQbPIpwTYZmGdAbTEaJ3oCP8dfbc8oouliOXVkH91IShXx2PL
        E40kIYsDz2+HbRN1eccdQtZGElwdfWGyBA==
X-Google-Smtp-Source: ABdhPJzUyitmHY1dtCggcF4xw71SVr2w9yVQTDZNp5ZYC9mO6dRWM91X4/8iasowvHDnyTiVMw4FYA==
X-Received: by 2002:a05:6512:1055:: with SMTP id c21mr1870170lfb.275.1603990241711;
        Thu, 29 Oct 2020 09:50:41 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s1sm331832lfd.236.2020.10.29.09.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:50:41 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 07/16] locking/bitspinlock: Cleanup PREEMPT_COUNT leftovers
Date:   Thu, 29 Oct 2020 17:50:10 +0100
Message-Id: <20201029165019.14218-7-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201029165019.14218-1-urezki@gmail.com>
References: <20201029165019.14218-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/bit_spinlock.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index bbc4730a6505..1e03d54b0b6f 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -90,10 +90,8 @@ static inline int bit_spin_is_locked(int bitnum, unsigned long *addr)
 {
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 	return test_bit(bitnum, addr);
-#elif defined CONFIG_PREEMPT_COUNT
-	return preempt_count();
 #else
-	return 1;
+	return preempt_count();
 #endif
 }
 
-- 
2.20.1

