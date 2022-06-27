Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8ACCCA47E
	for <rcu@archiver.kernel.org>; Mon, 27 Jun 2022 21:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241123AbiF0VST (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Jun 2022 17:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239785AbiF0VSQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 27 Jun 2022 17:18:16 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D90B18B22
        for <rcu@vger.kernel.org>; Mon, 27 Jun 2022 14:18:15 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id cu16so17244946qvb.7
        for <rcu@vger.kernel.org>; Mon, 27 Jun 2022 14:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P6zAww8yEhNK6GLlNUczVyELOljiluEBeFzWM46x8aA=;
        b=CIxqTz7Pb4j+yjZ1SOGQT1ADTPXFC11f8sIu4cWO56ObKpJwM/XR7vVhZtZduCC8ZA
         b8UX0eTC9tm8JcxHzznj5yJ3Y40kqiBNo6ZERLtgeTRijgP2s5zz4xsiBbrWae5utSOC
         tAO1lqmjRPy5WwTUQlp/xkuEP9n/SFAWPWcQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P6zAww8yEhNK6GLlNUczVyELOljiluEBeFzWM46x8aA=;
        b=ZoEgaJM6DN47xInsu3JOmzuxMVL1aJFTWwFIy9AD4X74L8kerS3e9fzss7Yrv2HxCO
         ApIjOp0DEWudHtoiCh8F+CI2MxjxJ3M5fBmfnwB0+Np006yAHyPfsATMO+6b8DhCx+2S
         DFzaftsc49YLDjQBnniUgVfcNN6DquXOOV0LO95vUsMtcem0D3RRw7CqcT/xXrsmkvdu
         ACTXlxQgYJakxCtWORzN6Fv4nJ9eMN0EQIl2HIpAMtJT6q3Rg+EQf7Bi3YhJ6U9o7B5E
         R0KpTvCN7UiFRzrkUtOdaPEO9Z/ugsuCXWDR9jsFU8n/cn1lEI2O9iz6+m1uCiErILU4
         WIOA==
X-Gm-Message-State: AJIora/JF6oABAQzYk6GozjLTtm5HrV6YHpyy4INYOYliU3o6brAlLAb
        VVwUX0seTkWFJfFDxaHj/9wLQnLP+qDy+AlF
X-Google-Smtp-Source: AGRyM1ttpPclZvOBtCGqavKftRZC+sCxwGzwxyModoS07TXm6rabbdfstrb5jml5Gcb2KLaW+hw9nw==
X-Received: by 2002:a05:622a:120e:b0:315:4464:1dd1 with SMTP id y14-20020a05622a120e00b0031544641dd1mr11013497qtx.654.1656364694457;
        Mon, 27 Jun 2022 14:18:14 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id v12-20020a05620a0f0c00b006a73654c19bsm10080506qkl.23.2022.06.27.14.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 14:18:14 -0700 (PDT)
Date:   Mon, 27 Jun 2022 21:18:13 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 8/8] rcu/kfree: Fix kfree_rcu_shrink_count() return
 value
Message-ID: <YroelcGVNhQj91ab@google.com>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-10-joel@joelfernandes.org>
 <Yrn9a5pOvhvL/eZj@pc638.lan>
 <20220627205907.GM1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627205907.GM1790663@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jun 27, 2022 at 01:59:07PM -0700, Paul E. McKenney wrote:
> On Mon, Jun 27, 2022 at 08:56:43PM +0200, Uladzislau Rezki wrote:
> > > As per the comments in include/linux/shrinker.h, .count_objects callback
> > > should return the number of freeable items, but if there are no objects
> > > to free, SHRINK_EMPTY should be returned. The only time 0 is returned
> > > should be when we are unable to determine the number of objects, or the
> > > cache should be skipped for another reason.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/tree.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 711679d10cbb..935788e8d2d7 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3722,7 +3722,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> > >  		atomic_set(&krcp->backoff_page_cache_fill, 1);
> > >  	}
> > >  
> > > -	return count;
> > > +	return count == 0 ? SHRINK_EMPTY : count;
> > >  }
> > >  
> > >  static unsigned long
> > > -- 
> > > 2.37.0.rc0.104.g0611611a94-goog
> > > 
> > Looks good to me!
> > 
> > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Now that you mention it, this does look independent of the rest of
> the series.  I have pulled it in with Uladzislau's Reviewed-by.

Thanks Paul and Vlad!

Paul, apologies for being quiet. I have been working on the series and the
review comments carefully. I appreciate your help with this work.

thanks,

 - Joel

