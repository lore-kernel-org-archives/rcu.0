Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE375C433EF
	for <rcu@archiver.kernel.org>; Mon, 11 Oct 2021 12:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50EE60F5B
	for <rcu@archiver.kernel.org>; Mon, 11 Oct 2021 12:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbhJKMNZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Oct 2021 08:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234675AbhJKMNY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Oct 2021 08:13:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45C2760F43;
        Mon, 11 Oct 2021 12:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633954284;
        bh=VCXL4haLuEdl2ezsWpP7xi+X3JHonnQj0T15oagIj5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FHT4R6gaIXpCLygnbwBo7e82aE/NtJToMylVtyuQ7XJXj9FFfQ3wLLw+VCmS03Jy9
         9GgKtn/6L/UgjYGpP4SDIiLURGhkttilgRZfRLCGnuFTPZ6dqPw9iSJB3ObDqAS1XE
         Qr1gZSWaUmAm5hB4w+dJk5YDjz/LePYlRLS2WHMmmrq3jx+qruYxpdtrJEBhpAua0o
         vsgdHaRB/fJXQ+7XCs6++KkKNr+TlY8xu268iCVZsxowbfLOUTvSOQLdfWs47KkE+W
         QjJkxfU9LAiWMlNCIEKe3XU6VCGfS05xPokb3xXeAU4YmPu/l5DT0CLL3HP4sR5d2e
         1F46PkBS/UrUA==
Date:   Mon, 11 Oct 2021 14:11:22 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 11/11] rcu/nocb: Don't invoke local rcu core on callback
 overload from nocb kthread
Message-ID: <20211011121122.GA356339@lothringen>
References: <20210929221012.228270-1-frederic@kernel.org>
 <20210929221012.228270-12-frederic@kernel.org>
 <20210930153737.lljjay2cquph7cfv@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930153737.lljjay2cquph7cfv@linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Phew, the last changelog is the most careless...

On Thu, Sep 30, 2021 at 05:37:37PM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-09-30 00:10:12 [+0200], Frederic Weisbecker wrote:
> > rcu_core() tries to ensure that its self-invocation in case of callbacks
> > overload only happen in softirq/rcuc mode. Indeed it doesn't make sense
> > to trigger local RCU core from nocb_cb kthread since it can execute
> > on a CPU different from the target rdp. Also in case of overload, the
> > nocb_cb kthread simply iterates a new loop of callbacks processing.
> > 
> > However the "offloaded" check that aims at preventing that is wrong.
> - that?

Rephrasing the changelog:

"However the "offloaded" check that aims at preventing misplaced
rcu_core() invocations is wrong."


> 
> > First of all that state is volatile and second: softirq/rcuc can
> > execute while the target rdp is offloaded. As a result rcu_core() can
> 
> can what?

"As a result rcu_core() can be invoked on the wrong CPU while in the
process of (de-offloading)."

Thanks!


> 
> > Fix that with moving the rcu_core() self-invocation to rcu_core() itself,
> > irrespective of the rdp offloaded state.
> 
> Sebastian
