Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35FCC35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875A22082F
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581725899;
	bh=zBkIaXyCDkP0NHhzcS+nOpVULeLBaNTeUYV5b4mTysY=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=hc3yX68IL8vI1VjWrJxV2Zh9wb+QlBusqpskPDpWcguCAtSB0AqQu7t5e42pDckj0
	 jx3L3gdHZSqG5mur+k2jeiJh/0XYflFFYj3zpNi20kL/9YALVtviYvBuwI1IHRLMRD
	 pcatq0/GsoaRwLSqVHuZozHFBwSdbstGXKmW9Ax4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgBOAST (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:18:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgBOAST (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:18:19 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58089207FF;
        Sat, 15 Feb 2020 00:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581725898;
        bh=zBkIaXyCDkP0NHhzcS+nOpVULeLBaNTeUYV5b4mTysY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Ay7eKa0NhKknq7r8n5VMKeW8J10mV+eaVAPGJsR74nCIxhqxwkGOoLRjdDqyLp7vK
         VUZytnkm9+XtrNGeiZeVTvJ3xJwhp9+Nj8UeQBvuG3ZtQuBtGGzAnBRbtg6bmK9jy5
         r9CX3wW7FHxub6psEs8uArKQ3bGe2Bu6btKhDCT0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B6B023520D46; Fri, 14 Feb 2020 16:18:16 -0800 (PST)
Date:   Fri, 14 Feb 2020 16:18:16 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/5] Callback-overload update for v5.7
Message-ID: <20200215001816.GA15284@paulmck-ThinkPad-P72>
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

This series contains updates to handling of callback-overload condiitons.

1.	Clear ->core_needs_qs at GP end or self-reported QS.

2.	React to callback overload by aggressively seeking quiescent
	states.

3.	React to callback overload by boosting RCU readers.

4.	Fix spelling mistake "leval" -> "level".

5.	Update __call_rcu() comments.

								Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt |    9 ++
 kernel/rcu/tree.c                               |   97 ++++++++++++++++++++----
 kernel/rcu/tree.h                               |    4 
 kernel/rcu/tree_plugin.h                        |    6 -
 4 files changed, 99 insertions(+), 17 deletions(-)
