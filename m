Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B19C35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58FA222C4
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581725029;
	bh=RWUpJokn+ItyNP1dp+jrWZfxIN6Wh7hz2VquOr9PtkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o5EHsilyGhDqgvjpx6tzD1NxammVTEDk0Xo+G2xXXKbER1pAsTJuYTG6zPYkn15wb
	 Cc4q9IrpTx7MJIzaqINQ6qiJ9j4sNtiWeEDnoOSAG9Rw3SM8OP6ynF3Z5QS5zpYOwv
	 IO22SyDza9Dx6+tjoW4Cji2N7LgLaaR0ihquBrdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgBOADt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:03:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbgBOADt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:03:49 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BED024649;
        Sat, 15 Feb 2020 00:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581725028;
        bh=RWUpJokn+ItyNP1dp+jrWZfxIN6Wh7hz2VquOr9PtkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMrsYNvhj4vGwzysw/CmL95Memr9by27VwO6GGUc9qWcQst4ZW7WNdXZDzX7Q61KD
         Ke5ox544JcuBfrFZqnxGji5T/THlWxlRyvocNjHLLaO2oUO6c7EHxcNsmiBxINpUU4
         EHBsfRjVKR22WA4FZzoX6UNPwHYmKe/AfEXe38N4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/4] locktorture: Allow CPU-hotplug to be disabled via --bootargs
Date:   Fri, 14 Feb 2020 16:03:35 -0800
Message-Id: <20200215000337.14667-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215000312.GA14585@paulmck-ThinkPad-P72>
References: <20200215000312.GA14585@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The bootparam_hotplug_cpu() bash function was checking for CPU-hotplug
kernel-boot parameters from --bootargs, but that check was specific to
rcutorture ("rcutorture\.onoff_").  This commit therefore makes this
check also work for locktorture ("torture\.onoff_").

Note that rcuperf does not do CPU-hotplug operations, so it is not
necessary to make a similar change for rcuperf.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index c3a49fb..1281022 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -12,7 +12,7 @@
 # Returns 1 if the specified boot-parameter string tells rcutorture to
 # test CPU-hotplug operations.
 bootparam_hotplug_cpu () {
-	echo "$1" | grep -q "rcutorture\.onoff_"
+	echo "$1" | grep -q "torture\.onoff_"
 }
 
 # checkarg --argname argtype $# arg mustmatch cannotmatch
-- 
2.9.5

