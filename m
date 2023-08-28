Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067ECC83F18
	for <rcu@archiver.kernel.org>; Mon, 28 Aug 2023 22:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjH1WQH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Aug 2023 18:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbjH1WPr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Aug 2023 18:15:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEAE10A;
        Mon, 28 Aug 2023 15:15:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C82261CD4;
        Mon, 28 Aug 2023 22:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB30FC433C8;
        Mon, 28 Aug 2023 22:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693260943;
        bh=V+aJqAsHK8sr2iNGFlGHXMwKWu/apnVARMPwjZrqRjg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RxkJptp3BHq8EzwCmijzCdSwwGG6cfCFPJWWtkShisBooUEKgqnPvo38z5vDLEDcG
         20HTo7qQNCICfGdwkDwhm1+6E2+VBUHZ+55B0H8CV9RbnsaukMLa3v6Xp48cYiaHEY
         sFVMNFz1Vivglm3UBw0dDgGeM8H8B+HXbtswUUBSAIHS0pDzujqDYGpFmMOmzsvkjj
         MCdgSRXPN3Mvo2yRvFWzkspVa34HE8SRxmzxIWhJnuvjiiyyOJnKBRCkeBFttMACqC
         06fSZz8Kh1msNtLAINk1bod1544BSeyr2z/RYTiEFSoMIBUlnIdhEa4+GWD/Y5vUiu
         og/uoiUEK0YJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B694EC3959E;
        Mon, 28 Aug 2023 22:15:43 +0000 (UTC)
Subject: Re: [GIT PULL] scftorture changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <79cb1ec7-08ec-40d2-bbb4-ce40b684f1a4@paulmck-laptop>
References: <79cb1ec7-08ec-40d2-bbb4-ce40b684f1a4@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <79cb1ec7-08ec-40d2-bbb4-ce40b684f1a4@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/scftorture.2023.08.15a
X-PR-Tracked-Commit-Id: 3f68f9c822ebe208f961ab0402e49a10465278ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ae0c157658b26e78eb30b50939ce3dfb794d21f
Message-Id: <169326094373.8741.14358880837632314778.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 22:15:43 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, rcu@vger.kernel.org,
        rostedt@goodmis.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The pull request you sent on Thu, 24 Aug 2023 15:06:20 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/scftorture.2023.08.15a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ae0c157658b26e78eb30b50939ce3dfb794d21f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
