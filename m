Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01DDC433ED
	for <rcu@archiver.kernel.org>; Wed, 21 Apr 2021 15:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 724C46144D
	for <rcu@archiver.kernel.org>; Wed, 21 Apr 2021 15:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241103AbhDUP6W (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Apr 2021 11:58:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235524AbhDUP6V (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Apr 2021 11:58:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52D0D6144B;
        Wed, 21 Apr 2021 15:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619020668;
        bh=GDHTx2Ati79aaQDh5rPmeZsQfiHr4Gx4DzLeFLm/spM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AEDzDw9opEABVJro9JzkhQbRoqsUaPeb59uxeK7aiFy+oHL7XlbFz2UJSOWu/mlgj
         krG0UQ8vDS1K6j5RwShDOkp+dNS48k4qRz4blK1gsCNIo27iys2GGcvJ2Ybzxn2FKE
         FYoTOCPyaQKEK/i/+lRNlOWdZovy+cwWe/ZDUyK2O23pRm51+gnw3CwRY71+c3mRYb
         Owa+VwHzl/KSZMZZRR1eQWoP7yB0J7nlixwK5k3754PT3/zHnDVGRfPXJ5RrWza1VS
         POfwsi5ABoN5qgkZhEHmsX4inFuaT/OL37lHHE0U609Mgci2sdzKOCttdtqw536mCC
         ReHXt903vgWIw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0FC4C5C0267; Wed, 21 Apr 2021 08:57:48 -0700 (PDT)
Date:   Wed, 21 Apr 2021 08:57:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 1/2] bitmap_parse: support 'all' semantics
Message-ID: <20210421155748.GU975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210421031326.72816-1-yury.norov@gmail.com>
 <20210421031326.72816-2-yury.norov@gmail.com>
 <20210421111932.36665920@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421111932.36665920@gandalf.local.home>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 21, 2021 at 11:19:32AM -0400, Steven Rostedt wrote:
> On Tue, 20 Apr 2021 20:13:25 -0700
> Yury Norov <yury.norov@gmail.com> wrote:
> 
> > @@ -76,6 +76,11 @@ to change, such as less cores in the CPU list, then N and any ranges using N
> >  will also change.  Use the same on a small 4 core system, and "16-N" becomes
> >  "16-3" and now the same boot input will be flagged as invalid (start > end).
> >  
> > +The special case-tolerant group name "all" has a meaning of selecting all CPUs,
> > +such that "isolcpus=all" is the equivalent of "isolcpus=0-N".
> 
> I'm OK with the concept of this patch set, but really? That is a horrible
> example. One should NEVER set isolcpus to all!

How about "isolcpus=all:2/4"?  ;-)

							Thanx, Paul

> -- Steve
> 
> 
> > +
> > +The semantics of "N" and "all" is supported on a level of bitmaps and holds for
> > +all users of bitmap_parse().
> >  
