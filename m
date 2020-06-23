Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397B8C433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CAD320809
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872729;
	bh=0XLoP4u6mLOqOEwZNGlpgrofXLn4xvy0MoAxyMsE/RU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UcwQZhWR00yv9iUfIJzxWWRTtYkt4qzHzBLy52rlpJyqpUvuJzuVkmx+Wnyyy5lP9
	 breRjHV6FM4fbDvjhnFcf8kQKzeM232fcgykb9JgCtenwp6jm/hrrdvs9wdcsvglgU
	 stVhfe/vMmHcW210Dxdc0jx6DHIiWfe6OeZcJ/QI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbgFWAig (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:38:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732153AbgFWAh5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E997A20FC3;
        Tue, 23 Jun 2020 00:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872677;
        bh=0XLoP4u6mLOqOEwZNGlpgrofXLn4xvy0MoAxyMsE/RU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Y6EfOmO9+jeiUTJEPelSGvT/++20BAp7x2NQFA2ortI2leX/af9E1NROJY6q4NDu
         botA/w3fKY9lGt8GLazJg5CGl1K6Z+1YCXDlLcQeMuq87LhBVsSK6lXy2P27lpGXzP
         +s3iJTliNArFOXWCRfEIZ+iC/ZL+kOxLx2ow9qnE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 15/23] torture: Pass --kmake-arg to all make invocations
Date:   Mon, 22 Jun 2020 17:37:44 -0700
Message-Id: <20200623003752.26872-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Marco Elver <elver@google.com>

We need to pass the arguments provided to --kmake-arg to all make
invocations. In particular, the make invocations generating the configs
need to see the final make arguments, e.g. if config variables depend on
particular variables that are passed to make.

For example, when using '--kcsan --kmake-arg CC=clang-11', we would lose
CONFIG_KCSAN=y due to 'make oldconfig' not seeing that we want to use a
compiler that supports KCSAN.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/configinit.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/configinit.sh b/tools/testing/selftests/rcutorture/bin/configinit.sh
index 93e80a4..d6e5ce0 100755
--- a/tools/testing/selftests/rcutorture/bin/configinit.sh
+++ b/tools/testing/selftests/rcutorture/bin/configinit.sh
@@ -32,11 +32,11 @@ if test -z "$TORTURE_TRUST_MAKE"
 then
 	make clean > $resdir/Make.clean 2>&1
 fi
-make $TORTURE_DEFCONFIG > $resdir/Make.defconfig.out 2>&1
+make $TORTURE_KMAKE_ARG $TORTURE_DEFCONFIG > $resdir/Make.defconfig.out 2>&1
 mv .config .config.sav
 sh $T/upd.sh < .config.sav > .config
 cp .config .config.new
-yes '' | make oldconfig > $resdir/Make.oldconfig.out 2> $resdir/Make.oldconfig.err
+yes '' | make $TORTURE_KMAKE_ARG oldconfig > $resdir/Make.oldconfig.out 2> $resdir/Make.oldconfig.err
 
 # verify new config matches specification.
 configcheck.sh .config $c
-- 
2.9.5

