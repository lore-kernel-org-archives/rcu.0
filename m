Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B54C4332F
	for <rcu@archiver.kernel.org>; Mon, 12 Dec 2022 16:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiLLQb2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Dec 2022 11:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiLLQbN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 12 Dec 2022 11:31:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCAEDECD;
        Mon, 12 Dec 2022 08:31:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7783A61135;
        Mon, 12 Dec 2022 16:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFAE9C433D2;
        Mon, 12 Dec 2022 16:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670862667;
        bh=eqfw8MZLwZQCexJ/EiNRzQkXY1bX7MhxmhWFB3wrvdY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OP/iqn6n3n47QRdXSXIigr7cU8/mD7UxXREhE6XtJ6Krl7VE/HOQ9DzET7IfMfhAV
         r+dRCXu5aUCjeBnPp1+/VMTAGs6Kr3CJkl9vVtYg2OPweHmjp5F2bRRcXZHbfX8Jhc
         eK7wo6e73idv5jD4YNV6yqZayi9IBg+nwbhyPP+K/H3C4uoi9v8co38s7QKwZFVaay
         WdJOgx0+LVMy5UgFPm/owiNk4nFySr6DMDYKWCa69dPxgQlVdjaPYT2PWYA4uCVQnK
         owFhA9+P375yNBK76ppLjppL3NJ++VlxvFWVPAcZGslgu+6Km/DvwA8dYGIU+D1pC4
         uGunder3c2NdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5F78C197B4;
        Mon, 12 Dec 2022 16:31:07 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221203011147.GA1815487@paulmck-ThinkPad-P17-Gen-1>
References: <20221203011147.GA1815487@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221203011147.GA1815487@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2022.12.02a
X-PR-Tracked-Commit-Id: 87492c06e68d802852c7ba76b4d3fde50807d72a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fab45ab6e823f9d7e5bc9520b2aa6564d6d58a7
Message-Id: <167086266780.18680.5490499760721131979.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 16:31:07 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@meta.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The pull request you sent on Fri, 2 Dec 2022 17:11:47 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2022.12.02a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fab45ab6e823f9d7e5bc9520b2aa6564d6d58a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
