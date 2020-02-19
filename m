Return-Path: <SRS0=W0OP=4H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABA8C3404F
	for <rcu@archiver.kernel.org>; Wed, 19 Feb 2020 00:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545222465D
	for <rcu@archiver.kernel.org>; Wed, 19 Feb 2020 00:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="M4Jm/WVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgBSABr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:01:47 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45632 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgBSABr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Feb 2020 19:01:47 -0500
Received: by mail-qk1-f196.google.com with SMTP id a2so21346386qko.12
        for <rcu@vger.kernel.org>; Tue, 18 Feb 2020 16:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZncEIyYi8WuUORtwhrTXqb5H8wAtob9Qk+8uAaIjx1I=;
        b=M4Jm/WVIOOrdqqA9r3dqNIkZ65s5JPx/OaYA/Z1C9ZmIbbyR1IAgkVtXwFEpy7YOr8
         EDVyq0AWtnB/yInsz1kCPJeBIOx7GDOKgLBdM8XwY2k2e40ALUw3/F4Gc7KHG9HmzA/s
         /SRNBeyRSUYejg2W9qPrnqTqNz/yzVhBbP+f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZncEIyYi8WuUORtwhrTXqb5H8wAtob9Qk+8uAaIjx1I=;
        b=OihNPcRaZRneMXD0asB+3RH/IWlNwm66K1daDaT380gmU895nkONm46ykjuOw5m/Ap
         RhF+puav1oi84Zgie/6TkpphLu9z4YVjYH8fKEDi2+I1z5bSIarAsv1q48Qzprb97rEY
         axj9aU+lNFeBMbDZvVdLFBKUkvGvUHDRN1zWQUYtBBWmW8jcDvaqlsWjLeSTzsppXLG/
         bOEaxU5pLY5s5V6e2Y+TY1ljjMxVVzql08/0I0dV7Bps9os/dMA+hCA9yA2490FJ/Ysd
         Q7lfTBeZB5z0MiZdCneW6uEiqopAVpsYO5NySzWSAn5yI2U4jE7YyU7RI/8mZtJvUg7B
         LjpA==
X-Gm-Message-State: APjAAAXjLgILW38nKH61kMYGdtC/qLFFdlc7tm28opzH84ZWxZYaM5ge
        /Yjc9m/KlWoac+SAQqBYggn+Bg==
X-Google-Smtp-Source: APXvYqw5t12g1wrtXskMvVyIqVO0btZ865Lf7DT68CyUl5rJs5IExjWAcjNd1r2JD94XwKTu2thuLQ==
X-Received: by 2002:ae9:f016:: with SMTP id l22mr21209557qkg.101.1582070506240;
        Tue, 18 Feb 2020 16:01:46 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y28sm142559qkj.44.2020.02.18.16.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 16:01:45 -0800 (PST)
Date:   Tue, 18 Feb 2020 19:01:44 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 1/3] rcu-tasks: *_ONCE() for
 rcu_tasks_cbs_head
Message-ID: <20200219000144.GA26663@google.com>
References: <20200215002446.GA15663@paulmck-ThinkPad-P72>
 <20200215002520.15746-1-paulmck@kernel.org>
 <20200217123851.GR14914@hirez.programming.kicks-ass.net>
 <20200217181615.GP2935@paulmck-ThinkPad-P72>
 <20200218075648.GW14914@hirez.programming.kicks-ass.net>
 <20200218162719.GE2935@paulmck-ThinkPad-P72>
 <20200218201142.GF11457@worktop.programming.kicks-ass.net>
 <20200218202226.GJ2935@paulmck-ThinkPad-P72>
 <20200218174503.3d4e4750@gandalf.local.home>
 <20200218225455.GN2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218225455.GN2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Feb 18, 2020 at 02:54:55PM -0800, Paul E. McKenney wrote:
> On Tue, Feb 18, 2020 at 05:45:03PM -0500, Steven Rostedt wrote:
> > On Tue, 18 Feb 2020 12:22:26 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > On Tue, Feb 18, 2020 at 09:11:42PM +0100, Peter Zijlstra wrote:
> > > > On Tue, Feb 18, 2020 at 08:27:19AM -0800, Paul E. McKenney wrote:  
> > > > > On Tue, Feb 18, 2020 at 08:56:48AM +0100, Peter Zijlstra wrote:  
> > > >   
> > > > > > I just took offence at the Changelog wording. It seems to suggest there
> > > > > > actually is a problem, there is not.  
> > > > > 
> > > > > Quoting the changelog: "Not appropriate for backporting due to failure
> > > > > being unlikely."  
> > > > 
> > > > That implies there is failure, however unlikely.
> > > > 
> > > > In this particular case there is absolutely no failure, except perhaps
> > > > in KCSAN. This patch is a pure annotation such that KCSAN can understand
> > > > the code.
> > > > 
> > > > Like said, I don't object to the actual patch, but I do think it is
> > > > important to call out false negatives or to describe the actual problem
> > > > found.  
> > > 
> > > I don't feel at all comfortable declaring that there is absolutely
> > > no possibility of failure.
> > 
> > Perhaps wording it like so:
> > 
> > "There's know known issue with the current code, but the *_ONCE()
> > annotations here makes KCSAN happy, allowing us to focus on KCSAN
> > warnings that can help bring about known issues in other code that we
> > can fix, without being distracted by KCSAN warnings that we do not see
> > a problem with."
> > 
> > ?
> 
> That sounds more like something I might put in rcutodo.html as a statement
> of the RCU approach to KCSAN reports.
> 
> But switching to a different situation (for variety, if nothing else),
> what about the commit shown below?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 35bc02b04a041f32470ae6d959c549bcce8483db
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Feb 18 13:41:02 2020 -0800
> 
>     rcutorture: Mark data-race potential for rcu_barrier() test statistics
>     
>     The n_barrier_successes, n_barrier_attempts, and
>     n_rcu_torture_barrier_error variables are updated (without access
>     markings) by the main rcu_barrier() test kthread, and accessed (also
>     without access markings) by the rcu_torture_stats() kthread.  This of
>     course can result in KCSAN complaints.
>     
>     Because the accesses are in diagnostic prints, this commit uses
>     data_race() to excuse the diagnostic prints from the data race.  If this
>     were to ever cause bogus statistics prints (for example, due to store
>     tearing), any misleading information would be disambiguated by the
>     presence or absence of an rcutorture splat.
>     
>     This data race was reported by KCSAN.  Not appropriate for backporting
>     due to failure being unlikely and due to the mild consequences of the
>     failure, namely a confusing rcutorture console message.
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 5453bd5..b3301f3 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1444,9 +1444,9 @@ rcu_torture_stats_print(void)
>  		atomic_long_read(&n_rcu_torture_timers));
>  	torture_onoff_stats();
>  	pr_cont("barrier: %ld/%ld:%ld\n",
> -		n_barrier_successes,
> -		n_barrier_attempts,
> -		n_rcu_torture_barrier_error);
> +		data_race(n_barrier_successes),
> +		data_race(n_barrier_attempts),
> +		data_race(n_rcu_torture_barrier_error));

Would it be not worth just fixing the data-race within rcutorture itself?

thanks,

 - Joel

