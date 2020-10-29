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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541B2C4363A
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F9D214F1
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMTUAse9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgJ2Qux (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbgJ2Qux (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 12:50:53 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01398C0613D7;
        Thu, 29 Oct 2020 09:50:53 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id i6so4219250lfd.1;
        Thu, 29 Oct 2020 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U0tBXDISJ7PKav4r0CxWwIZDBb4jy3ecrSqgpsbA5/M=;
        b=qMTUAse97Ag4sY/heShgNSsNCYf6PXz+YhGoBkReVy5Bpk+oGTd1KwM2lnLwkDRLNy
         FzGsZ4HODS2WboXisLq2+6AVl5Wu+3Mgan1NVY1USwNyCJou5D3CMK2dGTr100VKUGvv
         e83wr+oyKofohMsxCrWg/q2Ca88IUA+mAWtEX6m4dSGMdq9EXLBXyvwlU3wlJpqLKgm6
         +C/1VcjOTXXMMcekAS5jU59FBlYq5Sl2VhPtnyewNbmtv/jGh2615Z8YRYQT+wHPgzmw
         1TJMauGq7t6T3pPs0HOmkk+pFDJdzCrZx4bcL1axLzdcjK1Yi3+bFgTgPZarGiEeZqOE
         0oBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U0tBXDISJ7PKav4r0CxWwIZDBb4jy3ecrSqgpsbA5/M=;
        b=VpNaRsqgG3Pkti1Br/qJucMm1q+RRwjpHun7JBiPyraQDPW18Ln7cZm/T19wNRCT7/
         Ltw/VQNhbVj4+dMKPU/h8Cm/eyWdwhJ7WdBG2BaFPlngQ8qRmtkBId2v/QjyfFLlBNU4
         v/WqfsE1kaGoif1o1JCo+U5x+UP7PbSucRvipEwVo7JF0leKhtk99mkK/5eyAqemlY+s
         9IU0TwtV8UFs78rwkAb79KiGZB1lfgi1cy+rGtUa9Sq6boFT6ehsNyKDRlz7Cxh+CKjZ
         pIIvvDesrcATNad9WZ8rWvmfcttAzpG98dBQ+nrGEKmrS/48tnNqR10ABV7DaVjMG38b
         KekA==
X-Gm-Message-State: AOAM53355ffGXcquDbFsmpFZzYYBail8xVWZ11c/wdUd08jF2z3xRZMe
        C88dqSBxWr3S3Rz41xXiv7T/RRV2vZC87w==
X-Google-Smtp-Source: ABdhPJxCVmyVxeVzPA96sFx7IYrVStSytwDOLVMpyU3KlnWKEx1b8+yy00bzRJOYt2P0XyP2u5jIjA==
X-Received: by 2002:a19:6003:: with SMTP id u3mr1837955lfb.317.1603990251091;
        Thu, 29 Oct 2020 09:50:51 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s1sm331832lfd.236.2020.10.29.09.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:50:50 -0700 (PDT)
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
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 12/16] drm/i915: Cleanup PREEMPT_COUNT leftovers
Date:   Thu, 29 Oct 2020 17:50:15 +0100
Message-Id: <20201029165019.14218-12-urezki@gmail.com>
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
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 drivers/gpu/drm/i915/Kconfig.debug | 1 -
 drivers/gpu/drm/i915/i915_utils.h  | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/Kconfig.debug b/drivers/gpu/drm/i915/Kconfig.debug
index 25cd9788a4d5..b149f76d3ccd 100644
--- a/drivers/gpu/drm/i915/Kconfig.debug
+++ b/drivers/gpu/drm/i915/Kconfig.debug
@@ -20,7 +20,6 @@ config DRM_I915_DEBUG
 	bool "Enable additional driver debugging"
 	depends on DRM_I915
 	select DEBUG_FS
-	select PREEMPT_COUNT
 	select I2C_CHARDEV
 	select STACKDEPOT
 	select DRM_DP_AUX_CHARDEV
diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
index 54773371e6bd..ecfed860b3f6 100644
--- a/drivers/gpu/drm/i915/i915_utils.h
+++ b/drivers/gpu/drm/i915/i915_utils.h
@@ -337,8 +337,7 @@ wait_remaining_ms_from_jiffies(unsigned long timestamp_jiffies, int to_wait_ms)
 						   (Wmax))
 #define wait_for(COND, MS)		_wait_for((COND), (MS) * 1000, 10, 1000)
 
-/* If CONFIG_PREEMPT_COUNT is disabled, in_atomic() always reports false. */
-#if defined(CONFIG_DRM_I915_DEBUG) && defined(CONFIG_PREEMPT_COUNT)
+#ifdef CONFIG_DRM_I915_DEBUG
 # define _WAIT_FOR_ATOMIC_CHECK(ATOMIC) WARN_ON_ONCE((ATOMIC) && !in_atomic())
 #else
 # define _WAIT_FOR_ATOMIC_CHECK(ATOMIC) do { } while (0)
-- 
2.20.1

