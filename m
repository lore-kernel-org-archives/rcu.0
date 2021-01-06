Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FF8C433DB
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E2323125
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbhAFRbh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:31:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:46066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbhAFRbh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:31:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABB0623125;
        Wed,  6 Jan 2021 17:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954256;
        bh=xFQKoZ+wuRwtiozNuvxBbs97SoKonpfy6pQu9goHjmg=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=YV3g4XmhVUBOMmYVfJ/0L67SBcSKI6ryPsV/jaMu3B9iiqW+QLI3zb2Gp10SbOxV/
         +NyAjexyZSeyVbmzBol/fg6m+UobjI/ObPBn2pfTs9U72WSlziLB0iLQGjd+TTXOyo
         qQEs1IbtfxdF7ccX/W+eNTX+A9AnhvNdnRHTrxbLmdkgjgomhCt2tQqKhCSrEd3Dcu
         FjkdbVNEhM+I1JP+FtBm2mPXumHnyqClrrXD2BZP1WmB2JnpmF/TA83txFZnysOQMS
         FwJo2onmHcnhVz3sUESfvxo9Z0qGw6mUTdDDIoMo6wr7d6xb3Jq0q910MRoIrWAzhO
         X+ST6uRdza/dw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 881E735225EC; Wed,  6 Jan 2021 09:30:56 -0800 (PST)
Date:   Wed, 6 Jan 2021 09:30:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/18] Add a torture-all acceptance-test script
 for v5.12
Message-ID: <20210106173056.GA23035@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series adds a script to run a full set of tests.  My earlier practice
of testing just what changed proved inappropriate for the high-distraction
environment of a few months ago.

1.	Do Kconfig analysis only once per scenario.

2.	Add torture.sh torture-everything script.

3.	Make torture.sh use common time-duration bash functions.

4.	Remove use of "eval" in torture.sh.

5.	Add "make allmodconfig" to torture.sh.

6.	Auto-size SCF and scaling runs based on number of CPUs.

7.	Enable torture.sh argument checking.

8.	Make torture.sh rcuscale and refscale deal with allmodconfig.

9.	Make torture.sh refscale runs use verbose_batched module
	parameter.

10.	Create doyesno helper function for torture.sh.

11.	Make torture.sh allmodconfig retain and label output.

12.	Make torture.sh throttle VERBOSE_TOROUT_*() for refscale.

13.	Make torture.sh refuse to do zero-length runs.

14.	Drop log.long generation from torture.sh.

15.	Allow scenarios to be specified to torture.sh.

16.	Add command and results directory to torture.sh log.

17.	Add --kcsan-kmake-arg to torture.sh for KCSAN.

18.	Compress KASAN vmlinux files.

						Thanx, Paul

------------------------------------------------------------------------

 kvm.sh     |   22 +
 torture.sh |  698 +++++++++++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 585 insertions(+), 135 deletions(-)
