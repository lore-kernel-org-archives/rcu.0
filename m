Return-Path: <SRS0=/SR9=3F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4B9C33CAF
	for <rcu@archiver.kernel.org>; Thu, 16 Jan 2020 04:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF9F20723
	for <rcu@archiver.kernel.org>; Thu, 16 Jan 2020 04:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UWtMAmok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbgAPEGB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Jan 2020 23:06:01 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41486 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbgAPEGB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Jan 2020 23:06:01 -0500
Received: by mail-pf1-f193.google.com with SMTP id w62so9549317pfw.8
        for <rcu@vger.kernel.org>; Wed, 15 Jan 2020 20:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R3OaHJ/NoHo97qXRlJsk6XbKoJmXhoMLhGPLnTVZhRI=;
        b=UWtMAmokJ/P3d7sD2bmYBARu+1sTAP0qHRJ+jyvjczeS0igyZpJ7Pt1ZW27HzvPEtC
         Qo4e08NcyYbEKQ1o6NW+RInhKWixcbZ0JWw+ToAOCkjpbsioshu+xNiq3jDCiyc0k+0v
         V68XXLdKiWKW0S+JUsOTO8tFBazj8S9TUPpkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R3OaHJ/NoHo97qXRlJsk6XbKoJmXhoMLhGPLnTVZhRI=;
        b=Q7731BSkTjNXFNZpdGflI/3t8OUJRyY00AJt1SIdNga33G6W5cJrHuDiVgPUPq4ZJ0
         KbVc9sk0mfUTHljNza8I1BePNn9z8Im4RtNKr0qJboZWBBTAOoMIFIXVyJkohwex+a9S
         CIlO55mvP4tbcMidJ2M0f2Q2Y9xUz4jAMAMvkhxBG2TCwKfn4qnETEHZFpkrMYN9nDdV
         IlekvblYVygxrq1bTTE48HWAKcMuzoM5kYG0nnprAKyKPGgNdIqE+AoZ980W9awDfiiL
         Lgx5nKTugg0P99C/VmkdQnh3ant0XD9GLJpnfZbjl95nZKQQJakDuMTyevbjL2cDmyhk
         05oA==
X-Gm-Message-State: APjAAAVyhRcx+AEyJy5KD8vra7397zjaV0+v02AK9gbxqEcCFOFZb+NN
        YSEJewzia1RZTLpsTw1VM0MXtg==
X-Google-Smtp-Source: APXvYqzbpu+zEroh1lCJNK2RswLPoOkrbl0hdO0L1TFDlTlzeRdWYeqQT/qEldakCQJ9/tQN5n8TmA==
X-Received: by 2002:a63:a555:: with SMTP id r21mr36221700pgu.158.1579147560046;
        Wed, 15 Jan 2020 20:06:00 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e15sm785798pja.13.2020.01.15.20.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 20:05:59 -0800 (PST)
Date:   Wed, 15 Jan 2020 23:05:58 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bristot@redhat.com,
        frextrite@gmail.com, madhuparnabhowmik04@gmail.com,
        urezki@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 rcu-dev] rcuperf: Measure memory footprint during
 kfree_rcu() test
Message-ID: <20200116040558.GD246464@google.com>
References: <20191219211349.235877-1-joel@joelfernandes.org>
 <20191221000729.GH2889@paulmck-ThinkPad-P72>
 <20191221033714.GB156579@google.com>
 <20200106195200.GS13449@paulmck-ThinkPad-P72>
 <20200115220300.GA94036@google.com>
 <20200115224251.GK2935@paulmck-ThinkPad-P72>
 <20200115224542.GB94036@google.com>
 <20200116000104.GO2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116000104.GO2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 15, 2020 at 04:01:04PM -0800, Paul E. McKenney wrote:
> On Wed, Jan 15, 2020 at 05:45:42PM -0500, Joel Fernandes wrote:
> > On Wed, Jan 15, 2020 at 02:42:51PM -0800, Paul E. McKenney wrote:
> > > > [snip]
> > > > > > We can certainly refine it further but at this time I am thinking of spending
> > > > > > my time reviewing Lai's patches and learning some other RCU things I need to
> > > > > > catch up on. If you hate this patch too much, we can also defer this patch
> > > > > > review for a bit and I can carry it in my tree for now as it is only a patch
> > > > > > to test code. But honestly, in its current form I am sort of happy with it.
> > > > > 
> > > > > OK, I will keep it as is for now and let's look again later on.  It is not
> > > > > in the bucket for the upcoming merge window in any case, so we do have
> > > > > quite a bit of time.
> > > > > 
> > > > > It is not that I hate it, but rather that I want to be able to give
> > > > > good answers to questions that might come up.  And given that I have
> > > > > occasionally given certain people a hard time about their statistics,
> > > > > it is only reasonable to expect them to return the favor.  I wouldn't
> > > > > want you to be caught in the crossfire.  ;-)
> > > > 
> > > > Since the weights were concerning, I was thinking of just using a weight of
> > > > (1 / N) where N is the number of samples. Essentially taking the average.
> > > > That could be simple enough and does not cause your concerns with weight
> > > > tuning. I tested it and looks good, I'll post it shortly.
> > > 
> > > YES!!!  ;-)
> > > 
> > > Snapshot mem_begin before entering the loop.  For the mean value to
> > > be solid, you need at least 20-30 samples, which might mean upping the
> > > default for kfree_loops.  Have an "unsigned long long" to accumulate the
> > > sum, which should avoid any possibility of overflow for current systems
> > > and for all systems for kfree_loops less than PAGE_SIZE.  At which point,
> > > forget the "%" stuff and just sum up the si_mem_available() on each pass
> > > through the loop.
> > > 
> > > Do the division on exit from the loop, preferably checking for divide
> > > by zero.
> > > 
> > > Straightforward, fast, reasonably reliable, and easy to defend.
> > 
> > I mostly did it along these lines. Hopefully the latest posting is reasonable
> > enough ;-) I sent it twice because I messed up the authorship (sorry).
> 
> No problem with the authorship-fix resend!
> 
> But let's get this patch consistent with basic statistics!
> 
> You really do need 20-30 samples for an average to mean much.
> 
> Of course, right now you default kfree_loops to 10.  You are doing
> 8000 kmalloc()/kfree_rcu() loops on each pass.  This is large enough
> that just dropping the "% 4" should be just fine from the viewpoint of
> si_mem_available() overhead.  But 8000 allocations and frees should get
> done in way less than one second, so kicking the default kfree_loops up
> to 30 should be a non-problem.
> 
> Then the patch would be both simpler and statistically valid.
> 
> So could you please stop using me as the middleman in your fight with
> the laws of mathematics and get this patch to a defensible state?  ;-)

The thing is the signal doesn't vary much. I could very well just take one
out of the 4 samples and report that. But I still took the average since
there are 4 samples. I don't see much point in taking more samples here since
I am not concerned that the signal will fluctuate much (and if it really
does, then I can easily catch that kind of variation with multiple rcuperf
runs).

But if you really want though, I can increase the sampling to 20 samples or a
number like that and resend it.

thanks,

 - Joel

