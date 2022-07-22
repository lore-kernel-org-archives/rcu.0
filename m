Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492CBC43334
	for <rcu@archiver.kernel.org>; Fri, 22 Jul 2022 18:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbiGVSqt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 22 Jul 2022 14:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiGVSqt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 22 Jul 2022 14:46:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892868E1D4;
        Fri, 22 Jul 2022 11:46:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46E75B82A00;
        Fri, 22 Jul 2022 18:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9406C341CF;
        Fri, 22 Jul 2022 18:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658515606;
        bh=Z2HchYC/cIOlvGlAdiDEipQNphAUwzWoKKEFmiVeT34=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nomlzvpZ7qga21aYr69GaE85nXmC3UTaIu+WyapZR2qOOTo8q+Kow5qRF5sFg9BKD
         GjZw0L0u1impn6xS+yUuGLJsDto6tK/ZthJEr7cwspPGDuYQborbz9A5sXjfNj8NVY
         0z1dYFcJk5q4NmPV4IgkcG6YXwD+ZW83mIC5S9hGfNJAcED8wrqutfdWclw0Tnk43w
         cKTLKMgPtu7fJqcAVMoK4XPA2K5agyKR9G0Cc7GnCvrIw8GzaN0BnDTaBF4ZoDlCHI
         M/PcqTjUYYQATNvqAaNzdI0sES+bhlAooyYvu8XGlgKu2mQ7QwfEEt/0xo+pGKz2LM
         Oj2x9eVmLnYmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D58C8D9DDDD;
        Fri, 22 Jul 2022 18:46:45 +0000 (UTC)
Subject: Re: [GIT PULL] Urgent fix for expedited SRCU v5.19 boot-speed regression
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220722002825.GA2848736@paulmck-ThinkPad-P17-Gen-1>
References: <20220722002825.GA2848736@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220722002825.GA2848736@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu-urgent.2022.07.21a
X-PR-Tracked-Commit-Id: 4f2bfd9494a072d58203600de6bedd72680e612a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ba1329cbb9456c937bff1ed8ad4ca91ab75eab6
Message-Id: <165851560586.6992.15504211634045678082.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Jul 2022 18:46:45 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, zhangfei.gao@linaro.org,
        chenxiang66@hisilicon.com, shameerali.kolothum.thodi@huawei.com,
        pbonzini@redhat.com, quic_neeraju@quicinc.com, maz@kernel.org,
        yueluck@163.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The pull request you sent on Thu, 21 Jul 2022 17:28:25 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu-urgent.2022.07.21a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ba1329cbb9456c937bff1ed8ad4ca91ab75eab6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
