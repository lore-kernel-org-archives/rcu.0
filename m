Return-Path: <SRS0=NFG3=CS=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399B6C433E2
	for <rcu@archiver.kernel.org>; Wed,  9 Sep 2020 12:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC8A12166E
	for <rcu@archiver.kernel.org>; Wed,  9 Sep 2020 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599653007;
	bh=vsjTYNMmq1bU3l1iBwYS0EsYYEjqKIejBpLzYh0pyqo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=xZbNEoE18hD10dwNHh/IG/Ut4uN0XYsCTYZmgQ0op4b4CtmGSADsk3vDk6whlDGY3
	 Ct/x9/5UMxzMeg5lp87WiW33zT1IwoupVvo0uaxim5pilmlU8ImUSTF7OjGrGNdVWs
	 edzMrorgTi0EzpZRL4tT41VL+atoJ0HlF9AthjHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgIIMCb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Sep 2020 08:02:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729822AbgIIMAk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Sep 2020 08:00:40 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88A3A215A4;
        Wed,  9 Sep 2020 11:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599652210;
        bh=vsjTYNMmq1bU3l1iBwYS0EsYYEjqKIejBpLzYh0pyqo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=meVJ1T4+sNUN3l++6g5sFUQY9BG0qIDH6bh0Z3LmLIHJ8AyG09+hFC4DfI3u5lljP
         ibWHVA0xChCkPtlKyhBIW/SpOiCkw1U/8Tr812P5IIs/i9SEN4Hu7WQ51AXfkPknzI
         u11FU/2utLZ/Jqo+nNxQlALOZ6UF3TVyVGGqesGU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3748D3523091; Wed,  9 Sep 2020 04:50:10 -0700 (PDT)
Date:   Wed, 9 Sep 2020 04:50:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel] srcu: Fix static initialization
Message-ID: <20200909115010.GG29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200908144306.33355-1-aik@ozlabs.ru>
 <cc25257d-804e-8cf7-150b-e6bdbaf184be@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc25257d-804e-8cf7-150b-e6bdbaf184be@ozlabs.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 09, 2020 at 07:24:11PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 09/09/2020 00:43, Alexey Kardashevskiy wrote:
> > init_srcu_struct_nodes() is called with is_static==true only internally
> > and when this happens, the srcu->sda is not initialized in
> > init_srcu_struct_fields() and we crash on dereferencing @sdp.
> > 
> > This fixes the crash by moving "if (is_static)" out of the loop which
> > only does useful work for is_static=false case anyway.
> > 
> > Found by syzkaller.
> > 
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >  kernel/rcu/srcutree.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index c100acf332ed..49b54a50bde8 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -135,6 +135,9 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
> >  				   levelspread[level - 1];
> >  	}
> >  
> > +	if (is_static)
> > +		return;
> 
> Actually, this is needed here too:
> 
>  if (!ssp->sda)
>          return;
> 
> as
> ssp->sda = alloc_percpu(struct srcu_data)
> 
> can fail if the process is killed too soon - it is quite easy to get
> this situation with syzkaller (syscalls fuzzer)
> 
> Makes sense?

Just to make sure that I understand, these failures occur when the task
running init_srcu_struct_nodes() is killed, correct?

Or has someone managed to invoke (say) synchronize_srcu() on a
dynamically allocated srcu_struct before invoking init_srcu_struct() on
that srcu_struct?  This would be an SRCU usage bug.  If you dynamically
allocate your srcu_struct, you are absolutely required to invoke
init_srcu_struct() on it before doing anything else with it.

Or am I missing something here?

(The rcutorture test suite does test both static and dynamic allocation
of the srcu_struct, so I am expecting something a bit subtle here.)

							Thanx, Paul

> > +
> >  	/*
> >  	 * Initialize the per-CPU srcu_data array, which feeds into the
> >  	 * leaves of the srcu_node tree.
> > @@ -161,8 +164,6 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
> >  		timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
> >  		sdp->ssp = ssp;
> >  		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
> > -		if (is_static)
> > -			continue;
> >  
> >  		/* Dynamically allocated, better be no srcu_read_locks()! */
> >  		for (i = 0; i < ARRAY_SIZE(sdp->srcu_lock_count); i++) {
> > 
> 
> -- 
> Alexey
