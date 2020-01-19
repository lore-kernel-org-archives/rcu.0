Return-Path: <SRS0=vvc8=3I=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BA2C32771
	for <rcu@archiver.kernel.org>; Sun, 19 Jan 2020 01:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B3F206B7
	for <rcu@archiver.kernel.org>; Sun, 19 Jan 2020 01:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="RVlJ0JP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgASB6O (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 18 Jan 2020 20:58:14 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39846 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgASB6O (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 18 Jan 2020 20:58:14 -0500
Received: by mail-pj1-f68.google.com with SMTP id e11so5280741pjt.4
        for <rcu@vger.kernel.org>; Sat, 18 Jan 2020 17:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LJ3Wc/Od03gRI0xhfIxEFpOXcC+ajIe82gb/SI6Rau0=;
        b=RVlJ0JP4fw4NXoJHeTOJOrf4npw1S9fYJoJ1sllniZf/S2TzWfnpHii++KCdpZRa8F
         g5z3FFYCveYkxyBz88p2LZCKIJP7qBMBNmA5+YQXkhcz7QNooYIOrT9cQ8psui4RUKS6
         TXS5oPL65PwFt4vl2yzVR1Uaw5rlB/ix1P6bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LJ3Wc/Od03gRI0xhfIxEFpOXcC+ajIe82gb/SI6Rau0=;
        b=GbH3/pzsWX5wFQZt7Qh0qHxYlLiklktp9UH+l/HEcmg3yB3rSwUStKXbXlzvJ3qF5J
         5w63i9SXUDFAP+o02UltDoL1SESwL1D+8+lA0A/6J3KfEDyufYIjXXCxCXwd5Gjf1wAV
         Dek2q4l8o7KK2rfyEkzBMNz7CuXjFgrpyPkp9Ht9VT09y7sMEb0cswIueCoGAtnq/Nzx
         fQhQFyCcXQa96cCiu11WFXsg+kt6h9lvZtJpVjcX7ijoN865Qw/AqWp+fIAFlXfOpLTK
         qHR8PTk9EsJJ1oJYJX+Vpe5RMUWfhUUOsCZfZ/kcWJLaN/o4SRI9v4qNL2MKSGs/DmPz
         FxHw==
X-Gm-Message-State: APjAAAUCbUksR2f6F0wh3W7H0YzE1GExqOZXQE0dQMysCMbtkQxXah7Q
        Y9P3YwMVyODngzyZpkgxuVAF0w==
X-Google-Smtp-Source: APXvYqxAB8AUoCj3TWrvpAtNFwg+DIAoB6uNCZcQ0rf9LuoVAnfX/d460XizsrTGIFTdrATW0kLQTA==
X-Received: by 2002:a17:902:61:: with SMTP id 88mr7550250pla.313.1579399093586;
        Sat, 18 Jan 2020 17:58:13 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id u7sm33982199pfh.128.2020.01.18.17.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 17:58:13 -0800 (PST)
Date:   Sat, 18 Jan 2020 20:58:12 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, rostedt@goodmis.org, bristot@redhat.com
Subject: Re: RCU_BOOST not working for me
Message-ID: <20200119015812.GF244899@google.com>
References: <20200117215814.GB206250@google.com>
 <20200117221804.GA211665@google.com>
 <20200117231756.GO2935@paulmck-ThinkPad-P72>
 <20200118023434.GB244899@google.com>
 <20200118043458.GT2935@paulmck-ThinkPad-P72>
 <20200118201937.GD244899@google.com>
 <20200118224708.GY2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118224708.GY2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jan 18, 2020 at 02:47:08PM -0800, Paul E. McKenney wrote:
> On Sat, Jan 18, 2020 at 03:19:37PM -0500, Joel Fernandes wrote:
> > On Fri, Jan 17, 2020 at 08:34:58PM -0800, Paul E. McKenney wrote:
> > > On Fri, Jan 17, 2020 at 09:34:34PM -0500, Joel Fernandes wrote:
> > > > On Fri, Jan 17, 2020 at 03:17:56PM -0800, Paul E. McKenney wrote:
> > > > [...] 
> > > > > But rcutorture already has tests for RCU priority boosting.  Or are those
> > > > > failing in some way?
> > > > 
> > > > Yes there are tests, but I thought of just a simple experiment to study this.
> > > > Purely since it is existing RCU kernel code that I'd like to understand. And
> > > > me/Daniel are also looking into possibly using run-time / trace-based
> > > > verification some of these behaviors.
> > > 
> > > The functionality of rcu_state.cbovld should make that more entertaining.
> > > 
> > > But I would guess that the initial model would ignore memory footprint
> > > and just model RCU priority boosting as kicking in a fixed time after
> > > the beginning of the grace period.
> > > 
> > > Or do you guys have something else in mind?
> > 
> > Yes, that is the idea. And then turn the model into a unit test (for the
> > measurement). Though I am also personally trying to convince myself that a
> > unit test based on a model is better than the test in the kernel module I
> > just posted. We're just looking at applying Daniel's modeling work to
> > verification of behaviors like these.
> > 
> > A poor-man's alternative of a model-based test is just making sure that
> > synchronize_rcu() finishes in a bounded period of time (basically test by
> > observation than test by model) similar to what my kernel module did.  But I
> > guess a model based test would be more accurate and more strict about what is
> > considered a pass vs fail.
> 
> In one sense, fair enough.
> 
> But in a more practical sense, why would anyone put synchronize_rcu()
> anywhere near their real-time fastpaths?  Even synchronize_rcu_expedited()
> would be a rather brave choice for such a fastpath.

Oh, I was just talking in the context of a unit test for boost, such as the
one I wrote. By measuring synchronize_rcu() time in the previous test I
wrote, we can get a sense of if the BOOST worked or not. Since the point of
BOOST is to shorten the otherwise lengthy grace period.

> > I was also studying SRCU and could not find tracepoints so I am thinking of
> > adding some to aid the study. I know for Tree-SRCU you are using timers and
> > workqueues but the concept hasn't largely changed since [1] was written
> > right?
> 
> At one point I had tracepoints for SRCU on my list, but the discussions
> of tracepoints possibly being user API scared me off.

I find it hard to imagine why any sane userspace tooling would want to depend
on RCU tracepoints. If they are just debug scripts like the one we've been
thinking of writing, then that's fine.

The latest on "tracepoints as user API" that I learnt from last conferences
is, if a tracepoint is so popular that userspace tools are using it and known
to use it, then that because ABI/API. If they are not used or unpopular, then
they are not so much as API. I believe the existing RCU tracepoints already
there, haven't shown to be an issue so may be it is Ok for RCU?

> SRCU has been rewritten from scratch something like three times since
> that article was published.  The current version is only a few years old.
> And there is some motivation for more modifications due to the size of
> the srcu_struct structure.  (Maybe dynamically allocating the srcu_node
> array or some such, though this is not free of hazard and hassle, either.)
> Thus far, all complaints about the large size have been handled by other
> means, but there have been several such complaints.  In addition, the
> use of workqueues is still a bit on the experimental side.  Looking good
> thus far, but the code is yet young.
> 
> But yes, had the code remained unchanged for 14 years, there wouldn't
> be much downside to adding tracepoints.  But the code is less than three
> years old.

Interesting! Thanks for the history.

 - Joel

