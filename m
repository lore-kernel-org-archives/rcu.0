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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD2CC2D0A3
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15AE520FC3
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQJ622Se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgJ2Quw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbgJ2Quq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 12:50:46 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5A3C0613D6;
        Thu, 29 Oct 2020 09:50:45 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id p15so3836186ljj.8;
        Thu, 29 Oct 2020 09:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6d7fT3xuBeGb3tcQb6w951pF7XYBqLCodKnhO5rSaoA=;
        b=TQJ622SejNeckiwp0PghzPwPryN8+2raBYAWwb7WfshT4sBK8DFxzlFGw4k3TGFKmy
         YoHMW3gWheWLUXHM3aFBZcQW+O5r0lqr0P9HpyMGyML+1uk+q7T67XRP4uOkrUOOD+cc
         j8BZ0akvhYR0D1QR+ANcDnJV5kMKlxR85bdTk/fSo5bXQHkwEkXnx9P9PN7YAT60IHuG
         Y7EQQNzRe+NM9mTjs1AowuSxPRsLHTOxYp/RP5GldVLYKFuu/ziTScx4UldN3/fTTQGG
         13CMnvLth4DRtVz/jNrmP3erbSUeYYnZcUAtDl6nOOTOFs6qs6x6Fpzu/Shd9n8GmHdK
         +wwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6d7fT3xuBeGb3tcQb6w951pF7XYBqLCodKnhO5rSaoA=;
        b=anMyryEck7PfbF+u2k4zJ9AKsBYDxgi0hhaED6scoIm9wP0I/UQ1E1TFGjdDd9Au7+
         3EPr6r5gAmazW2gY3b2zVRLh8fEQxQUCKxH0kOKtLW7i4iSFGHPI8c9qlA1GhS+0iq3J
         GXNsve+j6jlEv+w0tunE8u4i1jYTuxfIb0SgFJQd2mHsZJ3BKm0QPibnWiW4V4W8egPH
         RNO30Y7RHhyweW00iKKRCD77O6nI8DX1fXiw3StG5LCuqgcmqt0gKduyg6jFIlHK2ovz
         JiJqqaI06zFscvN9m3VOp17kg3kr5iDmSk4sZrraEcHD4bg9PHoGPbvmU4o5Y0nxiKi5
         HnHQ==
X-Gm-Message-State: AOAM5318ZGHqtN+xC4FtQjaVY7iLE93uP+lSEqR8WIsrY5cIkud7XKH5
        +FPissfeM/CqQGiKu2CQdQu2lz4960RGCA==
X-Google-Smtp-Source: ABdhPJwFVDdr6X1LSLRA//9FC9DbOe7NKoWwo95SJ+c7CtnME8ABFWvtAb+6eJF8ael05O+bIstWtg==
X-Received: by 2002:a2e:9159:: with SMTP id q25mr721854ljg.264.1603990243459;
        Thu, 29 Oct 2020 09:50:43 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s1sm331832lfd.236.2020.10.29.09.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:50:42 -0700 (PDT)
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 08/16] uaccess: Cleanup PREEMPT_COUNT leftovers
Date:   Thu, 29 Oct 2020 17:50:11 +0100
Message-Id: <20201029165019.14218-8-urezki@gmail.com>
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
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/uaccess.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index c7c6e8b8344d..d6473a72a336 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -275,9 +275,9 @@ static inline bool pagefault_disabled(void)
  *
  * This function should only be used by the fault handlers. Other users should
  * stick to pagefault_disabled().
- * Please NEVER use preempt_disable() to disable the fault handler. With
- * !CONFIG_PREEMPT_COUNT, this is like a NOP. So the handler won't be disabled.
- * in_atomic() will report different values based on !CONFIG_PREEMPT_COUNT.
+ *
+ * Please NEVER use preempt_disable() or local_irq_disable() to disable the
+ * fault handler.
  */
 #define faulthandler_disabled() (pagefault_disabled() || in_atomic())
 
-- 
2.20.1

