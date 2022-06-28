Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B96AC43334
	for <rcu@archiver.kernel.org>; Tue, 28 Jun 2022 16:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbiF1Q5C (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Jun 2022 12:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbiF1Q4k (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 28 Jun 2022 12:56:40 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB1921E1E
        for <rcu@vger.kernel.org>; Tue, 28 Jun 2022 09:56:16 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id p31so20920244qvp.5
        for <rcu@vger.kernel.org>; Tue, 28 Jun 2022 09:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jqNLofw/D/PgB2PwZMkDfeM2ZVnMx72QWP1RSRdpmQo=;
        b=pHh6mjp31yvbo8A34LLzMDENTfRddWdvKsjXFp578aFN88WyGnMogyiV3dp3/v5EVH
         4jOMmiR2Qxitr1TmYkZbQU3o55SLX2qqGtZZUkY1NboZ5K9YVba9XWXMJ2HrBeI5rC9P
         mahSZs2mD1JH4sHb3p/1ImusiiICFxQzG4LXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jqNLofw/D/PgB2PwZMkDfeM2ZVnMx72QWP1RSRdpmQo=;
        b=YT6FdTs0CLlcBJ6QGUkABfRRVHsCLi8jy3bloHZ3Y9lhBb/WV7oI6O8sx6vUWl+io9
         oFYvRR64gBFPjBlm+7KyIG3tq/QTqDehb0AdMGhzNbJBtZAHDSjiWSaWIQ+zN3KVFinm
         oZ5P93bJeugAefT9MO/qUsaC/lgeaCEK9jy9xlidK84N4Hn0X2kT7mQGwtBd0j9CWfe1
         n7J+yh/KW7+I6/1d6UXegmlLCnLOcCOWvmiXdjiyga4P49vyY5Jsref6LrnZPrNYZjyl
         CZXTjKWtktmLFKGHYNwGHXsGWUsr56h6Ww5d2y5U+3dew4vwcvs2hvzj8VKGxG1iLfWD
         2iYg==
X-Gm-Message-State: AJIora+bk58JflIupR7TIdr7vGaKofhIe78gh6HYnnBIwNlUHcW90FEc
        5MhOtJ82NxJ8u6pE0/ZoAWHyCQ==
X-Google-Smtp-Source: AGRyM1sudwCjEYgzNWIA35xMKylvU+kWeJ9NFoOzHVRhkAOGNX3RF7lsg0poVrifS0ZVdWOcv3Jl1Q==
X-Received: by 2002:a05:6214:1c0f:b0:470:9d07:2f5d with SMTP id u15-20020a0562141c0f00b004709d072f5dmr3204675qvc.12.1656435375174;
        Tue, 28 Jun 2022 09:56:15 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id c190-20020ae9edc7000000b006a743b360bcsm10710238qkg.136.2022.06.28.09.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 09:56:14 -0700 (PDT)
Date:   Tue, 28 Jun 2022 16:56:14 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 8/8] rcu/kfree: Fix kfree_rcu_shrink_count() return
 value
Message-ID: <YrsyrmDbfnkpfDEP@google.com>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-10-joel@joelfernandes.org>
 <Yrn9a5pOvhvL/eZj@pc638.lan>
 <20220627205907.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <YroelcGVNhQj91ab@google.com>
 <20220627214359.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627214359.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jun 27, 2022 at 02:43:59PM -0700, Paul E. McKenney wrote:
> On Mon, Jun 27, 2022 at 09:18:13PM +0000, Joel Fernandes wrote:
> > On Mon, Jun 27, 2022 at 01:59:07PM -0700, Paul E. McKenney wrote:
> > > On Mon, Jun 27, 2022 at 08:56:43PM +0200, Uladzislau Rezki wrote:
> > > > > As per the comments in include/linux/shrinker.h, .count_objects callback
> > > > > should return the number of freeable items, but if there are no objects
> > > > > to free, SHRINK_EMPTY should be returned. The only time 0 is returned
> > > > > should be when we are unable to determine the number of objects, or the
> > > > > cache should be skipped for another reason.
> > > > > 
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > ---
> > > > >  kernel/rcu/tree.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index 711679d10cbb..935788e8d2d7 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -3722,7 +3722,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> > > > >  		atomic_set(&krcp->backoff_page_cache_fill, 1);
> > > > >  	}
> > > > >  
> > > > > -	return count;
> > > > > +	return count == 0 ? SHRINK_EMPTY : count;
> > > > >  }
> > > > >  
> > > > >  static unsigned long
> > > > > -- 
> > > > > 2.37.0.rc0.104.g0611611a94-goog
> > > > > 
> > > > Looks good to me!
> > > > 
> > > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > 
> > > Now that you mention it, this does look independent of the rest of
> > > the series.  I have pulled it in with Uladzislau's Reviewed-by.
> > 
> > Thanks Paul and Vlad!
> > 
> > Paul, apologies for being quiet. I have been working on the series and the
> > review comments carefully. I appreciate your help with this work.
> 
> Not a problem.  After all, this stuff is changing some of the trickier
> parts of RCU.  We must therefore assume that some significant time and
> effort will be required to get it right.

To your point about trickier parts of RCU, the v2 series though I tested it
before submitting is now giving me strange results with rcuscale. Sometimes
laziness does not seem to be in effect (as pointed out by rcuscale), other
times I am seeing stalls.

So I have to carefully look through all of this again. I am not sure why I
was not seeing these issues with the exact same code before (frustrated).

thanks,

 - Joel

