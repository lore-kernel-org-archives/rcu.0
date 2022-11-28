Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7FAC433FE
	for <rcu@archiver.kernel.org>; Mon, 28 Nov 2022 08:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiK1I2r (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Nov 2022 03:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiK1I2q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Nov 2022 03:28:46 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDF02716
        for <rcu@vger.kernel.org>; Mon, 28 Nov 2022 00:28:45 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so8012962pjd.5
        for <rcu@vger.kernel.org>; Mon, 28 Nov 2022 00:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+6maChNckuGCrTU+BiZD5u7zvu1KWw79sg0uZa59Hs=;
        b=q1JYkc6d47pPkX39Hz0rGik/wCHwoNqy49JUT62PSMlGilf7tDGXyECptudGU6ex57
         9M3/zzw4FlKBrBAXM0a9GItCyuJ+/YxZwSEAjbhU15G1UMOT26KnL+Jx2QrlS+GWgxCO
         B4vX6XcuVAPuCYiIZAtIAi84NKoawfscBUcq/VHQmHLTNz4XhAN0llwFMUt0A2DaD0zb
         6mukA4kcUtqF4SrFDw3mThXD2LqTyznijJyqGXzxc5xT5wQs11MszNnYzsAMqNPLcS/J
         3vEQQN8oAhbWp9khPwTxHqjLfKefS47NOPqCbqWG+hedKEx5ZjAeCuPTOpb17DDEV/U8
         F8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+6maChNckuGCrTU+BiZD5u7zvu1KWw79sg0uZa59Hs=;
        b=sUdg92qIp7iaD8u1l5/S30nskkuN42tC0U4lIQ0jksu42DlfDOksS/SL+TmG6/0m8q
         Oc+NGhuIRg7w70FwU7mINpYSD5L2rv3fdGBcbOwXZFgCa0rL1terlXLmUp4fulS1jWa7
         mpos7rBoBUHtQatwWS2C0b3PolDHKJa4icjMbpTDnV4ySd0S6WkbEkwUkcMPNrVC2BP3
         M+Hdg08GRePO5K6THQMhxVSgas+pEzD0cUji4HidEx0k1oH/ZltWyMqFGAxLNa1fSP2n
         m2yShc99oqcAQ+zsAm2F59o/+EscQFDcRO+N0zedK99a8bTTa2y18VWQh0YCUpk/zxE0
         +T4w==
X-Gm-Message-State: ANoB5pk5iBQX0rS0WvVOv0J4yZt5ZkbIHBss2jYul3ZCjmXQmcNmQB+X
        7mq9SkUNA+/MvV47E84gkS9IoV4n67zm
X-Google-Smtp-Source: AA0mqf5wUGZQhomJ91AXeq92JpHGQmhOdRvVzqVWS49/tKJMN2fup77BRXNxlNNea9rQh5KS83+ccQ==
X-Received: by 2002:a17:902:aa4a:b0:188:d4ea:2567 with SMTP id c10-20020a170902aa4a00b00188d4ea2567mr30534172plr.155.1669624124530;
        Mon, 28 Nov 2022 00:28:44 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z20-20020aa79494000000b0056f0753390csm7601637pfk.96.2022.11.28.00.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 00:28:44 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH 2/3] srcu: protect against concurrent srcu_gp_end()
Date:   Mon, 28 Nov 2022 16:28:15 +0800
Message-Id: <20221128082816.28518-3-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221128082816.28518-1-kernelfans@gmail.com>
References: <20221128082816.28518-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

At present, the code chunk "Transition to big if needed" is out of the
lock srcu_cb_mutex, which allows the following scene:

    srcu_gp_end() on cpu1                srcu_gp_end() on cpu2

    init_srcu_struct_nodes()
    ^^  scheduled out in the middle
                                         init_srcu_struct_nodes()
                                         ^^ overwrite the context set up by cpu1

Squashing out the race window by putting the code chunk under the
protection of srcu_cb_mutex.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
To: rcu@vger.kernel.org
---
 kernel/rcu/srcutree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index fe0759d89c2d..281cd69fe804 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -811,6 +811,13 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 			spin_unlock_irqrestore_rcu_node(sdp, flags);
 		}
 
+	/* Transition to big if needed. */
+	if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
+		if (ss_state == SRCU_SIZE_ALLOC)
+			init_srcu_struct_nodes(ssp, GFP_KERNEL);
+		else
+			smp_store_release(&ssp->srcu_size_state, ss_state + 1);
+	}
 	/* Callback initiation done, allow grace periods after next. */
 	mutex_unlock(&ssp->srcu_cb_mutex);
 
@@ -826,13 +833,6 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 		spin_unlock_irq_rcu_node(ssp);
 	}
 
-	/* Transition to big if needed. */
-	if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
-		if (ss_state == SRCU_SIZE_ALLOC)
-			init_srcu_struct_nodes(ssp, GFP_KERNEL);
-		else
-			smp_store_release(&ssp->srcu_size_state, ss_state + 1);
-	}
 }
 
 /*
-- 
2.31.1

