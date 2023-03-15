Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB32C61DA4
	for <rcu@archiver.kernel.org>; Wed, 15 Mar 2023 18:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjCOSTz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Mar 2023 14:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjCOSTl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Mar 2023 14:19:41 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628A77DD0A
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 11:19:34 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id r16so17191470qtx.9
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 11:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678904373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Bvd7KqU+0UJPbIZv2ZisqXKCDIddIzWkPhDnOppke0=;
        b=Bj88++U5M+bx+xrI+ueEqEmtvkt/BQxGm9alRbvENUNQgW/XLsUqKg+0i9rYjVwo/U
         xCkd8SkXbBn5uwMwDpOTp4ud+QYb1pA6hKv6CViFcxzUXknbgDo+WJAOH8ZGPY5Q4kih
         eJkADceCNkzHpKA9rKi6gN8oC5ABQXKSF5mo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678904373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Bvd7KqU+0UJPbIZv2ZisqXKCDIddIzWkPhDnOppke0=;
        b=mSCRZBz9omU39kGAIU2DKiVGSY2MVNkD0BRl674S4Rf0t5rk/f3T/po280CNz3gn08
         VKYUkJKIly6fBxUSGXHZwmQY4cCEQRHaCOf4XvfZbdFVgtgPn4XEiGB4h/R7O9aD6ifD
         am8hIMFYJDMaF7YJfoIBntMVvKpHVfRnAa4T1DrsfwH3O+qqf0c/NecvTzzk9Egp6KiL
         lBs+K+VU2dfoL3/npCXlqKdPCWQhQZJILAfHu+al28Hw5XJ/MMpCMdK63lZh880us39s
         fbRUlltjYb0C5on5flBo55bUQ6YlbcNgmkZ8wyPnnIM5qVae/b0GrJ7fm3OKS0uWFiqB
         tm7Q==
X-Gm-Message-State: AO0yUKX/kj/g6BbM5BxJ2nqEGtYKDXqqNHswpE+Ndnvk8COccp6I8t9L
        XxR7s21DTRNOWzhbRkp29zsqKQ==
X-Google-Smtp-Source: AK7set9+egTI2wMDAMY8dnTaLEBRl12RRV7zCaE7OSYn+8iy+tPhMG7McRQkufAEB31HwULzaVxfUg==
X-Received: by 2002:ac8:7c50:0:b0:3b8:4adb:c604 with SMTP id o16-20020ac87c50000000b003b84adbc604mr1513701qtv.14.1678904373115;
        Wed, 15 Mar 2023 11:19:33 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v125-20020a379383000000b007458ae32290sm4113974qkd.128.2023.03.15.11.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:19:32 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: [PATCH v2 08/14] rcuscale: Rename kfree_rcu() to kfree_rcu_mightsleep()
Date:   Wed, 15 Mar 2023 18:18:55 +0000
Message-Id: <20230315181902.4177819-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315181902.4177819-1-joel@joelfernandes.org>
References: <20230315181902.4177819-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The kfree_rcu() and kvfree_rcu() macros' single-argument forms are
deprecated.  Therefore switch to the new kfree_rcu_mightsleep() and
kvfree_rcu_mightsleep() variants. The goal is to avoid accidental use
of the single-argument forms, which can introduce functionality bugs in
atomic contexts and latency bugs in non-atomic contexts.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcuscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 91fb5905a008..98b75995b680 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -716,7 +716,7 @@ kfree_scale_thread(void *arg)
 			// is tested.
 			if ((kfree_rcu_test_single && !kfree_rcu_test_double) ||
 					(kfree_rcu_test_both && torture_random(&tr) & 0x800))
-				kfree_rcu(alloc_ptr);
+				kfree_rcu_mightsleep(alloc_ptr);
 			else
 				kfree_rcu(alloc_ptr, rh);
 		}
-- 
2.40.0.rc1.284.g88254d51c5-goog

