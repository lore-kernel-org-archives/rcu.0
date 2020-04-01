Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210CFC2D0F0
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 13:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70CB2073B
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 13:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Chcf0o+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732635AbgDANXK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:23:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36801 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732289AbgDANXJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 09:23:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id w145so1269628lff.3;
        Wed, 01 Apr 2020 06:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x+0+LY1hYid8SN3qoqXgUaMr5zJLkCBGndVrhVygy6s=;
        b=Chcf0o+1x+pHXlHz3a+Of7l1Fb/v7AlLTSaW8A+lrJMq3PW+0BUZMUBsmwYUyUYs2w
         Pc6vmF5cFBAHyoOz6hWDtfa3cqQIa6zOBjUjDyHbxtMKv8lrzYESLc3W8OjupBMhCLIb
         CSqWBuSd310VTAJPcXwDLGi79qx7mwz3ab8IwfHUdRK5SRz0Cd2kSDSmuG8+YC0+z9j2
         JWfATYzgpLCOEpl/BYkEWHkSfUZ5J39gCGLJeWeuFiDD5pAHrC0ad9R2NRHr1SndCIhQ
         uM3Gqek1l1BUq1oq+tbzkmtfZtS1PIIyqQ/hh3xGFVYI7xX9IPiJZhbUUAO8TeXRy59K
         E/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x+0+LY1hYid8SN3qoqXgUaMr5zJLkCBGndVrhVygy6s=;
        b=Fz84fvBEUJhiXahwSRo4htHwhtmbyizkLoW2/1HwdMS2oYrzdZ7HrkfN7xryCbc7yt
         XoHe6QYbBn+7hqbKkKZXMUlZl903vCmiJV22zsybyvgoQRkh7oq25MnxU78NwxSn2+7C
         3rnWjy3kPQYgC/TT4zAgXKB9bO7PfXdgxYr/pXJMPAHyo5OpMve0LzdVTGnef8KrKlRR
         gG1DD3g8Q5YPxpbgYZ4RSnNAyeuulG9+tij/NRSYEFrw1EbzESMOZshk0mru+FKei5gy
         m3924TWvP6jZDDmkUXwU88nBFjSYMRYjjNl/7LfcfP5dXVYa1QpTL30nTqLjDbgBEVli
         ylhQ==
X-Gm-Message-State: AGi0PuYr6m6J4/Gmk9+TSdlwLaQ1DNNH7RjQL4iJEQOOnuFyhWMPHGO/
        K0yeh9JMZnu3OCJgyWCvZMA=
X-Google-Smtp-Source: APiQypK98HgdlqS/OKFCL75PGkc3IGwL4tt2n4fedmuIGaEQIEEHCY+drgiyhExwvtjaCRjkEnP/qA==
X-Received: by 2002:a19:3f47:: with SMTP id m68mr14640157lfa.210.1585747386899;
        Wed, 01 Apr 2020 06:23:06 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id 24sm1183836ljv.105.2020.04.01.06.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 06:23:06 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 1 Apr 2020 15:22:58 +0200
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
Message-ID: <20200401132258.GA1953@pc636>
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331145806.GB236678@google.com>
 <20200331153450.GM30449@dhcp22.suse.cz>
 <20200331161215.GA27676@pc636>
 <20200401070958.GB22681@dhcp22.suse.cz>
 <20200401123230.GB32593@pc636>
 <20200401125503.GJ22681@dhcp22.suse.cz>
 <20200401130816.GA1320@pc636>
 <20200401131528.GK22681@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401131528.GK22681@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > We call it from atomic context, so we can not sleep, also we do not have
> > any existing context coming from the caller. I see that GFP_ATOMIC is high-level
> > flag and is differ from __GFP_ATOMIC. It is defined as:
> > 
> > #define GFP_ATOMIC (__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM)
> > 
> > so basically we would like to have __GFP_KSWAPD_RECLAIM that is included in it,
> > because it will also help in case of high memory pressure and wake-up kswapd to
> > reclaim memory.
> > 
> > We also can extract:
> > 
> > __GFP_ATOMIC | __GFP_HIGH | __GFP_RETRY_MAYFAIL | __GFP_KSWAPD_RECLAIM
> > 
> > but that is longer then
> > 
> > GFP_ATMOC |  __GFP_RETRY_MAYFAIL
> 
> OK, if you are always in the atomic context then GFP_ATOMIC is
> sufficient. __GFP_RETRY_MAYFAIL will make no difference for allocations
> which do not reclaim (and thus not retry). Sorry this was not clear to
> me from the previous description.
> 
Ahh. OK. Then adding __GFP_RETRY_MAYFAIL to GFP_ATOMIC will not make any effect.

Thank you for your explanation!

--
Vlad Rezki
