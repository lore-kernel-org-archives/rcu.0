Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE11BC43462
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D37661925
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhEKXNi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230210AbhEKXNc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 213A261938;
        Tue, 11 May 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=iWXTpS2pnGDGYtJUs36apiXqRUVCVQkeopZ/uk8CMCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cUKkA3rdlXIOl01ZyNHCdLoDG5ScKqiylymd73C6pXW42rcWFbBYXAwtVnoRrxmjA
         zJNNdvRsTPr9J42asVd+AvLgy2Qg3o76om5XkDTsgxvrVg34KHCUAaqVeFsrosZgWA
         8Eoh5dHORKXyppA2QswclW+bQ9Xij2Plnloba8qdTxn8guMwigd09NJef4WIsyz1Hx
         ZgztJGsMI2USYp89H53YycerNnm7QWolGOdwV9VuG3XBnrt7WXhLe4OJeUDEv3ADcT
         LXI7AmvBacW6B1xgXB7uyZCI2nXoS/PzCFmjKJb97XvLRQxlKhUaaadpmTAwvkRmGd
         7zHS6i8aG5ClA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7F1155C0DF5; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/26] torture:  Make the build machine control N in "make -jN"
Date:   Tue, 11 May 2021 16:12:09 -0700
Message-Id: <20210511231223.2895398-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Given remote rcutorture runs, it is quite possible that the build system
will have fewer CPUs than the system(s) running the actual test scenarios.
In such cases, using the number of CPUs on the test systems can overload
the build system, slowing down the build or, worse, OOMing the build
system.  This commit therefore uses the build system's CPU count to set
N in "make -jN", and by tradition sets "N" to double the CPU count.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-build.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-build.sh b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
index 115e1822b26f..55f4fc102624 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
@@ -40,8 +40,10 @@ if test $retval -gt 1
 then
 	exit 2
 fi
-ncpus=`cpus2use.sh`
-make -j$ncpus $TORTURE_KMAKE_ARG > $resdir/Make.out 2>&1
+
+# Tell "make" to use double the number of real CPUs on the build system.
+ncpus="`lscpu | grep '^CPU(' | awk '{ print $2 }'`"
+make -j$((2 * ncpus)) $TORTURE_KMAKE_ARG > $resdir/Make.out 2>&1
 retval=$?
 if test $retval -ne 0 || grep "rcu[^/]*": < $resdir/Make.out | egrep -q "Stop|Error|error:|warning:" || egrep -q "Stop|Error|error:" < $resdir/Make.out
 then
-- 
2.31.1.189.g2e36527f23

