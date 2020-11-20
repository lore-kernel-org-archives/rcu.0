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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215AFC63777
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 11:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B49C022264
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 11:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igxa+TR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgKTLtd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 06:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgKTLtc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 06:49:32 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C068AC0613CF;
        Fri, 20 Nov 2020 03:49:31 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id r17so9740209ljg.5;
        Fri, 20 Nov 2020 03:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mBsL2LpflnP7i6114nKCrRZGrVt300iUQlNYXhLEDyE=;
        b=igxa+TR1ynNqt0gUDuHeQSY0o733oiTDmPDy8Ohp2uCxMGfbMX2Ny2D9refyZ8K+kk
         4KdOvWvJNplgAiu3rgyvWTsLH9kG/PMIiFU7JzwGZnF0pyuXpRp47J0DyihLQI8a32YZ
         rIelaByFPfJq0sZDd4NPS2dP5VCBcEb8BUmVRb/+1F0PRhcxHwqefmlfz82UPuCfGYTR
         jMbBbcDZqWJd2q9E8ri+jgwuTSR/Hc96vcS/6YGObf1CqLH+Fd8UtBcyf+/KIGo4F8Pm
         YOnzVKSh7zas3dRlaeK1VS5Sj442NOcIbO8Liw4sHEECmiPFVKH8v0UvE7uUa6169Gz3
         fR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mBsL2LpflnP7i6114nKCrRZGrVt300iUQlNYXhLEDyE=;
        b=ldfKi+tE3FABxvlxuJlZwwuK5zzLwxURYJt8d1IF+X2XKK7GZN5uutd0QjirxJ6SxV
         VqlTz81/BuiHs69wq7p/6eXo5cHXHyHK9px5vT4OOcIV3080wemySaIPwGo083f5CNJY
         7DFAL72G7XlG1fDo1lpuX6DjRWFjFc7jNnug8ITiZhvEhN9e5jdk5CcDKSS0H5Gpefre
         Duyg4/m/0hHoHvP4xvZKlAQGfDTDlsAB5yFszB5LeiFbNbImWYPbN4LuR52Zjxuc9xlT
         vjkAmyD2j10XoRM8Ms62kJ0Lw5wENP4g2hxz/wfsEQO88+qqTnD9EIlqHpcXCe0fxyWS
         wmqA==
X-Gm-Message-State: AOAM531XPUo2m4A17pEDWBGekxozMqs3GWzrUpG8VDiuoqnJ5JS8/C8X
        netsRE8WnJc4I3pHx/iWT0dOQnEk9JjnZ0Yt
X-Google-Smtp-Source: ABdhPJyaSZVijzWNiLpzfVzcT8IvRjpthkrDsKkl7F/+4EvEChseqh7lfTo2OewltNoF1EHVF0CdaA==
X-Received: by 2002:a2e:8792:: with SMTP id n18mr8128199lji.57.1605872968693;
        Fri, 20 Nov 2020 03:49:28 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id i17sm262683ljb.1.2020.11.20.03.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 03:49:28 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 2/2] rcu: eliminate the __kvfree_rcu() macro
Date:   Fri, 20 Nov 2020 12:49:17 +0100
Message-Id: <20201120114917.5263-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201120114917.5263-1-urezki@gmail.com>
References: <20201120114917.5263-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Make the kvfree_rcu_arg_2() to be open-coded, so readability
and review look better from the first glance. Moreover, that
makes it clear that both kvfree_rcu_arg_1/2() use one single
interface.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate.h | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index b1e75648d402..6d56dd7e6a30 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -842,15 +842,6 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  */
 #define __is_kvfree_rcu_offset(offset) ((offset) < 4096)
 
-/*
- * Helper macro for kfree_rcu() to prevent argument-expansion eyestrain.
- */
-#define __kvfree_rcu(head, offset) \
-	do { \
-		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offset)); \
-		kvfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
-	} while (0)
-
 /**
  * kfree_rcu() - kfree an object after a grace period.
  * @ptr: pointer to kfree(both for single argument and double one)
@@ -868,7 +859,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * Because the functions are not allowed in the low-order 4096 bytes of
  * kernel virtual memory, offsets up to 4095 bytes can be accommodated.
  * If the offset is larger than 4095 bytes, a compile-time error will
- * be generated in __kvfree_rcu(). If this error is triggered, you can
+ * be generated in kvfree_rcu_arg_2(). If this error is triggered, you can
  * either fall back to use of call_rcu() or rearrange the structure to
  * position the rcu_head structure into the first 4096 bytes.
  *
@@ -914,8 +905,11 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 do {									\
 	typeof (ptr) ___p = (ptr);					\
 									\
-	if (___p)							\
-		__kvfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
+	if (___p) {									\
+		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offsetof(typeof(*(ptr)), rhf)));	\
+		kvfree_call_rcu(&((___p)->rhf), (rcu_callback_t)(unsigned long)		\
+			(offsetof(typeof(*(ptr)), rhf)));				\
+	}										\
 } while (0)
 
 #define kvfree_rcu_arg_1(ptr)					\
-- 
2.20.1

