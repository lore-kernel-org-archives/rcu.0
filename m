Return-Path: <SRS0=BMES=2A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796E7C43603
	for <rcu@archiver.kernel.org>; Tue, 10 Dec 2019 04:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBB7207FF
	for <rcu@archiver.kernel.org>; Tue, 10 Dec 2019 04:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575951580;
	bh=dWiwn2A+F2XWZVlk8N6X/QEoicvoZAVW/RAIIiVkQic=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=gOrykd/QpEwHy2CN4M1KR85FH0n0T8tJM6pSdg7aF98mWGIzvtVrrTWEIrbJcQpjD
	 7UVRF5n4vB27R+T3d2BLDwgW3k6CXgM2PmoRN+2CO1hwApCNqE903ZmddhbG//8rzd
	 dsVMxuNGydkLMiDaKeEpzt/+odeKQtlgsuKz0w+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfLJETk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:19:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:46768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfLJETj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 9 Dec 2019 23:19:39 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37FD220726;
        Tue, 10 Dec 2019 04:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951579;
        bh=dWiwn2A+F2XWZVlk8N6X/QEoicvoZAVW/RAIIiVkQic=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=yKpk4Y31yZTEjBcwTRhjEQ0FLGpFx8zRX+bpzxWDusZnuXF2415gTs3FuNLQ7cVC3
         qkv+h69trItNnGN3Zu5RJAHl8dOFArvVrD+ZftyKSMjHGQNX9wCs7XibStfJ70LvBw
         Z3ErQQWxFRuV7dmg6P1Xbykh+nTMXRLN82k2MJ20=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CFB4C3522768; Mon,  9 Dec 2019 20:19:38 -0800 (PST)
Date:   Mon, 9 Dec 2019 20:19:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/9] RCU list updates for v5.6
Message-ID: <20191210041938.GA3367@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides RCU-list updates:

1.	Describe variadic macro argument in a Sphinx-compatible way,
	courtesy of Jonathan Neuschäfer.

2.	Add hlist_unhashed_lockless(), courtesy of Eric Dumazet.

3.	Use hlist_unhashed_lockless() in timer_pending(), courtesy
	of Eric Dumazet.

4.	Use WRITE_ONCE() for assignments to ->pprev for hlist_nulls.

5.	Add and update docbook header comments in list.h.

6.	Add a hlist_nulls_unhashed_lockless() function.

7.	Add rculist_nulls docbook comments, courtesy of Madhuparna Bhowmik.

8.	Change rculist_nulls docbook comment headers, courtesy of
	Madhuparna Bhowmik.

9.	Add list_tail_rcu(), courtesy of Madhuparna Bhowmik.

							Thanx, Paul

------------------------------------------------------------------------

 list.h          |  144 +++++++++++++++++++++++++++++++++++++++++++++-----------
 list_nulls.h    |   30 ++++++++++-
 rculist.h       |   38 +++++++++-----
 rculist_nulls.h |   20 +++++--
 timer.h         |    2 
 5 files changed, 181 insertions(+), 53 deletions(-)
