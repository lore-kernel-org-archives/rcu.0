Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CBEC4167B
	for <rcu@archiver.kernel.org>; Mon,  7 Dec 2020 09:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1381A2311B
	for <rcu@archiver.kernel.org>; Mon,  7 Dec 2020 09:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgLGJDl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Dec 2020 04:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgLGJDl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Dec 2020 04:03:41 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015F8C0613D1;
        Mon,  7 Dec 2020 01:03:04 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id e23so8328388pgk.12;
        Mon, 07 Dec 2020 01:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MHWu3vtUz9+sanKifpsQifJGmOgcbrGzDyPpGK8ft/8=;
        b=kIlwtaVgUwEdCxp+IvjS7KCjaf2cg33M1dvudJSOT+GDqjxGnywDiJEFxS/N91bokB
         dYwRcZX46eqEM/X+hh9dgrGaeNmY4JAqsSqAYOrY5GTuVnqf4+OICv4D5deglMok+sh0
         IJQlEVwXlKzIgevhEtUBujBAaAtXA3oAflSi4lWGXNi+lGK+35VxLDhfCwHtOSZnqN+e
         k96O6UkjHMIiEcuiYXta/iGXMokuJXGnmxQKsJOoYwy6IGGXc340rWJmFwA2mYZ6jI7X
         UMwNFDOXL3RbSlkn8WqIG3QTXhECzVzF6Vk1ezeazPeLbBMV7/rp1JT6XhKyW/oG0j00
         YfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MHWu3vtUz9+sanKifpsQifJGmOgcbrGzDyPpGK8ft/8=;
        b=cIa+qKGyKc0GNa6X0lBdwZFAGzGCAcSs2plEMjFPs/B3V++v8pbXzZN8xe1VaYNOK+
         e2+asY6QqjIjVsP3H3BNSeVS1wmgVmzFlpuYDMm41EGsQb+86gzSIuV2xHQgGRXzmV0H
         UQzzVLrs/FCGgmo2YllbkwXAjosPgJRrdZ7UrHazOT4HI2/rTVnSNJ3RXOn3hnNXJBwl
         L7I86ylryFbSs9qgc53L7JAE07WdmsKNVLMWpXGylj5U9BzbryuA3GzRgQuPQcln0BUu
         Exn+15EnRrEkCXtxeXsRx/wd0WaVnp78CMa4tcjKxhBhTABvgx6/aD0lrP97v/gchEao
         9AkA==
X-Gm-Message-State: AOAM530lZhuSE5xydPoBAlP0/4PleE3i9Obpjh80tVly3Kk28Zxv5N8d
        5Rn5uJE44nHgpeChm2qgDB1nc4qL7bNv8w==
X-Google-Smtp-Source: ABdhPJwPZ6U1ffJOj91ZlD0tLv3OUKPUk/dVyEpFXre7GtCcrZ2+BroVuRTQ4WR5LpDDxNl+omoENA==
X-Received: by 2002:a65:6857:: with SMTP id q23mr6187536pgt.441.1607331783519;
        Mon, 07 Dec 2020 01:03:03 -0800 (PST)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id p6sm9854309pjt.13.2020.12.07.01.02.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 01:03:03 -0800 (PST)
Date:   Mon, 7 Dec 2020 18:02:53 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Subject: Re: [PATCH sl-b 1/6] mm: Add kmem_last_alloc() to return last
 allocation for memory block
Message-ID: <20201207090243.GA20765@js1304-desktop>
References: <20201205004022.GA31166@paulmck-ThinkPad-P72>
 <20201205004057.32199-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205004057.32199-1-paulmck@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Paul.

On Fri, Dec 04, 2020 at 04:40:52PM -0800, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> There are kernel facilities such as per-CPU reference counts that give
> error messages in generic handlers or callbacks, whose messages are
> unenlightening.  In the case of per-CPU reference-count underflow, this
> is not a problem when creating a new use of this facility because in that
> case the bug is almost certainly in the code implementing that new use.
> However, trouble arises when deploying across many systems, which might
> exercise corner cases that were not seen during development and testing.
> Here, it would be really nice to get some kind of hint as to which of
> several uses the underflow was caused by.
> 
> This commit therefore exposes a new kmem_last_alloc() function that
> takes a pointer to dynamically allocated memory and returns the return
> address of the call that allocated it.  This pointer can reference the
> middle of the block as well as the beginning of the block, as needed
> by things like RCU callback functions and timer handlers that might not
> know where the beginning of the memory block is.  These functions and
> handlers can use the return value from kmem_last_alloc() to give the
> kernel hacker a better hint as to where the problem might lie.

I agree with exposing allocation caller information to the other
subsystem to help the debugging. Some suggestions...

1. It's better to separate a slab object check (validity check) and
retrieving the allocation caller. Someone else would want to check
only a validity. And, it doesn't depend on the debug configuration so
it's not good to bind it to the debug function.

kmem_cache_valid_(obj|ptr)
kmalloc_valid_(obj|ptr)

2. rename kmem_last_alloc to ...

int kmem_cache_debug_alloc_caller(cache, obj, &ret_addr)
int kmalloc_debug_alloc_caller(obj, &ret_addr)

or debug_kmem_cache_alloc_caller()

I think that function name need to include the keyword 'debug' to show
itself as a debugging facility (enabled at the debugging). And, return
errno and get caller address by pointer argument.

3. If concrete error message is needed, please introduce more functions.

void *kmalloc_debug_error(errno)

Thanks.
