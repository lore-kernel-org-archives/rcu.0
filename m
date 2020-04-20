Return-Path: <SRS0=AG5q=6E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2789C54FCB
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 03:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C91C72074B
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 03:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hu4yA+CN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgDTDDa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 19 Apr 2020 23:03:30 -0400
Received: from mout.gmx.net ([212.227.15.15]:47125 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgDTDDa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 19 Apr 2020 23:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587351763;
        bh=y8NAK25+cuS6DZmxwOgEF4KVYsCul7QZhLOf2aiUwWQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=hu4yA+CNqicU61K1I6v23DRlfwnxUw2WxOphOPoisQKsK+nTJXvdS4aP+cg4PrHTw
         BlmT+p7cyW9s6t4khHtPs+j7Kb1gWNpCcXIkTO8IBiho6/8gIWzy9qZKbA8DPVrBTq
         pD0Hhpo7a1qU2yuO2wMm6KkRt1XAC6Lv7iaxKsgg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([212.114.172.182]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRTN9-1jcFJn3q6f-00NQIl; Mon, 20
 Apr 2020 05:02:43 +0200
Message-ID: <1587351761.9608.4.camel@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
From:   Mike Galbraith <efault@gmx.de>
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Mon, 20 Apr 2020 05:02:41 +0200
In-Reply-To: <20200420011749.GF176663@google.com>
References: <20200416203637.GA176663@google.com>
         <20200416210057.GY17661@paulmck-ThinkPad-P72>
         <20200416213444.4cc6kzxmwl32s2eh@linutronix.de>
         <20200417030515.GE176663@google.com>
         <20200417150442.gyrxhjymvfwsvum5@linutronix.de>
         <20200417182641.GB168907@google.com>
         <20200417185449.GM17661@paulmck-ThinkPad-P72> <20200418123748.GA3306@pc636>
         <20200419145836.GS17661@paulmck-ThinkPad-P72>
         <20200420002713.GA160606@google.com> <20200420011749.GF176663@google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IaaoGwagBjIuz3wr7irPlouVDtvpUf3p5J3TnACGbjvYphWn8sV
 tLWxbvc0Q97bTjFNJaBdsrkZF5a79KFXbPauYhsi6yCImu40W2dlGvtVBGSodHeE1p7foMK
 s0uvHq5zvlEg5z5X1WbKEOwqPLBqS4FZwy61APZzZ6Sw0O+Qanb4B+z7M4Oy6GHcFOwsec0
 0G5RsNppBHrMDO6c1e3Mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:chow2OHNd1M=:m7RJn78sSYJaeA/mEHAspv
 ILT4DO6nCDMvHTfOHSB3JAsuqr7O5qtvg4IKZT2AaHBdnfY5WWzIPGE4fwOl15Xve1QjD9u0g
 2yOsEBNawBivC3uX5KSyK9qSz7ZTx56QE4qJShXTkMWVfEdzShWZ5qX+CE3dn0xDzUsvIOJqE
 w2zeSi7XMJYNaRjM1rI7mHA+WPzGR/d5+gPGplhJ5OwNevSI/2bV00wUGz+nE1CQSkYd1iwNl
 1AQQI/QecXiqy695dJSHnOau1aTEWYq2vmPQ5fKhJ5Prkp0jii4EoeQnM2H2LjayJvcN1O86Q
 EB89XBiHsMHcgL2lwGfhqFwlaztJdL+tnU/nTCAsj1PQ8t3QyI08aNCQd3XSsczxAky7hjtvk
 ggvAkdy86TGkxXOOcOU/idE/ymZRApu1S6oJL2qpB7wAKSXMNOopCFDIXvuQi6X1my51ReDBq
 s/8wXqZcEoxxOs3K/vG/TqCDuSo71p/hvN5Wbu6i7bxacvLaRfTTFx6RhLiQdOu1SUiNy+iq2
 +ITGfkmaY6vLf9HQdwmElXWuh2yT2hDcoceHvumCLKqvs68FM+tGar/WdOs+u5Yoo01s7NjmB
 zm7/YCg7MCQkK91i59ReHjrV3a8JxSZ3AfAlYzkZogS/TI+NhiuUTRaJT0m4rxMV9n1qy8/rg
 a5ZkyvXo9VSiJloWCI+EngX3lVz2pu0W8Avp7dsxjSerDozp3krixEE5PwPhMekzG1cNm0peB
 IjlM4Fla/DzVdfu/dU0xDpCznQIFCOY8o/NvsYiIDZr7Bgl27e6kpKNd4vw86MB+EiHauSA/5
 +DJO9JGPnSNNXPgRratqVzph/42RQzONpCsVXEOk7cdJOZHjrL479V+nYojDeW0wBAfdqd196
 CNXxOCREoljSz0rUlagoWZ3B00CP61yDeUAKtt5NFSnH5Rw39RvWN728g4HvEYnl5FFo9dp+i
 h1+ZQ4C7LN+2qlcpDxQ26+qe9NwX/WzrR0iGoNqx2Jnr+meSwlgXok2MW/JEesHKF4rU/vRS0
 7rfPkjy06u83Yjelce2zZodspwP5LNRIgvHoDCmo2rgGFPQYWBGBXVwv4iPps63yxu1buc4VZ
 7LxcsI4mGM4YZwLEYt+DPtE9WOc6R7dhyDfyi1ToT26OuofESheW0z/OVJq01WJTkq9i1e2hY
 St9Ke3TrIPvBfAdPhIPPyF8fzhNvz4UEaAEFqXxHPrVNiL/4B6BI1GLTdWqSp6+BZ7mHktUy4
 E7pTT7GjFQhtrv/Xe
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, 2020-04-19 at 21:17 -0400, Joel Fernandes wrote:
>
> > > Can we do even better by moving the work-scheduling out from under t=
he
> > > spinlock?  This of course means that it is necessary to handle the
> > > occasional spurious call to the work handler, but that should be rar=
e
> > > and should be in the noise compared to the reduction in contention.
> >
> > Yes I think that will be required since -rt will sleep on workqueue lo=
cks as
> > well :-(. I'm looking into it right now.
> >
> >         /*
> >          * If @work was previously on a different pool, it might still=
 be
> >          * running there, in which case the work needs to be queued on=
 that
> >          * pool to guarantee non-reentrancy.
> >          */
> >         last_pool =3D get_work_pool(work);
> >         if (last_pool && last_pool !=3D pwq->pool) {
> >                 struct worker *worker;
> >
> >                 spin_lock(&last_pool->lock);
>
> Hmm, I think moving schedule_delayed_work() outside lock will work. Just=
 took
> a good look and that's not an issue. However calling schedule_delayed_wo=
rk()
> itself is an issue if the caller of kfree_rcu() is !preemptible() on
> PREEMPT_RT. Because the schedule_delayed_work() calls spin_lock on pool-=
>lock
> which can sleep on PREEMPT_RT :-(.

As of 4.19-rt, workqueue locks are converted to raw_spinlock_t.

	-Mike
