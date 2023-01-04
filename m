Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCE9C53210
	for <rcu@archiver.kernel.org>; Wed,  4 Jan 2023 20:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239967AbjADUnW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Jan 2023 15:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbjADUnV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Jan 2023 15:43:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FE31C111
        for <rcu@vger.kernel.org>; Wed,  4 Jan 2023 12:43:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C5F361821
        for <rcu@vger.kernel.org>; Wed,  4 Jan 2023 20:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A60C433D2;
        Wed,  4 Jan 2023 20:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672864999;
        bh=ph7EZCQ6ORFJjviF+si3bUlkRSURCp8KhWK2+JdctO8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kvM0+UsopkrNEvuYmpg1ZrnfNh1dekP3D1+AhLDDWHLmcTN/5J8Y9kW05d6I4fnv5
         2N4WXx+7+3iBJTyuI2XQQpSB1paUzXn/PKMwWTYS4LsDFSUJqpxueO/vyGwPyN4d/u
         eaGV6NP6I5xJYUd0xSfh1bmbYb3kb1duNszljbyrIAfByGjIB+7c0uSAQEd2Vz842m
         HJUBDv1WSoZs2fG2Ur07KdoCHojLtww0IqIBqNhtFQbSsfiFgfKbZh8tf2M9KBT1lk
         cf4vnsbzH6JTHmmEFGCFHbkd7w6w9DbNO/qtkfAA/oXkwxu7UB99z55fDggF2ZebWS
         RiP/2cEc124bA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 873395C066D; Wed,  4 Jan 2023 12:43:18 -0800 (PST)
Date:   Wed, 4 Jan 2023 12:43:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: Re: [PATCH] srcu: Add comments for srcu_size_state
Message-ID: <20230104204318.GJ4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221223130228.40737-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223130228.40737-1-kernelfans@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Dec 23, 2022 at 09:02:28PM +0800, Pingfan Liu wrote:
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>,
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
> To: rcu@vger.kernel.org

Queued, thank you!

After the inevitable wordsmithing, it appears as follows.  Could you
please check it?  (And yes, it does take advantage of 100 columns.)

							Thanx, Paul

------------------------------------------------------------------------

commit 9c473f0ef9eb8f3ac76d8295cfb4065a738b07a1
Author: Pingfan Liu <kernelfans@gmail.com>
Date:   Wed Jan 4 12:29:01 2023 -0800

    srcu: Add comments for srcu_size_state
    
    The SRCU_SIZE_* names are not self-explanatory, so this commit therefore
    adds comments to the definitions.
    
    Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
    Cc: Lai Jiangshan <jiangshanlai@gmail.com>
    Cc: "Paul E. McKenney" <paulmck@kernel.org>
    Cc: Frederic Weisbecker <frederic@kernel.org>,
    Cc: Josh Triplett <josh@joshtriplett.org>
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
    To: rcu@vger.kernel.org
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 558057b517b74..a6910805f9c51 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -92,16 +92,29 @@ struct srcu_struct {
 	struct lockdep_map dep_map;
 };
 
-/* Values for size state variable (->srcu_size_state). */
-#define SRCU_SIZE_SMALL		0
-#define SRCU_SIZE_ALLOC		1
-#define SRCU_SIZE_WAIT_BARRIER	2
-#define SRCU_SIZE_WAIT_CALL	3
-#define SRCU_SIZE_WAIT_CBS1	4
-#define SRCU_SIZE_WAIT_CBS2	5
-#define SRCU_SIZE_WAIT_CBS3	6
-#define SRCU_SIZE_WAIT_CBS4	7
-#define SRCU_SIZE_BIG		8
+// Values for size state variable (->srcu_size_state).  Once the state
+// has been set to SRCU_SIZE_ALLOC, the grace-period code advances through
+// this state machine one step per grace period until the SRCU_SIZE_BIG state
+// is reached.  Otherwise, the state machine remains in the SRCU_SIZE_SMALL
+// state indefinitely.
+#define SRCU_SIZE_SMALL		0	// No srcu_node combining tree, ->node == NULL
+#define SRCU_SIZE_ALLOC		1	// An srcu_node tree is being allocated, initialized,
+					//  and then referenced by ->node.  It will not be used.
+#define SRCU_SIZE_WAIT_BARRIER	2	// The srcu_node tree starts being used by everything
+					//  except call_srcu(), especially by srcu_barrier().
+					//  By the end of this state, all CPUs and threads
+					//  are aware of this tree's existence.
+#define SRCU_SIZE_WAIT_CALL	3	// The srcu_node tree starts being used by call_srcu().
+					//  By the end of this state, all of the call_srcu()
+					//  invocations that were running on a non-boot CPU
+					//  and using the boot CPU's callback queue will have
+					//  completed.
+#define SRCU_SIZE_WAIT_CBS1	4	// Don't trust the ->srcu_have_cbs[] grace-period
+#define SRCU_SIZE_WAIT_CBS2	5	//  sequence elements or the ->srcu_data_have_cbs[]
+#define SRCU_SIZE_WAIT_CBS3	6	//  CPU-bitmask elements until all four elements of
+#define SRCU_SIZE_WAIT_CBS4	7	//  each array have been initialized.
+#define SRCU_SIZE_BIG		8	// The srcu_node combining tree is fully initialized
+					//  and all aspects of it are being put to use.
 
 /* Values for state variable (bottom bits of ->srcu_gp_seq). */
 #define SRCU_STATE_IDLE		0
