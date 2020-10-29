Return-Path: <SRS0=ZNv1=EE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72286C4363A
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E2020FC3
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSdv4/5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgJ2Qvd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgJ2Qux (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 12:50:53 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D11AC0613D6;
        Thu, 29 Oct 2020 09:50:51 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k25so3827811lji.9;
        Thu, 29 Oct 2020 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=92KNqCS6q9TUfD5ljTwKBcQn4tkHhO2+EmRYDfcI8Ck=;
        b=FSdv4/5QnLuWNGEJefHYWAmA4rdRyQBUDKrOetugKcvKIYzTYfwxymCv/1A8SuGXxt
         iasJC0GFUDbZO+bEnBj0JBc00HhgPoSulDRZdA7SaV6eKL6/lADvDbh1edVr7HmF75R4
         mAjYCUS8aTHRuVrv1+XdOWgI6Ps4g50/sFa+dQOuIBck0h2dLqSk8GqpJN7TqoiIgRE1
         s6nHmSLaeyFCIpNvgltVx/IZIPZWNnSBQoUzFdNO+WbvriOTAPIehMn3Ceybif8cSfAP
         7RXokkUR0VZ3ETv5WcYQSlDTuvCmPfqS9Ge1bao1yksm/mtLr1GpmWcO+Oe7lFYkfoLS
         gyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=92KNqCS6q9TUfD5ljTwKBcQn4tkHhO2+EmRYDfcI8Ck=;
        b=Dg1XUEMWBwUVBm9O1//M4zEYMlVe/HyIEOx/j645UrA6r5xF4rhg0Invfroke4gwxF
         ZqkD1F/Q3cPCTkb3LTV0aIW+9TlCbcmqxWcF0LMEJRPVmQHBIicyPT1ryFBd7qY8JiFe
         2oDhZitaGUCD9n9QuCE3Mp/Y8FqKdAePCeaeWEV6UTbRjdd1fW2cTYGl7h/9AuGgvzB1
         taOmm2C7Tut1OiCPV3Lxod2uST3ky/w1V/Fo7wzj9TD5r/hsKFaVCX5DsK1L/1lk7u4t
         u+sTsxLM4wE0SDukTL/ZRROwIyAtDF5XF+URVraSDN1z44LYRLqNM9+5QWY/S1RU9yW5
         zyaQ==
X-Gm-Message-State: AOAM5333hX98FzUqIInq7lGhq3PGI6uh2rGIaqf+b/UXnahuTVsYKyWH
        mHLKZXUrYJQtw6UxfS9+VyT1Xd/b76BJ2Q==
X-Google-Smtp-Source: ABdhPJwYQKxSTCK6w4vhJ+pt+QERyr+HZbMCEc5FwPF243RoURmnrd3Zy3IZU/QZhxUYRBDyb3bOWQ==
X-Received: by 2002:a2e:515a:: with SMTP id b26mr2402889lje.262.1603990249400;
        Thu, 29 Oct 2020 09:50:49 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s1sm331832lfd.236.2020.10.29.09.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:50:48 -0700 (PDT)
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
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 11/16] xtensa: Cleanup PREEMPT_COUNT leftovers
Date:   Thu, 29 Oct 2020 17:50:14 +0100
Message-Id: <20201029165019.14218-11-urezki@gmail.com>
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
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 arch/xtensa/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 703cf6205efe..5a27dd34d3fc 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -819,7 +819,7 @@ ENTRY(debug_exception)
 	 * preemption if we have HW breakpoints to preserve DEBUGCAUSE.DBNUM
 	 * meaning.
 	 */
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_HAVE_HW_BREAKPOINT)
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
 	GET_THREAD_INFO(a2, a1)
 	l32i	a3, a2, TI_PRE_COUNT
 	addi	a3, a3, 1
-- 
2.20.1

