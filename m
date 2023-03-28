Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3F6C761A6
	for <rcu@archiver.kernel.org>; Tue, 28 Mar 2023 20:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjC1Ude (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjC1Udc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 28 Mar 2023 16:33:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6671D1FC3;
        Tue, 28 Mar 2023 13:33:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11A3AB81E66;
        Tue, 28 Mar 2023 20:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AACA9C433D2;
        Tue, 28 Mar 2023 20:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680035606;
        bh=yGzQt3bTBLlinCBi2YE0p92SNdMCAG34Oidgft38CVg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SGLdxbKA1dKWD+8njtsnnG1e0Ty2NTi0Re+X2hnILGOJ0J3KJAdV23Ndbcee6w4RP
         mpZWT5WPRLBgqUF4z21vpPrxQSga8YFJT6F8+6PxV4h9FX9x3n+/lfrvNK5vx5j6T7
         Ff7VJnuFM8gjx3EeCpBJyY82oSwlgCVC2+RFy425fR01IEOXUsnlBGcx779YM03pAM
         M5lGWLzAz1gGkppo9lRdis7gic30MIajTp2t3gDdn2cMseyYQrPx6e/ZeBqa/7/t9r
         pyye7ipi+doc/s5GLXFEyxWg6AD8SDAWi+4wvpElDthzAUv9C7s1O82v9TtjeYCJK/
         j0UTIVBihtjXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92F08E4D022;
        Tue, 28 Mar 2023 20:33:26 +0000 (UTC)
Subject: Re: [GIT PULL] Fix rcu_torture_read ftrace event
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9f32a8e2-7fc3-427b-b1e2-238fe81ce97e@paulmck-laptop>
References: <9f32a8e2-7fc3-427b-b1e2-238fe81ce97e@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9f32a8e2-7fc3-427b-b1e2-238fe81ce97e@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/urgent-rcu.2023.03.28a
X-PR-Tracked-Commit-Id: d18a04157fc171fd48075e3dc96471bd3b87f0dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcd476ea6a888ef6e6627f4c21a2ea8cca3e9312
Message-Id: <168003560659.432.16055539152135523350.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Mar 2023 20:33:26 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, douglas.raillard@arm.com,
        tglx@linutronix.de, rcu@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The pull request you sent on Tue, 28 Mar 2023 10:48:14 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/urgent-rcu.2023.03.28a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcd476ea6a888ef6e6627f4c21a2ea8cca3e9312

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
