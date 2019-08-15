Return-Path: <SRS0=ayKe=WL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1274FC3A589
	for <rcu@archiver.kernel.org>; Thu, 15 Aug 2019 15:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87FF20644
	for <rcu@archiver.kernel.org>; Thu, 15 Aug 2019 15:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="p/rcF9HU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfHOPZB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Aug 2019 11:25:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34444 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfHOPZB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Aug 2019 11:25:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id b24so1509645pfp.1
        for <rcu@vger.kernel.org>; Thu, 15 Aug 2019 08:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/HAVtRJ1PsEuTkAUc5sMbDf7NKx2+25/4sGFjK/yLmI=;
        b=p/rcF9HUaxokqqtlBD6cRzMqVS5aMb26xsT8XFZesE6GelXE2agrxezh39Oeg+hfGB
         xAvaausfSkZJetZST//O1oxgq4aGZkjqemfeRnMo4W7+ZZ/erzX1F6adVqpbB+c90m3Q
         V99zTMJqa9vfT5ucEAHWnJZ1WQ+Mn9yRvzAIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/HAVtRJ1PsEuTkAUc5sMbDf7NKx2+25/4sGFjK/yLmI=;
        b=VrkGTxHhAIne/ZEqRrq15DDBw+mMkpna5qMiQPTen8bAusH00KszJHMmDP27xuhf96
         2fDizzoPPvwKxgE+pIi40ngDDe/8sBoV9vu4sj2XVmz63g0SHBFli6VZJuOrZ3mzjNLN
         0ZJe5pfX0EFeB9khdTXQYUGdnoFQE3+qL3EH/CT+FypHtCtp3IRQpDBH7LbAJ85pLEVH
         +yuMXuJFeq003b2D5RSajiKGI7z8fvN4Ry7k1XAvBGYqiSNGS54xs0LsmB3qH6wrReCM
         9lOjKN8Ikk9hjQFP2Hs8i8OZ30SzYADDSFNxmiqxB+FLWy4mHkZMpCGn2YQ0alEWtpCF
         P6hg==
X-Gm-Message-State: APjAAAX+fZmz4dxfNYdOAJExgz7ilm+xd6Yp+i+yqI8VNA/UO4PiHV8q
        Sw3yhIWQtWN1JnSwAEP9RQTm0Q==
X-Google-Smtp-Source: APXvYqzGZZp0X2UruoJmPDipoLHodoHbSAODCUTEnrhBXIUOdW+725CS6Bq9Bv2QKCuiId8iQb2BGw==
X-Received: by 2002:a17:90a:a489:: with SMTP id z9mr2679120pjp.24.1565882700049;
        Thu, 15 Aug 2019 08:25:00 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id k6sm3082851pfi.12.2019.08.15.08.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 08:24:59 -0700 (PDT)
Date:   Thu, 15 Aug 2019 11:24:42 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 -rcu] workqueue: Convert for_each_wq to use built-in
 list check
Message-ID: <20190815152442.GB12078@google.com>
References: <20190815141842.GB20599@google.com>
 <20190815145749.GA18474@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815145749.GA18474@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 15, 2019 at 07:57:49AM -0700, Matthew Wilcox wrote:
> On Thu, Aug 15, 2019 at 10:18:42AM -0400, Joel Fernandes (Google) wrote:
> > list_for_each_entry_rcu now has support to check for RCU reader sections
> > as well as lock. Just use the support in it, instead of explicitly
> > checking in the caller.
> 
> ...
> 
> >  #define assert_rcu_or_wq_mutex_or_pool_mutex(wq)			\
> >  	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
> >  			 !lockdep_is_held(&wq->mutex) &&		\
> 
> Can't you also get rid of this macro?

Could be. But that should be a different patch. I am only cleaning up the RCU
list lockdep checking in this series since the series introduces that
concept).  Please feel free to send a patch for the same.

Arguably, keeping the macro around also can be beneficial in the future.

> It's used in one place:
> 
> static struct pool_workqueue *unbound_pwq_by_node(struct workqueue_struct *wq,
>                                                   int node)
> {
>         assert_rcu_or_wq_mutex_or_pool_mutex(wq);
> 
>         /*
>          * XXX: @node can be NUMA_NO_NODE if CPU goes offline while a
>          * delayed item is pending.  The plan is to keep CPU -> NODE
>          * mapping valid and stable across CPU on/offlines.  Once that
>          * happens, this workaround can be removed.
>          */
>         if (unlikely(node == NUMA_NO_NODE))
>                 return wq->dfl_pwq;
> 
>         return rcu_dereference_raw(wq->numa_pwq_tbl[node]);
> }
> 
> Shouldn't we delete that assert and use
> 
> +	return rcu_dereference_check(wq->numa_pwq_tbl[node],
> +			lockdep_is_held(&wq->mutex) ||
> +			lockdep_is_held(&wq_pool_mutex));

Makes sense. This API also does sparse checking. Also hopefully no sparse
issues show up because rcu_dereference_check() but anyone such issues should
be fixed as well.

thanks,

 - Joel

> 
