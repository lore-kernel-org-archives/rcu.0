Return-Path: <SRS0=UQpt=3H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9753AC32771
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 20:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6766024680
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 20:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QWFjyJmQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgARUVd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 18 Jan 2020 15:21:33 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:56151 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgARUVd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 18 Jan 2020 15:21:33 -0500
Received: by mail-pj1-f65.google.com with SMTP id d5so4777311pjz.5
        for <rcu@vger.kernel.org>; Sat, 18 Jan 2020 12:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CnpNmdXzbS/oIOX1OomCU6Fd4Xcx4LcQ0H3+8CRic4g=;
        b=QWFjyJmQ0rCdLA2xiWdXCOlabtC05Mm8s16uU0km6dSmJQt6InAlkvRpXr8W0Yq6Wb
         PrywH22SgRjDmigvenbW8zEryZBqfUE/SQ1+dvzejyHQp2qs72qeLGctUZl3iTCyKzAR
         tb6vvCFKr+kq/VPlXFHGE3tVxp3gmleKDWcTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CnpNmdXzbS/oIOX1OomCU6Fd4Xcx4LcQ0H3+8CRic4g=;
        b=fDhGEHRMKp/Ry1zrhsHFsaxwRBn7/tiS+XV4K7sYKvMs/+tHWEYH+l1GRuijknbqp3
         h0Ph3xb/6I4p76bpRj0r9s71RGl1EW1aWa6UH/gtL5mwGAxgVB3gcuKMB9qLyO7RBIhz
         F2RxjuA972fmXPev1/rax42VDezD8N8fEWhpCzIfA40pIweWTCZ8Vpm9M0JWDT55+Udq
         RIyXApN+jMVH5jN7z5lpzacjGstxbHIINCP3NfMbLJc2x/3eMaG6JoakwL/aWgiLX/XQ
         iZumO8zqrIYcqH7ReBRzao1f5SqnvBv53fW4KMFlGkU5SWPzckctDURtnTxDE58wkQht
         BXCg==
X-Gm-Message-State: APjAAAUVZA4XXybtb1zEf8f9jCJ/9vSMzRM7op9Emjdl0ZSgCaKOyREF
        wl4mUyqE5ZSltCkwqrJulkc8vg+4oMM=
X-Google-Smtp-Source: APXvYqxDwDMIl0QHSeVu7fnyMWaUKMF6ZDz7JCvMW1RBhJn914amAvam2X/qV3mgAaI3nSybKibYKw==
X-Received: by 2002:a17:90a:f314:: with SMTP id ca20mr13346876pjb.112.1579378892339;
        Sat, 18 Jan 2020 12:21:32 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v4sm33470130pff.174.2020.01.18.12.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 12:21:32 -0800 (PST)
Date:   Sat, 18 Jan 2020 15:21:31 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, rostedt@goodmis.org, bristot@redhat.com
Subject: Re: RCU_BOOST not working for me
Message-ID: <20200118202131.GE244899@google.com>
References: <20200117215814.GB206250@google.com>
 <20200117221804.GA211665@google.com>
 <20200117231756.GO2935@paulmck-ThinkPad-P72>
 <20200118023434.GB244899@google.com>
 <20200118043458.GT2935@paulmck-ThinkPad-P72>
 <20200118045436.GU2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118045436.GU2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 17, 2020 at 08:54:36PM -0800, Paul E. McKenney wrote:
> On Fri, Jan 17, 2020 at 08:34:58PM -0800, Paul E. McKenney wrote:
> > On Fri, Jan 17, 2020 at 09:34:34PM -0500, Joel Fernandes wrote:
> > > On Fri, Jan 17, 2020 at 03:17:56PM -0800, Paul E. McKenney wrote:
> > > [...] 
> > > > But rcutorture already has tests for RCU priority boosting.  Or are those
> > > > failing in some way?
> > > 
> > > Yes there are tests, but I thought of just a simple experiment to study this.
> > > Purely since it is existing RCU kernel code that I'd like to understand. And
> > > me/Daniel are also looking into possibly using run-time / trace-based
> > > verification some of these behaviors.
> > 
> > The functionality of rcu_state.cbovld should make that more entertaining.
> > 
> > But I would guess that the initial model would ignore memory footprint
> > and just model RCU priority boosting as kicking in a fixed time after
> > the beginning of the grace period.
> > 
> > Or do you guys have something else in mind?
> > 
> > 							Thanx, Paul
> > 
> > PS.  Steve, yes, I do well remember our earlier discussions about readers
> >      inheriting priority from the highest-priority synchronize_rcu().  ;-)
> 
> To see the reason why RCU priority boosting does not work like that,
> consider a (stupid but legal) situation with way more tasks like this
> than the system can handle:
> 
> 	for (;;) {
> 		cond_resched();
> 		p = kmalloc(sizeof(*p), GFP_ATOMIC);
> 		if (!p)
> 			continue;
> 		rcu_read_lock();
> 		kfree(&p->rh, my_func);
> 		rcu_read_unlock(;
> 	}
> 
> Nothing is ever waiting on the RCU grace period, so there is no natural
> place for priority to be inherited from.
> 
> But the current RCU priority boosting works just fine in this situation,
> at least assuming rcutree.kthread_prio is set suitably.  And if it is
> not working fine in some other situation, it would be good for someone
> to let me in on the secret.  ;-)

But in this example, you don't have anyone starting a grace period. So how
would the boosting be done? Somebody has to kick boosting into action?

thanks,

 - Joel

