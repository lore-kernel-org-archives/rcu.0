Return-Path: <SRS0=T7aT=4F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B668C34022
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 17:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344B420725
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 17:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dmMSMqlM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgBQRrD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:47:03 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:46854 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbgBQRrA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Feb 2020 12:47:00 -0500
Received: by mail-qv1-f68.google.com with SMTP id y2so7910389qvu.13
        for <rcu@vger.kernel.org>; Mon, 17 Feb 2020 09:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fclp6pj9Ohf5zy5oWRL58wezrgVRwCDmitgX4CBgiIw=;
        b=dmMSMqlMDcoQ6t6XjGXJctcHnBHWxJyM1OYtCv+wQVsW+3NgAjeCJvKohvWRdX8eSs
         H7ShIRPeA8kCpW/IZ2WtC7m7Qtp9baL4G3uXaOrC3jJniZmgMFYp7MVGn3fdLZl0cl2r
         0ntUp7mzxWtokPxs3zenSYL1YmpGGzGL4LaDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fclp6pj9Ohf5zy5oWRL58wezrgVRwCDmitgX4CBgiIw=;
        b=AS4ic7HCSQPlZ7XOV3aOOjPLc7QGun3yh++D0JrPoDrJUui9R41hxorkZGoImupkw5
         1gJ5uUQPzh6eZ12ZEvKcFcuEoVjt0/qGY0i3+NPPDjqilJ1A/63Du0n7ZQ7TPwYrrDrx
         Leu0yNkR5pygHcEMtmfDD2qGyR+hCeNE3PFVBUp+iIL25XwduDxH+f7NhkiWbsgXzHuW
         vbcL0wNnRXEKKi5ZLMZBZ4Ppqv9cbo3W6sYPPIRhCQlQzMjWzFgRJWK6mzjEKKds+MCE
         EMNNAHj2rSk79FlQMoU3IH9daH2oDRtbBOXm2nVpUhGVzNRjDHeGwMeA5wp6iWt2Rk7R
         6m9Q==
X-Gm-Message-State: APjAAAX1aNAjJ9JnaTdolUtjV0B5dlGProvVcBkG3qRD2lGfkWiewzs3
        cMEFSTeyugVCGC8ljeIVcwHRkg==
X-Google-Smtp-Source: APXvYqzE6DvKlDvn8pSMAAIb4kG6AaX71wvMuonU8Jb0CTjX1CojS0wGkGqSs4A2hXYJ6Pq3XpUkmQ==
X-Received: by 2002:a0c:fb0f:: with SMTP id c15mr13129726qvp.209.1581961619438;
        Mon, 17 Feb 2020 09:46:59 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l8sm496717qtr.36.2020.02.17.09.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 09:46:58 -0800 (PST)
Date:   Mon, 17 Feb 2020 12:46:58 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 1/4] srcu: Fix __call_srcu()/process_srcu()
 datarace
Message-ID: <20200217174658.GC112239@google.com>
References: <20200215002907.GA15895@paulmck-ThinkPad-P72>
 <20200215002932.15976-1-paulmck@kernel.org>
 <20200217124231.GS14914@hirez.programming.kicks-ass.net>
 <20200217170157.GA166797@google.com>
 <20200217171104.GV14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217171104.GV14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Feb 17, 2020 at 06:11:04PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 17, 2020 at 12:01:57PM -0500, Joel Fernandes wrote:
> 
> > Peter it sounds like you have a failure scenario in mind. Could you describe
> > more if so?
> > 
> > I am curious if you were thinking of invented-stores issue here.
> > 
> > For educational purposes, I was trying to come up with an example where my
> > compiler does something bad to code without WRITE_ONCE(). So far I only can
> > reproduce a write-tearing example when write with an immediate value is split
> > into 2 writes, like Will mentioned:
> > http://lore.kernel.org/r/20190821103200.kpufwtviqhpbuv2n@willie-the-truck
> > But that does not seem to apply to this code.
> 
> > > > -			snp->srcu_gp_seq_needed_exp = gpseq;
> > > > +			WRITE_ONCE(snp->srcu_gp_seq_needed_exp, gpseq);
> 
> Yeah, store tearing. No sane compiler will actually do that, but it is
> allowed to do random permutations of byte stores just to fuck with us.
> 
> WRITE_ONCE() disallows that.
> 
> In that case, the READ_ONCE()s could observe garbage and the compare
> might accidentally report the wrong thing.

Oh ok, I understand what you mean now. Thank you for clarification!

thanks,

 - Joel

