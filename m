Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B3EC433FE
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 08:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DCD223A79
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 08:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgLHI55 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Dec 2020 03:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgLHI55 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Dec 2020 03:57:57 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E39C061749;
        Tue,  8 Dec 2020 00:57:17 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id t8so13290204pfg.8;
        Tue, 08 Dec 2020 00:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dHXM39H5tX8WYsUDBFgFUzws2OiQRzv4RNf97EmRG0o=;
        b=cCVRTX+BHDSkkB8GSVYqpNfJFUwOz4G7vylifeNU1+A77ERgGl181X50s2x/K8GnWn
         m1dpt6LXCddO1r/MSy74sLXm9IXeExO7au4B7reU7OR/sTgmsKDVqOqWgYvPWqnUcJU9
         pruiTMrOewR4eeXNbmQj7axHdmFKA46M1L6FIg3wsoqzP0ncZPEYZBVytOLzNdhLDlpX
         JKWK6RoTz7ZQsAC54+pQh0sr42qC6subfKfPA6Ps3VO+G6BKCkeYNKEKNcCVSadslymr
         8+uWtxWYIqZkSBNifp9jPXQUgPT8JSj95UKhMRXAaafF/Cnc16L829B7pilHjcAsO0NG
         uOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dHXM39H5tX8WYsUDBFgFUzws2OiQRzv4RNf97EmRG0o=;
        b=eo0RzYwoXKIgJcssfUhbPtgoiSwLC6fciXbIXb5K78s7PkJPznkzF91Ks3X2GF1pqu
         ZDF9u43bj0Z1ZgJmzW+1tJI6ar8x+iCk0gpEpPQMvDk6gXm74myUqEs2+edi3t00Ldu4
         xnJIB2LmubHW3wAn473bR2+xMmz3xXVra+9fqFaIWtjTcKAx1e7Hmuc1P81GAp3OdIrL
         JtLVzy2OjGE4aiVZocOdOmHlt/buucQCJmsW+cldrHkDLJQ9OTpLJ9WfRwWcW0LSVR8a
         ey9VIgaifMR/NL3I9YXaV7dGAvAuO/EklzvjAvHvg3fPGH32JbUsuo/EcIGmftm3tAyB
         PAXQ==
X-Gm-Message-State: AOAM530p7YLnwUNYPu2vIAvI2Nb8xNygxefU1QnlP+JkHaml7E38vebY
        q67rMstVwmIZR+9O/q5Afcw=
X-Google-Smtp-Source: ABdhPJy4YOWy6psmuKqxBhqPKTs9txXFSTAH5qM0bQrm6DF2ecBRDAyDJM/gjquTcPsI4uqbWD5uYA==
X-Received: by 2002:a05:6a00:1593:b029:198:195:4d93 with SMTP id u19-20020a056a001593b029019801954d93mr19789417pfk.32.1607417836564;
        Tue, 08 Dec 2020 00:57:16 -0800 (PST)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id y10sm2122384pjm.34.2020.12.08.00.57.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 00:57:16 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:57:07 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20201208085653.GA26940@js1304-desktop>
References: <20201205004022.GA31166@paulmck-ThinkPad-P72>
 <20201205004057.32199-1-paulmck@kernel.org>
 <20201207090243.GA20765@js1304-desktop>
 <20201207172554.GI2657@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207172554.GI2657@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Dec 07, 2020 at 09:25:54AM -0800, Paul E. McKenney wrote:
> On Mon, Dec 07, 2020 at 06:02:53PM +0900, Joonsoo Kim wrote:
> > Hello, Paul.
> > 
> > On Fri, Dec 04, 2020 at 04:40:52PM -0800, paulmck@kernel.org wrote:
> > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > 
> > > There are kernel facilities such as per-CPU reference counts that give
> > > error messages in generic handlers or callbacks, whose messages are
> > > unenlightening.  In the case of per-CPU reference-count underflow, this
> > > is not a problem when creating a new use of this facility because in that
> > > case the bug is almost certainly in the code implementing that new use.
> > > However, trouble arises when deploying across many systems, which might
> > > exercise corner cases that were not seen during development and testing.
> > > Here, it would be really nice to get some kind of hint as to which of
> > > several uses the underflow was caused by.
> > > 
> > > This commit therefore exposes a new kmem_last_alloc() function that
> > > takes a pointer to dynamically allocated memory and returns the return
> > > address of the call that allocated it.  This pointer can reference the
> > > middle of the block as well as the beginning of the block, as needed
> > > by things like RCU callback functions and timer handlers that might not
> > > know where the beginning of the memory block is.  These functions and
> > > handlers can use the return value from kmem_last_alloc() to give the
> > > kernel hacker a better hint as to where the problem might lie.
> > 
> > I agree with exposing allocation caller information to the other
> > subsystem to help the debugging. Some suggestions...
> 
> Good to hear!  ;-)
> 
> > 1. It's better to separate a slab object check (validity check) and
> > retrieving the allocation caller. Someone else would want to check
> > only a validity. And, it doesn't depend on the debug configuration so
> > it's not good to bind it to the debug function.
> > 
> > kmem_cache_valid_(obj|ptr)
> > kmalloc_valid_(obj|ptr)
> 
> Here both functions would say "true" for a pointer from kmalloc()?
> Or do I need to add a third function that is happy with a pointer from
> either source?

I focused on separation and missed this case that the user sometimes
cannot know the object source (kmalloc/kmem_cache). At first step,
just checking whether it is a slab-object or not looks enough.

int kmem_valid_obj()

> 
> I do understand that people who don't want to distinguish could just do
> "kmem_cache_valid_ptr(p) || kmalloc_valid_ptr(p)".  However, the two
> use cases in the series have no idea whether the pointer they have came
> from kmalloc(), kmem_cache_alloc(), or somewhere else entirely, even an
> on-stack variable.
> 
> Are you asking me to choose between the _obj() and _ptr() suffixes?

Yes, I prefer _obj().

> If not, please help me understand the distinction.
> 
> Do we want "debug" in these names as well?

I don't think so since it can be called without enabling the debug
option.

> 
> > 2. rename kmem_last_alloc to ...
> > 
> > int kmem_cache_debug_alloc_caller(cache, obj, &ret_addr)
> > int kmalloc_debug_alloc_caller(obj, &ret_addr)
> > 
> > or debug_kmem_cache_alloc_caller()
> > 
> > I think that function name need to include the keyword 'debug' to show
> > itself as a debugging facility (enabled at the debugging). And, return
> > errno and get caller address by pointer argument.
> 
> I am quite happy to add the "debug", but my use cases have no idea
> how the pointer was allocated.  In fact, the next version of the
> patch will also handle allocator return addresses from vmalloc().
> 
> And for kernels without sufficient debug enabled, I need to provide
> the name of the slab cache, and this also is to be in the next version.

Okay. So, your code would be...

if (kmem_valid_obj(ptr))
        kmalloc_debug_print_provenance(ptr)
else if (vmalloc_valid_obj(ptr))
        ....

> > 3. If concrete error message is needed, please introduce more functions.
> > 
> > void *kmalloc_debug_error(errno)
> 
> Agreed, in fact, I was planning to have a function that printed out
> a suitable error-message continuation to the console for ease-of-use
> reasons.  For example, why is the caller deciding how deep the stack
> frame is?  ;-)
> 
> So something like this?
> 
> 	void kmalloc_debug_print_provenance(void *ptr);
> 
> With the understanding that it will print something helpful regardless
> of where ptr came from, within the constraints of the kernel build and
> boot options?

Looks good idea. I suggest a name, kmem_dump_obj(), for this function.
In this case, I don't think that "debug" keyword is needed since it shows
something useful (slab cache info) even if debug option isn't enabled.

So, for summary, we need to introduce two functions to accomplish your
purpose. Please correct me if wrong.

int kmem_valid_obj(ptr)
void kmem_dump_obj(ptr)

Thanks.
