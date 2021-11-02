Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC47C433F5
	for <rcu@archiver.kernel.org>; Tue,  2 Nov 2021 03:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95C6360FC2
	for <rcu@archiver.kernel.org>; Tue,  2 Nov 2021 03:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhKBDph (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 1 Nov 2021 23:45:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231526AbhKBDpg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 1 Nov 2021 23:45:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 996C0603E7;
        Tue,  2 Nov 2021 03:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635824582;
        bh=KXz0p12Nzdx4B23cIQ1dc95IDwVYhN/CqNvbAJRH19A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LjYmtZmjEKLUclJpAnBiaIifPX16asUqIDw78V8AD1SXFyL7AJRgq3JhvgtwYC0ce
         36J5RdUF/ExsschlGpsjEwNQVUhaogRfCIIRAQWHeK1xwKx0vO1Nce7MzVC2iwVvhK
         n/glBILq0BCRU1E6vsth4fZkcUjCTLMLFnffT5RCAeWtC324nPUavZa0heey7r36uV
         ZWulEnkZpZnQqvBWVuE/KtDjpJEs+mPnlHx53MlwBN0nVZ1Izlz9AT1ZcvT/cGOfcj
         wB7kYMEFtESQqtGA3YFFbuRc0NziHR+qWdjJvn6xQUtWFbPVJiNvwSI8p43rH/2AWS
         ULU4lRDLTsLdw==
Subject: Re: [GIT PULL] RCU changes for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211101232519.GA508858@paulmck-ThinkPad-P17-Gen-1>
References: <20211101232519.GA508858@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211101232519.GA508858@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2021.11.01a
X-PR-Tracked-Commit-Id: dd1277d2ad95e7f0de1b79c70fdfe635d9df0f80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fedc28076bbbb32edb722e80f9406a3d1d668a8
Message-Id: <163582458250.3035.1240562827154998297.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 03:43:02 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com, juri.lelli@redhat.com,
        longman@redhat.com, neeraju@codeaurora.org, peterz@infradead.org,
        swood@redhat.com, zhouzhouyi@gmail.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 16:25:19 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2021.11.01a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fedc28076bbbb32edb722e80f9406a3d1d668a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
