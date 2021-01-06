Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9C9C433E9
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF4322BE8
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbhAFR1k (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:27:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbhAFR1j (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:27:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C687623339;
        Wed,  6 Jan 2021 17:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953972;
        bh=FSLGdwx2wrlgUMwWLHENxFKkgMZoUn2xMYzEHbGt85Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UKMVpnP10RAhvLEPOHODhDHGLuZsdOESj6PUyxeGnsSbDbkp2pWHBsTQePSghObaD
         seHfmuCFCj2YGJhAmXHvypTEFXB+jFJjF7HHiedwigKOTpy0sJ7mifByl/Hc2qOG67
         mwm+DfKjid7wPuG+UQbbkq7SsMkryLNm8i7EUqB58c4fSheQOWrBunV2qu7xcLEi9u
         A4564v1UFtEIAbSiof3DFhkgjoYd7KSVJCiSsT0WLhJxDaJHUCH9KFt4wTNOXV1W8Z
         mbprbun7wIAPxP0pAF/MbxToCTQeMKfwmeqKWzvJbI6xY8LETJod3iAstFRsFUYAOS
         Za2V/Rbq6XkZg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 19/20] torture: Allow standalone kvm-recheck.sh run detect --trust-make
Date:   Wed,  6 Jan 2021 09:26:06 -0800
Message-Id: <20210106172607.22816-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106172547.GA22404@paulmck-ThinkPad-P72>
References: <20210106172547.GA22404@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Normally, kvm-recheck.sh is run from kvm.sh, which provides the
TORTURE_TRUST_MAKE environment variable that, if a non-empty string,
indicates that the --trust-make command-line parameter has been passed
to kvm.sh.  If there was no --trust-make, kvm-recheck.sh insists
that the Make.out file contain at least one "CC" command.  Thus, when
kvm-recheck.sh is run standalone to evaluate a prior --trust-make run,
it will incorrectly insist that a proper kernel build did not happen.

This commit therefore causes kvm-recheck.sh to also search the "log"
file in the top-level results directory for the string "--trust-make".

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/parse-build.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/parse-build.sh b/tools/testing/selftests/rcutorture/bin/parse-build.sh
index 09155c1..9313e50 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-build.sh
@@ -21,7 +21,7 @@ mkdir $T
 
 . functions.sh
 
-if grep -q CC < $F || test -n "$TORTURE_TRUST_MAKE"
+if grep -q CC < $F || test -n "$TORTURE_TRUST_MAKE" || grep -qe --trust-make < `dirname $F`/../log
 then
 	:
 else
-- 
2.9.5

