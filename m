Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3BDC433E6
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 17:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2837C20639
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 17:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598896461;
	bh=jFwJF6GRbBWcPLF+xYvqZWxJ4QYQVdN67yM8Mqn7oHE=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=UDtSgA/RFbeZoL/CyUXD3qEGroBKT8WmIM0yJ7JjSJMRj4uIT0AO7GiEtqLW9cB/r
	 rBEb+KE6sk/lJ+/S3X0Nl1awKWMWN2dI3dEhYHw4vyZhjOtaohUoFbN8DxAGHTQ1/i
	 kFrZoTs/uZB7u5tnkyF5N3cqCWXfxidyoTowh/bg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgHaRyU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgHaRyU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 13:54:20 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C45E220866;
        Mon, 31 Aug 2020 17:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896459;
        bh=jFwJF6GRbBWcPLF+xYvqZWxJ4QYQVdN67yM8Mqn7oHE=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=RRG8eIbMdiFg++fde4816iN0mE5VxY814UBar2KX3anx/hIoE2ivk0ognYS0BZTqi
         1cS/KevVMYcd0Zb6JK1z43XjWgQIZgcoBaUM+6paooHLe4hMs36z2RmS3QCMcBGQb3
         G4l6RMKJCkttC92M98h1ylBRECf/WB+PRuIDOrXY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A273E35230F1; Mon, 31 Aug 2020 10:54:19 -0700 (PDT)
Date:   Mon, 31 Aug 2020 10:54:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/3] RCU documentation updates for v5.10
Message-ID: <20200831175419.GA31013@paulmck-ThinkPad-P72>
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

This series provides documentation updates.

1.	Fix typo in synchronize_rcu() function name.

2.	Drop doubled words from RCU Data-Structures.rst.

3.	Drop doubled words from RCU requirements documentation.

							Thanx, Paul

------------------------------------------------------------------------

 Design/Data-Structures/Data-Structures.rst |    2 +-
 Design/Requirements/Requirements.rst       |    4 ++--
 whatisRCU.rst                              |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
