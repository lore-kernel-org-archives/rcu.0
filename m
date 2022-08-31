Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD15ECAAD1
	for <rcu@archiver.kernel.org>; Wed, 31 Aug 2022 18:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiHaSPO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 31 Aug 2022 14:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiHaSOB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 31 Aug 2022 14:14:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48E7F14F8;
        Wed, 31 Aug 2022 11:12:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5D8861C12;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00A5C43145;
        Wed, 31 Aug 2022 18:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969532;
        bh=bzKU7PKdCGbkmiMWj3QAJG1+fLAMsGALe9aOVvfa5P0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O2M52KrAgOKK6OZ4MGlb2A88bli74vfHA09J58qAKAisbM3AQGwog9dcNB7iduFzq
         ANpP/nsVzZ6tHrV4GgHw2QItlHwe4njcvqDLpiGCYFojw2ydGdOOuY7iEyRYaVy8i+
         qzSW38wZfp+bCTBWrP2qA+hg5Zl05fw6BUjm+vQS6egB++gPcMU2aa6sAy3hzRm+Fx
         D0ZU0kQ5ihmzzpb0X7zjI4HuRpitrE3xrsdp5BXZ7LqaGJqvK5p4zcVdoszI+AlILi
         +6a3UqZ/H3zyuaiVKIp9WyyGcz/P6ohDr/dzC6X3mchSCiw5oM8F/uOe1dP7Q/JiaR
         sYnRVS5aj9Fag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 62BE15C090A; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 06/25] rcutorture: Remove redundant RTWS_DEF_FREE check
Date:   Wed, 31 Aug 2022 11:11:51 -0700
Message-Id: <20220831181210.2695080-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831181207.GA2694717@paulmck-ThinkPad-P17-Gen-1>
References: <20220831181207.GA2694717@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This check does nothing because the state at this point in the code
because the rcu_torture_writer_state value is guaranteed to instead
be RTWS_REPLACE.  This commit therefore removes this check.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 050f4d0a987ff..236bd6b57277f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1314,8 +1314,7 @@ rcu_torture_writer(void *arg)
 			if (cur_ops->get_gp_state && cur_ops->poll_gp_state) {
 				idx = cur_ops->readlock();
 				cookie = cur_ops->get_gp_state();
-				WARN_ONCE(rcu_torture_writer_state != RTWS_DEF_FREE &&
-					  cur_ops->poll_gp_state(cookie),
+				WARN_ONCE(cur_ops->poll_gp_state(cookie),
 					  "%s: Cookie check 1 failed %s(%d) %lu->%lu\n",
 					  __func__,
 					  rcu_torture_writer_state_getname(),
-- 
2.31.1.189.g2e36527f23

