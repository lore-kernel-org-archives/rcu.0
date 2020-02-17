Return-Path: <SRS0=T7aT=4F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF94C34022
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 21:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C32207FD
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 21:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Pzz6Zgxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgBQVLi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Feb 2020 16:11:38 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45742 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgBQVLh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Feb 2020 16:11:37 -0500
Received: by mail-qk1-f193.google.com with SMTP id a2so17497907qko.12
        for <rcu@vger.kernel.org>; Mon, 17 Feb 2020 13:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FxRvJ7r8F0ZhX0NHb83GmNQC4jmvCqMGLG+tYQsonZM=;
        b=Pzz6Zgxbs2KU70lU07hCHuYB+qSwV2OzlgI3vnRxXKSknajbzUMUz9POTYrINqVTxS
         Q4v+CqY7C/FMizwmjXn3j6MRDtN5/l3Ah0YAxZNd7CKo63eb+UYaLAr+A5NlItB3SXoF
         Ytq8dEvLHRhR0hxyGKXmWQFFIocQ96jLq3lkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FxRvJ7r8F0ZhX0NHb83GmNQC4jmvCqMGLG+tYQsonZM=;
        b=PODpKrdEgatmz3FOT+5uszpxEdew9XP777Tr9h3zxos63t8K9zdUmlc7Bp/O/Q9gXK
         lavsGAnGYpqLTkWC5ddP8oxwcYhBo8Rp7uDb0A7YUZT4jtYGw3iTwdZ5/4/HYT+ZbLPA
         db3YgDwxaL12oKzNOnT9F05o2t7U1l6JaQI4yt2P29ODs0dBlVSiEL033QORczI8uzTt
         gHBlHjNRYCl8ndnVbOphGlAOhjiMlnJW9PUiiy2dku6DdtWeCXwiPm0lM9wMakRlzKUl
         U72xAsgGFSk2T5dNg19gwd/D3McxbJvbyhYfGHufQHCUS74jL78nXX70EPWzr4RKe4T6
         PYqw==
X-Gm-Message-State: APjAAAUNeEnW2TUXiQSi0Z+na4Swb8E5ys6ibRANlMKenFDYgD6/A/5T
        BoCbSDleKWw18xClM1DiL9dyhw==
X-Google-Smtp-Source: APXvYqygX7dLAl4Fy2BYXdFwY91MRzUP3Zm9j4CbyODQwFddsNhaRmCqH65KiokFA+D4qv930fnjMA==
X-Received: by 2002:a37:9e0f:: with SMTP id h15mr15770994qke.287.1581973896659;
        Mon, 17 Feb 2020 13:11:36 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 132sm429238qkn.109.2020.02.17.13.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 13:11:35 -0800 (PST)
Date:   Mon, 17 Feb 2020 16:11:35 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH tip/core/rcu 06/30] rcu: Add WRITE_ONCE to rcu_node
 ->exp_seq_rq store
Message-ID: <20200217211135.GA207704@google.com>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
 <20200214235607.13749-6-paulmck@kernel.org>
 <20200214224743.280772a7@oasis.local.home>
 <20200215105803.GY2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215105803.GY2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Feb 15, 2020 at 02:58:03AM -0800, Paul E. McKenney wrote:
> On Fri, Feb 14, 2020 at 10:47:43PM -0500, Steven Rostedt wrote:
> > On Fri, 14 Feb 2020 15:55:43 -0800
> > paulmck@kernel.org wrote:
> > 
> > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > 
> > > The rcu_node structure's ->exp_seq_rq field is read locklessly, so
> > > this commit adds the WRITE_ONCE() to a load in order to provide proper
> > > documentation and READ_ONCE()/WRITE_ONCE() pairing.
> > > 
> > > This data race was reported by KCSAN.  Not appropriate for backporting
> > > due to failure being unlikely.
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  kernel/rcu/tree_exp.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > index d7e0484..85b009e 100644
> > > --- a/kernel/rcu/tree_exp.h
> > > +++ b/kernel/rcu/tree_exp.h
> > > @@ -314,7 +314,7 @@ static bool exp_funnel_lock(unsigned long s)
> > >  				   sync_exp_work_done(s));
> > >  			return true;
> > >  		}
> > > -		rnp->exp_seq_rq = s; /* Followers can wait on us. */
> > > +		WRITE_ONCE(rnp->exp_seq_rq, s); /* Followers can wait on us. */
> > 
> > Didn't Linus say this is basically bogus?
> > 
> > Perhaps just using it as documenting that it's read locklessly, but is
> > it really needed?
> 
> Yes, Linus explicitly stated that WRITE_ONCE() is not required in
> this case, but he also said that he was OK with it being there for
> documentation purposes.

Just to add, PeterZ does approve of WRITE_ONCE() to prevent store-tearing
where applicable.

And I have reproduced Will's example [1] with the arm64 Clang compiler
shipping with the latest Android NDK just now. It does break up stores when
writing zeroes to 64-bit valyes, this is a real problem which WRITE_ONCE()
resolves. And I've verified GCC on arm64 does break up 64-bit immediate value
writes without WRITE_ONCE().

thanks,

 - Joel

[1] https://lore.kernel.org/lkml/20190821103200.kpufwtviqhpbuv2n@willie-the-truck/


> And within RCU, I -do- need it because I absolutely need to see if a
> given patch introduced new KCSAN reports.  So I need it for the same
> reason that I need the build to proceed without warnings.
> 
> Others who are working with less concurrency-intensive code might quite
> reasonably make other choices, of course.  And my setting certain KCSAN
> config options in my own builds doesn't inconvenience them, so we should
> all be happy, right?  :-)
> 
> 							Thanx, Paul
> 
> > -- Steve
> > 
> > 
> > 
> > >  		spin_unlock(&rnp->exp_lock);
> > >  		trace_rcu_exp_funnel_lock(rcu_state.name, rnp->level,
> > >  					  rnp->grplo, rnp->grphi, TPS("nxtlvl"));
> > 
