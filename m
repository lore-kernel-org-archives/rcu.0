Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C8AC35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25749207FF
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581726550;
	bh=tl3u23Rh/qeAmhWSpAVu6UVi9OCXgBBp/Y8/HQIOyGk=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=eozFI7/itDxax3cm87z0c9LKBIp4BitOqLCQCwukWYoKMMg7iKGGVYvqUi2ARGJ41
	 DXLPAXE9RbxKB9x9x9BYxp9od8GWPsI/fOfm+YgU8JpIBKX/P5I0knTZZpOE8W51i+
	 WRdMuI+LeNNP2W/+qM6vWI/wlXXTHGiGFZcUpkDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgBOA3K (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:29:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbgBOA3J (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:29:09 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C3A9206D7;
        Sat, 15 Feb 2020 00:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581726549;
        bh=tl3u23Rh/qeAmhWSpAVu6UVi9OCXgBBp/Y8/HQIOyGk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Q5/YfDT3HqF1T3UCedTwvA+iN/1uMTH0op6DT6FiRPp3nOblaUxOhIqV/mY9G7kCZ
         L0ij6uVpKZTuaE4BNm1+hezwM9OaOwyhd2G1o+HhlTCgEQIs2UhvYugr1ABkNAhgff
         AIIUXafteoV19GKZIrrMERpipKO8Qy6qpxfEsmsQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 277793520D46; Fri, 14 Feb 2020 16:29:07 -0800 (PST)
Date:   Fri, 14 Feb 2020 16:29:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/4] SRCU updates for v5.7
Message-ID: <20200215002907.GA15895@paulmck-ThinkPad-P72>
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

This series contains SRCU updates.

1.	Fix __call_srcu()/process_srcu() datarace.

2.	Fix __call_srcu()/srcu_get_delay() datarace.

3.	Fix process_srcu()/srcu_batches_completed() datarace.

4.	Add READ_ONCE() to srcu_struct ->srcu_gp_seq load.

							Thanx, Paul

------------------------------------------------------------------------

 srcutree.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)
