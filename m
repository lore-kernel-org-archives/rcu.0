Return-Path: <SRS0=UQpt=3H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA638C32771
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 20:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8012469D
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 20:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wl0UWlpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgARUTm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 18 Jan 2020 15:19:42 -0500
Received: from mail-pj1-f51.google.com ([209.85.216.51]:36974 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgARUTk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 18 Jan 2020 15:19:40 -0500
Received: by mail-pj1-f51.google.com with SMTP id m13so5063939pjb.2
        for <rcu@vger.kernel.org>; Sat, 18 Jan 2020 12:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TmOxpIfA1VjdvNXx9f0mRAcCMKr9p35+Un9n1aRE4rQ=;
        b=wl0UWlpSmcs5WHiAMDoNx693VaYnhahNkXglf9wAzXg8XnGnEY3OrmS15WjP2xUner
         kHK+CqVDIElnSywaR/SIxXFU0EGyHDUhBH6YNjD8ImHc48SucobD+R8T19mbZokDuBKn
         ItNYCOdPPvA/WmmSeOwpy0BzxgymOMmCxEIsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TmOxpIfA1VjdvNXx9f0mRAcCMKr9p35+Un9n1aRE4rQ=;
        b=ldr7XSNyQBXVOnjKSYgH78ol44PVCF1RZQ9V0W0qEhdG+tjtTJfu0ciBhX8+b/ZXAL
         aF4jGAv36IYfTT9ZV5gO87capTE5/Pj3Eq4KcP4QYrofMdn0sV/zNIkv5h2eGDNET4T5
         0K6tm068nIcxICSVsnEnVUlMDXyKhSaR3am1dP1+xmZ6RGcjpmFc3NlBECdfbY+RkYb5
         xowwusHMfoLXDLZCtnHm/hfT+p0pFF9p+T9xiN60M5lp2Ml1v9NnYGShpPXjOI0WU7KT
         slhULF1G3oUpixG6gxH2O+zwjAoXYWgtXzRiL54HX0qVBkyQGGZns7cEcvwj0Lem5PmY
         ryuQ==
X-Gm-Message-State: APjAAAWpTs7hnpSGqvAf3cun/oE9gDkgGXeELWK90FvhZacY9CXYvm9h
        nU2kYYb5aWUZapRMD3wpAG0xFg==
X-Google-Smtp-Source: APXvYqxxVaq3TbAV8UmEYIvYHju7ta3IE+DJ+35pEOYxtDYiqbmuyQp+zv6J+G5aNCTut44xYaMnbg==
X-Received: by 2002:a17:902:b704:: with SMTP id d4mr6183176pls.54.1579378779216;
        Sat, 18 Jan 2020 12:19:39 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t65sm34266551pfd.178.2020.01.18.12.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 12:19:38 -0800 (PST)
Date:   Sat, 18 Jan 2020 15:19:37 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, rostedt@goodmis.org, bristot@redhat.com
Subject: Re: RCU_BOOST not working for me
Message-ID: <20200118201937.GD244899@google.com>
References: <20200117215814.GB206250@google.com>
 <20200117221804.GA211665@google.com>
 <20200117231756.GO2935@paulmck-ThinkPad-P72>
 <20200118023434.GB244899@google.com>
 <20200118043458.GT2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118043458.GT2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 17, 2020 at 08:34:58PM -0800, Paul E. McKenney wrote:
> On Fri, Jan 17, 2020 at 09:34:34PM -0500, Joel Fernandes wrote:
> > On Fri, Jan 17, 2020 at 03:17:56PM -0800, Paul E. McKenney wrote:
> > [...] 
> > > But rcutorture already has tests for RCU priority boosting.  Or are those
> > > failing in some way?
> > 
> > Yes there are tests, but I thought of just a simple experiment to study this.
> > Purely since it is existing RCU kernel code that I'd like to understand. And
> > me/Daniel are also looking into possibly using run-time / trace-based
> > verification some of these behaviors.
> 
> The functionality of rcu_state.cbovld should make that more entertaining.
> 
> But I would guess that the initial model would ignore memory footprint
> and just model RCU priority boosting as kicking in a fixed time after
> the beginning of the grace period.
> 
> Or do you guys have something else in mind?

Yes, that is the idea. And then turn the model into a unit test (for the
measurement). Though I am also personally trying to convince myself that a
unit test based on a model is better than the test in the kernel module I
just posted. We're just looking at applying Daniel's modeling work to
verification of behaviors like these.

A poor-man's alternative of a model-based test is just making sure that
synchronize_rcu() finishes in a bounded period of time (basically test by
observation than test by model) similar to what my kernel module did.  But I
guess a model based test would be more accurate and more strict about what is
considered a pass vs fail.

I was also studying SRCU and could not find tracepoints so I am thinking of
adding some to aid the study. I know for Tree-SRCU you are using timers and
workqueues but the concept hasn't largely changed since [1] was written
right?

[1] https://lwn.net/Articles/202847/

thanks!

 - Joel

> 							Thanx, Paul
> 
> PS.  Steve, yes, I do well remember our earlier discussions about readers
>      inheriting priority from the highest-priority synchronize_rcu().  ;-)
