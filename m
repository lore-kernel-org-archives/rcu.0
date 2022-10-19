Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97313C433FE
	for <rcu@archiver.kernel.org>; Wed, 19 Oct 2022 22:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiJSWrC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 19 Oct 2022 18:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiJSWq6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 19 Oct 2022 18:46:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4A5189C3A;
        Wed, 19 Oct 2022 15:46:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6773B82565;
        Wed, 19 Oct 2022 22:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A66C433D6;
        Wed, 19 Oct 2022 22:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219612;
        bh=ZG4aSPWT39VnE1RWNNPIrbbBQn09pN7NZIq4jagKU90=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=h1f+ch+h9OpSbbYc1ykW9MUsKtRnc6c/wrC6nCucP/IGLQ/ImLqGllecH4Na5f1Qw
         PEaZTxJX/e/fur6OXD6jETgFPIGQ5prsPG4uuONZvfnyx1tKEAMnJvDL79vi90lsv3
         KKDD0DYi2YRHERzEP0+YLjtke97lQWYBO5mNWmx3So0z1NdFXUU1DvuFyy6fo2HskC
         hzsy4B7Vs65CxsLollVWB4ObuhU4jZ0BUc1vk6pHpcD/X/hFTECfqOluZ9QyfPgT8v
         79Z4Of3jqQCWFbZJ3dPv2np4KNWD9PX7Rcm0t3u9QND9WZQ0JXzCvsl43HQgMumTaV
         FByHHw0VPHV+Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 234915C06B4; Wed, 19 Oct 2022 15:46:52 -0700 (PDT)
Date:   Wed, 19 Oct 2022 15:46:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/8] Miscellaneous fixes for v6.2
Message-ID: <20221019224652.GA2499358@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains miscellaneous fixes:

1.	Remove duplicate RCU exp QS report from rcu_report_dead(),
	courtesy of Zqiang.

2.	Synchronize ->qsmaskinitnext in rcu_boost_kthread_setaffinity(),
	courtesy of Pingfan Liu.

3.	Remove unused 'cpu' in rcu_virt_note_context_switch(), courtesy
	of Zeng Heng.

4.	Use READ_ONCE() for lockless read of rnp->qsmask, courtesy of
	"Joel Fernandes (Google)".

5.	Explain why SLAB_DESTROY_BY_RCU reference before locking.

6.	Remove rcu_is_idle_cpu(), courtesy of Yipeng Zou.

7.	rcu-tasks: Make grace-period-age message human-readable.

8.	Fix __this_cpu_read() lockdep warning in
	rcu_force_quiescent_state(), courtesy of Zqiang.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/kvm_host.h |    2 +-
 b/include/linux/rcutiny.h  |    2 +-
 b/include/linux/rcutree.h  |    2 +-
 b/include/linux/slab.h     |    6 ++++++
 b/kernel/rcu/tasks.h       |    2 +-
 b/kernel/rcu/tree.c        |    2 --
 b/kernel/rcu/tree_plugin.h |    5 ++++-
 include/linux/rcutiny.h    |    2 --
 include/linux/rcutree.h    |    2 --
 kernel/rcu/tree.c          |   10 ++--------
 10 files changed, 16 insertions(+), 19 deletions(-)
