Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB55C433EF
	for <rcu@archiver.kernel.org>; Sat, 14 May 2022 14:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiENOlN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 14 May 2022 10:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbiENOlI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 14 May 2022 10:41:08 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BEE2C104
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 07:41:04 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id z126so9398535qkb.2
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZKPPE2WUYvAD5MXZsJrfnXXtSzcnxpDI9pLWFlrKcGc=;
        b=sE+/gU5mJkAXj5IQ5WrwNcgpKCCGDtukr/oGSTF7ajiFqNa2T+znaDpUHgRnM4RPFW
         MpxsnUhFUdpO/XWqzGQVCqTpLijFzM83X6JhOuoeF4tiqUZ2HOMMjdQ5meGSc6dpLv1G
         HKji5jhCLS+I79cBRdBo24kVtggBTlRZ7CQ+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZKPPE2WUYvAD5MXZsJrfnXXtSzcnxpDI9pLWFlrKcGc=;
        b=k8mFJfj58fyfYvmahjWuF7E5YOcdJaP/QtyF5gY2EBX1GNv1OW0NUvkCOvIoZVz7XB
         dzjTyPHrxzqz9GM39kZp0USlsXziXNYfdoxOd7qwJoAmLW/BzZwTJCdu0ILplSoEZK5c
         4rzbatr21BVvY9YYl78JRHvKv2Eg+gIBQL7bRBSw1ql3eYsw03UkfjUBT27sUGMgz55X
         FNoQxONzNEH87YS7KoxOV45HaaJNZ8kSvAZWeA2tcZsPpPablp/laGhXSi20Bvty0Wdf
         NYEH2Vur2RXO+HYVvIDT1ccl8iQSs2JMq5Hs/albWlspDFFOE3uEf6S1+9LhQSZ4T1Sv
         3h3w==
X-Gm-Message-State: AOAM5303nj+q8JZ0cTF5vMNMiyyJac9yiTsfR0vKSZrVfbjgkBlGFRZx
        Q8hxk4h0Tu3CvljrdpfJDX1JUA==
X-Google-Smtp-Source: ABdhPJwjIca2U1dMd+fVbw97We0Yzz2BmvdGFZkp/jdIqWODCilWHQi+0cbYHy5a7MeXWzcD6L1jrA==
X-Received: by 2002:ae9:ef11:0:b0:69f:cac1:bac8 with SMTP id d17-20020ae9ef11000000b0069fcac1bac8mr6787890qkg.755.1652539263657;
        Sat, 14 May 2022 07:41:03 -0700 (PDT)
Received: from localhost (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id l124-20020a37bb82000000b006a006c884f0sm2953862qkf.106.2022.05.14.07.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 07:41:03 -0700 (PDT)
Date:   Sat, 14 May 2022 14:41:03 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 04/14] cred: Move call_rcu() to call_rcu_lazy()
Message-ID: <Yn+/f6fPyUUIoc3m@google.com>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-5-joel@joelfernandes.org>
 <20220513000253.GX1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513000253.GX1790663@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 12, 2022 at 05:02:53PM -0700, Paul E. McKenney wrote:
> On Thu, May 12, 2022 at 03:04:32AM +0000, Joel Fernandes (Google) wrote:
> > This is required to prevent callbacks triggering RCU machinery too
> > quickly and too often, which adds more power to the system.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> The put_cred_rcu() does some debugging that would be less effective
> with a 10-second delay.  Which is probably OK assuming that significant
> testing happens on CONFIG_RCU_LAZY=n kernels.

Good point, I'll add that to the commit message, thanks!

thanks,

 - Joel

> 							Thanx, Paul
> 
> > ---
> >  kernel/cred.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/cred.c b/kernel/cred.c
> > index 933155c96922..f4d69d7f2763 100644
> > --- a/kernel/cred.c
> > +++ b/kernel/cred.c
> > @@ -150,7 +150,7 @@ void __put_cred(struct cred *cred)
> >  	if (cred->non_rcu)
> >  		put_cred_rcu(&cred->rcu);
> >  	else
> > -		call_rcu(&cred->rcu, put_cred_rcu);
> > +		call_rcu_lazy(&cred->rcu, put_cred_rcu);
> >  }
> >  EXPORT_SYMBOL(__put_cred);
> >  
> > -- 
> > 2.36.0.550.gb090851708-goog
> > 
