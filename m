Return-Path: <SRS0=IXig=5B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F12C18E5B
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 13:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3D02051A
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 13:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G42P68L1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbgCPNzN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 09:55:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48928 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731110AbgCPNzN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 09:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WEBG3nIg5bRO/ndpNpdjvppQegv8JGgyyt7RDg3n9BA=; b=G42P68L1AVx/huDT3DLmA5JN+R
        T9nK0j8g2tIhO+d+7Kq90Oabd+k2yKREMXg4WYN1OrgaB7okGszUsGuSn/OEjIFY2Qf6qAsnr4lHE
        gnut877TQ4yK4893v0WhkXkigpKr2NlBpIZygt/mmbGcKoMnsiXHnk+hFHrO6XG0WzmVhWcKkL/mD
        klD0+jzJF4ttIx932LKWpLPPRNswCysyDAD6vr/tZ3uDWqw1UaO58gK7k93FAU6IK7JfE93lpcPTt
        2CcZGdh+piCS5+Uf/3xe5N/TNWjbtPH1EdD7jnlFmnht8D33wSrnAm6UKjgF1bsLmsfSJ5sgLVMaA
        vqrRm3GQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDqCz-0007ub-Qa; Mon, 16 Mar 2020 13:55:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3B7530138D;
        Mon, 16 Mar 2020 14:55:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE7B820B16492; Mon, 16 Mar 2020 14:55:07 +0100 (CET)
Date:   Mon, 16 Mar 2020 14:55:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Qian Cai <cai@lca.pw>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] locking/lockdep: Avoid recursion in
 lockdep_count_{for,back}ward_deps()
Message-ID: <20200316135507.GF12561@hirez.programming.kicks-ass.net>
References: <20200312151258.128036-1-boqun.feng@gmail.com>
 <20200313093325.GW12561@hirez.programming.kicks-ass.net>
 <20200315010422.GA134626@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315010422.GA134626@google.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Mar 14, 2020 at 09:04:22PM -0400, Joel Fernandes wrote:
> On Fri, Mar 13, 2020 at 10:33:25AM +0100, Peter Zijlstra wrote:

> Thanks Peter and Boqun, the below patch makes sense to me. Just had some nits
> below, otherwise:
> > @@ -1719,11 +1725,11 @@ unsigned long lockdep_count_forward_deps
> >  	this.class = class;
> >  
> >  	raw_local_irq_save(flags);
> > -	current->lockdep_recursion = 1;
> > +	current->lockdep_recursion++;
> >  	arch_spin_lock(&lockdep_lock);
> >  	ret = __lockdep_count_forward_deps(&this);
> >  	arch_spin_unlock(&lockdep_lock);
> > -	current->lockdep_recursion = 0;
> > +	current->lockdep_recursion--;
> 
> This doesn't look like it should recurse. Why not just use the
> lockdep_recursion_finish() helper here?

I chose to only add that to the sites that check recursion on entry.
