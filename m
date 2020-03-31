Return-Path: <SRS0=gdpO=5Q=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024DDC43331
	for <rcu@archiver.kernel.org>; Tue, 31 Mar 2020 14:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C784D2078B
	for <rcu@archiver.kernel.org>; Tue, 31 Mar 2020 14:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kX2+YjEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbgCaO6I (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:58:08 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43189 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbgCaO6I (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 31 Mar 2020 10:58:08 -0400
Received: by mail-qk1-f193.google.com with SMTP id o10so23225244qki.10
        for <rcu@vger.kernel.org>; Tue, 31 Mar 2020 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cIZTwSTovCqpZjcH+8VKON/BYcVXt4dyLFHN/7fWLC0=;
        b=kX2+YjEFA7reVl0nZqgetW7HHWs3WBI8tDuovxTjTwwVwqW3601QSEjGEsCGuePVj7
         LeJYnQq9IpkrFubdFv7FGPJwARcYAe9R6jylxk3Pa+7d/tXkyxj20UwItvKvKi6iEgdm
         3Bb9hGRRxwfEbpNgz5aR7L0gIR2HceLIlhu8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cIZTwSTovCqpZjcH+8VKON/BYcVXt4dyLFHN/7fWLC0=;
        b=B9g8S3wWU6BQ0+8J2IAfFNES90Pcjdu7PvytrbVaxs+dz+q84WOaCrYgEV3IqjMthV
         dLQYfCw7BMqoFyZYYBsyKAzf4Fx9bgIhHvVygI0bJ5BBZaG4bH7/OvNRlRoGqY7YtCFG
         TrxFkPBZfF5z9MwGpnJnFC3hw7fRP9ivwDwa8LBEmaK/Eec1yKTSvibjG3WW1SpVClkm
         /4UuAS5R9KFmYHERPQEVW7qnVrdYqUlEhzhR0sjIskY84kQRT7OkyPMuFECwb/OjlbEe
         ja8B53wCfC/kgkL18rQx+0FWX6DwEG/zCLNXbNoq3Nz/gpi8Mult07zPqAHMqO+0wvVY
         paoQ==
X-Gm-Message-State: ANhLgQ2KsVkoFHlmun17uu9LjrU3cUDZ7mz81ADkGQfgrGDC7zPThuZA
        PhWkQl2l0YoLLa9Vyxw7yDqc5Q==
X-Google-Smtp-Source: ADFU+vvPtFUJr9gLEzw5E54meLVFZylfDHn2cwkCKpLYfEDzB9hmFVGY0wKdA27LYbe+/zml0iNEug==
X-Received: by 2002:a37:a4d6:: with SMTP id n205mr5467313qke.352.1585666687349;
        Tue, 31 Mar 2020 07:58:07 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n142sm12693714qkn.11.2020.03.31.07.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 07:58:06 -0700 (PDT)
Date:   Tue, 31 Mar 2020 10:58:06 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, rcu@vger.kernel.org, willy@infradead.org,
        peterz@infradead.org, neilb@suse.com, vbabka@suse.cz,
        mgorman@suse.de, Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200331145806.GB236678@google.com>
References: <20200331131628.153118-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331131628.153118-1-joel@joelfernandes.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Mar 31, 2020 at 09:16:28AM -0400, Joel Fernandes (Google) wrote:
> In kfree_rcu() headless implementation (where the caller need not pass
> an rcu_head, but rather directly pass a pointer to an object), we have
> a fall-back where we allocate a rcu_head wrapper for the caller (not the
> common case). This brings the pattern of needing to allocate some memory
> to free some memory.  Currently we use GFP_ATOMIC flag to try harder for
> this allocation, however the GFP_MEMALLOC flag is more tailored to this
> pattern. We need to try harder not only during atomic context, but also
> during non-atomic context anyway. So use the GFP_MEMALLOC flag instead.
> 
> Also remove the __GFP_NOWARN flag simply because although we do have a
> synchronize_rcu() fallback for absolutely worst case, we still would
> like to not enter that path and atleast trigger a warning to the user.
> 
> Cc: linux-mm@kvack.org
> Cc: rcu@vger.kernel.org
> Cc: willy@infradead.org
> Cc: peterz@infradead.org
> Cc: neilb@suse.com
> Cc: vbabka@suse.cz
> Cc: mgorman@suse.de
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> 
> This patch is based on the (not yet upstream) code in:
> git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (branch rcu/kfree)
> 
> It is a follow-up to the posted series:
> https://lore.kernel.org/lkml/20200330023248.164994-1-joel@joelfernandes.org/
> 
> 
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 4be763355c9fb..965deefffdd58 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3149,7 +3149,7 @@ static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
>  
>  	if (!ptr)
>  		ptr = kmalloc(sizeof(unsigned long *) +
> -				sizeof(struct rcu_head), GFP_ATOMIC | __GFP_NOWARN);
> +				sizeof(struct rcu_head), GFP_MEMALLOC);

Just to add, the main requirements here are:
1. Allocation should be bounded in time.
2. Allocation should try hard (possibly tapping into reserves)
3. Sleeping is Ok but should not affect the time bound.

Considering this, GFP_MEMALLOC|GFP_NOWAIT seems appropriate. Thoughts?

thanks,

 - Joel


