Return-Path: <SRS0=P5Uu=WI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08614C31E40
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 03:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C594820842
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 03:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kSGtJz21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfHLDVp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 11 Aug 2019 23:21:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40877 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfHLDVp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 11 Aug 2019 23:21:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so48774863pgj.7
        for <rcu@vger.kernel.org>; Sun, 11 Aug 2019 20:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xwj7ZxWPgT0Jle7oEamkwkLyypmR/z5dn+XAc0K5QiE=;
        b=kSGtJz21XbvDbemzfOeXzhDFbfDXP4+vIX0HtIwRGIV71YkG0HMMY7pwXpRhnZ29J+
         gptwzSJ8wYODw/0GUJOieSOdBy7KOOYedAtmOU8jTbk4KO84b99jpvaImPDVh5Qpig0I
         h7PgUJIYJBRnKfzIEQmFRm4qrzt8p7OlRfWJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xwj7ZxWPgT0Jle7oEamkwkLyypmR/z5dn+XAc0K5QiE=;
        b=gcBfMMDr+zjTwIJHxZWVU4ZLzLB//7u9QzRQpaiAuxKPXGTRo3n6c+uD8mPFMVp4Tj
         sK7MaJ5DvF+f79BbTMggAnYG+R4FHh1ds0abWbfzkxmSPG8U9HcOk/cyda2rVDSn15Nv
         wvllr2eGTpz2IhtjJuWI12xVn0DN0N5VgKiU3zitIkSVoDktA5nTmaC/LyigUxCA/buF
         TNBaNBT1oujXz1nVTdsOMMt8B94BvxKL/cIp82y1Y4Bh+tOn7+uQPRgvjLXwgEjLC90q
         GJTVav850RJjUIjxZUsryYodQ0tbP1amEacDOOWXRq2O/nKSJHEIdzzWt16JNh7shYDd
         hfZA==
X-Gm-Message-State: APjAAAWkcvLHm+8+7Itaxh5qNbDBpT5kCxY8jQZnNvBSIB188FbKO9Sb
        VddG6D1maFVu1Xy2dO4D4B92U8LHj7c=
X-Google-Smtp-Source: APXvYqz+axiydNkDU7oFFHOzbIQem1LZza3M9uLaKpHPAW8X1qDmdk9R9FudOiGZ7T579wTjAc1Xug==
X-Received: by 2002:aa7:818b:: with SMTP id g11mr34135772pfi.122.1565580104473;
        Sun, 11 Aug 2019 20:21:44 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id dw7sm10837049pjb.21.2019.08.11.20.21.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 20:21:43 -0700 (PDT)
Date:   Sun, 11 Aug 2019 23:21:42 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190812032142.GA171001@google.com>
References: <20190811180852.GA128944@google.com>
 <20190811211318.GX28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811211318.GX28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Aug 11, 2019 at 02:13:18PM -0700, Paul E. McKenney wrote:
[snip]
> This leaves NO_HZ_FULL=y&&PREEMPT=y kernels.  In that case, RCU is
> more aggressive about using resched_cpu() on CPUs that have not yet
> reported a quiescent state for the current grace period.

Just wanted to ask something - how does resched_cpu() help for this case?

Consider a nohz_full CPU and a PREEMPT=y kernel. Say a single task is running
in kernel mode with scheduler tick off. As we discussed, we have no help from
cond_resched() (since its a PREEMPT=y kernel).  Because enough time has
passed (jtsq*3), we send the CPU a re-scheduling IPI.

This seems not that useful. Even if we enter the scheduler due to the
rescheduling flags set on that CPU, nothing will do the rcu_report_qs_rdp()
or rcu_report_qs_rnp() on those CPUs, which are needed to propagate the
quiescent state to the leaf node. Neither will anything to do a
rcu_momentary_dyntick_idle() for that CPU. Without this, the grace period
will still end up getting blocked.

Could you clarify which code paths on a nohz_full CPU running PREEMPT=y
kernel actually helps to end the grace period when we call resched_cpu() on
it?  Don't we need atleast do a rcu_momentary_dyntick_idle() from the
scheduler IPI handler or from resched_cpu() for the benefit of a nohz_full
CPU? Maybe I should do an experiment to see this all play out.

And I need to write down everything I learnt today before I go crazy... ;-)
