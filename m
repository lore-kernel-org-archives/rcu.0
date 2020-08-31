Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05649C433E6
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E902083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897105;
	bh=Y4u7+yEwfUJyhrxlRG76fKoW2V808QAbTnyJicDP4tA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oz1OAkdhNDDt4rA1OpT0akARBpQqG4+egtdFYSjvMSL8Cry6got9rPrLX2KO783Wb
	 /99wdy2kzKd+hLXUSH1aCMcu3jkx/Q6XX8nXHD5awVMy8GypEs1j+JyislrlGpnJdH
	 ++dvp6FEG7v6UlQydOcpHBeLLeR6EJidbCvH/gwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgHaSE5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729360AbgHaSEK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:04:10 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1766D2166E;
        Mon, 31 Aug 2020 18:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897050;
        bh=Y4u7+yEwfUJyhrxlRG76fKoW2V808QAbTnyJicDP4tA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JFHjdAdxDepHfLQCT51IeamWbZH03th2cAxP0vyHpoDjMG9xtexvMnrZ3DBabkre1
         5V1bPMJGl9W4pHK3QBElcdoU2UQpr7jNYwADzwYNlaP8IoQDluiNz4Td2wWFHC+amL
         dWNiJDpnEk2OWxGpT1eLhQavmJ5n/WD4UubYi0iY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH tip/core/rcu 07/14] rcutorture: Add CONFIG_PROVE_RCU_LIST to TREE05
Date:   Mon, 31 Aug 2020 11:03:59 -0700
Message-Id: <20200831180406.494-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180348.GA416@paulmck-ThinkPad-P72>
References: <20200831180348.GA416@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, the CONFIG_PROVE_RCU_LIST=y case is untested.  This commit
therefore adds CONFIG_PROVE_RCU_LIST=y to rcutorture's TREE05 scenario.

Cc: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE05 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE05 b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
index 2dde0d9..4f95f85 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE05
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
@@ -16,5 +16,6 @@ CONFIG_RCU_NOCB_CPU=y
 CONFIG_DEBUG_LOCK_ALLOC=y
 CONFIG_PROVE_LOCKING=y
 #CHECK#CONFIG_PROVE_RCU=y
+CONFIG_PROVE_RCU_LIST=y
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
-- 
2.9.5

