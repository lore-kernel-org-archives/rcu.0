Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681A4C433EF
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38C31610A6
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhIPA2b (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 20:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232465AbhIPA2a (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 20:28:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32D266108F;
        Thu, 16 Sep 2021 00:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631752031;
        bh=cEL/L+ZjNWSduUWcr5nyho3gOYF9O19HEtMawXccHik=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=BjQ3fd+ZdLum6vMSrkslA+yQrxs5MtYtznV0LPkYeamiKLcexh9/NQBAFQDKHd2+7
         ynjePclr+HuThJ6GW4k6K9R6tz5SIEC73z9hNSW9JDEETSy6Jnq4lUkdJNsmJdApHb
         msPecuIzIUUEvyYw9BXHrsOKXhzcdGYYQ7ILr+3PgYX0e962xXB5//VSFeA2os+z9U
         nPIvoJlpY/Q+RWSpRbh7pkUYFJGvDnnnik54NPmyS0TqRgxfdSb1Y+M+T8Ln7pCEri
         F5oqwqDPI2V10snmbIJJMgL0OUK8HMhCC/VmIOJRL6k95g1gH75Pz7vc0EvINj2idy
         IS7EUmoDKsVNg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 017895C054E; Wed, 15 Sep 2021 17:27:10 -0700 (PDT)
Date:   Wed, 15 Sep 2021 17:27:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH rcu 0/5] Torture-script updates for v5.16
Message-ID: <20210916002710.GA3909915@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains torture-script updates:

1.	Apply CONFIG_KCSAN_STRICT to kvm.sh --kcsan argument.

2.	Make torture.sh print the number of files to be compressed.

3.	Add an extract-stall script.

4.	Allot 1G of memory for scftorture runs.

5.	Make kvm-remote.sh print size of downloaded tarball.

						Thanx, Paul

------------------------------------------------------------------------

 b/tools/rcu/extract-stall.sh                           |   33 +++++++++++++++++
 b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh |    1 
 b/tools/testing/selftests/rcutorture/bin/kvm.sh        |    2 -
 b/tools/testing/selftests/rcutorture/bin/torture.sh    |    9 +++-
 tools/testing/selftests/rcutorture/bin/torture.sh      |    2 -
 5 files changed, 43 insertions(+), 4 deletions(-)
