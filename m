Return-Path: <SRS0=AG5q=6E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629C4C3815B
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 17:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41DBA20672
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 17:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebxYYa+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgDTRSm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726751AbgDTRSl (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 20 Apr 2020 13:18:41 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE75C061A0C;
        Mon, 20 Apr 2020 10:18:41 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h6so8666190lfc.0;
        Mon, 20 Apr 2020 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VYMaDUupuu+1XZmez9TH2RnYxrJx8PLxzhd/hOM9XLg=;
        b=ebxYYa+hhfOgD88yosIaS2Gd5P11+ADinW4n/RC3+sDxyECrvyeOSjJZ79pJddcV/h
         5CtgoZwuyl1UmpgJ83/sed4sIuMdDWf0/u+WcaW0OP+VrhRfHNz37h9kGFF9Imx+R0yZ
         4PlkOwBw4C4XwBaM18zxY8VH7pfNobOfUbvT4dsK9o5dS930oD4Irq0lQQU8NcEiUZ7m
         Ow6QSHfxHMqNU7Fxv4DJGSafPimYSD1uPU5Y/OfBzLW7gzdGsb8G4uM/WSJEWud8egdR
         td67JXAyOBbuqJM/mKTqU8y1R6UQoYHma8kuPhkzJ9laAUgcr6UkaTjlw1pZ/y/enVQB
         jj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VYMaDUupuu+1XZmez9TH2RnYxrJx8PLxzhd/hOM9XLg=;
        b=h55B721p/rXtS9RyPqOntbMa19fQhl4CSvPHhzQH3UM3S4Ge5cxaB4v0nxadiYjSE7
         m4s4iDPpkDXhBb7iZZd39Ce9+5tamms+wxE6R6fVBoQeZpxdJV2+O9pTfve//IEH+D/c
         +jN2lpoqsmzU2gmRn6SaF8lSh+WdGJGUgavuo5Qfy7uBCcooM8QiaewMPMgQW1U0v1j/
         NtOGrtcwOPkHqSrbLQMv5NMwtraHFLEK9Vo2NCw4UvJAjVDcistS9DPqXnZ+0Fypbwi5
         p+m2nQfByXzRXOP5rdr4FDWEvryOio2VI+twIQDA6xC42dQOOSJ58hHcx+7mM8PhoxFf
         jllQ==
X-Gm-Message-State: AGi0PuYTA5xmZB8q1Jtuc6UkT3i7CqCcbDYJNZeL6n7DqNi5v0apyg1p
        iCLQBrfKDJp7jMuR7kCNu3FROA9ml3VE8A==
X-Google-Smtp-Source: APiQypLNTg/SiKTEzKZlqNGzEbM6+CiM/nl6TiWhzvpUvLVX7sxorgQsFFur+IMGuKb6KoyVaaRr1g==
X-Received: by 2002:a19:f518:: with SMTP id j24mr11493715lfb.205.1587403119810;
        Mon, 20 Apr 2020 10:18:39 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id h22sm38312ljl.96.2020.04.20.10.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 10:18:38 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 20 Apr 2020 19:18:29 +0200
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, urezki@gmail.com
Subject: Re: [PATCH rcu/dev -fixes 3/4] rcu/tree: Avoid using xchg() in
 kfree_call_rcu_add_ptr_to_bulk()
Message-ID: <20200420171829.GA12196@pc636>
References: <20200420153837.194532-1-joel@joelfernandes.org>
 <20200420153837.194532-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420153837.194532-4-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Apr 20, 2020 at 11:38:36AM -0400, Joel Fernandes (Google) wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> There is no need to use xchg(), the access is serialized by krcp->lock.
> The xchg() function adds some atomic barriers which remain hidden in
> x86's disassembly but are visible on ARM for instance.
> 
> Replace xchg() with a load + store.
> 
> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/rcu/tree.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index cd61649e1b001..f6eb3aee0935e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3088,7 +3088,8 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
>  	/* Check if a new block is required. */
>  	if (!krcp->bhead ||
>  			krcp->bhead->nr_records == KFREE_BULK_MAX_ENTR) {
> -		bnode = xchg(&krcp->bcached, NULL);
> +		bnode = krcp->bcached;
> +		krcp->bcached = NULL;
>  		if (!bnode) {
>  			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
>  
>
But we populate the cache without holding the krcp->lock. That is why it
is xchg here. See below:

<snip>
  if (cmpxchg(&krcp->bcached, NULL, bhead))
     free_page((unsigned long) bhead);
<snip>

we do not hold any krcp->lock here, we do not need it.

--
Vlad Rezki
