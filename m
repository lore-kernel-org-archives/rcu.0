Return-Path: <SRS0=sv12=BS=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A36C433DF
	for <rcu@archiver.kernel.org>; Sat,  8 Aug 2020 22:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F489206C3
	for <rcu@archiver.kernel.org>; Sat,  8 Aug 2020 22:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596924572;
	bh=q4JBzf8Zsry7M1Qasj9UBYrOF27loPu9rc129Jvj2Aw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=CQy1OduTUZddq2yMv96QQlRZviwXKvZQ08dlGdGMXIB4YYvQk7HIXYpo0E2FcSEB8
	 njbY5CM/mdsGmoQiqdlllK+gMftXijip/QOK/siWuNCibqXmC7LDGgRAxahL7KJKvC
	 bZf6au2c+uLEBx4vlGaYNKCLMh/SpZ2zk11BhfUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgHHWJc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 8 Aug 2020 18:09:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbgHHWJc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 8 Aug 2020 18:09:32 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57FAE206C3;
        Sat,  8 Aug 2020 22:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596924570;
        bh=q4JBzf8Zsry7M1Qasj9UBYrOF27loPu9rc129Jvj2Aw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FDPVsDNXcM4GOS9vwLDGmyr+vyK6rg7HWCo52YPhkEeEvleBZ0hb3qkeIPbK0dwT3
         pRNz64WZTU7nix7pyKJUqAt3xzS76qdxrBsYpfUjepJprZ5QLoybSXcpoELVd1sv2U
         PsTJZSKtNAcix2dRHUeTxsG2prrE9gWIcOKEo3lU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 308693522636; Sat,  8 Aug 2020 15:09:30 -0700 (PDT)
Date:   Sat, 8 Aug 2020 15:09:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     William Tambe <tambewilliam@gmail.com>
Cc:     rcu@vger.kernel.org
Subject: Re: delayed_put_task_struct() used through call_rcu() by
 put_task_struct_rcu_user() never gets called
Message-ID: <20200808220930.GD4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAF8i9mNFFrSqfoREnQoR-vrt+b_auq=xd9-yEP0eK-q1J-PvwA@mail.gmail.com>
 <CAF8i9mO3AcW+dnXvGsiJ7STu42OQEuqkTG0PGaCpZT=9OQq=Ug@mail.gmail.com>
 <CAF8i9mMJCdadZkVDxCENhQbEVD4wmA1hU50nBo6AOhU16Y6cMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF8i9mMJCdadZkVDxCENhQbEVD4wmA1hU50nBo6AOhU16Y6cMg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Aug 08, 2020 at 04:19:42PM -0500, William Tambe wrote:
> On Sat, Aug 8, 2020 at 4:17 PM William Tambe <tambewilliam@gmail.com> wrote:
> >
> > On Sat, Aug 8, 2020 at 1:21 PM William Tambe <tambewilliam@gmail.com> wrote:
> > >
> > > I am having an issue in my kernel where delayed_put_task_struct() used
> > > through call_rcu() by put_task_struct_rcu_user() never gets called.
> >
> > I am able to trace this issue to invoke_rcu_core() not getting called
> > in __call_rcu_core() due to rcu_is_watching() always returning true.

That in fact should be the common case.  Normally, you would be invoking
call_rcu() and thus __call_rcu_core() from a context that RCU is watching.

But what happens after that in __call_rcu_core()?

> > Any idea why I am seeing such an issue ?

One way would be if every single one of your call_rcu() invocations was
done with irqs disabled.  And if the scheduling-clock interrupt was turned
off.  And if the CPU in question never received any other interrupts.

As in all of those things have to be in effect in order to indefinitely
postpone the call to delayed_put_task_struct().  In this case, v5.8's
__call_rcu_core() would always exit via this path:

	if (irqs_disabled_flags(flags) || cpu_is_offline(smp_processor_id()))
		return;

> Also, the issue is not happening when using highres=off .

Might highres=off be forcing the scheduling-clock interrupt to be
enabled?

> > > Any idea ?

If you are running oldish kernels and the CPU in question is a nohz_full
CPU, the scheduling-clock interrupt would be turned off.  (In more recent
kernel versions, RCU will force it back on if things are not progressing.)

To say more, I would need your exact kernel version (including any
patches and any other out-of-tree source code) and your .config file.

							Thanx, Paul
