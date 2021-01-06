Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD69C43219
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A07A23120
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbhAFR1t (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:27:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbhAFR1b (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:27:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEC802313E;
        Wed,  6 Jan 2021 17:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953972;
        bh=HKrBUqTW0hnQbStY7/pA3xxHqE9+iWICVnV2gzOMCkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AW89BeP76t1+BFVFs+2LizswplJEW43WRrJ5OrUYwdxVz30M0/qbc1/9sLm9HLAUi
         HkAfde3KYdCkSkCrTsSrBRKs8/QwIcFS97jOn+f3NOX8kmqdONvcDH8VVbfDNst6QA
         MbQNf8fwr2z+rqUIl2FZAYSxx5tz80oFW7Gw0ayu1diw/kxwWx11FI5ZC5c/xir6Fi
         W3BZ7VjzRZip2C7mcmhdVE2bNLU240OdbDJgVyLQNe4heYVmHjIgZJ5QjNqN8/K1Mk
         Q8lpgdI8ut8PF1mQWp/JHIHXEwczkLI4EtxT5T8Jok0Yt9Lo699P1BRB+tIDHLbrlc
         ZkMYxjek+XueQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 14/20] torture: Stop hanging on panic
Date:   Wed,  6 Jan 2021 09:26:01 -0800
Message-Id: <20210106172607.22816-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106172547.GA22404@paulmck-ThinkPad-P72>
References: <20210106172547.GA22404@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

By default, the "panic" kernel parameter is zero, which causes the kernel
to loop indefinitely after a panic().  The rcutorture scripting will
eventually kill the corresponding qemu process, but only after waiting
for the full run duration plus a few minutes.  This works, but delays
notifying the developer of the failure.

This commit therefore causes the rcutorture scripting to pass the
"panic=-1" kernel parameter, which caused the kernel to instead
unceremoniously shut down immediately.  This in turn causes qemu to
terminate, so that if all of the runs in a given batch panic(), the
rcutorture scripting can immediately proceed to the next batch.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/functions.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 97c3a17..c35ba24 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -203,6 +203,7 @@ identify_qemu () {
 # and the TORTURE_QEMU_INTERACTIVE environment variable.
 identify_qemu_append () {
 	echo debug_boot_weak_hash
+	echo panic=-1
 	local console=ttyS0
 	case "$1" in
 	qemu-system-x86_64|qemu-system-i386)
-- 
2.9.5

