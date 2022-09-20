Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58936C54EE9
	for <rcu@archiver.kernel.org>; Tue, 20 Sep 2022 03:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiITDQm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 19 Sep 2022 23:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiITDQT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 19 Sep 2022 23:16:19 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D18419B5
        for <rcu@vger.kernel.org>; Mon, 19 Sep 2022 20:16:17 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b23so1472888pfp.9
        for <rcu@vger.kernel.org>; Mon, 19 Sep 2022 20:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Snm8t3NTfOqEsMKPeOD6u+xP/gEgRgiVVRe9G3xXDKA=;
        b=oJeGK5Wx87nUhhm9ch3l/E3jqcPK96+NvhYKroxq4m1r7FqUoNAhoea9OuEpBGq86j
         G8vEPlk9rvKrH/D6PTgEajpiXiZAGoKZJp7OqWOUamw3yffX2NFVqs4ZPNagjc8BKWrd
         P2w1icLfCEIX9dpp9SfWRBtDRna+ApzCV7N/WDMSFXFJlkDApjo0y5BUsWY73yHElPtq
         0qQzaWtvvOg1NDMFnhNuWAB19loBtAthuisZXU09btuXvzugj7eWd67udHconjdTR13A
         QlHE5SXI1K/V2GJ5yjxJvIcKh+SRpOucWbucmZyHCXXmZQ7mv80CwNlzM/hchW2gz27i
         Q29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Snm8t3NTfOqEsMKPeOD6u+xP/gEgRgiVVRe9G3xXDKA=;
        b=fr/L38P4wRZhmg2342xXXLdTUxC5eqCjBhE/W5N0I2aMINFtynW83GcTW4bcsxug+j
         0oRP6+vB7O9R0snqOESKV8R0MhMStqLUJFHMc9AHk7Yf9PTX2j99HClz/f/A+T4XtJ5y
         yd4FmiTHkvFha5LRD5IYm7MDZTRyjwBwLEup1HxTA9OAaLU/WzaBPjeDxNGTpp4PL7LA
         45f918zji7lCB9I2aWDc+sLWJDuFqTH/teZ8Ehyhh45q1D9BNDmGPZcPBSV6meyWTZ9T
         7qX4yudNiOu4h6pINGMGIxGB5er5minwcJXOb9jDavVnGWcl/a7HGiX+6kdP7YW4Er1n
         QE1Q==
X-Gm-Message-State: ACrzQf2AOKT/g7RZmvcL3HE9NpjU+sWmzldQQTExwlnJZtFqQXAbsHuP
        gtrz8BYe3bWLv3Ls3wgXLw==
X-Google-Smtp-Source: AMsMyM44zv5S89I3UozSqFWT1TZHRpwaU6tibeb3ytnpqA/YFe5CKLcHKRYuM5s6Xa9Z3zUkqKAimQ==
X-Received: by 2002:a63:f20e:0:b0:439:398f:80f8 with SMTP id v14-20020a63f20e000000b00439398f80f8mr18235216pgh.494.1663643777213;
        Mon, 19 Sep 2022 20:16:17 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709027e8900b00176c6738d13sm148583pla.169.2022.09.19.20.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 20:16:16 -0700 (PDT)
Date:   Tue, 20 Sep 2022 11:16:09 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCHv2 2/3] rcu: Resort to cpu_dying_mask for affinity when
 offlining
Message-ID: <YykweX7mXEk/83Ft@piliu.users.ipa.redhat.com>
References: <20220915055825.21525-1-kernelfans@gmail.com>
 <20220915055825.21525-3-kernelfans@gmail.com>
 <20220916142358.GA27246@lothringen>
 <CAFgQCTu6cxrbZ4jLdV6og2uhAG35LRjhjTw0Emgfpy0BW4kq6Q@mail.gmail.com>
 <20220919103432.GA57002@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919103432.GA57002@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 19, 2022 at 12:34:32PM +0200, Frederic Weisbecker wrote:
> On Mon, Sep 19, 2022 at 12:33:23PM +0800, Pingfan Liu wrote:
> > On Fri, Sep 16, 2022 at 10:24 PM Frederic Weisbecker
> > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > index ef6d3ae239b9..e5afc63bd97f 100644
> > > > --- a/kernel/rcu/tree_plugin.h
> > > > +++ b/kernel/rcu/tree_plugin.h
> > > > @@ -1243,6 +1243,12 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
> > > >                   cpu != outgoingcpu)
> > > >                       cpumask_set_cpu(cpu, cm);
> > > >       cpumask_and(cm, cm, housekeeping_cpumask(HK_TYPE_RCU));
> > > > +     /*
> > > > +      * For concurrent offlining, bit of qsmaskinitnext is not cleared yet.
> > > > +      * So resort to cpu_dying_mask, whose changes has already been visible.
> > > > +      */
> > > > +     if (outgoingcpu != -1)
> > > > +             cpumask_andnot(cm, cm, cpu_dying_mask);
> > >
> > > I'm not sure how the infrastructure changes in your concurrent down patchset
> > > but can the cpu_dying_mask concurrently change at this stage?
> > >
> > 
> > For the concurrent down patchset [1], it extends the cpu_down()
> > capability to let an initiator to tear down several cpus in a batch
> > and in parallel.
> > 
> > At the first step, all cpus to be torn down should experience
> > cpuhp_set_state(cpu, st, CPUHP_TEARDOWN_CPU), by that way, they are
> > set in the bitmap cpu_dying_mask [2]. Then the cpu hotplug kthread on
> > each teardown cpu can be kicked to work. (Indeed, [2] has a bug, and I
> > need to fix it by using another loop to call
> > cpuhp_kick_ap_work_async(cpu);)
> 
> So if I understand correctly there is a synchronization point for all
> CPUs between cpuhp_set_state() and CPUHP_AP_RCUTREE_ONLINE ?
> 

Yes, your understanding is right.

> And how about rollbacks through cpuhp_reset_state() ?
> 

Originally, cpuhp_reset_state() is not considered in my fast kexec
reboot series since at that point, all devices have been shutdown and
have no way to back. The rebooting just adventures to move on.

But yes as you point out, cpuhp_reset_state() throws a challenge to keep
the stability of cpu_dying_mask.

Considering we have the following order.
1.
  set_cpu_dying(true)
  rcutree_offline_cpu()
2. when rollback
  set_cpu_dying(false)
  rcutree_online_cpu()


The dying mask is stable before rcu routines, and
rnp->boost_kthread_mutex can be used to build a order to access the
latest cpu_dying_mask as in [1/3].


Thanks,

	Pingfan
