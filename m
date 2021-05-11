Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C75C43619
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9609F61925
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhEKXNl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhEKXNc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 043166193A;
        Tue, 11 May 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=nT+WwqTuijqKEBiwpVUa2iZqdt8xinIz/AGYesgwAoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rRblfLqdhDAf8BzBfwoHbPD2tK9fsGfbPGuHLwsNcRvy3rT8ogKKQnb1SX7PPhml1
         9KB+vzhb59+vNUwchZE2z4rlPmPjKYBctqlGW/eXqjudtKlPXvIPq59DtfIliXKInH
         llDuMiPd3eMk8vpSwD77M0kuOIjx6pGeF9T8G70Q3P8Jy4b/E1cZY0LrRYFEOv5X09
         n7VJ5sjzYWS0kz87b+TLBXVVY6CYl+CaNP3wzUhid+rKjoMLn1d5pWxHviVO5lVr7V
         x4u97YMA9MajFPiZ9fCHKm4aWzMIuTu1ebkKa/53XnWbIj1uUDQ93catIxGA9miQ2t
         XAvB9MM1oEGcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 79C8C5C0DE7; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/26] torture: Fix grace-period rate output
Date:   Tue, 11 May 2021 16:12:06 -0700
Message-Id: <20210511231223.2895398-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The kvm-again.sh script relies on shell comments added to the qemu-cmd
file, but this means that code extracting values from the QEMU command in
this file must grep out those commment.  Which kvm-recheck-rcu.sh failed
to do, which destroyed its grace-period-per-second calculation.  This
commit therefore adds the needed "grep -v '^#'" to kvm-recheck-rcu.sh.

Fixes: 315957cad445 ("torture: Prepare for splitting qemu execution from kvm-test-1-run.sh")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
index 1706cd4466b4..fbdf162b6acd 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
@@ -31,7 +31,7 @@ then
 	echo "$configfile ------- " $stopstate
 else
 	title="$configfile ------- $ngps GPs"
-	dur=`sed -e 's/^.* rcutorture.shutdown_secs=//' -e 's/ .*$//' < $i/qemu-cmd 2> /dev/null`
+	dur=`grep -v '^#' $i/qemu-cmd | sed -e 's/^.* rcutorture.shutdown_secs=//' -e 's/ .*$//'`
 	if test -z "$dur"
 	then
 		:
-- 
2.31.1.189.g2e36527f23

