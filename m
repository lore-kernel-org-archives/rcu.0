Return-Path: <SRS0=IXig=5B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3169FC3F2CE
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 15:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BAE2074D
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 15:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="PkRwHenX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbgCPPBQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:01:16 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43346 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731776AbgCPPBM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 11:01:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id l13so14386837qtv.10
        for <rcu@vger.kernel.org>; Mon, 16 Mar 2020 08:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=toDgRxGkv3Au9QraZzaLZxhTcUG6A8OuNPWq31a+tWs=;
        b=PkRwHenXC1sh5P6YofjVaT7LKOVV8z7J1aDn/2jT4HDuyut32E5bKrUkalswF9IRuP
         /lDL2EZQf6DQkgFTHHe7Dl/RD25L+sXC24B9tSug/pKtzfmNJKOnkEDBrXpfVkXM0xaC
         WI03IfjTn8z5GM0o++tlHYVIrFjP7nGJdThsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=toDgRxGkv3Au9QraZzaLZxhTcUG6A8OuNPWq31a+tWs=;
        b=NJDW84JAmqra1ERd6haRGSt8fe8RPAC+W5jvIoNv/GuUZU8xar1EYvHKGSkHlvd7Zh
         e0lnZEl7vfFFB4qcSdv92VFeNMZjWlE1VSbuLppx0aIk4m51KlJlHq2/z15himnfFeSn
         xAsd+1/e8AE28YH6bUiPbNxoFL+ZuvwOOfVkbQLqMW6v0f/3B/PSZoOSCG99h+fsRueh
         vqz2ZJHbIUxIW7jfbrtQOnWsDCzf8j1Yg4AYM8gUt8tZtTmtSvUvJkAtitS87/7HuCeI
         4W6Sb7NM6cMy8IyDq2cEer+KvuENFftngqHsCeQvCNkpkQSTdmxB/aL9MJEoYJfXYyhl
         ZD0Q==
X-Gm-Message-State: ANhLgQ0zaImwMGeGVQtG8zOPtNvNazX3Zz4mBWf3HihF+5Pb5I7oG7Fk
        KDf4/sEHhPY6PT7LhWbbsGOeJw==
X-Google-Smtp-Source: ADFU+vvJFwFt9cBgLtR8fCszl78b95Z+5RabLU2VNLX1UaPszxBnI0lJnRSvBlXkhyGKePUrD4aU/g==
X-Received: by 2002:ac8:2f23:: with SMTP id j32mr514513qta.120.1584370871758;
        Mon, 16 Mar 2020 08:01:11 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d72sm15615874qkc.88.2020.03.16.08.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:01:11 -0700 (PDT)
Date:   Mon, 16 Mar 2020 11:01:10 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Qian Cai <cai@lca.pw>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] locking/lockdep: Avoid recursion in
 lockdep_count_{for,back}ward_deps()
Message-ID: <20200316150110.GB134626@google.com>
References: <20200312151258.128036-1-boqun.feng@gmail.com>
 <20200313093325.GW12561@hirez.programming.kicks-ass.net>
 <20200315010422.GA134626@google.com>
 <20200316135507.GF12561@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316135507.GF12561@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 16, 2020 at 02:55:07PM +0100, Peter Zijlstra wrote:
> On Sat, Mar 14, 2020 at 09:04:22PM -0400, Joel Fernandes wrote:
> > On Fri, Mar 13, 2020 at 10:33:25AM +0100, Peter Zijlstra wrote:
> 
> > Thanks Peter and Boqun, the below patch makes sense to me. Just had some nits
> > below, otherwise:
> > > @@ -1719,11 +1725,11 @@ unsigned long lockdep_count_forward_deps
> > >  	this.class = class;
> > >  
> > >  	raw_local_irq_save(flags);
> > > -	current->lockdep_recursion = 1;
> > > +	current->lockdep_recursion++;
> > >  	arch_spin_lock(&lockdep_lock);
> > >  	ret = __lockdep_count_forward_deps(&this);
> > >  	arch_spin_unlock(&lockdep_lock);
> > > -	current->lockdep_recursion = 0;
> > > +	current->lockdep_recursion--;
> > 
> > This doesn't look like it should recurse. Why not just use the
> > lockdep_recursion_finish() helper here?
> 
> I chose to only add that to the sites that check recursion on entry.

Makes sense, thank you Peter.

 - Joel

