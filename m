Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B66EB64D9
	for <rcu@archiver.kernel.org>; Tue, 27 Jun 2023 18:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjF0SCX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Jun 2023 14:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjF0SCW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Jun 2023 14:02:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA89FC4;
        Tue, 27 Jun 2023 11:02:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 675AD61199;
        Tue, 27 Jun 2023 18:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9488C433C0;
        Tue, 27 Jun 2023 18:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687888940;
        bh=18rkMIPCaIP3xxXorwjtEuqe+ycEMD9EjBEKU5YpGsQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=a0O+lgU36/OUH0Sl4Yq7MptHVg+5VngSWLudVX3HX7rSWDwYiudAWcFeIzTA1+9qc
         MAODUcwTtRn8SbE19ZWIAvsZoTceRDiDiL3F8Z42d0oaypROrsc9BYHeMFIVcsoAcN
         SiCu5rclUT0e9knm+g9vZyFaXDWjQxifdRAZd3Dy57So8/0ziHkulA359drPpf65ip
         WcQg2yDsLqK1zCX5UKIlw3WGLav3Y3z+fxX2RbRPsJwwXe5KL7zssZPLMumnjlxCAG
         +7Wj4RpmSyrb/KZIyzInvE7hbZ+K1ae/fXhx8HJ3jF+mCRT3fDY0jTmHycTneWie9m
         1Wl/S3WLr8spg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABC20E53807;
        Tue, 27 Jun 2023 18:02:20 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <963d6eb8-6520-4c33-bbe8-6c76205bfd3d@paulmck-laptop>
References: <963d6eb8-6520-4c33-bbe8-6c76205bfd3d@paulmck-laptop>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <963d6eb8-6520-4c33-bbe8-6c76205bfd3d@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2023.06.22a
X-PR-Tracked-Commit-Id: 2e31da752c6d0e892f2a9232e18da816d04ee691
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af96134dc8562f9fcbb8358af36f6086619a29ab
Message-Id: <168788894068.10734.288268348758088738.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 18:02:20 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The pull request you sent on Sun, 25 Jun 2023 08:35:40 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2023.06.22a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af96134dc8562f9fcbb8358af36f6086619a29ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
