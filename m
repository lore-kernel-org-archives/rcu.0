Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73796C43331
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 21:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F1E20771
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 21:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585602965;
	bh=yYQpEqTlJC/6Uz9HelZxuRA+BqiQPCT+jSly2DQyKv4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=su7hQ3M/A4giXkSdvGeoss0S3yI2NRqI6YdUmDImIijD2vTYWISB9aDXZRCqMNn1Y
	 nC8LQq+5yx+c3lxjjTU/MrQQ9Z7NbDCnDOk9U9dARCy3kgEfWjKTxIgYDtCTQv/OLC
	 HRrCwCIfzXe4fA/ZCrdTilOrzHU4Y9J2NLug+CYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgC3VQF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 30 Mar 2020 17:16:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbgC3VQE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 30 Mar 2020 17:16:04 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56A7E20733;
        Mon, 30 Mar 2020 21:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585602964;
        bh=yYQpEqTlJC/6Uz9HelZxuRA+BqiQPCT+jSly2DQyKv4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ua79KH5UDCgdqxwUx0v+TEn1ok2zYWzFF967w2Z3/t22zNnxcU/8fwrAujtyXqsTh
         7oFgJWBYNpE7SO6KD/L6CO/0qHfC/8EKSBnnt374pb7OPens6HN9N5+LKfN5WrJbod
         lmwPoDNmz9RdMrsT7aEwoeN0EF92MN2l6WpU9KoY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2C3AA35229BC; Mon, 30 Mar 2020 14:16:04 -0700 (PDT)
Date:   Mon, 30 Mar 2020 14:16:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        boqun.feng@gmail.com, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "open list:READ-COPY UPDATE (RCU)" <rcu@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] rcu: Replace 1 by true
Message-ID: <20200330211604.GA6655@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <0/4>
 <20200330012450.312155-1-jbi.octave@gmail.com>
 <20200330012450.312155-3-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330012450.312155-3-jbi.octave@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 30, 2020 at 02:24:48AM +0100, Jules Irenge wrote:
> Coccinelle reports a warning at use_softirq declaration
> 
> WARNING: Assignment of 0/1 to bool variable
> 
> The root cause is
> use_softirq a variable of bool type is initialised with the integer 1
> Replacing 1 with value true solve the issue.
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Queued for review and testing, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d91c9156fab2..c2ffea31eae8 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -100,7 +100,7 @@ static struct rcu_state rcu_state = {
>  static bool dump_tree;
>  module_param(dump_tree, bool, 0444);
>  /* By default, use RCU_SOFTIRQ instead of rcuc kthreads. */
> -static bool use_softirq = 1;
> +static bool use_softirq = true;
>  module_param(use_softirq, bool, 0444);
>  /* Control rcu_node-tree auto-balancing at boot time. */
>  static bool rcu_fanout_exact;
> -- 
> 2.25.1
> 
