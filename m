Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88D7C433F5
	for <rcu@archiver.kernel.org>; Thu, 10 Feb 2022 20:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbiBJUrT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 10 Feb 2022 15:47:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbiBJUrS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 10 Feb 2022 15:47:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AA521090
        for <rcu@vger.kernel.org>; Thu, 10 Feb 2022 12:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644526037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HwR20u8meC03NeC4tbyRsHMNKvROISOaBQ8YoHGaCfk=;
        b=MP5Zc+AxgF5nQslT3xz22Szg+Wa0FoagORWJff6GDVFcxH4COdH1DOvwD0QxGhTToIjtGz
        t7TX0L3oPr33Ja8JolZdsmR99Vh24AHcOVCJWiwDndiK3E/lMwnsTgKxwBhGjbEgX905vv
        JM6YRA3KB2xMEXXi00qJMOY+OLyT3lk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-D7WUmNV3MimiMU-bmM0hgQ-1; Thu, 10 Feb 2022 15:47:16 -0500
X-MC-Unique: D7WUmNV3MimiMU-bmM0hgQ-1
Received: by mail-qk1-f198.google.com with SMTP id b18-20020a05620a089200b004e0e2f73f35so4365638qka.19
        for <rcu@vger.kernel.org>; Thu, 10 Feb 2022 12:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HwR20u8meC03NeC4tbyRsHMNKvROISOaBQ8YoHGaCfk=;
        b=gjVIWTVfOGlL14fuLWgsRrJ9faiytMY+hM1H3n6HKO9/GxsgkYiZmE4xFzUpEQyQdM
         tQ1E0kkWx4RnfYs4W2U4pMTgFSbwKh9UcRM5Sxvl2YBs1vcFX7vA/wF364Mv0eZqBsn/
         z6nEshYooep323rBUKqZhdWfgADgxAkYsDH+QPrnZ3OjxYE82r7OvXngDRS6rFQB6l5y
         UxcgW1VT80PT7nROHWE/fjgQ68XwshLllJrkipZKAUhruMSAXXpHIIYejyrycRmhbk5q
         1HtVoPV8aA3kPsn8uQfvXBk6YJgiH0x0GBjQxt6V/m9gvvhTD3+2O95JKNGhnctMJddL
         dbuA==
X-Gm-Message-State: AOAM532nMn/hRaJlXFSAecdkvsfauWAXMVD1bOcgwtcXmhCAXfFVqKg/
        +IHAz/cgVB+gpafvzlcfpSGy57wuF9AMgo2RAvNrrz31keVot4lxAKMrXtNLIKac1koGkpmxGHt
        +LT54UkIKLDH3
X-Received: by 2002:ae9:e850:: with SMTP id a77mr4810500qkg.239.1644526035888;
        Thu, 10 Feb 2022 12:47:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjJH76HocPWGbiLqt0WtLoGYGGZLkPs37x844ujPaPMxNnMMSqIhTiOV6LUr4ZC8C1Kh6gEw==
X-Received: by 2002:ae9:e850:: with SMTP id a77mr4810493qkg.239.1644526035662;
        Thu, 10 Feb 2022 12:47:15 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id u36sm220240qtc.42.2022.02.10.12.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 12:47:15 -0800 (PST)
Date:   Thu, 10 Feb 2022 15:47:13 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-xfs@vger.kernel.org,
        Ian Kent <raven@themaw.net>, rcu@vger.kernel.org
Subject: Re: [PATCH] xfs: require an rcu grace period before inode recycle
Message-ID: <YgV50a9ia0bHKTFh@bfoster>
References: <YfIdVq6R6xEWxy0K@zeniv-ca.linux.org.uk>
 <20220127052609.GR59729@dread.disaster.area>
 <YfLsBdPBSsyPFgHJ@bfoster>
 <20220128213911.GO4285@paulmck-ThinkPad-P17-Gen-1>
 <Yffioz+t9cjZbIBv@bfoster>
 <20220201220028.GH4285@paulmck-ThinkPad-P17-Gen-1>
 <YgEe21z+WUvpQa0N@bfoster>
 <20220207163621.GC4285@paulmck-ThinkPad-P17-Gen-1>
 <20220210040917.GN59729@dread.disaster.area>
 <20220210054544.GI4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210054544.GI4285@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Feb 09, 2022 at 09:45:44PM -0800, Paul E. McKenney wrote:
> On Thu, Feb 10, 2022 at 03:09:17PM +1100, Dave Chinner wrote:
> > On Mon, Feb 07, 2022 at 08:36:21AM -0800, Paul E. McKenney wrote:
> > > On Mon, Feb 07, 2022 at 08:30:03AM -0500, Brian Foster wrote:
> > > Another approach is to use SLAB_TYPESAFE_BY_RCU.  This allows immediate
> > > reuse of freed memory, but also requires pointer traversals to the memory
> > > to do a revalidation operation.  (Sorry, no free lunch here!)
> > 
> > Can't do that with inodes - newly allocated/reused inodes have to go
> > through inode_init_always() which is the very function that causes
> > the problems we have now with path-walk tripping over inodes in an
> > intermediate re-initialised state because we recycled it inside a
> > RCU grace period.
> 
> So not just no free lunch, but this is also not a lunch that is consistent
> with the code's dietary restrictions.
> 
> From what you said earlier in this thread, I am guessing that you have
> some other fix in mind.
> 

Yeah.. I've got an experiment running that essentially tracks pending
inode grace period cookies and attempts to avoid them at allocation
time. It's crude atm, but the initial numbers I see aren't that far off
from the results produced by your expedited grace period mechanism. I
see numbers mostly in the 40-50k cycles per second ballpark. This is
somewhat expected because the current baseline behavior relies on unsafe
reuse of inodes before a grace period has elapsed. We have to rely on
more physical allocations to get around this, so the small batch
alloc/free patterns simply won't be able to spin as fast. The difference
I do see with this sort of explicit gp tracking is that the results
remain much closer to the baseline kernel when background activity is
ramped up.

However, one of the things I'd like to experiment with is whether the
combination of this approach and expedited grace periods provides any
sort of opportunity for further optimization. For example, if we can
identify that a grace period has elapsed between the time of
->destroy_inode() and when the queue processing ultimately marks the
inode reclaimable, that might allow for some optimized allocation
behavior. I see this occur occasionally with normal grace periods, but
not quite frequent enough to make a difference.

What I observe right now is that the same test above runs at much closer
to the baseline numbers when using the ikeep mount option, so I may need
to look into ways to mitigate the chunk allocation overhead..

Brian

> 							Thanx, Paul
> 

