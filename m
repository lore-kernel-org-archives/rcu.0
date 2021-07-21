Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92153C63793
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BC3961246
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhGUUVL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhGUUVH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AFBA6127C;
        Wed, 21 Jul 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901303;
        bh=FDM2hDTQAWj6EbUMrXTVEAQigLgtAPdlOA3yKfaSn6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I7CDdV2EZmcgEnlvvMIhpke16don0n4t0fyS6UN2Rc5qHCnrewfABRQM+Ngxu6Jep
         eycKfHHB0iX/QVqQgAJi1fC7EzatNb4B1S63ZPArBcpRcKb4pHGXv9OhE7CYlU/meS
         B4tquXIvZTo2gHNUL//vVXyxsNKXKNdDJ8K9sqFZwLS/a6/HJCFxXUX1jvlBYi1B8u
         hOb560YVHhSPXcxMTOKpX0n7kdb38qXA7u0gu5Pq0MOgHkkF/M4qXpycn2lsEzuOur
         hZL0a1xAdvoMEB29C6peXkvppTyWmRqGyZblCBRgtdDTDuhjXwVUt/i/mW/NwOOk0/
         /AajCHQcfPcFQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DAEA45C0F00; Wed, 21 Jul 2021 14:01:42 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/21] torture: Move parse-console.sh call to PATH-aware scripts
Date:   Wed, 21 Jul 2021 14:01:29 -0700
Message-Id: <20210721210140.787717-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
References: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The last line of kvm-test-1-run-qemu.sh invokes parse-console.sh, but
kvm-test-1-run-qemu.sh is unaware of the PATH containing this script
and does not have the job title handy.  This commit therefore moves
the invocation of parse-console.sh to kvm-test-1-run.sh, which has
PATH and title at hand.  This commit does not add an invocation of
parse-console.sh to kvm-test-1-run-batch.sh because this latter script
is run in the background, and the information will be gathered at the
end of the full run.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh | 2 --
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh      | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
index 5b1aa2a4f3f69..7c6643d1f0370 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
@@ -172,5 +172,3 @@ fi
 
 # Tell the script that this run is done.
 rm -f $resdir/build.run
-
-parse-console.sh $resdir/console.log $title
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 420ed5ce9d32f..f10f426f50893 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -214,3 +214,4 @@ then
 fi
 
 kvm-test-1-run-qemu.sh $resdir
+parse-console.sh $resdir/console.log $title
-- 
2.31.1.189.g2e36527f23

