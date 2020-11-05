Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AC9C5517A
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B16D20756
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604620120;
	bh=y9+008TcZ5dQEv4McswveXEpGGU4MHFSE/f1o4sTv98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HjLi7o1I3BYmRLCJdAjPNDdkCwDRlos/MTBXBDtdrUn/pnOfaRdsnan4pMJz/nPNy
	 EZhhbFin2U8JF7MpVUljO5mwas71oN3u3M+vPFNbIIntEWk+yw0aErgwBn21Tm0pXp
	 8RLPa2CFYWRbFRms/E3d+/XNnWZZvBZrnB8WIJ6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbgKEXr1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:47:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:45970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732656AbgKEXr0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:26 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74B0A20759;
        Thu,  5 Nov 2020 23:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620045;
        bh=y9+008TcZ5dQEv4McswveXEpGGU4MHFSE/f1o4sTv98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sbnXjKQy4XB1XzgrzCQeICtIqUlpRQrcsWBP6FNBxZFKlwd9o/0pNllpruMTmbBiE
         T37jA8pFNzU5AAAE1I9Dravuq6gxQjYHTtGVK1301Ajna3mZWSkYpPD7X0GfNXzmwD
         9KfiXmJ3mwnDcRtBH7x/jV6Y6hQ3MSPa1Uqm1Whw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/28] torture: Exclude "NOHZ tick-stop error" from fatal errors
Date:   Thu,  5 Nov 2020 15:47:00 -0800
Message-Id: <20201105234719.23307-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The "NOHZ tick-stop error: Non-RCU local softirq work is pending"
warning happens frequently and appears to be irrelevant to the various
torture tests.  This commit therefore filters it out.

If there proves to be a need to pay attention to it a later commit will
add an "advice" category to allow the user to immediately see that
although something happened, it was not an indictment of the system
being tortured.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/console-badness.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/console-badness.sh b/tools/testing/selftests/rcutorture/bin/console-badness.sh
index 0e4c0b2..80ae7f0 100755
--- a/tools/testing/selftests/rcutorture/bin/console-badness.sh
+++ b/tools/testing/selftests/rcutorture/bin/console-badness.sh
@@ -13,4 +13,5 @@
 egrep 'Badness|WARNING:|Warn|BUG|===========|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for|!!!' |
 grep -v 'ODEBUG: ' |
 grep -v 'This means that this is a DEBUG kernel and it is' |
-grep -v 'Warning: unable to open an initial console'
+grep -v 'Warning: unable to open an initial console' |
+grep -v 'NOHZ tick-stop error: Non-RCU local softirq work is pending, handler'
-- 
2.9.5

