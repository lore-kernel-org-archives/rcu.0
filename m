Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E12C636CA
	for <rcu@archiver.kernel.org>; Thu, 15 Jul 2021 22:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 885BC613D4
	for <rcu@archiver.kernel.org>; Thu, 15 Jul 2021 22:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhGOWsI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Jul 2021 18:48:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhGOWsH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Jul 2021 18:48:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A266D611C0;
        Thu, 15 Jul 2021 22:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626389113;
        bh=sTE8Lbkdaq5tSiIGXaUgH6+Aei9w1MKrtrWhxxdfptw=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=IWEhuNp2ZeXUSJF+6eRSJ2tCfTi4e69PUBFH+CPF/QH56+SfRBIlxehOMGtOFfy7/
         5YizLQQeY4akjFAO/puDxffyy3QPreEsy5TunJ2vZO8TXsjJJPJsltOFj4J9iSdDoV
         ZCPzu5PcG5Tp8WMW4bOIK0hChmBR0VSamhbIiEq3R5Q5LilLgf/W2kHPzbRuj5DZva
         qrbRLkSt4sc1l7bSUxBcalLegR7RldjdrhI3fVFonhtNeRzW9QZu30YU9Y3CmRoosi
         SclgFQM3zkCVu5etyR7ekUqkLy2aYRjLd3SReG2Cs2KY81YTxORukPOGSgcxlFqHXP
         AfwaxtNAxfPmA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6B5015C0355; Thu, 15 Jul 2021 15:45:13 -0700 (PDT)
Date:   Thu, 15 Jul 2021 15:45:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, yanfei.xu@windriver.com, ast@kernel.org,
        andriin@fb.com, kernel-team@fb.com
Subject: [GIT PULL] RCU fixes for v5.14
Message-ID: <20210715224513.GA1391317@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Linus,

Please pull fixes for RCU from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git urgent
  # HEAD 79160a603bdb51916226caf4a6616cc4e1c58a58: Merge tag 'usb-5.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2021-07-05 14:16:22 -0700)

The changes are as follows:

09cd91a30b76 ("scftorture: Avoid false-positive warnings in scftorture_invoker()")
12a87a106aad ("refscale: Avoid false-positive warnings in ref_scale_reader()")
	These commits fix regressions induced by a merge-window change
	in scheduler semantics, which means that smp_processor_id()
	can no longer be used in kthreads using simple affinity to bind
	themselves to a specific CPU.

99cc18e36e90 ("rcu-tasks: Don't delete holdouts within trc_inspect_reader()")
f5aa977ca96e ("rcu-tasks: Don't delete holdouts within trc_wait_for_one_reader()")
	These commits fix a pre-merge-window bug in Tasks Trace RCU that
	was thought to be strictly theoretical.  However, production
	workloads have started hitting this, so these fixes need to be
	merged sooner rather than later.

30363f26e6cc ("rcu: Fix pr_info() formats and values in show_rcu_gp_kthreads()")
	This commit fixes a minor printk()-format-mismatch issue
	introduced during the merge window.

All of these changes have been exposed to -next and kbuild test robot testing,
and of course also to the usual rcutorture testing.

----------------------------------------------------------------
Paul E. McKenney (5):
      scftorture: Avoid false-positive warnings in scftorture_invoker()
      refscale: Avoid false-positive warnings in ref_scale_reader()
      rcu-tasks: Don't delete holdouts within trc_inspect_reader()
      rcu-tasks: Don't delete holdouts within trc_wait_for_one_reader()
      rcu: Fix pr_info() formats and values in show_rcu_gp_kthreads()

 kernel/rcu/refscale.c   | 6 +++---
 kernel/rcu/tasks.h      | 6 ++----
 kernel/rcu/tree_stall.h | 4 ++--
 kernel/scftorture.c     | 6 +++---
 4 files changed, 10 insertions(+), 12 deletions(-)
