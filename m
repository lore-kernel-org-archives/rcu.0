Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C08AC433EF
	for <rcu@archiver.kernel.org>; Fri, 15 Jul 2022 15:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbiGOPuW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 15 Jul 2022 11:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbiGOPuV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 15 Jul 2022 11:50:21 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505D810FF8
        for <rcu@vger.kernel.org>; Fri, 15 Jul 2022 08:50:19 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id l11so3945825qvu.13
        for <rcu@vger.kernel.org>; Fri, 15 Jul 2022 08:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H7yHxYc9yC4sbLrWUcEmpKJfCgoHwr79j8/tlsYS1IM=;
        b=BitHvrbN7N+jwAb0olNekVSpn6p/YpSErbvEXnXX5RlUSLDx/1U7vaxknEKOhRHtti
         teKgwgDPYzpXt6bPbG1vK6XYssXj8yyu29pKutLLEdIBecCjuKecwMpEmDussYITb68i
         IGXGaNSZZsGfwi0MkGToURLWYysfi/0gxk++Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H7yHxYc9yC4sbLrWUcEmpKJfCgoHwr79j8/tlsYS1IM=;
        b=ygVekFh7ArQmqMRlxXLCHYgeeXyv7HPNUnpX9ta36ZdIaXoh6IA3rmzwVP64WkJwkB
         fEI56xydRw4zwFQpNsYN/zDe7qzl87GT6q7WqteCP/nY0EdmeOQH8Q0oh3r3LXKa6+q5
         EdjoE66xFYbwXoap5p/RCQnGaZb91h7sqfmkI9sxSN4od3RcE5HCZZTFYmQT8ctt48ME
         CERJJFfVp/TdZED1JXl0ZaN5SDldMPdumz8Q4ESQCTFiD7BIqnydpNzXoAPQgVrdyHI6
         HAodIHBJje7njd9R+Gg130PA7RybxukxrT0YndTnA+GskV3LM+KcXUrD2yD1yJFeP2w/
         rbig==
X-Gm-Message-State: AJIora/qytgWvASAYtynUx8aT/KlUAvGKORi/N7uBjQaRVIDl9Cb1EDf
        Sn0eeNHYDc9N33fYrOX5ykFhue+9o+37Pg==
X-Google-Smtp-Source: AGRyM1vc4Y9gFJkYwZ8F1a+EYWb1++RyA3Rq7iMko+lgplJSqGMBL6+KRiOXTjEUT+Xl97WBXjQ1bg==
X-Received: by 2002:ad4:5ae6:0:b0:472:f085:853d with SMTP id c6-20020ad45ae6000000b00472f085853dmr12548863qvh.14.1657900218393;
        Fri, 15 Jul 2022 08:50:18 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id ay17-20020a05620a179100b006b5d3a6f1e1sm847036qkb.0.2022.07.15.08.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 08:50:18 -0700 (PDT)
Date:   Fri, 15 Jul 2022 15:50:17 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v3 0/5] Implement call_rcu_lazy() and miscellaneous fixes
Message-ID: <YtGMucOzKDy5A1UK@google.com>
References: <20220713213237.1596225-1-joel@joelfernandes.org>
 <20220714205154.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220714222131.GA3321557@paulmck-ThinkPad-P17-Gen-1>
 <YtGFLFbzuZncfDeN@google.com>
 <20220715152937.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <YtGKcScgTh3t4SYS@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtGKcScgTh3t4SYS@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jul 15, 2022 at 03:40:33PM +0000, Joel Fernandes wrote:
> On Fri, Jul 15, 2022 at 08:29:37AM -0700, Paul E. McKenney wrote:
> > On Fri, Jul 15, 2022 at 03:18:04PM +0000, Joel Fernandes wrote:
> > > On Thu, Jul 14, 2022 at 03:21:31PM -0700, Paul E. McKenney wrote:
> > > > On Thu, Jul 14, 2022 at 01:51:54PM -0700, Paul E. McKenney wrote:
> > > > > On Wed, Jul 13, 2022 at 09:32:32PM +0000, Joel Fernandes (Google) wrote:
> > > > > > Hello!
> > > > > > 
> > > > > > Please find the next improved version of call_rcu_lazy() attached.  The main
> > > > > > difference between the previous versions is that:
> > > > > > - In v2 rcu_barrier is fixed to not hang (I found this to be due to a missing
> > > > > >   GP thread wakeup), now I am limiting this wake up only to rcu_barrier() as
> > > > > >   requested by Paul.
> > > > > > - Fixed checkpatch and build robot issues.
> > > > > > - Some more changes to 'lazy' parameter passing and consolidation of segcblist
> > > > > >   functions.
> > > > > > - more testing via rcutorture and rcuscale.
> > > > > 
> > > > > Thank you!  What I am going to do is to pull these into an experimental
> > > > > not-for-mainline branch and run the usual set of rcutorture tests.
> > > > > I will then take a look at the patches.
> > > > 
> > > > And there were a few conflicts with the nocb patch series in -rcu.
> > > > The allegedly conflict-resolved series is here: joel.2022.07.14a
> > > > Please let me know if I messed something up.
> > > 
> > > Thanks, it looks Ok. There is one robot fix for hexagon's arch where I think
> > > TREE_RCU is disabled, could you apply the diff below to patch 1/5 ?
> > > 
> > > Or, I can also just keep it in my version of 1/5 to go out with the next rev.
> > 
> > Given that I am not testing on hexagon, I will let you fix this one on
> > the next rev.  If someone out there is testing this branch on hexagon,
> > they should feel free to apply your patch locally.  ;-)
> 
> I am pretty sure this is the feature that was going to make Hexagon widely
> adopted, but your call ;-)

Jokes apart, I am sure this feature will be useful to a lot of folks and
architectures but lets keep this diff for the next revision as you said.

Actually never heard of Hexagon till today... 32-bit and 4x VLIW, Cool! :
https://en.wikipedia.org/wiki/Qualcomm_Hexagon

thanks,

 - Joel


