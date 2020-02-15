Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9146C35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92BB2081E
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581726288;
	bh=YFsIW4ZIbL87oBAFgIiddTmWNgwoa/40z5hBp8G73IU=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=Mx2QX2wCM2Q5+evqZ8LNWO+F2E6miBM03a5Y4+/1S0N0+mpRhTRT+gqeI/xe1rljV
	 tpiB183B2eT5iO7GKcTUaU6lnIuLXMYHx9fqNEnNgpkv7PJtjsm1e0qLEase0KylUk
	 SDsE5wa1ytJcynMHYns0l+y5Mz87GEvqDtJHUwmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgBOAYs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:24:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgBOAYs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:24:48 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B181C206D7;
        Sat, 15 Feb 2020 00:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581726287;
        bh=YFsIW4ZIbL87oBAFgIiddTmWNgwoa/40z5hBp8G73IU=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ruarJtvrgIZHUj9ftWYx2kResrLljnbcfGEPesqw9QFTTxMMJmHs+i6V4VT1bTRLw
         QOpVhprhSJZyh4UgcsdiHWaEbEfKUYAzIgjTRcevzNaGQjd7tCS1TAqonXI9qRE+DH
         3p+Exri1xOfY7I2HVpszoccwPhjTp9IGtMjgLy+E=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 30AEB3520D46; Fri, 14 Feb 2020 16:24:46 -0800 (PST)
Date:   Fri, 14 Feb 2020 16:24:46 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/3] Tasks-RCU updates for v5.7
Message-ID: <20200215002446.GA15663@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains Tasks-RCU updates.

1.	Add *_ONCE() for rcu_tasks_cbs_head.

2.	Add missing annotation for exit_tasks_rcu_start(), courtesy
	of Jules Irenge.

3.	Add missing annotation for exit_tasks_rcu_finish(), courtesy
	of Jules Irenge.

							Thanx, Paul

------------------------------------------------------------------------

 update.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
