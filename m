Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6ABC433E6
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 17:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB07A20EDD
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 17:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598896496;
	bh=SuWMWoLa/jaNxtfrl0Nk5OHeVgH+PZy84Io8ikBgdZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yy0SaApDMQ2NgVgm3juasHmrXsxLcrOnFMTjoFXkZIR4sSxx9T5NtzhcVHNwuXE2A
	 sg0P3q9KWFqkxE+P6TRheVliYVQ9M4sDadjyW/Z0dTrzATslNTAOZiM5BZnVsix6T/
	 03RebGkN16Ip3ExFK8+984CeXND0e5zuuriu5+m4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgHaRy4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgHaRy4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 13:54:56 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8809420639;
        Mon, 31 Aug 2020 17:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896495;
        bh=SuWMWoLa/jaNxtfrl0Nk5OHeVgH+PZy84Io8ikBgdZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t4SveYVYepo7N9nqoL2ByIpGuTejIxrpeXZJEzbIQjbII99bbuIoQ9y82VVQi9B+/
         1ztqQpKRbvd893xMxxRGStHzMwfLC5UrzENB3U0tDdIOF54rx2+i7gfGVJ72mhPiXs
         kOzRngYswrAUr2G9ve9wxM484htmIfxSPKUkrzv8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Tobias Klauser <tklauser@distanz.ch>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/3] docs: Fix typo in synchronize_rcu() function name
Date:   Mon, 31 Aug 2020 10:54:50 -0700
Message-Id: <20200831175452.32381-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831175419.GA31013@paulmck-ThinkPad-P72>
References: <20200831175419.GA31013@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Tobias Klauser <tklauser@distanz.ch>

s/sychronize_rcu/synchronize_rcu/

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/whatisRCU.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index c7f147b..fb3ff76 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -360,7 +360,7 @@ order to amortize their overhead over many uses of the corresponding APIs.
 
 There are at least three flavors of RCU usage in the Linux kernel. The diagram
 above shows the most common one. On the updater side, the rcu_assign_pointer(),
-sychronize_rcu() and call_rcu() primitives used are the same for all three
+synchronize_rcu() and call_rcu() primitives used are the same for all three
 flavors. However for protection (on the reader side), the primitives used vary
 depending on the flavor:
 
-- 
2.9.5

