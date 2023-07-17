Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499A2EB64DC
	for <rcu@archiver.kernel.org>; Mon, 17 Jul 2023 18:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjGQSSh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Jul 2023 14:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjGQSSd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Jul 2023 14:18:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E89E6F;
        Mon, 17 Jul 2023 11:18:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FECF611D1;
        Mon, 17 Jul 2023 18:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F85EC433C7;
        Mon, 17 Jul 2023 18:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617893;
        bh=qWUu8PF0tZZSAIf3SBn9RhDk4Qva5kb5eZvPW+nZlN0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=A6TR5Eu2lWcSMwhT4Ng67kkz8cXprRJnjUVJeJ9WLTXO4s9LBOW1ZzhW27uvqTZ5n
         BtwtnyYTelmF8Dz/3lX+524S/9Co+5ROOzICA1rNY5SCJEKmSVFEgbsoowv6C6gIx2
         uiaK15rN45gSuB25N4SOxoU6iofi+ZIq3gbsbhHuHeuelBMzLG/N7E+cWsRMxRinwk
         /ZKAgimJmg1UWNVvz1UtjkViFGSQYmRFuqBt9m7PQ5aBqNO6dHzUhtsUAQ9bw1VBnm
         mnUH7mmtMAXmfQqhsWytOchtKs/c7xPeXMNR1A8vDY7C+S/tpme4Eu3SyGgMnFKzgi
         qF3f/vNJkY35w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 562B3CE03F1; Mon, 17 Jul 2023 11:18:13 -0700 (PDT)
Date:   Mon, 17 Jul 2023 11:18:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/4] Torture-test updates for smp_call_function()
Message-ID: <38be0135-a7a4-4c16-b2c6-1b3817c3067f@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains updates for the smp_call_function() torture tests:

1.	Scale scftorture memory based on number of CPUs.

2.	Forgive memory-allocation failure if KASAN.

3.	Pause testing after memory-allocation failure.

4.	Add CONFIG_PREEMPT_DYNAMIC=n to NOPREEMPT scenario.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/scftorture.c                                      |    6 ++++--
 b/tools/testing/selftests/rcutorture/bin/torture.sh        |    4 +++-
 b/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT |    2 ++
 kernel/scftorture.c                                        |    6 +++++-
 4 files changed, 14 insertions(+), 4 deletions(-)
