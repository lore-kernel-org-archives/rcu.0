Return-Path: <SRS0=ANd2=CD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BE7C433DF
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 15:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5070A20786
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 15:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OD7envjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgHYPXQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHYPXO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Aug 2020 11:23:14 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A69BC061574;
        Tue, 25 Aug 2020 08:23:14 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F31BB9A5;
        Tue, 25 Aug 2020 17:23:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1598368989;
        bh=+ill/ZwwkhuFoJdnovdknow0Na//rSUqB2CNf3qkpuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OD7envjWQAJrEAml+0DQ2452TNNYSfRGvyFs6++IeKv77xLHT9sFX9xSd09l+q0nU
         1KbzerxZC2aFrQgCZbTznmP2opljNjrFaAHjd9JqFJHLwp5UvL2EdOgOOj6TlVQ6e7
         RYJWa3VGMbigE/9h05xk2/3iUzXFsOU/YdCLUFDE=
Date:   Tue, 25 Aug 2020 18:22:49 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Fix compilation warning with
 !CONFIG_TASKS_RCU and CONFIG_TINY_RCU
Message-ID: <20200825152249.GF6767@pendragon.ideasonboard.com>
References: <20200823030405.22174-1-laurent.pinchart@ideasonboard.com>
 <20200825150222.GP2855@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825150222.GP2855@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On Tue, Aug 25, 2020 at 08:02:22AM -0700, Paul E. McKenney wrote:
> On Sun, Aug 23, 2020 at 06:04:05AM +0300, Laurent Pinchart wrote:
> > Commit 8344496e8b49 ("rcu-tasks: Conditionally compile
> > show_rcu_tasks_gp_kthreads()") introduced conditional compilation of
> > several functions, but forgot one occurrence of
> > show_rcu_tasks_classic_gp_kthread() that causes the compiler to warn of
> > an unused static function. Fix it.
> > 
> > Fixes: 8344496e8b49 ("rcu-tasks: Conditionally compile show_rcu_tasks_gp_kthreads()")
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> >  kernel/rcu/tasks.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 835e2df8590a..bddf3968c1eb 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -590,7 +590,9 @@ void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
> >  }
> >  
> >  #else /* #ifdef CONFIG_TASKS_RCU */
> > +#ifndef CONFIG_TINY_RCU
> >  static void show_rcu_tasks_classic_gp_kthread(void) { }
> > +#endif /* #ifndef CONFIG_TINY_RCU */
> >  void exit_tasks_rcu_start(void) { }
> >  void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
> >  #endif /* #else #ifdef CONFIG_TASKS_RCU */
> 
> Good catch!!!
> 
> But does the following addition of "static inline" work for you?

They do. I initially added a static inline, and realized #ifdef was used
extensively when trying to find the proper Fixes: tag, so I went for
that. I don't mind either way, as long as this gets fixed :-)

> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 835e2df..3dc3ffc 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -590,9 +590,9 @@ void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
>  }
>  
>  #else /* #ifdef CONFIG_TASKS_RCU */
> -static void show_rcu_tasks_classic_gp_kthread(void) { }
> -void exit_tasks_rcu_start(void) { }
> -void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
> +static inline void show_rcu_tasks_classic_gp_kthread(void) { }
> +static inline void exit_tasks_rcu_start(void) { }
> +static inline void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
>  #endif /* #else #ifdef CONFIG_TASKS_RCU */
>  
>  #ifdef CONFIG_TASKS_RUDE_RCU

-- 
Regards,

Laurent Pinchart
