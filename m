Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D66FC2BB85
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7BB82076D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586972000;
	bh=JUcg+B91/9Gp3VgiUqN1wZx9m8F/cwzYoxpa4XW01qA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=REZiQChf9no6YDyJo72ju5pyATWkNeJYVwnZPJ+5x9mIwMMoRjZBUhfI9hReUZxbR
	 uKlJdqNyT4r5jjZBg3CZnSjmO9NTlxH+CD04oeeCL7+Iwb1xpqtBNmPqDunlnYO8zq
	 WMxavxavUcKHQnyjiVjy+nZ5ALKgPwQg7le/ih1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411310AbgDORdR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:33:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411130AbgDORbH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C451217BA;
        Wed, 15 Apr 2020 17:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971866;
        bh=JUcg+B91/9Gp3VgiUqN1wZx9m8F/cwzYoxpa4XW01qA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JXU8mrOI40mWCLHj7I9NlhoBCXHuWTA/ywtOsk4JOabv/MNMhjduVo5BtuwqxltFR
         YvK00786ukjo62Y3tqK2c1TrNBTbNQv/mF5itdgA0gYTOK3/TAT62NhfCXq0dadngV
         UqLoNBQnNO9bTCFSPXbjy2rEBcypvlz5ardvCcTk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 15/18] torture: Allow scenario-specific Kconfig options to override CFcommon
Date:   Wed, 15 Apr 2020 10:30:57 -0700
Message-Id: <20200415173100.9927-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415173037.GA9768@paulmck-ThinkPad-P72>
References: <20200415173037.GA9768@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit applies config_override_param() to allow scenario-specific
Kconfig options to override those in CFcommon.  This in turn will allow
additional Kconfig options to be placed in CFcommon, for example, an
option common to all but a few scenario can be placed in CFcommon and
then overridden in those few scenarios.  Plus this change saves one
whole line of code.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index b7296f1..c7534fd 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -67,12 +67,11 @@ if test -r "$config_dir/CFcommon"
 then
 	echo " --- $config_dir/CFcommon" >> $resdir/ConfigFragment.input
 	cat < $config_dir/CFcommon >> $resdir/ConfigFragment.input
-	config_override.sh $config_dir/CFcommon $config_template > $T/Kc1
+	cp $config_dir/CFcommon $T/Kc0
 else
-	cp $config_template $T/Kc1
+	echo > $T/Kc0
 fi
-echo " --- $config_template" >> $resdir/ConfigFragment.input
-cat $config_template >> $resdir/ConfigFragment.input
+config_override_param "$config_template" Kc0 Kc1 "`cat $config_template 2> /dev/null`"
 config_override_param "--kcsan options" Kc1 Kc2 "$TORTURE_KCONFIG_KCSAN_ARG"
 config_override_param "--kconfig argument" Kc2 Kc3 "$TORTURE_KCONFIG_ARG"
 cp $T/Kc3 $resdir/ConfigFragment
-- 
2.9.5

