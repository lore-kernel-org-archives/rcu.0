Return-Path: <SRS0=P5Uu=WI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3FFC433FF
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 01:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AB22084D
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 01:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="iY7acCut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfHLBk5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 11 Aug 2019 21:40:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46686 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLBk4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 11 Aug 2019 21:40:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id q139so630599pfc.13
        for <rcu@vger.kernel.org>; Sun, 11 Aug 2019 18:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pcaHTe8e8msoMcC2QRjvC+ehm4GbZkk/MDQ2TNtCi1g=;
        b=iY7acCutdsEaJLBoTVOq0hupU+bwFiOeT1PqX1YzZu41YdfFqwbe8C9rO2/MslyuKh
         tMojGe6eNHd6k5LxZjnlcPNI53ePRr8HIyA3NcGBkvA6raOx+xfh3s9WvQfCIDjv9iqU
         1DMSMqk+3pAvWUe3W0dqN7siyD3HgkZK56HQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pcaHTe8e8msoMcC2QRjvC+ehm4GbZkk/MDQ2TNtCi1g=;
        b=sQDFspHqDacHflHUb1HOoG7ovouMmMt9pCT96d3u4VBBLLX0wqDOaCoqbB49xrRziO
         aYzNLynwCRCV16NHOyDYEKAhv5Ssvw8XVVh+lHKBqjMKz2PW+59gwAaLEMr3gysPSbOW
         nf1MK+tu+KO4bAVbQGDTZg17zsDRFzy49jyhGF3BS5tPnFR6hcfVpyawFAQwK2P6wQmK
         NRf+agXisembpkSezPbeBhux0zBbEAW7A+jL4x91vPhnvWAnWHju89q9jn89fhIniVij
         kwnz6zb3j5bZOoGLEe+SmOkPIkvYwXgc6lPzCeS60yxfJff135yKJa0AaYD5WD972r2+
         ot4Q==
X-Gm-Message-State: APjAAAUX1xWgy61VYlH0eEZ5sY3miy9z6CA4FV0wG61PhjbJpra/olvr
        wfZXifRyegAIqqPjcdyjgwo5SB6FGl8=
X-Google-Smtp-Source: APXvYqzJstvrzU3CvmwaFapBu3EAeEGpfT9l1sq+3qPzfwD7F4YDk2U7De505BGn2T7qprWLyLEEdg==
X-Received: by 2002:a63:c009:: with SMTP id h9mr28126559pgg.166.1565574056148;
        Sun, 11 Aug 2019 18:40:56 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x65sm104086498pfd.139.2019.08.11.18.40.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 18:40:55 -0700 (PDT)
Date:   Sun, 11 Aug 2019 21:40:53 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu <rcu@vger.kernel.org>
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190812014053.GD128944@google.com>
References: <20190811180852.GA128944@google.com>
 <CAEXW_YSbGCSLVrqD-_pDO5KJzLR2goYt8otOd65hWPQtZGkGUA@mail.gmail.com>
 <20190811211646.GY28441@linux.ibm.com>
 <20190811212505.GB128944@google.com>
 <20190811233024.GZ28441@linux.ibm.com>
 <20190812012431.GC128944@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812012431.GC128944@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Aug 11, 2019 at 09:24:31PM -0400, Joel Fernandes wrote:
> On Sun, Aug 11, 2019 at 04:30:24PM -0700, Paul E. McKenney wrote:
[snip]
> > Next question:  Why does rcu_implicit_dynticks_qs() check only for
> > tick_nohz_full_cpu() and not also IS_ENABLED(CONFIG_PREEMPT)?  After
> > all, a nohz_full CPU in a !CONFIG_PREEMPT kernel should be able to
> > rely on cond_resched(), right?
> > 
> > Should this change?  Why or why not?
> 
> Let me think more about this :) I have an answer in mind but I will think a
> bit more about it and responsd :)

It should not change. That's because (as somewhat mentioned in the comments),
some code paths in the kernel check need_resched() before invoking
cond_resched(). So even with PREEMPT=n having the help of cond_resched(), the
cond_resched() may actually not even be invoked.  So in this case, the
resched_cpu() from rcu_implicit_dynticks_qs() does the needful by setting the
rescheduling flags on the CPU, so that cond_resched() on those CPUs actually
get called. Is that a correct analysis?

thanks,

 - Joel

