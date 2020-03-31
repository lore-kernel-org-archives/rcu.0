Return-Path: <SRS0=gdpO=5Q=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2579BC2D0F1
	for <rcu@archiver.kernel.org>; Tue, 31 Mar 2020 15:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5DB20848
	for <rcu@archiver.kernel.org>; Tue, 31 Mar 2020 15:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585668897;
	bh=Eif2B2ShIJpPgxuw/zOevzktekR3iUQpQKzn/Ra8G2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xf8X2axITyUbKuIcEk0MW/S+v72gvjqdDPWAsrDMLgikh0aYJdR7rigIU7mID7Kp4
	 HQRWmlmuqsvj4hfwwWc7e6YRAw6Hb9Kp6nZXkBzRlE11h2slS861FjhJSkbn7u9mtH
	 msKErtqHfYHyPADlGms3jWowLm8v9azrzgie0vwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgCaPe4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:34:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37092 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbgCaPe4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 31 Mar 2020 11:34:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so26622397wrm.4;
        Tue, 31 Mar 2020 08:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XWJpdT6ZsPCOgPe98UycjXxzkHnMVRDPn15M3ka7UM4=;
        b=hJC3ikGApOoNVaBpATr/c//jIQhLRz3dLmRCnVFYqgu7FVyS4YiJFeY62OsWo98YJf
         A4tyFC8wI3jBcskCdWZ2/Z7JugjIHs+eUtP5Bw7/ncHtzt9URqUV5meF+FPm/aa/S5NO
         MqTOTWYKHjyvHuqwwaiiftNpLM1SElthOXOnGYJqbDC9iP/9zN93qYW+M2ErLeFj4g2J
         itVhMdbWmMWWRbi4JpkxRjXO+66ZaAG7tKkU63yUERCiTq4y2IWhPP5i7F4OBmyxgU62
         c+PE/qSixFr7JqWiQdVjKJg2V03O+cbxZ6ZcP2hfqgEc+8oxnVW/L+c2VAWNbI4Sxdw1
         0PvQ==
X-Gm-Message-State: ANhLgQ3NFqv3xDGP8WlyLgVhPuCIuh06Pc5Nl/HD7zvMoxHRbhZZs23D
        zyl2Y0p+xWzhLlmwx3lENWA=
X-Google-Smtp-Source: ADFU+vtOC9s0hgunzjXryLDkoY30klCWAusuNW8kiJdYJ6kgbFjbK79bnAt6gZ6I6SlD2xgVK1GhVQ==
X-Received: by 2002:adf:ef08:: with SMTP id e8mr22284875wro.66.1585668894424;
        Tue, 31 Mar 2020 08:34:54 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id o16sm24444126wrw.75.2020.03.31.08.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 08:34:53 -0700 (PDT)
Date:   Tue, 31 Mar 2020 17:34:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200331153450.GM30449@dhcp22.suse.cz>
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331145806.GB236678@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331145806.GB236678@google.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue 31-03-20 10:58:06, Joel Fernandes wrote:
[...]
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 4be763355c9fb..965deefffdd58 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3149,7 +3149,7 @@ static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
> >  
> >  	if (!ptr)
> >  		ptr = kmalloc(sizeof(unsigned long *) +
> > -				sizeof(struct rcu_head), GFP_ATOMIC | __GFP_NOWARN);
> > +				sizeof(struct rcu_head), GFP_MEMALLOC);
> 
> Just to add, the main requirements here are:
> 1. Allocation should be bounded in time.
> 2. Allocation should try hard (possibly tapping into reserves)
> 3. Sleeping is Ok but should not affect the time bound.


__GFP_ATOMIC | __GFP_HIGH is the way to get an additional access to
memory reserves regarless of the sleeping status.

Using __GFP_MEMALLOC is quite dangerous because it can deplete _all_ the
memory. What does prevent the above code path to do that?
If a partial access to reserves is sufficient then why the existing
modifiers (mentioned above are not sufficient?
-- 
Michal Hocko
SUSE Labs
