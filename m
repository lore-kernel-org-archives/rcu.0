Return-Path: <SRS0=neSi=6F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD00C55182
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 05:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEDC22076C
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 05:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tM2LL6lg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDUFST (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Apr 2020 01:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725881AbgDUFSS (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 21 Apr 2020 01:18:18 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A16C061A0F
        for <rcu@vger.kernel.org>; Mon, 20 Apr 2020 22:18:16 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z26so12572986ljz.11
        for <rcu@vger.kernel.org>; Mon, 20 Apr 2020 22:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tyPTTEOW1uyi12bNNbjYorUqdumzV2gHX6UaoaWUJYY=;
        b=tM2LL6lg0DulU/bZeNDBYQT2U1wUjlpOJzKyvXNLU5mqsAvYzjWple0UYL7ZPxolBt
         l+2v9P8x5CwqdbvpbD7znT+VXnZjMA1ysqxZ05218AaPLX8/eMfcNqmJqAu1PsGpjSma
         1G74t6MMHHHR7vMxyQDjFuIxqZ86lSeoCyedIkUAymLyjTt/z2ypcuYunAzye8yUmT7d
         +ug0GbMwPfoaZuA1qNEPbG/dYtGOv8fkXBtdkHdVfLmQ4QaoawDiRBNNM0zggmZmn6JT
         otRixVs/jbJwoo5yz/ewuiqFQ2yrr633DCYzsnHnWC/8iF6f+f2ATkbVou1lThLxbjON
         HjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tyPTTEOW1uyi12bNNbjYorUqdumzV2gHX6UaoaWUJYY=;
        b=fjH2M2tCYrYT0r6GSzg7EvU+/Ee5ejlNTM1F7FZ1QUGpninrX+PuEVXG3Qll05XdSJ
         fNCRMyJTet1GlvISZbZncIobFukWudK81NSU0wKnThaacuCm8JNW1sIITVQ+AhhcmhpO
         050JAkCdKQ9olnwSWh8It07uzUWX5Vw3X1qPbcVAKpLTUu+iGwKZkNR9Je47Nwiv9cXA
         Ei/H/w9ga4oCDzNMCAn0JZ72wkiV8I+bAixUl8P4XagX7Zm1ie3iAP9Ypa8iGMDcr4Ex
         3dW/cZDXrByr3OGuF4fdK7DxGZTvNlzQy/lsbog3cPg9hItyPXm16GbuxJZDZGdtY+gf
         7Hdw==
X-Gm-Message-State: AGi0PuYZmzYqH8jYSgJJDU1atEiNFRjQ8S7x01sri/jtEMKeY0e5ulCV
        uTufGDWWK3lxcBZ51nmzFy4=
X-Google-Smtp-Source: APiQypLuijGBXfwgHJgPr8nzu7mLR55qokUY3ANH38jpKuVfb2V8GBJoSbpjKvAMufTDkzaYw7WeBg==
X-Received: by 2002:a2e:8e8a:: with SMTP id z10mr4635857ljk.107.1587446295258;
        Mon, 20 Apr 2020 22:18:15 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id d23sm1071522ljg.90.2020.04.20.22.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 22:18:14 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 21 Apr 2020 07:18:05 +0200
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200421051805.GA5124@pc636>
References: <20200420162534.GD17661@paulmck-ThinkPad-P72>
 <20200420162900.GA11867@pc636>
 <20200420164657.GE17661@paulmck-ThinkPad-P72>
 <20200420165924.GA12078@pc636>
 <20200420172126.GG17661@paulmck-ThinkPad-P72>
 <20200420174019.GB12196@pc636>
 <20200420175915.GH17661@paulmck-ThinkPad-P72>
 <20200420190650.GA12775@pc636>
 <20200420201723.GA4192@pc636>
 <20200420212257.4332734f@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420212257.4332734f@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> <rant>
> I really wish you would crop your email. If I scroll down three pages
> without seeing any reply, I usually stop reading there.
> </rant>
> 
Agree. i will do it in better manner next time.

> > > >  
> > Paul, i have just measured the time duration of the schedule_delayed_work().
> > To do that i used below patch:
> > 
> > <snip>
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 02f73f7bbd40..f74ae0f3556e 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3232,6 +3232,12 @@ static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
> >         return ((struct rcu_head *) ++ptr);
> >  }
> >  
> > +static void noinline
> > +measure_schedule_delayed_work(struct kfree_rcu_cpu *krcp)
> > +{
> > +       schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> > +}
> > +
> >  /*
> >   * Queue a request for lazy invocation of appropriate free routine after a
> >   * grace period. Please note there are three paths are maintained, two are the
> > @@ -3327,8 +3333,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >         if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> >                         !krcp->monitor_todo) {
> >                 krcp->monitor_todo = true;
> > -               schedule_delayed_work(&krcp->monitor_work,
> > -                       expedited_drain ? 0 : KFREE_DRAIN_JIFFIES);
> > +               measure_schedule_delayed_work(krcp);
> >         }
> > <snip>
> > 
> > i have done it for not CONFIG_PREEMPT_RT kernel, i do not have any RT configuration.
> > I run rcuperf to apply the load to see the time taken by the actual placing of the work,
> > i.e. the time taken by schedule_delayed_work():
> > 
> > <snip>
> > root@pc636:/sys/kernel/debug/tracing# cat trace
> > # tracer: function_graph
> > #
> > # function_graph latency trace v1.1.5 on 5.6.0-rc6+
> > # --------------------------------------------------------------------
> > # latency: 0 us, #16/16, CPU#0 | (M:server VP:0, KP:0, SP:0 HP:0 #P:4)
> > #    -----------------
> > #    | task: -0 (uid:0 nice:0 policy:0 rt_prio:0)
> > #    -----------------
> > #
> > #                                       _-----=> irqs-off
> > #                                      / _----=> need-resched
> > #                                     | / _---=> hardirq/softirq
> > #                                     || / _--=> preempt-depth
> > #                                     ||| /
> > #     TIME        CPU  TASK/PID       ||||     DURATION                  FUNCTION CALLS
> > #      |          |     |    |        ||||      |   |                     |   |   |   |
> >   682.384653 |   1)    <idle>-0    |  d.s. |   5.329 us    |  } /* measure_schedule_delayed_work.constprop.86 */
> 
> Strange output. Do you have all functions being traced? That could
> cause overhead.
> 
> Try this:
> 
> 	# echo measure_schedule_delayed_work > set_ftrace_filter
> 	# echo function_graph > current_tracer
> 	# cat trace
> 
> That will give you much better timings of the overhead of a single
> function.
> 
I did exactly how are your steps. I do not filter all available
functions, there is only one set:

<snip>
root@pc636:/sys/kernel/debug/tracing# cat set_ftrace_filter
measure_schedule_delayed_work.constprop.86
root@pc636:/sys/kernel/debug/tracing# cat tracing_thresh
5
root@pc636:/sys/kernel/debug/tracing# cat current_tracer
function_graph
root@pc636:/sys/kernel/debug/tracing#
<snip>

Also i set 5 microseconds threshold to filter out what is less
and added the latency-format trace option.

--
Vlad Rezki
