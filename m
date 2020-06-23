Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE16C433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6862920738
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872701;
	bh=/Q26VqU3580OaRfSBl2rt+MzXRjW79zb8l2uahSHUUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uAk0CbiUd4JuN356FjyVGUiSXnJKBqhcWuZHMo0zA12trYcnLuxL2S/+WbmH7vNZh
	 xHljjAJnWT+jzO5YHDYlzDJqNh9goF5O7m7m+J9E4frSsCJxI4rTAH4+ms72RmRgKX
	 eoNHBmng9R3yOtF6JaajrsMoy5kSCPiHgzoxNdwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732172AbgFWAh6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732151AbgFWAh5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BABCA208D5;
        Tue, 23 Jun 2020 00:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872676;
        bh=/Q26VqU3580OaRfSBl2rt+MzXRjW79zb8l2uahSHUUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YXP5QBaekfO4eV1jqMW3efbjJVIt9lQmNvLSb8SV5RCYOD3vU0M4BPmQ1NYgJmbE1
         CrEEEyrX0N4CJrbHo/13M8zX4pzPM50OA2+Mu//fNbSys9tSy71qTjt5CSrQjuypVv
         IRbsHiFWDwUitzHG7Ei/vL6x409pwfq/Un0YnUsI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 14/23] rcutorture: Check for unwatched readers
Date:   Mon, 22 Jun 2020 17:37:43 -0700
Message-Id: <20200623003752.26872-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

RCU is supposed to be watching all non-idle kernel code and also all
softirq handlers.  This commit adds some teeth to this statement by
adding a WARN_ON_ONCE().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 37455a1..9c31001 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1377,6 +1377,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
 	struct rt_read_seg *rtrsp1;
 	unsigned long long ts;
 
+	WARN_ON_ONCE(!rcu_is_watching());
 	newstate = rcutorture_extend_mask(readstate, trsp);
 	rcutorture_one_extend(&readstate, newstate, trsp, rtrsp++);
 	started = cur_ops->get_gp_seq();
-- 
2.9.5

