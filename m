Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD56C35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95A9207FF
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581727296;
	bh=N1Aak56BohJjQ1J0OxXRukRjP6wUOprgC/m9UHl76Bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p+OBCxFGiACoU6rNO28OlfYNBV5IjVthx1qobAfy3NNB+p96g7/c53pDsUCj/wVaI
	 EVOh/xXid31OpF26ajU2skaWP6ey/lKpJsLai0rNOpX38dq3dB7ju8ofa0Rwkl9Rao
	 HwV8Eu/m/ZJP8rXCsLxksosuxZjHNLGLzP8NxDmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgBOAlg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:41:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgBOAlg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:41:36 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BD3A2082F;
        Sat, 15 Feb 2020 00:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581727295;
        bh=N1Aak56BohJjQ1J0OxXRukRjP6wUOprgC/m9UHl76Bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a7Ymzx5O4OFspEmZkvzxP6UHoh1xU5tWmutYSNMFCnjtoC9SSKoufJ+kDq7PdNErX
         sqr8QVIhzI9y7ypqpwpwxcFyPrZhLDYnecdqBCJAAddx1H5odnNIHe4vkRXk0wfxPB
         HVhMN2S/BaixbnrYIt/ipaAfEO1pGD3aLG7OEIcw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/18] rcutorture: Add 100-CPU configuration
Date:   Fri, 14 Feb 2020 16:41:15 -0800
Message-Id: <20200215004125.16953-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215003634.GA16227@paulmck-ThinkPad-P72>
References: <20200215003634.GA16227@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The small-system rcutorture configurations have served us well for a great
many years, but it is now time to add a larger one.  This commit does
just that, but does not add it to the defaults in CFLIST.  This allows
the kvm.sh argument '--configs "4*CFLIST TREE10" to run four instances
of each of the default configurations concurrently with one instance of
the large configuration.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE10 | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE10

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
new file mode 100644
index 0000000..2debe78
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
@@ -0,0 +1,18 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=100
+CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+#CHECK#CONFIG_TREE_RCU=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_RCU_FAST_NO_HZ=n
+CONFIG_RCU_TRACE=n
+CONFIG_RCU_NOCB_CPU=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+#CHECK#CONFIG_PROVE_RCU=n
+CONFIG_DEBUG_OBJECTS=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=n
-- 
2.9.5

