Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80713C433F5
	for <rcu@archiver.kernel.org>; Tue, 28 Sep 2021 18:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6725261357
	for <rcu@archiver.kernel.org>; Tue, 28 Sep 2021 18:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241884AbhI1SPO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Sep 2021 14:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241551AbhI1SPM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 28 Sep 2021 14:15:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CFB36128E;
        Tue, 28 Sep 2021 18:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632852812;
        bh=TpFw+ccqPdi0hdqbzs0ZOAz96eff47qPLwoYAUSctAs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PduSo8gAlxjISGzq8tyHLm7eTOKM5oILWJ3AG9Or0R3ne/S3dFTItialdhHVw15tn
         T13MeYy35RrL7uymYyC6MLFf/+Mx4yIAmalJRyVyqALVqOfVjd1U+afjL5k+nghPFf
         +NzEbCw2+bsIjhyOExcA0cXC6c9V5wWTqh8bjx8lQMTUxOC+843w1T8V22dW9eEkwN
         DAtK6+6juBxM9Pxv2xK0OGQElL/1Z7gXbpZaezfVJ7dFt5r6sGTeP99OLHFV7mYsDd
         +YqkYuW3CYeeWtpB5kJGe9nd/x+f9Z3pdYBGGDig4R0pHrOGZunN9zQYWxqGJaTHZj
         hpLEcrcjh1jMg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6AC2E5C0815; Tue, 28 Sep 2021 11:13:32 -0700 (PDT)
Date:   Tue, 28 Sep 2021 11:13:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        urezki@gmail.com, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        joel@joelfernandes.org
Subject: Re: [PATCH 0/4] rcu: Unify a bit [non-]PREEMPT expedited quiescent
 state report
Message-ID: <20210928181332.GA2598698@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210916121048.36623-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916121048.36623-1-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 16, 2021 at 02:10:44PM +0200, Frederic Weisbecker wrote:
> This eventually removes rcu_data.exp_deferred_qs to use
> rcu_data.cpu no_qs.b.exp instead.
> 
> For those like me who need a headlamp to walk there: https://ibb.co/3d06r0V
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	rcu/dev
> 
> HEAD: 7d9d8a0c6141f95cbac4367b12e755bfabb383ee

Applied and pushed with some additional marking and commit-log editing.
The marking is needed because rcu_qs() can be invoked with interrupts
enabled, which can result in a low-probability data race with the
expedited IPI handler rcu_exp_handler().  There was another access in
sync_sched_exp_online_cleanup() than needed marking, so I am queuing a
separate commit for that one.

I suspect that this problem predated your series.  This is a low
probability data race, so KCSAN might be hard-pressed to spot it.

Anyway, the result in much much nicer with the converged use of the
->cpu_no_qs.b.exp field, so thank you!!!

Might simplify a few of your future headlamp diagrams as well?  ;-)

						Thanx, Paul

> Thanks,
> 	Frederic
> ---
> 
> Frederic Weisbecker (4):
>       rcu: Ignore rdp.cpu_no_qs.b.exp on premptible RCU's rcu_qs()
>       rcu: Remove useless WRITE_ONCE() on rcu_data.exp_deferred_qs
>       rcu: Move rcu_data.cpu_no_qs.b.exp reset to rcu_export_exp_rdp()
>       rcu: Remove rcu_data.exp_deferred_qs and convert to rcu_data.cpu no_qs.b.exp
> 
> 
>  kernel/rcu/tree.h        |  1 -
>  kernel/rcu/tree_exp.h    |  6 +++---
>  kernel/rcu/tree_plugin.h | 24 +++++++++++++-----------
>  3 files changed, 16 insertions(+), 15 deletions(-)
