Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C71C433DB
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 23:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E582A2313E
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 23:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbhAFXmx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 18:42:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:51450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbhAFXmx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 18:42:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F11EF2313E;
        Wed,  6 Jan 2021 23:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609976533;
        bh=nzHj+d9zdHxNgx4XItiu7AMfRHKTP/VSS9I8N0zIGE0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UftMCV5yQteFmCgmawOeR6jAqA74tCtToWGOu0TfWJhkrWghHIJT9addF/nbJqIxr
         B9eLpR1xj0puDlqatdAohG+OwnP2a7ztfATrwxTes0EMLk1LLcK5xvqnQcXEvu3EWm
         jPpHkj3ATcpkHKxfpL1gark8XGOahm4ZBs9s3J53sxnDu9eG23IGWnqKVMG7di31lp
         WQmusYBUNAfrr6v9LkL0owhMj3xDOFnSV8IdB+m+qLcEAUMrCcd+XOO5R90nWL5Xim
         M3XPorEfTvb9c24SlTP3e8NP/loI3ZUOksiElkRpHPIozqVeZrzLO7hHXp4AZoxzL/
         /uIxyGI44rNPA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BF03735225DC; Wed,  6 Jan 2021 15:42:12 -0800 (PST)
Date:   Wed, 6 Jan 2021 15:42:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-mm@kvack.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, ming.lei@redhat.com,
        axboe@kernel.dk, kernel-team@fb.com
Subject: Re: [PATCH v4 sl-b 0/6] Export return addresses etc. for better
 diagnostics
Message-ID: <20210106234212.GA20560@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210106011603.GA13180@paulmck-ThinkPad-P72>
 <20210106134843.ed8e298da92d4fe93b6aa259@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106134843.ed8e298da92d4fe93b6aa259@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 06, 2021 at 01:48:43PM -0800, Andrew Morton wrote:
> On Tue, 5 Jan 2021 17:16:03 -0800 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > This is v4 of the series the improves diagnostics by providing access
> > to additional information including the return addresses, slab names,
> > offsets, and sizes collected by the sl*b allocators and by vmalloc().
> 
> Looks reasonable.  And not as bloaty as I feared, but it does add ~300
> bytes to my allnoconfig build.  Is the CONFIG_ coverage as tight as it
> could be?

Glad I managed to exceed your expectations.  ;-)

Let's see...  When I do an allnoconfig build, it has CONFIG_PRINTK=n.
Given that this facility is based on printk(), I could create an
additional patch that #ifdef'ed everything out in CONFIG_PRINTK=n kernels.
This would uglify things a bit, but it would save ~300 bytes.

If I don't hear otherwise from you, I will put something together,
test it, and send it along.

							Thanx, Paul
