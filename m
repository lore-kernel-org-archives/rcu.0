Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236F2C43618
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 078C16192C
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhEKXNk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhEKXNc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E8F76192B;
        Tue, 11 May 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=g+6d3phEhzedyJwNDVwtwj0AAwQ7beVUbSC1enFErhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H34P+mC6HMkBbKSA0bxnO4hhM3ZXzXHo+8PIKiEKU3ZMcmbU1jSmyslPP3AY31HIs
         5YUcl8ZHKdE8F8jTBcW0pl3ZGe8J2fhRMYHaiKE7EwJuUrHMurLoI0B5RqzRXdD0Bj
         Vru4Y0eH7Q7KysschYFBQ3o5mhLGh6YIqn+uUw/eqy4DbOcVhm5EJVuwLm1BogoGGE
         E5/nejWDXvtp2ywJHPNHwo2GMXOsE1eYqjjKXkufG7FGkdZirG1ZicgNpejD6AeHCB
         LhEZfefyWPJTXTn7bwvztkSBhTBvuapgAtLstFpxo+poOfGVicrTRfEqIAcJyoRIc3
         ivxtCDdMdu5MQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 867A45C0E3F; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH tip/core/rcu 16/26] torture:  Set kvm.sh language to English
Date:   Tue, 11 May 2021 16:12:13 -0700
Message-Id: <20210511231223.2895398-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Some of the code invoked directly and indirectly from kvm.sh parses
the output of commands.  This parsing assumes English, which can cause
failures if the user has set some other language.  In a few cases,
there are language-independent commands available, but this is not
always the case.  Therefore, as an alternative to polyglot parsing,
this commit sets the LANG environment variable to en_US.UTF-8.

Reported-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index fab3bd9cf9d1..390bb97b07d8 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -20,6 +20,9 @@ mkdir $T
 
 cd `dirname $scriptname`/../../../../../
 
+# This script knows only English.
+LANG=en_US.UTF-8; export LANG
+
 dur=$((30*60))
 dryrun=""
 KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
-- 
2.31.1.189.g2e36527f23

