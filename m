Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6885C4332F
	for <rcu@archiver.kernel.org>; Tue, 31 Oct 2023 05:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbjJaFnK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 31 Oct 2023 01:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbjJaFnG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 31 Oct 2023 01:43:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BD3100;
        Mon, 30 Oct 2023 22:43:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11D34C43391;
        Tue, 31 Oct 2023 05:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698730953;
        bh=OlKgjZGtwAMv92r/wP+e0lq5eofuI/cKEslNw2JQzII=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=t+OEILRvt36tPaUzHo+RqBcfWFge02vETq1WQ6EDOTJuKgJdbhiZ/jHR0CNF4k53/
         YPuXovcXybw/WpHQ7DMIWw2eQuB6c4iwFDSWXhvbdW1WN9wgoEhuyRKRPk1ge0o1CO
         qyEzukz86ZU8aJqN2Ae4+MXB/DZ8B3bJ0Xl/W4sl1sEnhBTYXkDqCGS/Ikeia4LTYa
         Lyy6sddo/pvkZFcxc4TNrfBv5dsDFbQH6vLV2R59UO0z4R++yd2nrjLNLcMK5oT0/O
         dTxQVoaXaHuP+sLZ/D1scQhtJS49cDndR+49w29AblxLO7TZLjHF/tqAOZCLjfykk9
         6ZLWu2j5zT+5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 002D2EAB08C;
        Tue, 31 Oct 2023 05:42:33 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZTuf+xNrfqGjHFDK@lothringen>
References: <ZTuf+xNrfqGjHFDK@lothringen>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZTuf+xNrfqGjHFDK@lothringen>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git tags/rcu-next-v6.7
X-PR-Tracked-Commit-Id: d97ae6474ca0411bb8c2696e5764ec946dba43d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2656821f1f202d58224551b71eff41aafd1edf8b
Message-Id: <169873095299.17204.6636032620489047649.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 05:42:32 +0000
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Z qiang <qiang.zhang1211@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The pull request you sent on Fri, 27 Oct 2023 13:33:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git tags/rcu-next-v6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2656821f1f202d58224551b71eff41aafd1edf8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
