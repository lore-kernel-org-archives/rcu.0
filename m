Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21955C433ED
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 14:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA8666128A
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 14:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhEUODN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 21 May 2021 10:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232587AbhEUODM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 21 May 2021 10:03:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0574600CC;
        Fri, 21 May 2021 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621605709;
        bh=4NU3L/wRMJdaIM1lpW4/qgGxrymlw6Y10w9dSIEXwHg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=k0aXQLcppBc724fUuHCe8op2TXc4CanDDbbLvjvCE5wNC9UWY6gV2O96k4/vExpQ6
         dBWxwqNxS2vznmWLyuIaTROH/FOqw/hGNAwA7AZy+LvODPk578qrIAS7/Bw4V2gunk
         eH1767xBA0VL5/aOcLBwFOnQO53LrvzF5uK0gbR4KSmQU/UlgsoT39Ttp15YD9B33K
         e7oUmMYn8ALCmu3DsrJwklZTSbtrkQkW7VP0/p6LMsyQVFsV0fJwZhq4pFMIMXeGeh
         cTYn8v+22Qpb7vx2u9ZPd2sU2neE26jgzlJeAUKVoscCwpeOKEXLio40mFRYQaYKsH
         PQeuHh2aaYIwg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 94CF75C033C; Fri, 21 May 2021 07:01:49 -0700 (PDT)
Date:   Fri, 21 May 2021 07:01:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: consider time a VM was suspended
Message-ID: <20210521140149.GV4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210516102716.689596-1-senozhatsky@chromium.org>
 <YKdU0U0aHKm2x3Y7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKdU0U0aHKm2x3Y7@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 21, 2021 at 03:36:01PM +0900, Sergey Senozhatsky wrote:
> On (21/05/16 19:27), Sergey Senozhatsky wrote:
> >  kernel/rcu/tree_stall.h | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index 59b95cc5cbdf..cb233c79f0bc 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -7,6 +7,8 @@
> >   * Author: Paul E. McKenney <paulmck@linux.ibm.com>
> >   */
> >  
> > +#include <asm/kvm_para.h>
> > +
> 
> D'oh, why did I do this...
> 
> Paul, I've a trivial fixup. How do you want to handle it?

I dropped your earlier patch due to the warning and also because it
looked like you might have a different approach.

So please just send the fixed-up patch and I will pull it in and see
how it does.

							Thanx, Paul

> ---
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index cd815b19740a..b9b52f91e5b8 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -7,7 +7,7 @@
>   * Author: Paul E. McKenney <paulmck@linux.ibm.com>
>   */
>  
> -#include <asm/kvm_para.h>
> +#include <linux/kvm_para.h>
>  
>  //////////////////////////////////////////////////////////////////////////////
>  //
