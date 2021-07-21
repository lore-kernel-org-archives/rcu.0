Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6992FC6377B
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D6961221
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhGUT5W (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:57:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231344AbhGUT5W (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:57:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C7BE61003;
        Wed, 21 Jul 2021 20:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626899878;
        bh=0eLeS3k0y7Fs6C2dVLp9Afq//m2THMjXFEe78US7XrE=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=iCrlJ3bLiP8GZgXZUMIQgyH+pJkP4zjwSo4nXfuqqKIZ+uMKsrG709S0IoYN6jXUV
         p7Y4CIsTdZIC84yFO2A5jMEEgaiWxcXIUAUabeg7bp4D55t3WsIDNXZNwJ153XqomF
         0bE80dQYSonPBtTpSbRVJr5HzPWMn7chlJlHpe/iLE+mV4iFrLladcsdgNBgDuWsv0
         8LSlA/kesL3fKl9e7GWtTCXYGy3s4wMkyxFIXMw+Hgynzey88RH9C3fs+iCVzLRkRm
         Pm258yCM6TOUltl0oBRvmQRw+vXRGdrg+SGmFvm+sEn/0+Gip7Np0N8kOVIMAEOFPc
         ZxcOwe7UJN2lw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2A2145C09A4; Wed, 21 Jul 2021 13:37:58 -0700 (PDT)
Date:   Wed, 21 Jul 2021 13:37:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH rcu 0/5] Tasks-RCU updates for v5.15
Message-ID: <20210721203758.GA3386731@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains Tasks-RCU updates:

1.	rcu-tasks: Add comments explaining task_struct strategy.

2.	rcu-tasks: Mark ->trc_reader_nesting data races.

3.	rcu-tasks: Mark ->trc_reader_special.b.need_qs data races.

4.	rcu-tasks: Fix synchronize_rcu_rude() typo in comment.

5.	Fix macro name CONFIG_TASKS_RCU_TRACE, courtesy of Zhouyi Zhou.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcupdate.h |    2 +-
 b/kernel/rcu/tasks.h       |   11 ++++++++++-
 b/kernel/rcu/tree_plugin.h |    8 ++++----
 kernel/rcu/tasks.h         |   23 ++++++++++++-----------
 4 files changed, 27 insertions(+), 17 deletions(-)
